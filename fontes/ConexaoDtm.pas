unit ConexaoDtm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Phys.IBBase, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, ARDataConnector, ARFireDACConn, Datasnap.Provider,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, vcl.dialogs,
  funcoes, vcl.forms;

type
  TdmConexao = class(TDataModule)
    dcBanco: TFDConnection;
    fdTransaction: TFDTransaction;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qryLoginUsua: TFDQuery;
    qryInsNotaLog: TFDQuery;
    qryUpdNota: TFDQuery;
    qryConfig: TFDQuery;
    qryLogNota: TFDQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    procedure IniciarTransacao;
    procedure FecharTransacao;
    procedure CancelarTransacao;

    function AbreConexaoDB: Boolean;
    function RealizarLogin(const pUsuario, pSenha: String): Boolean;
    procedure GravarLog(const pNota, pUsuario: Integer; const pOperacao: String);
    procedure AprovarNota(const pNota: Integer);
    function GravarOperacao(const pNota, pUsuario: Integer; pOperacao: String; const pValorNota: Double): Boolean;
    procedure ObtemConfiguracaoNota(const pValNota: Double; var pQuantVisto, pQuantAprovacao: Integer);
    procedure ObtemLogNota(const pCodNota: Integer; var pQuantVisto, pQuantAprovacao: Integer);
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmConexao }

function TdmConexao.AbreConexaoDB: Boolean;
var
  CaminhoBanco: string;
Begin
  Result := False;
  CaminhoBanco := Func.ObterCaminhoBancoDados;

  try
    DcBanco.Connected := False;
    DcBanco.LoginPrompt := False;
    DcBanco.Params.Clear;
    DcBanco.Params.Add(Format('DataBase=%s', [CaminhoBanco]));
    DcBanco.Params.Add('DriverID=SQLite');

    DcBanco.Connected := True;

    Result:= True;
  except
    on E: Exception Do
    Begin
      Result := False;
      Showmessage('Problemas ao conectar no banco de dados. '+ #13 +
                    'Verifique o caminho do banco de dados.');
      Application.Terminate;
    end;
  end;
end;

procedure TdmConexao.CancelarTransacao;
begin
  dcBanco.Rollback;
end;

procedure TdmConexao.DataModuleDestroy(Sender: TObject);
begin
  dcBanco.Connected := False;
end;

procedure TdmConexao.FecharTransacao;
begin
  dcBanco.Commit;
end;

procedure TdmConexao.GravarLog(const pNota, pUsuario: Integer; const pOperacao: String);
begin
  qryInsNotaLog.Close;
  qryInsNotaLog.ParamByName('cod_nota').AsInteger := pNota;
  qryInsNotaLog.ParamByName('cod_usua').AsInteger := pUsuario;
  qryInsNotaLog.ParamByName('data').AsString := FormatDateTime('yyyy-mm-dd', Now);
  qryInsNotaLog.ParamByName('operacao').AsString := pOperacao;
  qryInsNotaLog.ExecSQL;
end;

procedure TdmConexao.AprovarNota(const pNota: Integer);
begin
  IniciarTransacao;
  try
    qryUpdNota.Close;
    qryUpdNota.ParamByName('id').AsInteger := pNota;
    qryUpdNota.ExecSQL;
    FecharTransacao;
  except
    on E: Exception do
    begin
      CancelarTransacao;
      ShowMessage('N�o foi poss�vel concluir a opera��o.'+ #13 +
                  'Motivo: '+ E.Message);
    end;
  end;
end;

function TdmConexao.GravarOperacao(const pNota, pUsuario: Integer; pOperacao: String; const pValorNota: Double): Boolean;
var
    QuantVistoNecessario: Integer;
    QuantAprovNecessario: Integer;
    QuantVistoObtido: Integer;
    QuantAprovObtido: Integer;
begin
  Result := False;
  IniciarTransacao;
  try
    GravarLog(pNota, pUsuario, pOperacao);
    FecharTransacao;
    Result := True;
  except
    on E: Exception do
    begin
      CancelarTransacao;
      ShowMessage('N�o foi poss�vel concluir a opera��o.'+ #13 +
                  'Motivo: '+ E.Message);
    end;
  end;

  ObtemConfiguracaoNota(pValorNota, QuantVistoNecessario, QuantAprovNecessario);
  ObtemLogNota(pNota, QuantVistoObtido, QuantAprovObtido);
  // Caso a nota j� obteve a quantidade de visto ou aprova��o muda o status
  // para Aprovado
  if (QuantVistoObtido = QuantVistoNecessario) and
     (QuantAprovObtido = QuantAprovNecessario) then
     AprovarNota(pNota);
end;

procedure TdmConexao.IniciarTransacao;
begin
  dcBanco.StartTransaction;
end;

procedure TdmConexao.ObtemConfiguracaoNota(const pValNota: Double;
  var pQuantVisto, pQuantAprovacao: Integer);
begin
  qryConfig.Close;
  qryConfig.ParamByName('val_nota').AsFloat := pValNota;
  qryConfig.Open();
  pQuantVisto := qryConfig.FieldByName('visto').AsInteger;
  pQuantAprovacao := qryConfig.FieldByName('aprovacao').AsInteger;
end;

procedure TdmConexao.ObtemLogNota(const pCodNota: Integer; var pQuantVisto,
  pQuantAprovacao: Integer);
begin
  qryLogNota.Close;
  qryLogNota.ParamByName('cod_nota').AsInteger := pCodNota;
  qryLogNota.Open();
  pQuantVisto := 0;
  pQuantAprovacao := 0;
  while not qryLogNota.Eof do
  begin
    if qryLogNota.FieldByName('operacao').AsString = 'A' then
      pQuantAprovacao := qryLogNota.FieldByName('quant').AsInteger;

    if qryLogNota.FieldByName('operacao').AsString = 'V' then
      pQuantVisto := qryLogNota.FieldByName('quant').AsInteger;
    qryLogNota.Next;
  end;
end;

function TdmConexao.RealizarLogin(const pUsuario, pSenha: String): Boolean;
begin
  Result := False;
  qryLoginUsua.Close;
  qryLoginUsua.ParamByName('PUSUARIO').AsString := pUsuario;
  qryLoginUsua.ParamByName('PSENHA').AsString := pSenha;
  qryLoginUsua.Open();
  if not qryLoginUsua.IsEmpty then
  begin
    Result := True;
    func.Usuario.IdUsua := qryLoginUsua.FieldByName('ID').AsInteger;
    func.Usuario.NomeUsuario := qryLoginUsua.FieldByName('LOGIN').AsString;
    func.Usuario.Papel := qryLoginUsua.FieldByName('PAPEL').AsString;
    func.Usuario.ValMinAp := qryLoginUsua.FieldByName('VAL_MIN').AsFloat;
    func.Usuario.ValMaxAp := qryLoginUsua.FieldByName('VAL_MAX').AsFloat;
  end;

end;

end.

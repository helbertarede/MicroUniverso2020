unit MainFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, LoginFrm,
  ConexaoDtm, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  RxToolEdit, system.Math, strUtils, funcoes, Vcl.ComCtrls, CadNotasFrm;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    dsNotas: TDataSource;
    qryNotas: TFDQuery;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtDataIni: TDateEdit;
    Label2: TLabel;
    edtDataFim: TDateEdit;
    btnFiltrar: TBitBtn;
    btnLimparFiltro: TBitBtn;
    btnUsuario: TBitBtn;
    stbStatus: TStatusBar;
    btnVisto: TBitBtn;
    btnAprovacao: TBitBtn;
    btnCadNota: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryNotasAfterOpen(DataSet: TDataSet);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnLimparFiltroClick(Sender: TObject);
    procedure btnUsuarioClick(Sender: TObject);
    procedure btnVistoClick(Sender: TObject);
    procedure btnAprovacaoClick(Sender: TObject);
    procedure qryNotasAfterRefresh(DataSet: TDataSet);
    procedure btnCadNotaClick(Sender: TObject);
  private
    QuantVistoNecessario: Integer;
    QuantAprovNecessario: Integer;
    QuantVistoObtido: Integer;
    QuantAprovObtido: Integer;
    procedure ExibirNotas;
    procedure ConfigurarStatus;
    function ValidarData: Boolean;
    function ValidarNota: Boolean;
    procedure GravarOperacao(const pOper: String);
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnLimparFiltroClick(Sender: TObject);
begin
  qryNotas.Filtered := False;
  qryNotas.Filter := '';
end;

procedure TfrmMain.btnAprovacaoClick(Sender: TObject);
begin
  dmConexao.ObtemConfiguracaoNota(qryNotas.FieldByName('valor_total').AsFloat,
                                 QuantVistoNecessario,
                                 QuantAprovNecessario);
  dmConexao.ObtemLogNota(qryNotas.FieldByName('ID').AsInteger,
                         QuantVistoObtido,
                         QuantAprovObtido);

  if QuantAprovNecessario = 0 then
  begin
    ShowMessage(Format('A nota %d n�o necessita de aprova��o.',
                       [qryNotas.FieldByName('ID').AsInteger]));
    Exit;
  end;
  if ((QuantVistoObtido < QuantVistoNecessario) or
     (QuantAprovObtido < QuantAprovNecessario)) then
  begin
    if dmConexao.GravarOperacao(qryNotas.FieldByName('ID').AsInteger,
                             func.Usuario.IdUsua,
                            'A', qryNotas.FieldByName('valor_total').AsFloat) then
      ShowMessage('Opera��o realizada com sucesso!');
  end
  else
  begin
    ShowMessage(Format('A nota %d j� atingiu a quantidade de aprova��es necess�rio.',
                       [qryNotas.FieldByName('ID').AsInteger]));
  end;
  qryNotas.Refresh;
end;

procedure TfrmMain.btnCadNotaClick(Sender: TObject);
var
  frm: TfrmCadNotas;
begin
  frm := TfrmCadNotas.Create(Self);
  try
    frm.ShowModal;
    ExibirNotas;
  finally
    FreeAndNil(frm);
  end;
end;

procedure TfrmMain.btnFiltrarClick(Sender: TObject);
begin
  if not ValidarData then
    Exit;

  screen.Cursor := crHourGlass;
  try
    qryNotas.Filtered := False;
    qryNotas.Filter := Format(' dt_emiss between ''%s'' and ''%s'' ',
            [FormatDateTime('dd/mm/yyyy', edtDataini.Date),
             FormatDateTime('dd/mm/yyyy', edtDataFim.Date)]);
    qryNotas.Filtered := True;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmMain.btnUsuarioClick(Sender: TObject);
begin
  if not TfrmLogin.CriarLogin then
  begin
    PostMessage(Handle, WM_CLOSE, 0, 0);
    Exit;
  end
  else
  begin
    ExibirNotas;
  end;
end;

procedure TfrmMain.btnVistoClick(Sender: TObject);
begin
  dmConexao.ObtemConfiguracaoNota(qryNotas.FieldByName('valor_total').AsFloat,
                                 QuantVistoNecessario,
                                 QuantAprovNecessario);
  dmConexao.ObtemLogNota(qryNotas.FieldByName('ID').AsInteger,
                         QuantVistoObtido,
                         QuantAprovObtido);

  if QuantVistoObtido < QuantVistoNecessario then
  begin
    if dmConexao.GravarOperacao(qryNotas.FieldByName('ID').AsInteger,
                             func.Usuario.IdUsua,
                             'V', qryNotas.FieldByName('valor_total').AsFloat) then
      ShowMessage('Opera��o realizada com sucesso!');
  end
  else
  begin
    ShowMessage(Format('A nota %d j� atingiu a quantidade de visto necess�rio.',
                       [qryNotas.FieldByName('ID').AsInteger]));
  end;
  qryNotas.Refresh;
end;

function TfrmMain.ValidarNota: Boolean;
var
  bVisto, bAprov: Boolean;
begin
  Result := False;
  // A nota 3 precisa de 2 visto mas s� conseguiu
  if QuantVistoObtido >= QuantVistoNecessario then
    bVisto := True;

  if QuantAprovNecessario > QuantAprovObtido then
    bAprov := True;
end;

procedure TfrmMain.ConfigurarStatus;
begin
  stbStatus.Panels[1].Text := func.Usuario.NomeUsuario;
  stbStatus.Panels[3].Text := func.Usuario.PapelStr;
  stbStatus.Panels[5].Text := FloatToStr(func.Usuario.ValMinAp);
  stbStatus.Panels[7].Text := FloatToStr(func.Usuario.ValMaxAp);
  stbStatus.Panels[9].Text := FloatToStr(qryNotas.RecordCount);
  if not qryNotas.IsEmpty then
  begin
    btnVisto.Enabled := func.Usuario.Papel = 'V';
    btnAprovacao.Enabled := func.Usuario.Papel = 'A';
  end;
end;

procedure TfrmMain.ExibirNotas;
begin
  qryNotas.Close;
  qryNotas.ParamByName('pUsua').AsInteger := func.Usuario.IdUsua;
  qryNotas.Open();
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  if not TfrmLogin.CriarLogin then
  begin
    PostMessage(Handle, WM_CLOSE, 0, 0);
    Exit;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  ExibirNotas;
end;

procedure TfrmMain.GravarOperacao(const pOper: String);
begin
  dmConexao.ObtemConfiguracaoNota(qryNotas.FieldByName('valor_total').AsFloat,
                                 QuantVistoNecessario,
                                 QuantAprovNecessario);
  dmConexao.ObtemLogNota(qryNotas.FieldByName('ID').AsInteger,
                         QuantVistoObtido,
                         QuantAprovObtido);

  if QuantVistoObtido < QuantVistoNecessario then
  begin
    dmConexao.GravarOperacao(qryNotas.FieldByName('ID').AsInteger,
                             func.Usuario.IdUsua,
                             pOper, qryNotas.FieldByName('valor_total').AsFloat);
  end
  else
  begin
    ShowMessage(Format('A nota %d j� atingiu a quantidade de visto necess�rio.',
                       [qryNotas.FieldByName('ID').AsInteger]));
  end;
  qryNotas.Refresh;
end;

procedure TfrmMain.qryNotasAfterOpen(DataSet: TDataSet);
begin
  (DataSet.FieldByName('id') as TIntegerField).DisplayFormat := '000000';
  (DataSet.FieldByName('valor_desc') as TNumericField).DisplayFormat := '##0.00';
  (DataSet.FieldByName('valor_frete') as TNumericField).DisplayFormat := '##0.00';
  (DataSet.FieldByName('valor_merc') as TNumericField).DisplayFormat := '##0.00';
  (DataSet.FieldByName('valor_total') as TNumericField).DisplayFormat := '##0.00';
  ConfigurarStatus;
end;

procedure TfrmMain.qryNotasAfterRefresh(DataSet: TDataSet);
begin
  ConfigurarStatus;
end;

function TfrmMain.ValidarData: Boolean;
begin
  Result := False;
  if ((Trim(edtDataIni.Text) = EmptyStr) and
      (Trim(edtDataFim.Text) = EmptyStr)) then
  begin
    edtDataIni.SetFocus;
    ShowMessage('� necess�rio informar um per�odo de data.');
    Exit;
  end;

  if edtDataFim.Date > edtDataIni.Date then
  begin
    edtDataIni.SetFocus;
    ShowMessage('A data final n�o pode maior do que a data inicial.');
    Exit;
  end;
  Result := True;
end;

end.

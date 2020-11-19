unit funcoes;

interface

uses
  Classes, Windows, Forms, SysUtils, IniFiles, vcl.controls, vcl.Dialogs;

const
  NOME_ARQUIVO_CONFIG = '\config.ini';

type
  TUsuario = class(TObject)
  private
    FValMaxAp: Double;
    FPapel: String;
    FNomeUsuario: String;
    FValMinAp: Double;
    FIdUsua: Integer;
    function GetPapelStr: String;
  public
    property IdUsua: Integer read FIdUsua write FIdUsua;
    property NomeUsuario: String Read FNomeUsuario write FNomeUsuario;
    property Papel: String read FPapel write FPapel;
    property PapelStr: String read GetPapelStr;
    property ValMinAp: Double read FValMinAp write FValMinAp;
    property ValMaxAp: Double read FValMaxAp write FValMaxAp;
  end;

  TFuncoes = class(TObject)
  private
    FUsuario: TUsuario;
    class procedure GetInstance;
    class procedure ReleaseInstance;
    constructor Create; reintroduce;
  public
    Destructor Destroy; Override;
    function LeIniStr(sPath: string; sSessao: string; sItend: string; sDefault: string): string;
    function ObterCaminhoBancoDados: string;
    property Usuario: TUsuario read FUsuario write FUsuario;
  end;

var
  Func: TFuncoes;


implementation


{ TFuncoes }

constructor TFuncoes.Create;
begin
  FUsuario := TUsuario.Create;
end;

destructor TFuncoes.Destroy;
begin
  inherited;
  FUsuario.Free;
end;

class procedure TFuncoes.GetInstance;
begin
  if not Assigned(Func) then
    Func := TFuncoes.Create;
end;

function TFuncoes.LeIniStr(sPath, sSessao, sItend, sDefault: string): string;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(sPath);
  try
    Result := ini.ReadString(sSessao, sItend, sDefault);
  finally
    FreeAndNil(ini);
  end;
end;

function TFuncoes.ObterCaminhoBancoDados: string;
var
  sNomeArqIni: string;
begin
  sNomeArqIni := ExtractFileDir(Application.ExeName) + NOME_ARQUIVO_CONFIG;
  if not FileExists(sNomeArqIni) Then
  begin
    ShowMessage('Arquivo de configura��o n�o encontrado.');
    Application.Terminate;
    Exit;
  end;
  Result := LeIniStr(sNomeArqIni, 'Comunicacao', 'BaseDados', '');
end;

class procedure TFuncoes.ReleaseInstance;
begin
  if Assigned(Func) then
    Func.Free;
end;

{ TUsuario }

function TUsuario.GetPapelStr: String;
begin
  if FPapel = 'V' then
    Result := 'Visto'
  else
    Result := 'Aprova��o';
end;

Initialization

TFuncoes.GetInstance;

Finalization

TFuncoes.ReleaseInstance;

end.

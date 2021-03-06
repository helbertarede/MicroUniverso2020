program Compras;

uses
  Vcl.Forms,
  System.SysUtils,
  Vcl.Controls,
  Sharemem,
  MainFrm in 'MainFrm.pas' {frmMain},
  ConexaoDtm in 'fontes\ConexaoDtm.pas' {dmConexao: TDataModule},
  funcoes in 'fontes\funcoes.pas',
  LoginFrm in 'fontes\LoginFrm.pas' {frmLogin},
  CadUsuaFrm in 'fontes\CadUsuaFrm.pas' {frmCadUsua},
  CadNotasFrm in 'fontes\CadNotasFrm.pas' {frmCadNotas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  if Assigned(dmConexao) then
    FreeAndNil(dmConexao);
end.

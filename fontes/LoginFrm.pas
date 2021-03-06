unit LoginFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  dxGDIPlusClasses, Vcl.Buttons, ConexaoDtm, funcoes, CadUsuaFrm;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    imgIcoFechar: TImage;
    Label13: TLabel;
    Label12: TLabel;
    boxCampoSel: TShape;
    pnUsuario: TPanel;
    pnSenha: TPanel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Panel2: TPanel;
    btnConfirmar: TBitBtn;
    SpeedButton1: TSpeedButton;
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgIcoFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LinkLabel1Click(Sender: TObject);
    procedure edtUsuarioEnter(Sender: TObject);
    procedure edtSenhaEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    FUsuarioLogado: Boolean;
    procedure ExibirBordasCampo(pn: TPanel);
    { Private declarations }
  public
    class function CriarLogin: Boolean;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  Self.left := ( Screen.Width div 2 ) - ( Self.Width div 2 );
  Self.Top := ( Screen.Height div 2 ) - ( Self.height div 2 ) -4;
  FUsuarioLogado := False;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  if not dmConexao.AbreConexaoDB then
  begin
    btnConfirmar.Enabled := False;

  end;

end;

procedure TfrmLogin.btnConfirmarClick(Sender: TObject);
begin
  if (Trim(edtUsuario.Text) = EmptyStr) or
     (Trim(edtSenha.Text) = EmptyStr) then
  begin
    ShowMessage('Usu�rio ou senh�o n�o informado.');
    edtUsuario.SetFocus;
    Exit;
  end;

  if not dmConexao.RealizarLogin(edtUsuario.Text, edtSenha.Text) then
  begin
    showmessage('Usu�rio n�o cadastrado!');
    edtUsuario.SetFocus;
    edtSenha.Clear;
  end
  else
  begin
    FUsuarioLogado := True;
    Close;
  end;
end;

class function TfrmLogin.CriarLogin: Boolean;
var
  frm: TfrmLogin;
begin
  Result := False;
  frm := TfrmLogin.Create(nil);
  try
    frm.ShowModal;
    Result := frm.FUsuarioLogado;
  finally
    FreeAndNil(frm);
  end;
end;

procedure TfrmLogin.edtSenhaEnter(Sender: TObject);
begin
  ExibirBordasCampo(pnSenha);
end;

procedure TfrmLogin.edtUsuarioEnter(Sender: TObject);
begin
  ExibirBordasCampo(pnUsuario);
end;

procedure TfrmLogin.ExibirBordasCampo(pn: TPanel);
begin
  boxCampoSel.Top := pn.Top -5;
  boxCampoSel.Left := pn.Left -5;
  boxCampoSel.Visible := True;
end;

procedure TfrmLogin.imgIcoFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.LinkLabel1Click(Sender: TObject);
begin
  showmessage('novo usuario');
end;

procedure TfrmLogin.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  SC_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, SC_DragMove, 0);
end;

procedure TfrmLogin.SpeedButton1Click(Sender: TObject);
var
  frm: TfrmCadUsua;
begin
  frm := TfrmCadUsua.Create(Self);
  try
    frm.ShowModal;
  finally
    FreeAndNil(frm);
  end;
end;

end.

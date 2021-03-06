unit CadUsuaFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ConexaoDtm, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxCurrencyEdit, cxDBEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmCadUsua = class(TForm)
    qryUsuario: TFDTable;
    qryUsuarioid: TFDAutoIncField;
    qryUsuariologin: TWideStringField;
    qryUsuariosenha: TWideStringField;
    qryUsuariopapel: TStringField;
    qryUsuarioval_min: TBCDField;
    qryUsuarioval_max: TBCDField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    pnCampos: TPanel;
    Label2: TLabel;
    edtLogin: TcxDBTextEdit;
    Label3: TLabel;
    edtSenha: TcxDBTextEdit;
    Label4: TLabel;
    Label5: TLabel;
    cxDBCurrencyEdit1: TcxDBCurrencyEdit;
    Label6: TLabel;
    cxDBCurrencyEdit2: TcxDBCurrencyEdit;
    cboPapel: TDBComboBox;
    procedure FormShow(Sender: TObject);
    procedure qryUsuarioBeforeInsert(DataSet: TDataSet);
    procedure qryUsuarioAfterPost(DataSet: TDataSet);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadUsua: TfrmCadUsua;

implementation

{$R *.dfm}

procedure TfrmCadUsua.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  case Button of
    nbFirst: ;
    nbPrior: ;
    nbNext: ;
    nbLast: ;
    nbInsert, nbEdit:
      begin
        pnCampos.Enabled := True;
        if edtLogin.CanFocus then
          edtLogin.SetFocus;
      end;
    nbDelete: ;
    nbPost:
      begin
        pnCampos.Enabled := False;
      end;
    nbCancel: ;
    nbRefresh: ;
    nbApplyUpdates: ;
    nbCancelUpdates: ;
  end;
end;

procedure TfrmCadUsua.FormShow(Sender: TObject);
begin
  qryUsuario.Open();
end;

procedure TfrmCadUsua.qryUsuarioAfterPost(DataSet: TDataSet);
begin
  dmConexao.FecharTransacao;
  DataSet.Refresh;
end;

procedure TfrmCadUsua.qryUsuarioBeforeInsert(DataSet: TDataSet);
begin
  dmConexao.IniciarTransacao;
end;

end.

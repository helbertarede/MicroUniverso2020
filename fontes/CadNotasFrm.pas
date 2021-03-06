unit CadNotasFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ConexaoDtm, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxCurrencyEdit, cxDBEdit,
  cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit, cxSpinEdit, Vcl.StdCtrls,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TfrmCadNotas = class(TForm)
    DBNavigator1: TDBNavigator;
    qryNota: TFDTable;
    qryNotaid: TFDAutoIncField;
    qryNotadt_emiss: TDateTimeField;
    qryNotavalor_merc: TBCDField;
    qryNotavalor_desc: TBCDField;
    qryNotavalor_frete: TBCDField;
    qryNotavalor_total: TBCDField;
    qryNotastatus: TStringField;
    DataSource1: TDataSource;
    Label1: TLabel;
    cxDBSpinEdit1: TcxDBSpinEdit;
    Label2: TLabel;
    edtData: TcxDBDateEdit;
    Label3: TLabel;
    edtValMerc: TcxDBCurrencyEdit;
    Label4: TLabel;
    edtValDesconto: TcxDBCurrencyEdit;
    Label5: TLabel;
    edtValFrete: TcxDBCurrencyEdit;
    Label6: TLabel;
    edtValTotal: TcxDBCurrencyEdit;
    procedure qryNotaAfterPost(DataSet: TDataSet);
    procedure qryNotaBeforeInsert(DataSet: TDataSet);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure FormShow(Sender: TObject);
    procedure qryNotaNewRecord(DataSet: TDataSet);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TfrmCadNotas.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  case Button of
    nbFirst: ;
    nbPrior: ;
    nbNext: ;
    nbLast: ;
    nbInsert, nbEdit:
      begin
        if edtData.CanFocus then
          edtData.SetFocus;
      end;
    nbDelete: ;
    nbPost: ;
    nbCancel: ;
    nbRefresh: ;
    nbApplyUpdates: ;
    nbCancelUpdates: ;  end;

end;

procedure TfrmCadNotas.FormShow(Sender: TObject);
begin
  qryNota.Open();
  qryNota.Insert;
end;

procedure TfrmCadNotas.qryNotaAfterPost(DataSet: TDataSet);
begin
  dmConexao.FecharTransacao;
  qryNota.Refresh;
end;

procedure TfrmCadNotas.qryNotaBeforeInsert(DataSet: TDataSet);
begin
  dmConexao.IniciarTransacao;
end;

procedure TfrmCadNotas.qryNotaNewRecord(DataSet: TDataSet);
begin
  qryNota.FieldByName('STATUS').AsString := 'P';
  qryNota.FieldByName('dt_emiss').AsDateTime := Now;
end;

end.

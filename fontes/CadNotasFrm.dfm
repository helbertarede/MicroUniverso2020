object frmCadNotas: TfrmCadNotas
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastrar Notas'
  ClientHeight = 161
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 56
    Width = 8
    Height = 13
    Caption = 'id'
    FocusControl = cxDBSpinEdit1
  end
  object Label2: TLabel
    Left = 169
    Top = 56
    Width = 42
    Height = 13
    Caption = 'dt_emiss'
    FocusControl = edtData
  end
  object Label3: TLabel
    Left = 17
    Top = 104
    Width = 77
    Height = 13
    Caption = 'Vlr. Mercadorias'
    FocusControl = edtValMerc
  end
  object Label4: TLabel
    Left = 169
    Top = 104
    Width = 64
    Height = 13
    Caption = 'Vlr. Desconto'
    FocusControl = edtValDesconto
  end
  object Label5: TLabel
    Left = 321
    Top = 104
    Width = 45
    Height = 13
    Caption = 'Vlr. Frete'
    FocusControl = edtValFrete
  end
  object Label6: TLabel
    Left = 465
    Top = 104
    Width = 43
    Height = 13
    Caption = 'Vlr. Total'
    FocusControl = edtValTotal
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 0
    Width = 597
    Height = 25
    DataSource = DataSource1
    VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
    Align = alTop
    TabOrder = 5
    OnClick = DBNavigator1Click
    ExplicitLeft = 200
    ExplicitTop = 72
    ExplicitWidth = 240
  end
  object cxDBSpinEdit1: TcxDBSpinEdit
    Left = 17
    Top = 72
    DataBinding.DataField = 'id'
    DataBinding.DataSource = DataSource1
    Enabled = False
    TabOrder = 6
    Width = 121
  end
  object edtData: TcxDBDateEdit
    Left = 169
    Top = 72
    DataBinding.DataField = 'dt_emiss'
    DataBinding.DataSource = DataSource1
    TabOrder = 0
    Width = 121
  end
  object edtValMerc: TcxDBCurrencyEdit
    Left = 17
    Top = 120
    DataBinding.DataField = 'valor_merc'
    DataBinding.DataSource = DataSource1
    TabOrder = 1
    Width = 121
  end
  object edtValDesconto: TcxDBCurrencyEdit
    Left = 169
    Top = 120
    DataBinding.DataField = 'valor_desc'
    DataBinding.DataSource = DataSource1
    TabOrder = 2
    Width = 121
  end
  object edtValFrete: TcxDBCurrencyEdit
    Left = 321
    Top = 120
    DataBinding.DataField = 'valor_frete'
    DataBinding.DataSource = DataSource1
    TabOrder = 3
    Width = 121
  end
  object edtValTotal: TcxDBCurrencyEdit
    Left = 465
    Top = 120
    DataBinding.DataField = 'valor_total'
    DataBinding.DataSource = DataSource1
    Enabled = False
    TabOrder = 4
    Width = 121
  end
  object qryNota: TFDTable
    BeforeInsert = qryNotaBeforeInsert
    AfterPost = qryNotaAfterPost
    OnNewRecord = qryNotaNewRecord
    IndexFieldNames = 'id'
    Connection = dmConexao.dcBanco
    UpdateOptions.UpdateTableName = 'nota_compra'
    TableName = 'nota_compra'
    Left = 448
    Top = 48
    object qryNotaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryNotadt_emiss: TDateTimeField
      FieldName = 'dt_emiss'
      Origin = 'dt_emiss'
    end
    object qryNotavalor_merc: TBCDField
      FieldName = 'valor_merc'
      Origin = 'valor_merc'
      Precision = 15
      Size = 2
    end
    object qryNotavalor_desc: TBCDField
      FieldName = 'valor_desc'
      Origin = 'valor_desc'
      Precision = 15
      Size = 2
    end
    object qryNotavalor_frete: TBCDField
      FieldName = 'valor_frete'
      Origin = 'valor_frete'
      Precision = 15
      Size = 2
    end
    object qryNotavalor_total: TBCDField
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 15
      Size = 2
    end
    object qryNotastatus: TStringField
      FieldName = 'status'
      Origin = 'status'
      FixedChar = True
      Size = 1
    end
  end
  object DataSource1: TDataSource
    DataSet = qryNota
    Left = 528
    Top = 48
  end
end

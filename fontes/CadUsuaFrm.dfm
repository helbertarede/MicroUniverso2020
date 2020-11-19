object frmCadUsua: TfrmCadUsua
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Us'#225'rio'
  ClientHeight = 367
  ClientWidth = 622
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 25
    Width = 622
    Height = 200
    Align = alTop
    DataSource = DataSource1
    Enabled = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'login'
        Width = 188
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'senha'
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'papel'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'val_min'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'val_max'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 0
    Width = 622
    Height = 25
    DataSource = DataSource1
    Align = alTop
    TabOrder = 1
    OnClick = DBNavigator1Click
    ExplicitLeft = 40
    ExplicitTop = 153
    ExplicitWidth = 240
  end
  object pnCampos: TPanel
    Left = 0
    Top = 229
    Width = 622
    Height = 138
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 264
    object Label2: TLabel
      Left = 80
      Top = 16
      Width = 22
      Height = 13
      Caption = 'login'
      FocusControl = edtLogin
    end
    object Label3: TLabel
      Left = 223
      Top = 16
      Width = 29
      Height = 13
      Caption = 'senha'
      FocusControl = edtSenha
    end
    object Label4: TLabel
      Left = 80
      Top = 72
      Width = 26
      Height = 13
      Caption = 'papel'
    end
    object Label5: TLabel
      Left = 215
      Top = 72
      Width = 36
      Height = 13
      Caption = 'val_min'
      FocusControl = cxDBCurrencyEdit1
    end
    object Label6: TLabel
      Left = 358
      Top = 72
      Width = 40
      Height = 13
      Caption = 'val_max'
      FocusControl = cxDBCurrencyEdit2
    end
    object edtLogin: TcxDBTextEdit
      Left = 80
      Top = 32
      DataBinding.DataField = 'login'
      DataBinding.DataSource = DataSource1
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 121
    end
    object edtSenha: TcxDBTextEdit
      Left = 223
      Top = 32
      DataBinding.DataField = 'senha'
      DataBinding.DataSource = DataSource1
      TabOrder = 1
      Width = 121
    end
    object cxDBCurrencyEdit1: TcxDBCurrencyEdit
      Left = 215
      Top = 88
      DataBinding.DataField = 'val_min'
      DataBinding.DataSource = DataSource1
      TabOrder = 2
      Width = 121
    end
    object cxDBCurrencyEdit2: TcxDBCurrencyEdit
      Left = 358
      Top = 88
      DataBinding.DataField = 'val_max'
      DataBinding.DataSource = DataSource1
      TabOrder = 3
      Width = 121
    end
    object cboPapel: TDBComboBox
      Left = 80
      Top = 88
      Width = 121
      Height = 21
      DataField = 'papel'
      DataSource = DataSource1
      Items.Strings = (
        'VISTO'
        'APROVA'#199#195'O')
      TabOrder = 4
    end
  end
  object qryUsuario: TFDTable
    BeforeInsert = qryUsuarioBeforeInsert
    AfterPost = qryUsuarioAfterPost
    IndexFieldNames = 'id'
    Connection = dmConexao.dcBanco
    UpdateOptions.UpdateTableName = 'usuario'
    TableName = 'usuario'
    Left = 368
    Top = 160
    object qryUsuarioid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryUsuariologin: TWideStringField
      FieldName = 'login'
      Origin = 'login'
      Size = 60
    end
    object qryUsuariosenha: TWideStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 30
    end
    object qryUsuariopapel: TStringField
      FieldName = 'papel'
      Origin = 'papel'
      FixedChar = True
      Size = 1
    end
    object qryUsuarioval_min: TBCDField
      FieldName = 'val_min'
      Origin = 'val_min'
      Precision = 12
      Size = 2
    end
    object qryUsuarioval_max: TBCDField
      FieldName = 'val_max'
      Origin = 'val_max'
      Precision = 12
      Size = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = qryUsuario
    Left = 536
    Top = 152
  end
end

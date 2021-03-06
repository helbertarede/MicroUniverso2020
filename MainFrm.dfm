object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Notas de Compras'
  ClientHeight = 497
  ClientWidth = 839
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 839
    Height = 113
    Align = alTop
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 8
      Top = 5
      Width = 425
      Height = 55
      Caption = 'Per'#237'odo de Compra'
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 22
        Width = 51
        Height = 13
        Caption = 'Data inicial'
      end
      object Label2: TLabel
        Left = 236
        Top = 22
        Width = 46
        Height = 13
        Caption = 'Data final'
      end
      object edtDataIni: TDateEdit
        Left = 120
        Top = 17
        Width = 96
        Height = 21
        NumGlyphs = 2
        TabOrder = 0
      end
      object edtDataFim: TDateEdit
        Left = 328
        Top = 17
        Width = 96
        Height = 21
        NumGlyphs = 2
        TabOrder = 1
      end
    end
    object btnFiltrar: TBitBtn
      Left = 608
      Top = 10
      Width = 100
      Height = 30
      Hint = 'Filtar Notas'
      Caption = 'Filtrar'
      TabOrder = 1
      OnClick = btnFiltrarClick
    end
    object btnLimparFiltro: TBitBtn
      Left = 714
      Top = 10
      Width = 100
      Height = 30
      Hint = 'Limpar Filtro'
      Caption = 'Limpar Filtro'
      TabOrder = 2
      OnClick = btnLimparFiltroClick
    end
    object btnUsuario: TBitBtn
      Left = 608
      Top = 74
      Width = 100
      Height = 30
      Hint = 'Logar com outro usu'#225'rio'
      Caption = 'Logar Usua'
      TabOrder = 3
      OnClick = btnUsuarioClick
    end
    object btnVisto: TBitBtn
      Left = 714
      Top = 42
      Width = 100
      Height = 30
      Hint = 'Realizar Visto da Nota'
      Caption = 'Visto'
      Enabled = False
      TabOrder = 4
      OnClick = btnVistoClick
    end
    object btnAprovacao: TBitBtn
      Left = 714
      Top = 74
      Width = 100
      Height = 30
      Hint = 'Realizar Aprova'#231#227'o da Nota'
      Caption = 'Aprova'#231#227'o'
      Enabled = False
      TabOrder = 5
      OnClick = btnAprovacaoClick
    end
    object btnCadNota: TBitBtn
      Left = 608
      Top = 42
      Width = 100
      Height = 30
      Hint = 'Cadastrar Notas'
      Caption = 'Cadastrar Notas'
      TabOrder = 6
      OnClick = btnCadNotaClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 113
    Width = 839
    Height = 365
    Align = alClient
    DataSource = dsNotas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Title.Caption = 'N'#250'mero'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dt_emiss'
        Title.Caption = 'Data Emiss'#227'o'
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_merc'
        Title.Caption = 'Vlr. Mercadoria'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_desc'
        Title.Caption = 'Vlr. Desconto'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_frete'
        Title.Caption = 'Vlr. Frete'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_total'
        Title.Caption = 'Vlr. Total'
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_STATUS'
        Title.Caption = 'Status'
        Width = 68
        Visible = True
      end>
  end
  object stbStatus: TStatusBar
    Left = 0
    Top = 478
    Width = 839
    Height = 19
    Panels = <
      item
        Text = 'Usu'#225'rio:'
        Width = 50
      end
      item
        Text = 'Helbert'
        Width = 100
      end
      item
        Text = 'Papel:'
        Width = 50
      end
      item
        Text = 'teste'
        Width = 100
      end
      item
        Text = 'Vlr. Mim. Ap.'
        Width = 75
      end
      item
        Text = '1000'
        Width = 100
      end
      item
        Text = 'Vlr. Max. Ap'
        Width = 75
      end
      item
        Text = '100'
        Width = 100
      end
      item
        Text = 'Quant. Notas:'
        Width = 90
      end
      item
        Text = '333'
        Width = 50
      end>
  end
  object dsNotas: TDataSource
    DataSet = qryNotas
    Left = 432
    Top = 304
  end
  object qryNotas: TFDQuery
    AfterOpen = qryNotasAfterOpen
    AfterRefresh = qryNotasAfterRefresh
    Connection = dmConexao.dcBanco
    Transaction = dmConexao.fdTransaction
    SQL.Strings = (
      'select'
      '    id,'
      '    dt_emiss,'
      '    valor_desc,'
      '    valor_frete,'
      '    valor_merc,'
      '    valor_total,'
      '    status,'
      '    case status'
      '        when '#39'P'#39' then '#39'Pendente'#39
      '        when '#39'A'#39' then '#39'Aprovado'#39
      '    end as DESCRICAO_STATUS'
      'from nota_compra'
      'where (nota_compra.status = '#39'P'#39' or'
      '       nota_compra.status = '#39#39')'
      '  and not exists(select 1'
      '                 from nota_log'
      '                 where nota_log.cod_nota = nota_compra.id'
      '                   and nota_log.cod_usua = :pUsua)')
    Left = 472
    Top = 208
    ParamData = <
      item
        Name = 'PUSUA'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end

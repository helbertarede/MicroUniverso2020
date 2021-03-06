object dmConexao: TdmConexao
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 335
  Width = 478
  object dcBanco: TFDConnection
    Params.Strings = (
      
        'Database=C:\Desenvolvimento\Ultilitarios\MicroUniverso\DataBase\' +
        'compras.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockWait, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    LoginPrompt = False
    Transaction = fdTransaction
    UpdateTransaction = fdTransaction
    Left = 40
    Top = 32
  end
  object fdTransaction: TFDTransaction
    Connection = dcBanco
    Left = 104
    Top = 48
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 72
    Top = 184
  end
  object qryLoginUsua: TFDQuery
    Connection = dcBanco
    SQL.Strings = (
      'select '
      '    id,'
      '    login,'
      '    senha,'
      '    papel,'
      '    val_min,'
      '    val_max'
      'from usuario '
      'where usuario.login = :pusuario '
      '  and usuario.senha = :pSenha')
    Left = 224
    Top = 152
    ParamData = <
      item
        Name = 'PUSUARIO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PSENHA'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryInsNotaLog: TFDQuery
    Connection = dcBanco
    SQL.Strings = (
      
        'insert into nota_log(cod_nota, cod_usua, data, operacao) values ' +
        '(:cod_nota, :cod_usua, :data, :operacao)')
    Left = 280
    Top = 152
    ParamData = <
      item
        Name = 'COD_NOTA'
        ParamType = ptInput
      end
      item
        Name = 'COD_USUA'
        ParamType = ptInput
      end
      item
        Name = 'DATA'
        ParamType = ptInput
      end
      item
        Name = 'OPERACAO'
        ParamType = ptInput
      end>
  end
  object qryUpdNota: TFDQuery
    Connection = dcBanco
    SQL.Strings = (
      'update nota_compra set'
      '    status = '#39'A'#39
      'where id = :Id')
    Left = 336
    Top = 152
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qryConfig: TFDQuery
    Connection = dcBanco
    SQL.Strings = (
      'select '
      '    val_ini,'
      '    val_final,'
      '    visto,'
      '    aprovacao'
      'from configuracao'
      'where :val_nota between val_ini and val_final')
    Left = 224
    Top = 208
    ParamData = <
      item
        Name = 'VAL_NOTA'
        ParamType = ptInput
      end>
  end
  object qryLogNota: TFDQuery
    Connection = dcBanco
    SQL.Strings = (
      'select '
      '  count(*) as quant,'
      '  operacao'
      'from nota_log'
      'where nota_log.cod_nota = :cod_nota'
      ' and operacao = '#39'V'#39
      'group by operacao'
      ''
      'union all'
      ''
      'select '
      '  count(*) as quant,'
      '  operacao'
      'from nota_log'
      'where nota_log.cod_nota = :cod_nota'
      ' and operacao = '#39'A'#39
      'group by operacao')
    Left = 280
    Top = 208
    ParamData = <
      item
        Name = 'COD_NOTA'
        ParamType = ptInput
      end>
  end
end

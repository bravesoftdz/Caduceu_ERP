object frmResultadoProcucao: TfrmResultadoProcucao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Estoque resultante da produ'#231#227'o'
  ClientHeight = 478
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgSair: TImage
    Left = 598
    Top = 426
    Width = 51
    Height = 44
    Cursor = crHandPoint
    Hint = 'Sair'
    ParentShowHint = False
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000280000
      002808060000008CFEB86D000000097048597300000EC400000EC401952B0E1B
      0000025C4944415478DA63FCFFFF3FC360068CA30E1C75E06075E02D15467620
      5508C40940AC02C44C600D4C8C0CFFFF51C553FF80F80E102F00E27EB53BFF7F
      12ED40A8E33603B12B86068803A91DEC7B80D8179B237139B01C487560F5116D
      1C08029540077612EBC09B404A8DCE0EBC0D74A03AB10EFC03A498E9ECC07F40
      07B210EB409C0EA0A10319800E641A190E0482FFB269A50CEF8FEC65F87CE52C
      5E4B79B50D18046DDD191ECFEA22583C51CD81F279F5FFD972EAC1FCE741260C
      9F2F617724C871921BCF83D9BFA635333C9C508FD7915471A05C66050347713B
      8AFCF300138C9044761C0CFC9C50C3F0704A2B6D1DC86F6AC320BEFC30863C72
      4862731C08BC8CB167F878E2106D1D088A623E139BFFE2CB302D7A0174E4FFBF
      7FB13AEE75AC23C3FBE30718F001AAE662684832100308851C4D1C0862F39BD9
      32600B4994908B0186DC09FC21473307127224298EA399037165081000A5C94F
      97F097933475203EC7211C690A74E419FA3B9018C7C100BEC29C260EE4D1D4FF
      8FB52801A6B97FFFFE32602F82088724551C080D390C79E40C812BE3100A49AA
      3850A9B8858125B31A451E5B3987AD9CFC33AB83E15E57256D1D088A6295BA89
      FF196372212187A7864009C9A553186E37E651A7B1705B8D89607B4FA9BC83E1
      CDFEAD0C9F4EE1AF4DF88CAD19445C7C19EE75561032F2BFEAAD7FD4712095BA
      9D18C6522D0407830371769A68E8C0BF44779A800EC4D9EDA4A1036F11DDED04
      3A1094A2DBE9EC4050C71D63B0009703710E7DD0C881BB194819FA40722468F0
      281188951990D224951CF81788EF02F17C0652078F06131875E0A803071A0000
      506AF3C058DC002D0000000049454E44AE426082}
    ShowHint = True
    Stretch = True
    OnClick = imgSairClick
  end
  object grpProdutoFinal: TGroupBox
    Left = 8
    Top = 8
    Width = 569
    Height = 49
    Caption = 'Produto final'
    TabOrder = 0
    object edtDescricaoProdutoFinal: TDBEdit
      Left = 3
      Top = 19
      Width = 494
      Height = 21
      TabStop = False
      Color = 14079702
      DataField = 'DESCRICAO_PRODUTO'
      DataSource = dmMSource.dtsOrdemProducao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtUnidadeProdutoFinal: TDBEdit
      Left = 508
      Top = 19
      Width = 35
      Height = 21
      TabStop = False
      Color = 14079702
      DataField = 'UND_PRODUTO'
      DataSource = dmMSource.dtsOrdemProducao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 72
    Width = 569
    Height = 398
    Caption = 'Resultados - Movimenta'#231#227'o'
    TabOrder = 1
    object memResultado: TMemo
      Left = 2
      Top = 15
      Width = 565
      Height = 381
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Lines.Strings = (
        'memResultado')
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 10
      ExplicitTop = 16
      ExplicitWidth = 185
      ExplicitHeight = 89
    end
  end
end

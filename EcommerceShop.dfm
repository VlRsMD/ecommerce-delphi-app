object EccomerceApp: TEccomerceApp
  Left = 0
  Top = 0
  Caption = 'Ecommerce App'
  ClientHeight = 676
  ClientWidth = 875
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object ListBoxProducts: TListBox
    Left = 0
    Top = 0
    Width = 875
    Height = 676
    Align = alClient
    ItemHeight = 15
    TabOrder = 0
    ExplicitLeft = 64
    ExplicitWidth = 737
    ExplicitHeight = 513
  end
  object BtnSaveProducts: TButton
    Left = 368
    Top = 448
    Width = 121
    Height = 33
    Caption = 'Add Custom Product'
    TabOrder = 1
    OnClick = BtnSaveProductsClick
  end
end

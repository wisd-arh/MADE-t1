object Form1: TForm1
  Left = 192
  Top = 103
  Width = 870
  Height = 878
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 104
    Width = 809
    Height = 337
    ColCount = 30
    DefaultColWidth = 120
    DefaultRowHeight = 15
    FixedCols = 0
    RowCount = 10000
    FixedRows = 0
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 8
    Top = 16
    Width = 561
    Height = 21
    TabOrder = 1
    Text = 
      'C:\Documents and Settings\Administrator\Desktop\MADE\1\train_s.c' +
      'sv'
  end
  object Button1: TButton
    Left = 584
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 8
    Top = 48
    Width = 561
    Height = 21
    TabOrder = 3
    Text = 
      'C:\Documents and Settings\Administrator\Desktop\MADE\1\train-tar' +
      'get.csv'
  end
  object Button2: TButton
    Left = 584
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 672
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Train'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Chart1: TChart
    Left = 0
    Top = 448
    Width = 641
    Height = 377
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    Legend.Visible = False
    View3D = False
    BevelOuter = bvNone
    TabOrder = 6
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 832
    Width = 862
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object Button4: TButton
    Left = 672
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Go'
    TabOrder = 8
    OnClick = Button4Click
  end
  object Edit3: TEdit
    Left = 664
    Top = 448
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '100000'
  end
  object Button5: TButton
    Left = 736
    Top = 512
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 10
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 736
    Top = 544
    Width = 75
    Height = 25
    Caption = 'SaveWeight'
    TabOrder = 11
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 736
    Top = 576
    Width = 75
    Height = 25
    Caption = 'LoadWeight'
    TabOrder = 12
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 736
    Top = 616
    Width = 75
    Height = 25
    Caption = 'Test'
    TabOrder = 13
    OnClick = Button8Click
  end
  object Edit4: TEdit
    Left = 8
    Top = 80
    Width = 561
    Height = 21
    TabOrder = 14
    Text = 
      'C:\Documents and Settings\Administrator\Desktop\MADE\1\test_s.cs' +
      'v'
  end
  object Button9: TButton
    Left = 736
    Top = 656
    Width = 75
    Height = 25
    Caption = 'CalcSigma'
    TabOrder = 15
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 736
    Top = 688
    Width = 75
    Height = 25
    Caption = 'Simplify'
    TabOrder = 16
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 736
    Top = 760
    Width = 75
    Height = 25
    Caption = 'DeleteSW'
    TabOrder = 17
    OnClick = Button11Click
  end
end

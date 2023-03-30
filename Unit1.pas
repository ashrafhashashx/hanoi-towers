unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, ComCtrls;

type
  TForm1 = class(TForm)
    BarManager: TButton;
    ThemesManager: TButton;
    L2RManager: TButton;
    L2MManager: TButton;
    M2LManager: TButton;
    M2RManager: TButton;
    R2MManager: TButton;
    R2LManager: TButton;
    SpecialManager: TButton;
    Congratulations: TButton;
    SpeedBarManeger: TButton;
    Timer: TTimer;
    p: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BarManagerClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure ThemesManagerClick(Sender: TObject);
    procedure L2RManagerClick(Sender: TObject);
    procedure L2MManagerClick(Sender: TObject);
    procedure M2LManagerClick(Sender: TObject);
    procedure M2RManagerClick(Sender: TObject);
    procedure R2MManagerClick(Sender: TObject);
    procedure R2LManagerClick(Sender: TObject);
    procedure CongratulationsClick(Sender: TObject);
    procedure SpecialManagerClick(Sender: TObject);
    procedure SpeedBarManegerClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure pClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  B:Boolean;
  Base:TShape;
  LCol{Left Column},
  MCol{Middle Column},
  RCol{Right Column}
  :Array[0..20] of TShape;
  {Why 0..20 ?   :  Because the shape [0] if going to be the column while the
   the rest of the shapes are going to be the disks}
  Bar,SpeedBar:TTrackBar;
  Special,Manager,L2R,L2M,M2L,M2R,R2M,R2L:TButton;
  Moves:TEdit;
  Edit:TMaskEdit;
  {The Manager Button will be used for carrying procedures}
  {The Special Button and the Edit will be both used for the "Special User
   Service"}
  Themes:TComboBox;
  nL{Number of Disks in Left Column},
  nM{Number of Disks in Middle Column},
  nR{Number of Disks in Right Column},
  n{Total Number of Disks}:Byte;
  NumberOfMoves:Integer;
implementation

{$R *.dfm}

procedure Centerize(Shape:TShape;n1,n2:Integer);
  begin
  Shape.Left:=(n1 + n2) div 2 - Shape.Width div 2;
  end;

procedure Zabbit(MassZabbi6ation:Boolean);
  var
    OfficialDiskHeight,OfficialSeperator:Integer;
    i:Byte;
  begin
  if MassZabbi6ation then
    begin
    OfficialSeperator:=1 * Base.Width div 90;
    //Base
      Base.Width:=Form1.Width - 40;
      Base.Height:=10 * Form1.Height div 100;
      Base.Top:=Form1.Height - Base.Height - 44;
      Centerize(Base , -7 , Form1.Width);
    //Bar
      if Base.Height >= 25 then
        Bar.Height:=25
      else
        Bar.Height:=98 * Base.Height div 100;
      Bar.Width:=2 * Base.Width div 9;
      Bar.Top:=Base.Top + (Base.Height - Bar.Height) div 2;
      Bar.Left:=Base.Left + OfficialSeperator;
    //Themes
      if Base.Height >= Themes.Height then
        Themes.Visible:=True
      else
        Themes.Visible:=False;
      Themes.Width:=1 * Base.Width div 9;
      Themes.Top:=Base.Top + (Base.Height - Themes.Height) div 2;
      Themes.Left:=Bar.Left + Bar.Width + OfficialSeperator;
    //Edit
      Edit.Width:=1 * Base.Width div 9;
      if Base.Height >= 21 then
        Edit.Height:= 21
      else
        Edit.Height:= 98 * Base.Height div 100;
      Edit.Top:=Base.Top + (Base.Height - Edit.Height) div 2;
      Edit.Left:=Themes.Left + Themes.Width + OfficialSeperator;
    //Special
      Special.Width:=2 * Base.Width div 9;
      Special.Height:=L2R.Height;
      Special.Top:=L2R.Top;
      Special.Left:=Edit.Left + Edit.Width + OfficialSeperator;
    //L2R, L2M, M2L, M2R, R2M, R2L
      //Width
        L2R.Width:=5 * Base.Width div 180;
        L2M.Width:=L2R.Width;
        M2L.Width:=L2R.Width;
        M2R.Width:=L2R.Width;
        R2M.Width:=L2R.Width;
        R2L.Width:=L2R.Width;
        if Base.Height >= 25 then
          L2R.Height:=25
        else
      //Height
        L2R.Height:=98 * Base.Height div 100;
        L2M.Height:=L2R.Height;
        M2L.Height:=L2R.Height;
        M2R.Height:=L2R.Height;
        R2M.Height:=L2R.Height;
        R2L.Height:=L2R.Height;
      //Top
        L2R.Top:=Base.Top + (Base.Height - L2R.Height) div 2;
        L2M.Top:=L2R.Top;
        M2L.Top:=L2R.Top;
        M2R.Top:=L2R.Top;
        R2M.Top:=L2R.Top;
        R2L.Top:=L2R.Top;
      //Left
        L2R.Left:=Special.Left + Special.Width + OfficialSeperator;
        L2M.Left:=L2R.Left + L2R.Width;
        M2L.Left:=L2M.Left + L2M.Width + OfficialSeperator div 2;
        M2R.Left:=M2L.Left + M2L.Width;
        R2M.Left:=M2R.Left + M2R.Width + OfficialSeperator div 2;
        R2L.Left:=R2M.Left + R2M.Width;
    //Moves
      Moves.Width:=1 * Base.Width div 11;
      if Base.Height >= 21 then
        Moves.Height:= 21
      else
        Moves.Height:= 98 * Base.Height div 100;
      Moves.Top:=Base.Top + (Base.Height - Edit.Height) div 2;
      Moves.Left:=R2L.Left + R2L.Width + OfficialSeperator;
    //SpeedBar
      SpeedBar.Height:=L2R.Height;
      SpeedBar.Width:=R2L.Left + R2L.Width - L2R.Left;
      SpeedBar.Left:=L2R.Left;
      SpeedBar.Top:=L2R.Top;
    //Columns
      //Col
        if Form1.Width > 350 then
          begin
          LCol[0].Width:=4;
          MCol[0].Width:=4;
          RCol[0].Width:=4;
          end
        else
          begin
          LCol[0].Width:=2;
          MCol[0].Width:=2;
          RCol[0].Width:=2;
          end;

        LCol[0].Height:=99 * Base.Top div 100;
        MCol[0].Height:=LCol[0].Height;
        RCol[0].Height:=MCol[0].Height;

        LCol[0].Top:=Base.Top - LCol[0].Height;
        MCol[0].Top:=LCol[0].Top;
        RCol[0].Top:=MCol[0].Top;

        Centerize(LCol[0],
          Base.Left + 0 * Base.Width div 3 , Base.Left + 1 * Base.Width div 3);
        Centerize(MCol[0],
          Base.Left + 1 * Base.Width div 3 , Base.Left + 2 * Base.Width div 3);
        Centerize(RCol[0],
          Base.Left + 2 * Base.Width div 3 , Base.Left + 3 * Base.Width div 3);
    end;
    //Disks
      for i:=1 to 20 do
        begin
        LCol[i].Width:=StrToInt(LCol[i].Hint) * 5 * (Base.Width div 3) div 101;
        MCol[i].Width:=StrToInt(MCol[i].Hint) * 5 * (Base.Width div 3) div 101;
        RCol[i].Width:=StrToInt(RCol[i].Hint) * 5 * (Base.Width div 3) div 101;
        OfficialDiskHeight:=1 * (98 * Base.Top div 100) div 20;
        LCol[i].Height:=OfficialDiskHeight;
        MCol[i].Height:=OfficialDiskHeight;
        RCol[i].Height:=OfficialDiskHeight;
        LCol[i].Top:=Base.Top - i * (100 * OfficialDiskHeight div 99);
        MCol[i].Top:=LCol[i].Top;
        RCol[i].Top:=MCol[i].Top;
        Centerize(LCol[i],
          Base.Left + 0 * Base.Width div 3 , Base.Left + 1 * Base.Width div 3);
        Centerize(MCol[i],
          Base.Left + 1 * Base.Width div 3 , Base.Left + 2 * Base.Width div 3);
        Centerize(RCol[i],
          Base.Left + 2 * Base.Width div 3 , Base.Left + 3 * Base.Width div 3);
        end;
  end;

procedure TForm1.FormCreate(Sender: TObject);
  var
    i:Byte;
  begin
  //Base
    Base:=TShape.Create(Application);
    Base.Parent:=Form1;
    Base.Brush.Color:=clYellow;
  //Columns
    for i:=0 to 20 do
      begin
      LCol[i]:=TShape.Create(Application);
      LCol[i].Parent:=Form1;
      LCol[i].Brush.Color:=clYellow;
      LCol[i].Hint:='1';
      LCol[i].Hide;
      LCol[0].Hint:='21';
      LCol[0].Show;
      MCol[i]:=TShape.Create(Application);
      MCol[i].Parent:=Form1;
      MCol[i].Brush.Color:=clYellow;
      MCol[i].Hint:='1';
      MCol[i].Hide;
      MCol[0].Hint:='21';
      MCol[0].Show;
      RCol[i]:=TShape.Create(Application);
      RCol[i].Parent:=Form1;
      RCol[i].Brush.Color:=clYellow;
      RCol[i].Hint:='1';
      RCol[i].Hide;
      RCol[0].Hint:='21';
      RCol[0].Show;
      end;
  //Bar
    Bar:=TTrackBar.Create(Application);
    Bar.Parent:=Form1;
    Bar.Position:=3;
    Bar.Min:=1;
    Bar.Max:=20;
    Bar.OnChange:=BarManager.OnClick;
  //SpeedBar
    SpeedBar:=TTrackBar.Create(Application);
    SpeedBar.Parent:=Form1;
    SpeedBar.Hide;
    SpeedBar.Min:=1;
    SpeedBar.Max:=40;
    SpeedBar.Position:=20;
    SpeedBar.OnChange:=SpeedBarManeger.OnClick;
  //L2R
    L2R:=TButton.Create(Application);
    L2R.Parent:=Form1;
    L2R.Caption:='<';
    L2R.OnClick:=L2RManager.OnClick;
  //L2M
    L2M:=TButton.Create(Application);
    L2M.Parent:=Form1;
    L2M.Caption:='>';
    L2M.OnClick:=L2MManager.OnClick;
  //M2L
    M2L:=TButton.Create(Application);
    M2L.Parent:=Form1;
    M2L.Caption:='<';
    M2L.OnClick:=M2LManager.OnClick;
  //M2R
    M2R:=TButton.Create(Application);
    M2R.Parent:=Form1;
    M2R.Caption:='>';
    M2R.OnClick:=M2RManager.OnClick;
  //R2M
    R2M:=TButton.Create(Application);
    R2M.Parent:=Form1;
    R2M.Hint:=R2M.Name;
    R2M.Caption:='<';
    R2M.OnClick:=R2MManager.OnClick;
  //R2L
    R2L:=TButton.Create(Application);
    R2L.Parent:=Form1;
    R2L.Caption:='>';
    R2L.OnClick:=R2LManager.OnClick;
  //Edit
    Edit:=TMaskEdit.Create(Application);
    Edit.Parent:=Form1;
    Edit.Text:='Password';
    Edit.OnClick:=p.OnClick;
    B:=False;
  //Moves
    Moves:=TEdit.Create(Application);
    Moves.Parent:=Form1;
    Moves.Text:='Number of Moves';
  //Special
    Special:=TButton.Create(Application);
    Special.Parent:=Form1;
    Special.OnClick:=SpecialManager.OnClick;
    Special.Caption:='Activate the auto solution';
  //Themes
    Themes:=TComboBox.Create(Application);
    Themes.Parent:=Form1;
    Themes.Text:='Banana';
    Themes.OnChange:=ThemesManager.OnClick;
    Themes.AddItem('Banana',Manager);
    Themes.AddItem('Berry',Manager);
    Themes.AddItem('Kiwi',Manager);
    Themes.AddItem('Orange',Manager);
    Themes.AddItem('Cherry',Manager);
  //Default
    nL:=Bar.Position;
    nM:=0;
    nR:=0;
    n:=3;
    for i:=1 to nL do
      begin
      LCol[i].Show;
      LCOl[i].Hint:=IntToStr(nL + 1 - i);
      end;
  //Zabbit
    Zabbit(True);
    NumberOfMoves:=0;
  end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Zabbit(True);
end;

procedure TForm1.BarManagerClick(Sender: TObject);
  var
    i:Byte;
  begin
  SpeedBar.Position:=20;
  Moves.Text:='0';
  NumberOfMoves:=0;
  L2R.OnClick:=L2RManager.OnClick;
  L2M.OnClick:=L2MManager.OnClick;
  M2L.OnClick:=M2LManager.OnClick;
  M2R.OnClick:=M2RManager.OnClick;
  R2M.OnClick:=R2MManager.OnClick;
  R2L.OnClick:=R2LManager.OnClick;
  Special.OnClick:=SpecialManager.OnClick;
  if Special.Caption='STOP the Auto Solution' then
    begin
    Special.Click;
    end;
  for i:=1 to 20 do
    begin
    LCol[i].Hide;
    LCol[i].Hint:='0';
    MCol[i].Hide;
    MCol[i].Hint:='0';
    RCol[i].Hide;
    RCol[i].Hint:='0';
    end;
  n:=Bar.Position;
  nL:=n;
  nM:=0;
  nR:=0;
  for i:=1 to nL do
    begin
    LCol[i].Show;
    LCol[i].Hint:=IntToStr(nL+1-i);
    end;
  Zabbit(False);
  end;

procedure TForm1.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
  begin
  Zabbit(True);
  end;

procedure TForm1.ThemesManagerClick(Sender: TObject);
  var
    i:Byte;
    OfficialShapesColor:TColor;
  begin
  OfficialShapesColor:=$0059ACFF;
  if Themes.Text='Banana' then
    begin
    OfficialShapesColor:=clYellow;
    Form1.Color:=$0080FFFF;
    end
  else if Themes.Text='Berry' then
    begin
    OfficialShapesColor:=$00804000;
    Form1.Color:=$00FF8000;
    end
  else if Themes.Text='Cherry' then
    begin
    OfficialShapesColor:=clRed;
    Form1.Color:=$008080FF;
    end
  else if Themes.Text='Kiwi' then
    begin
    OfficialShapesColor:=clGreen;
    Form1.Color:=clLime;
    end
  else if Themes.Text='Orange' then
    begin
    OfficialShapesColor:=$000060BF;
    Form1.Color:=$0059ACFF;
    end;
  Base.Brush.Color:=OfficialShapesColor;
  for i:=0 to 20 do
    begin
    LCol[i].Brush.Color:=OfficialShapesColor;
    MCol[i].Brush.Color:=OfficialShapesColor;
    RCol[i].Brush.Color:=OfficialShapesColor;
    end;
  end;

procedure Move(var a1:Array of TShape; var n1:Byte;
               var a2:Array of TShape; var n2:Byte);
  begin
  if StrToInt(a1[n1].Hint) < StrToInt(a2[n2].Hint) then
    begin
    n2:=n2+1;
    a2[n2].Show;
    a2[n2].Hint:=a1[n1].Hint;
    a1[n1].Hint:='1';
    a1[n1].Hide;
    n1:=n1-1;
    inc(NumberOfMoves);
    Moves.Text:=IntToStr(NumberOfMoves)
    end;
  end;

procedure TForm1.L2RManagerClick(Sender: TObject);
  begin
  Move(LCol,nL,RCol,nR);
  if (nL = 0) and (nM = 0) then
    Congratulations.Click;
  end;

procedure TForm1.L2MManagerClick(Sender: TObject);
  begin
  Move(LCol,nL,MCol,nM);
  end;

procedure TForm1.M2LManagerClick(Sender: TObject);
  begin
  Move(MCol,nM,LCol,nL);
  end;

procedure TForm1.M2RManagerClick(Sender: TObject);
  begin
  Move(MCol,nM,RCol,nR);
  if (nL = 0) and (nM = 0) then
    Congratulations.Click;
  end;

procedure TForm1.R2MManagerClick(Sender: TObject);
  begin
  Move(RCol,nR,MCol,nM);
  end;

procedure TForm1.R2LManagerClick(Sender: TObject);
  begin
  Move(RCol,nR,LCol,nL);
  end;

procedure TForm1.CongratulationsClick(Sender: TObject);
  begin
  ShowMessage('Congratulations ! you`ve made it ! ');
  L2R.OnClick:=Congratulations.OnExit;
  L2M.OnClick:=Congratulations.OnExit;
  M2L.OnClick:=Congratulations.OnExit;
  M2R.OnClick:=Congratulations.OnExit;
  R2M.OnClick:=Congratulations.OnExit;
  R2L.OnClick:=Congratulations.OnExit;
  Special.OnClick:=Congratulations.OnExit;
  end;

procedure TForm1.SpecialManagerClick(Sender: TObject);
  begin
  if Special.Caption='Activate the auto solution' then
    begin
    if Edit.Text='Password' then
      ShowMessage('Type the password first !')
    else if Edit.Text='4764' then
      begin
      ShowMessage('Use the right bar to choose time between 2 steps');
      SpeedBar.Show;
      Special.Caption:='STOP the Auto Solution';
      L2R.Hide;
      L2M.Hide;
      M2L.Hide;
      M2R.Hide;
      R2M.Hide;
      R2L.Hide;
      Timer.Enabled:=True;
     end
    else
      ShowMessage('WRONG Password');
    end
  else if Special.Caption='STOP the Auto Solution' then
    begin
    SpeedBar.Hide;
    Special.Caption:='Activate the auto solution';
    L2R.Show;
    L2M.Show;
    M2L.Show;
    M2R.Show;
    R2M.Show;
    R2L.Show;
    Timer.Enabled:=False;
    end;
  end;

procedure TForm1.SpeedBarManegerClick(Sender: TObject);
  begin
  Timer.Interval:=(SpeedBar.Position * SpeedBar.Position);
  end;

procedure TForm1.TimerTimer(Sender: TObject);
  begin
  if NumberOfMoves mod 2 = 0 then
    begin
    if LCol[nL].Hint='1' then
      begin
      if n mod 2 = 0 then
        L2M.Click
      else
        L2R.Click;
      end
    else if MCol[nM].Hint='1' then
      begin
      if n mod 2 = 0 then
        M2R.Click
      else
        M2L.Click;
      end
    else if RCol[nR].Hint='1' then
      begin
      if n mod 2 = 0 then
        R2L.Click
      else
        R2M.Click;
      end;
    end
  else
    begin
    if LCol[nL].Hint='1' then
      begin
      if StrToInt(MCol[nM].Hint) < StrToInt(RCol[nR].Hint) then
        M2R.Click
      else if StrToInt(RCol[nR].Hint) < StrToInt(MCol[nM].Hint) then
        R2M.Click;
      end
    else if MCol[nM].Hint='1' then
      begin
      if StrToInt(LCol[nL].Hint) < StrToInt(RCol[nR].Hint) then
        L2R.Click
      else if StrToInt(RCol[nR].Hint) < StrToInt(LCol[nL].Hint) then
        R2L.Click;
      end
    else if RCol[nR].Hint='1' then
      begin
      if StrToInt(LCol[nL].Hint) < StrToInt(MCol[nM].Hint) then
        L2M.Click
      else if StrToInt(MCol[nM].Hint) < StrToInt(LCol[nL].Hint) then
        M2L.Click;
      end;
    end;
  end;

procedure TForm1.pClick(Sender: TObject);
begin
  if not B then
    begin
      Edit.Text:='';
      B:=True;
      Edit.PasswordChar:='*';
    end;
end;

end.

unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls;

type
    TForm1 = class(TForm)
        StringGrid1: TStringGrid;
        CrossEdit: TEdit;
        ZerroEdit: TEdit;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        procedure ClearStringGrid;
        Procedure CheckStringGrid;
        function CheckTable: Boolean;
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);

    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    Form1: TForm1;
    CountCross, CountZero: Integer;

implementation

{$R *.dfm}

procedure TForm1.ClearStringGrid;
var
    i: Integer;
begin
    with StringGrid1 do
        for i := 0 to ColCount - 1 do
            Cols[i].Clear;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    CountZero := 0;
    CountCross := 0;
end;

function TForm1.CheckTable: Boolean;
var
    i, j: Integer;
begin
    Result := True;
    for i := 0 to 2 do
        for j := 0 to 2 do
            if StringGrid1.Cells[i, j] = '' then
                Result := False;
end;

Procedure TForm1.CheckStringGrid;
Var
    i: Integer;
    IsCorrect: Boolean;
begin
    IsCorrect := CheckTable;
    with StringGrid1 do
    begin
        if (Cells[0, 0] + Cells[0, 1] + Cells[0, 2] = 'OOO') or
          (Cells[1, 0] + Cells[1, 1] + Cells[1, 2] = 'OOO') or
          (Cells[2, 0] + Cells[2, 1] + Cells[2, 2] = 'OOO') or
          (Cells[0, 0] + Cells[1, 0] + Cells[2, 0] = 'OOO') or
          (Cells[0, 1] + Cells[1, 1] + Cells[2, 1] = 'OOO') or
          (Cells[0, 2] + Cells[1, 2] + Cells[2, 2] = 'OOO') or
          (Cells[0, 0] + Cells[1, 1] + Cells[2, 2] = 'OOO') or
          (Cells[2, 0] + Cells[1, 1] + Cells[0, 2] = 'OOO') then
        begin
            ShowMessage('Победили нолики!');
            ClearStringGrid();
            Inc(CountZero);
            ZerroEdit.Text := IntToStr(CountZero);
        end
        else if (Cells[0, 0] + Cells[0, 1] + Cells[0, 2] = 'XXX') or
          (Cells[1, 0] + Cells[1, 1] + Cells[1, 2] = 'XXX') or
          (Cells[2, 0] + Cells[2, 1] + Cells[2, 2] = 'XXX') or
          (Cells[0, 0] + Cells[1, 0] + Cells[2, 0] = 'XXX') or
          (Cells[0, 1] + Cells[1, 1] + Cells[2, 1] = 'XXX') or
          (Cells[0, 2] + Cells[1, 2] + Cells[2, 2] = 'XXX') or
          (Cells[0, 0] + Cells[1, 1] + Cells[2, 2] = 'XXX') or
          (Cells[2, 0] + Cells[1, 1] + Cells[0, 2] = 'XXX') then
        begin
            ShowMessage('Победили крестики!');
            ClearStringGrid();
            Inc(CountCross);
            CrossEdit.Text := IntToStr(CountCross);
        end
        ELSE if IsCorrect then
        begin
            ShowMessage('Ничья!');
            ClearStringGrid();
        end;
    end
end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    if (StringGrid1.Cells[ACol, ARow] = '') then
    Begin
        if (Label4.caption = 'Крестики') then
        begin
            StringGrid1.Cells[ACol, ARow] := 'X';
            Label4.caption := 'Нолики';
        end
        Else
        begin
            StringGrid1.Cells[ACol, ARow] := 'O';
            Label4.caption := 'Крестики'
        end;
        CheckStringGrid();
    End;
end;

end.

pageextension 50100 "BSB Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group("BSB Bookstore")
            {
                Caption = 'Bookstore';

                field("BSB Favorite Book No."; Rec."BSB Favorite Book No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Favorite Book No. field.', Comment = '%';
                }
                field("BSB Favorite Book Description"; Rec."BSB Favorite Book Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Favorite Book Description field.', Comment = '%';
                }
            }
        }
        addafter(Control149)
        {
            part(BSBBookFactbox; "BSB Book Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("BSB Favorite Book No.");
            }
        }
    }
}
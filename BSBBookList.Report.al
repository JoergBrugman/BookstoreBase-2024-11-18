report 50100 "BSB Book List"
{
    Caption = 'Book List';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'BSBBookList.Report.rdlc';

    dataset
    {
        dataitem(SingleRowData; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            column(COMPANYNAME; CompanyName) { }
            column(ShowNoOfPages; ShowNoOfPages) { }
        }
        dataitem("BSB Book"; "BSB Book")
        {
            RequestFilterFields = "No.", Type, ISBN;

            column(No_BSBBook; "No.") { IncludeCaption = true; }
            column(Description_BSBBook; Description) { IncludeCaption = true; }
            column(Author_BSBBook; Author) { IncludeCaption = true; }
            column(NoofPages_BSBBook; "No. of Pages") { IncludeCaption = true; }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowNoOfPages; ShowNoOfPages)
                    {
                        Caption = 'Show No. of Pages';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Show No. of Pages field.';
                    }
                }
            }
        }
    }

    var
        ShowNoOfPages: Boolean;

}
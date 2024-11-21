/// <summary>
/// Das ist mein Masterdata "Book"
/// </summary>
table 50100 "BSB Book"
{
    Caption = 'Book', Comment = 'de-DE=Buch';
    DataCaptionFields = "No.", Description;
    LookupPageId = "BSB Book List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'de-DE=Nr.';
            NotBlank = true; //[ ] Implementierung der Nummernserien fehlt noch
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description', Comment = 'de-DE=Beschreibung';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description', Comment = 'de-DE=Suchbegriff';
            //[x] Muss noch versorgt werden. Synch fehlt! In Tabelle 27 Item im Description-OnValidate orientieren
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked', Comment = 'de-DE=Gesperrt';
        }
        field(5; Type; Enum "BSB Book Type")
        {
            Caption = 'Type', Comment = 'de-DE=Art';
        }
        field(7; Created; Date) //[x] automatisch versorgen mit Today, wenn ein Buch erstellt wird
        {
            Caption = 'Created', Comment = 'de-DE=Erstellt am';
            Editable = false;
        }
        field(8; "Last Date Modified"; Date) //[x] automatisch versorgen mit Today, wenn ein Buch geändert wird
        {
            Caption = 'Last Date Modified', Comment = 'de-DE=Geädert am';
            Editable = false;
        }
        field(10; Author; Text[50])
        {
            Caption = 'Aurthor';
        }
        field(11; "Author Provision %"; Decimal)
        {
            Caption = 'Author Provision %', Comment = 'de-DE=Autorenprovision %';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(15; ISBN; Code[20])
        {
            Caption = 'ISBN', Comment = 'de-DE=ISBN';
        }
        field(16; "No. of Pages"; Integer)
        {
            Caption = 'No. of Pages', Comment = 'de-DE=Anz. Seiten';
            MinValue = 0;
        }
        field(17; "Edition No."; Integer)
        {
            Caption = 'Edition No.', Comment = 'de-DE=Editionsnr.';
            MinValue = 0;
        }
        field(18; "Date of Publishing"; Date)
        {
            Caption = 'Date of Publishing', Comment = 'de-DE=Veröffentlichungsdatum';
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, Author, ISBN) { }
    }

    var
        OnDeleteBookErr: Label 'A Book cannot be deleted';

    trigger OnInsert()
    begin
        Created := Today;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        OnBeforeOnDelete(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        Error(OnDeleteBookErr); //[x] Ein Buch darf nicht gelöscht
    end;

    /// <summary>
    /// Throw an error on base of Rec if Book is blocked
    /// </summary>
    procedure TestBlocked()
    begin
        // TestField(Blocked, false);
        TestBlocked(Rec);
    end;

    /// <summary>
    /// Throw an error if Book is blocked
    /// </summary>
    /// <param name="BookNo">No. of the Book to be checked</param>
    procedure TestBlocked(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if not BSBBook.Get(BookNo) then
            exit;
        TestBlocked(BSBBook);
        // BSBBook.TestField(Blocked, false);
    end;

    procedure ShowCard(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if not BSBBook.Get(BookNo) then
            exit;
        ShowCard(BSBBook);
    end;

    procedure ShowCard()
    begin
        ShowCard(Rec);
    end;

    local procedure ShowCard(BSBBook: Record "BSB Book")
    begin
        Page.RunModal(Page::"BSB Book Card", BSBBook);
    end;

    local procedure TestBlocked(BSBBook: Record "BSB Book")
    begin
        BSBBook.TestField(Blocked, false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var Rec: Record "BSB Book"; var xRec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}
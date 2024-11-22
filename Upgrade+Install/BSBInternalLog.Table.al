table 50101 "BSB Internal Log"
{
    Caption = 'Internal Log';
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; Company; Text[50])
        {
            Caption = 'Company';
        }
        field(4; Created; DateTime)
        {
            Caption = 'Created';
        }
        field(5; Comment; Text[500])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }

    var
        BSBInternalLog: Record "BSB Internal Log";

    procedure InsertNewLog(TriggerTxt: Text)
    var
        ExecContex: ExecutionContext;
        ModuleInfo: ModuleInfo;
    begin
        ExecContex := Session.GetCurrentModuleExecutionContext();
        NavApp.GetCurrentModuleInfo(ModuleInfo);
        InsertNewLog(TriggerTxt, ExecContex, ModuleInfo);
    end;

    procedure InsertNewLog(TriggerTxt: Text; ExecContex: ExecutionContext; ModuleInfo: ModuleInfo)
    begin
        BSBInternalLog.Init();
        BSBInternalLog."Entry No." := 0;
        BSBInternalLog.Description := TriggerTxt;
        BSBInternalLog.Created := CurrentDateTime;
        BSBInternalLog.Company := CompanyName;
        BSBInternalLog.Comment := StrSubstNo('%1', ExecContex);
        BSBInternalLog.Comment += StrSubstNo(' - AppName %1 - AppVersion %2 - DataVersion %3', ModuleInfo.Name, ModuleInfo.AppVersion, ModuleInfo.DataVersion);
        BSBInternalLog.Insert();
    end;

}
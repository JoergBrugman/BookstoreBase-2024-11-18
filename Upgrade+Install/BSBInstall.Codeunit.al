codeunit 50106 "BSB Install"
{
    Subtype = Install;

    var
        BSBInternalLog: Record "BSB Internal Log";

    trigger OnInstallAppPerCompany()
    begin
        BSBInternalLog.InsertNewLog('OnInstallAppPerCompany');
    end;

    trigger OnInstallAppPerDatabase()
    begin
        BSBInternalLog.InsertNewLog('OnInstallAppPerDatabase');
    end;
}
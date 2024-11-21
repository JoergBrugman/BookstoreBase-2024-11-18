codeunit 50102 "BSB Book Type Paperback Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Print on Demand');
    end;

    procedure StartDeliverBook()
    begin
        Message('DPD Standard');
    end;
}
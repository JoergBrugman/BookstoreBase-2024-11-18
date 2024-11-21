codeunit 50101 "BSB Book Type Hardcover Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Aus Lager picken');
    end;

    procedure StartDeliverBook()
    begin
        Message('UPS Premium');
    end;
}
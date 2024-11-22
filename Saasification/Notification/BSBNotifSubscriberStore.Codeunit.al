codeunit 50105 "BSB Notif. Subscriber Store"
{
    var
        MyNotifications: Record "My Notifications";
        CreditLimitNotif: Notification;
        CreditLimitNotifActionEditCustomerLbl: Label 'Edit Customer';
        CreditLimitNotifIDTxt: Label '3ef67fd9-bb5b-4454-9d6b-926005977f8b', Locked = true;
        CreditLimitNotifMessageMsg: Label '%1 %2 of %3 %4 %5 exceed %6 %7';
        MyNotificationDescriptionTxt: Label 'Balance of Customer is lager than Credit Limit';
        MyNotificationNameTxt: Label 'Customer Balance exceeds Credit Limit';

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnAfterGetRecordEvent, '', true, true)]
    local procedure CheckCreditLimit(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        if Rec."Bill-to Customer No." = '' then
            exit;
        Customer.SetAutoCalcFields("Balance (LCY)");
        Customer.Get(Rec."Bill-to Customer No.");
        if Customer."Credit Limit (LCY)" = 0 then
            exit;
        if (Customer."Balance (LCY)" > Customer."Credit Limit (LCY)") and
            MyNotifications.IsEnabledForRecord(CreditLimitNotifIDTxt, Customer)
        then begin
            CreditLimitNotif.Id := CreditLimitNotifIDTxt;
            CreditLimitNotif.Message := StrSubstNo(CreditLimitNotifMessageMsg,
                Customer.FieldCaption("Balance (LCY)"),
                Customer."Balance (LCY)",
                Customer.TableCaption,
                Customer."No.",
                customer.Name,
                Customer.FieldCaption("Credit Limit (LCY)"),
                customer."Credit Limit (LCY)");
            CreditLimitNotif.SetData('CustNo', Rec."Bill-to Customer No.");
            CreditLimitNotif.AddAction(CreditLimitNotifActionEditCustomerLbl, Codeunit::"BSB Notif. Subscriber Store", 'OpenCustomerCard');
            CreditLimitNotif.Send();
        end;
    end;

    procedure OpenCustomerCard(Notif: Notification)
    var
        Customer: Record Customer;
    begin
        Customer.Get(Notif.GetData('CustNo'));
        Page.Run(Page::"Customer Card", Customer);
    end;

    [EventSubscriber(ObjectType::Page, Page::"My Notifications", OnInitializingNotificationWithDefaultState, '', false, false)]
    local procedure "My Notifications_OnInitializingNotificationWithDefaultState"()
    var
    begin
        MyNotifications.InsertDefaultWithTableNum(CreditLimitNotifIDTxt, MyNotificationNameTxt, MyNotificationDescriptionTxt, Database::Customer);
    end;


}
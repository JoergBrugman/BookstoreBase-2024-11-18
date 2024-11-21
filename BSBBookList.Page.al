page 50101 "BSB Book List"
{
    Caption = 'Books';
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BSB Book";
    CardPageId = "BSB Book Card";

    layout
    {
        area(Content)
        {
            repeater(Books)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(ISBN; Rec.ISBN)
                {
                    ToolTip = 'Specifies the value of the ISBN field.', Comment = '%';
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Aurthor field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type; field.', Comment = '%';
                }
                field("No. of Pages"; Rec."No. of Pages")
                {
                    ToolTip = 'Specifies the value of the No. of Pages field.', Comment = '%';
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Notes; Notes) { }
            systempart(Links; Links) { }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(ClassicProgramming_Promoted; ClassicProgramming) { }
            actionref(HandledEventPattern_Promoted; HandledEventPattern) { }
        }
        area(Processing)
        {
            action(ClassicProgramming)
            {
                Caption = 'Classic Programming';
                Image = Process;
                ToolTip = 'Classic programming without intervention options for dependent apps.',
                    Comment = 'de-DE=Klassische Programmierung ohne Eingriffsmöglichkeit für abhängige Apps.';

                trigger OnAction()
                var
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                begin
                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            begin
                                BSBBookTypeHardcoverImpl.StartDeployBook();
                                BSBBookTypeHardcoverImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                BSBBookTypePaperbackImpl.StartDeployBook();
                                BSBBookTypePaperbackImpl.StartDeliverBook();
                            end;
                        else
                            Error('Nicht implementiert');
                    end;
                end;
            }
            action(HandledEventPattern)
            {
                Caption = 'Handled-Event-Pattern';
                Image = Process;
                ToolTip = 'With the handled event pattern, we offer dependent apps the opportunity to incorporate their specific process.',
                    Comment = 'de-DE=Mit dem Handled-Event-Pattern bieten wir abhängigen Apps die Möglichkeit, ihren spezifischen Prozess einzubinden.';

                trigger OnAction()
                var
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    IsHandled: Boolean;
                begin
                    OnBeforeHandleType(Rec, IsHandled);
                    if IsHandled then
                        exit;
                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            begin
                                BSBBookTypeHardcoverImpl.StartDeployBook();
                                BSBBookTypeHardcoverImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                BSBBookTypePaperbackImpl.StartDeployBook();
                                BSBBookTypePaperbackImpl.StartDeliverBook();
                            end;
                        else
                            Error('Nicht implementiert');
                    end;
                end;
            }
            action(InterfaceImpl)
            {
                Caption = 'Interface-Impl.';
                Image = Process;
                // ToolTip = 'With the handled event pattern, we offer dependent apps the opportunity to incorporate their specific process.',
                //     Comment = 'de-DE=Mit dem Handled-Event-Pattern bieten wir abhängigen Apps die Möglichkeit, ihren spezifischen Prozess einzubinden.';

                trigger OnAction()
                var
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    BSBBookTypeEmptyImpl: Codeunit "BSB Book Type Empty Impl.";
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                    IsHandled: Boolean;
                begin
                    OnBeforeHandleType(Rec, IsHandled);
                    if IsHandled then
                        exit;
                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            BSBBookTypeProcess := BSBBookTypeHardcoverImpl;
                        "BSB Book Type"::Paperback:
                            BSBBookTypeProcess := BSBBookTypePaperbackImpl;
                        "BSB Book Type"::" ":
                            BSBBookTypeProcess := BSBBookTypeEmptyImpl;
                    end;
                    BSBBookTypeProcess.StartDeployBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
            action(InterfaceImplAndEnum)
            {
                Caption = 'Interface-Impl.+Enum';
                Image = Process;
                // ToolTip = 'With the handled event pattern, we offer dependent apps the opportunity to incorporate their specific process.',
                //     Comment = 'de-DE=Mit dem Handled-Event-Pattern bieten wir abhängigen Apps die Möglichkeit, ihren spezifischen Prozess einzubinden.';

                trigger OnAction()
                var
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                begin
                    BSBBookTypeProcess := Rec.Type;
                    BSBBookTypeProcess.StartDeployBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
        }
    }


    [IntegrationEvent(false, false)]
    local procedure OnBeforeHandleType(Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}
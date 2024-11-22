permissionset 50100 "BSB BOOK, EDIT"
{
    Caption = 'Edit and Create Books etc.';
    // Assignable = true;
    Permissions =
        table "BSB Book" = X,
        tabledata "BSB Book" = RIMD,
        table "BSB Internal Log" = X,
        tabledata "BSB Internal Log" = RIMD;
}
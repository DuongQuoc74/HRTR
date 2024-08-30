// JScript File
function BlockLogsConfirmValidation() {
    if (Page_ClientValidate('vgblocklogs')) {
        $find('bhmpeConfirmBlockLogs').show();
    }
    return false;
}

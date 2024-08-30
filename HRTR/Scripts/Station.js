// JScript File
function showModalAdd() {
    ResetData();
    $find('bhvmpeAdd').show();
    document.getElementById("ctl00_maincontent_txtStationNameA").focus();
    return false;
}

function updateValidation() {
    if (Page_ClientValidate('vgupdatestation')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}

function ResetData() {
    ResetControl("lblAddErr", "");
    ResetControl("hdStationID", "0");
    ResetControl("txtStationNameA", "");
    ResetControl("ddlWorkcellA", "0");
}
// JScript File
function updateValidation() {

    if (Page_ClientValidate('vgcoursestation')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}


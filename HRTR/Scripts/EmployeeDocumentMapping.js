// JScript File
function updateValidation() {

    if (Page_ClientValidate('vgcoursestation')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}

function confirmDelete() {
    return confirm('Are you sure you want to delete?');
}
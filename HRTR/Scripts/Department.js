// JScript File
function NewDepartment() {

    ResetDepartmentData();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');


    $find('bhvmpeDepartment').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    jQuery('[id$="_txtDepartmentCode"]').focus();
    return false;

}
function ResetDepartmentData() {
    jQuery('[id$="lblDepartmentMessage"]').html('');
    jQuery('[id$="hdDepartmentID"]').val('0');
    jQuery('[id$="txtDepartmentCode"]').val('');
    jQuery('[id$="txtDepartmentName"]').val('');

    //ResetControl("lblDepartmentMessage", "");
    //ResetControl("hdDepartmentID", "0");
    //ResetControl("txtDepartmentCode", "");
    //ResetControl("txtDepartmentName", "");
}

function DepartmentUpdateValidation() {

    if (Page_ClientValidate('vgdepartment')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}


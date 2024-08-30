// JScript File
function NewProduct() {

    ResetProductData();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');


    $find('bhvmpeProduct').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    jQuery('[id$="_txtProductName"]').focus();
    return false;

}
function ResetProductData() {
    jQuery('[id$="lblProductMessage"]').html('');
    jQuery('[id$="hdProductID"]').val('0');
    jQuery('[id$="txtProductName"]').val('');
    jQuery('[id$="ddlTrainingGroup"]').val('0');

    //ResetControl("lblProductMessage", "");
    //ResetControl("hdProductID", "0");
    //ResetControl("txtProductName", "");
    //ResetControl("ddlTrainingGroup", "0");
}

function ProductUpdateValidation() {

    if (Page_ClientValidate('vgproduct')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}


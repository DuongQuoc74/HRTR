// JScript File
function NewMDItem() {
    //    ResetData();
    //    $find('bhvmpeMDItem').show();
    //    document.getElementById("ctl00_maincontent_txtMDItemCode").focus();
    //    return false;

    //    //    ResetData();
    //    //    $find('bhvmpeAdd').show();
    //    //    document.getElementById("ctl00_maincontent_txtSearchUserA").focus();
    //    //    return false;

    ResetMDItemData();
    //    $find('bhvmpeAdd').show();
    //    document.getElementById("ctl00_maincontent_txtPartNoA").focus();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');


    $find('bhvmpeMDItem').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    jQuery('[id$="_txtMDItemCode"]').focus();
    return false;

}
function ResetMDItemData() {
    jQuery('[id$="lblMDItemMessage"]').html('');
    jQuery('[id$="hdMDItemID"]').val('0');
    jQuery('[id$="txtMDItemCode"]').val('');
    jQuery('[id$="txtDescription"]').val('');
    jQuery('[id$="cbIsActive"]').attr('checked', true);
//    ResetControl("lblMDItemMessage", "");
////    var ddlMDTypeS = document.getElementById("ctl00_maincontent_ddlMDTypeS");
////    if (ddlMDTypeS != null) {
//////        var vMDTypeS = ddlMDTypeS.selectedIndex;
////        var vMDTypeS = ddlMDTypeS.value;
////        //        alert(vMDTypeS);
////        jQuery('[id$="_ddlMDType"]').val(vMDTypeS);
//////        ResetControl("ddlMDType", vMDTypeS);
////        //                alert(document.getElementById("ctl00_maincontent_ddlMDTypeA").value);
////    }
//    ResetControl("hdMDItemID", "0");
//    ResetControl("txtMDItemCode", "");
//    ResetControl("txtDescription", "");
//    ResetControl("cbIsActive", true);
}

function MDItemUpdateValidation() {

    if (Page_ClientValidate('vgmditem')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}

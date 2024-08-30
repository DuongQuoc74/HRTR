// JScript File
function NewWorkcell() {

    ResetWorkcellData();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');


    $find('bhvmpeWorkcell').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    jQuery('[id$="_txtWorkcellCode"]').focus();
    return false;

}
function ResetWorkcellData() {
    jQuery('[id$="lblWorkcellMessage"]').html('');
    jQuery('[id$="hdWorkcellID"]').val('0');
    jQuery('[id$="txtWorkcellCode"]').val('');
    jQuery('[id$="txtWorkcellName"]').val('');
    //ResetControl("lblWorkcellMessage", "");
    //ResetControl("hdWorkcellID", "0");
    //ResetControl("txtWorkcellCode", "");
    //ResetControl("txtWorkcellName","");
}

function WorkcellUpdateValidation() {

    if (Page_ClientValidate('vgworkcell')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}


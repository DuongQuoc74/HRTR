// JScript File
function NewGC_MESRules() {
    ResetGC_MESRulesData();

    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');

    $find('bhvmpeGC_MESRules').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    return false;

}
function GC_MESRulesUpdateValidation() {
    if (Page_ClientValidate('vggc_mesrules')) {
        $find('bhmpeUpdateGC_MESRules').show();
    }
    return false;
}

function ResetGC_MESRulesData() {
    jQuery('[id$="lblGC_MESRulesMessage"]').html('');
    jQuery('[id$="hdGC_MESRulesID"]').val('0');
    jQuery('[id$="ddlDetectedStepIns"]').val('0');
    jQuery('[id$="ddlQM_Defects"]').val('0');
    jQuery('[id$="txtCRD"]').val('');
    jQuery('[id$="ddlEscapedStepIns"]').val('0');
    jQuery('[id$="cbIsActive"]').attr('checked', true);

    //ResetControl("lblGC_MESRulesMessage", "");
    //ResetControl("hdGC_MESRulesID", "0");
    //ResetControl("ddlDetectedStepIns", "0");
    //ResetControl("ddlQM_Defects", "0"); ///0: All
    //ResetControl("txtCRD", ""); ///-1: All
    //ResetControl("ddlEscapedStepIns", "0"); ///-1: All
    //ResetControl("cbIsActive", true);
}

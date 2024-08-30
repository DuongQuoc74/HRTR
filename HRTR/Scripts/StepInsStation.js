// JScript File
function NewGC_StepInsStation() {
    ResetGC_StepInsStationData();

    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');

    $find('bhvmpeGC_StepInsStation').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    return false;

}
function GC_StepInsStationUpdateValidation() {
    if (Page_ClientValidate('vggc_stepinsstation')) {
        $find('bhmpeUpdateGC_StepInsStation').show();
    }
    return false;
}

function ResetGC_StepInsStationData() {
    jQuery('[id$="lblGC_StepInsStationMessage"]').html('');
    jQuery('[id$="hdGC_StepInsStationID"]').val('0');
    jQuery('[id$="ddlStepIns"]').val('0');
    jQuery('[id$="txtDepartmentName"]').val('0');
    jQuery('[id$="ddlStation"]').attr('checked', true);

    //ResetControl("lblGC_StepInsStationMessage", "");
    //ResetControl("hdGC_StepInsStationID", "0");
    //ResetControl("ddlStepIns", "0");
    //ResetControl("ddlStation", "0");
    //ResetControl("cbIsActive", true);
}

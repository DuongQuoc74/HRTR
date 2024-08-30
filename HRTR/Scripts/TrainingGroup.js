// JScript File
function NewTrainingGroup() {

    ResetTrainingGroupData();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');


    $find('bhvmpeTrainingGroup').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    jQuery('[id$="_txtTrainingGroupName"]').focus();
    return false;

}
function ResetTrainingGroupData() {
    jQuery('[id$="lblTrainingGroupMessage"]').html('');
    jQuery('[id$="hdTrainingGroupID"]').val('0');
    jQuery('[id$="txtTrainingGroupName"]').val('');
    jQuery('[id$="cbIsActive"]').attr('checked', true);
    //ResetControl("lblTrainingGroupMessage", "");
    //ResetControl("hdTrainingGroupID", "0");
    //ResetControl("txtTrainingGroupName", "");
}

function TrainingGroupUpdateValidation() {

    if (Page_ClientValidate('vgtraininggroup')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}


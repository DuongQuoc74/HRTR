// JScript File
jQuery(document).ready(function () {

    jQuery(document).on('keypress', '.positivenumber', function (event) {
        return OnlyPositiveNumber();
    });


});
function NewTrainingEmpLock() {
    ResetTrainingEmpLockData();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');
    jQuery('[id$="_txtExtendDay"]').addClass('invisible');
    jQuery('[id$="_lblExtendDay"]').addClass('invisible');
    jQuery('[id$="_lblCompleteDate"]').addClass('invisible');
    jQuery('[id$="_txtCompleteDate"]').addClass('invisible');
    jQuery('[id$="_imgCompleteDate"]').addClass('invisible');
    jQuery('[id$="_lblExtendFromDate"]').addClass('invisible');
    jQuery('[id$="_txtExtendFromDate"]').addClass('invisible');
    jQuery('[id$="_imgExtendFromDate"]').addClass('invisible');

    $find('bhvmpeTrainingEmpLock').show();
    jQuery('[id$="_txtEmployeeID"]').focus();
    return false;
}

function TrainingEmpLockUpdateValidation() {
    var extendDay = $.trim($('[id$="txtExtendDay"]').val());
    if (!isNaN(extendDay) && extendDay > 0) {
        if ($.trim($('[id$="txtExtendFromDate"]').val()).length == 0) {
            alert("Please select Extend From Date.");
            $('[id$="txtExtendFromDate"]').focus();
            return false;
        }
    }
    //        alert(extendDay);
    //        alert($.trim($('[id$="txtExtendFromDate"]').val()).length);
    if ($.trim($('[id$="txtExtendFromDate"]').val()).length != 0) {
        //          alert(extendDay);
        //        alert($('[id$="txtExtendFromDate"]').val());
        if (isNaN(extendDay) || extendDay == 0) {
            alert("Please input Extend Day.");
            $('[id$="txtExtendDay"]').focus();
            return false;
        }
    }
    if (Page_ClientValidate('vgtrainingemplock')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}

function ResetTrainingEmpLockData() {
    jQuery('[id$="lblTrainingEmpLockMessage"]').html('');
    jQuery('[id$="hdLockID"]').val('0');
    jQuery('[id$="txtEmployeeID"]').val('');
    jQuery('[id$="txtEmployeeIDSAP"]').val('');
    jQuery('[id$="txtUserName"]').val('');
    jQuery('[id$="txtEmployeeName"]').val('');
    jQuery('[id$="txtTrainingCodeID"]').val('');
    jQuery('[id$="txtDescription"]').val('');
    jQuery('[id$="txtDueDate"]').val('');
    jQuery('[id$="txtExtendDay"]').val('0');
    jQuery('[id$="txtCompleteDate"]').val('');
    jQuery('[id$="txtExtendFromDate"]').val('');
    jQuery('[id$="cbIsActive"]').attr('checked', true);

    //ResetControl("lblTrainingEmpLockMessage", "");
    //ResetControl("hdLockID", "0");
    //ResetControl("txtEmployeeID", "");
    //ResetControl("txtEmployeeIDSAP", "");
    //ResetControl("txtUserName", "");
    //ResetControl("txtEmployeeName", "");
    //ResetControl("txtTrainingCodeID", "");
    //ResetControl("txtDescription", "");
    //ResetControl("txtDueDate", "");
    //ResetControl("txtExtendDay", "0");
    //ResetControl("txtCompleteDate", "");
    //ResetControl("txtExtendFromDate", "");
    //ResetControl("cbIsActive", true);
}

function cvFile_ClientValidate(source, args) {
    var hdUploadFileName = document.getElementById("ctl00_maincontent_hdUploadFileName");
    var vFileName = hdUploadFileName.value;
    if (vFileName == "")
        args.IsValid = false;
    else
        args.IsValid = true;
}

function UploadTrainingEmpLockValidation() {
    if (Page_ClientValidate('vguploademployee')) {
        $find('bhmpeConfirmUpload').show();
    }
    return false;
}

function uploadStart(sender, args) {
    //    alert("uploadStart");
}
function uploadError(sender, args) {
    //    alert(args.get_errorMessage());
}

function uploadComplete(sender, args) {
    try {
        var fileName = args.get_fileName();
        var fileExtension = fileName.substring(fileName.lastIndexOf('.') + 1);
        var lblUploadStatus = document.getElementById("ctl00_maincontent_lblUploadStatus");
        var hdUploadFileName = document.getElementById("ctl00_maincontent_hdUploadFileName");
        if (fileExtension != 'xls' && fileExtension != 'xlsx') {
            if (lblUploadStatus != null) {
                lblUploadStatus.innerHTML = "File extension not support. Only Excel files should be accepted.";
            }
            hdUploadFileName.value = "";
            $find('ctl00_maincontent_AsyncFUTrainingEmpLock').ErrorBackColor = "<span style='color:red;' />";
            return;
        }
        else {
            if (hdUploadFileName != null) {
                hdUploadFileName.value = fileName;
            }
            lblUploadStatus.innerHTML = "";
        }
    }
    catch (e) {
        alert(e.Message);
    }
}
// JScript File
jQuery.noConflict();
jQuery(document).ready(function () {
    jQuery(document).on('keypress', '.positivenumber', function (event) {
        return OnlyPositiveNumber();
    });
});
function NewCourse() {
    ResetCourseData();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');

    jQuery('[id$="_lblEffectiveDate"]').addClass('invisible');
    jQuery('[id$="_txtEffectiveDate"]').addClass('invisible');
    jQuery('[id$="_imgEffectiveDate"]').addClass('invisible');
    ValidatorEnable($get('[id$="_rfvEffectiveDate"]'), false);

    $find('bhvmpeCourse').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    jQuery('[id$="_txtCourseName"]').focus();
    return false;
}

function LoadEffectiveDate(obj) {
    if (obj.checked) {
        jQuery('[id$="_lblEffectiveDate"]').removeClass('invisible');
        jQuery('[id$="_txtEffectiveDate"]').removeClass('invisible');
        jQuery('[id$="_imgEffectiveDate"]').removeClass('invisible');
        ValidatorEnable($get('[id$="_rfvEffectiveDate"]'), true);
    } else {
        jQuery('[id$="_lblEffectiveDate"]').addClass('invisible');
        jQuery('[id$="_txtEffectiveDate"]').addClass('invisible');
        jQuery('[id$="_imgEffectiveDate"]').addClass('invisible');
        ValidatorEnable($get('[id$="_rfvEffectiveDate"]'), false);
    }
}

function fnCritical() {
    //ResetCourseData();
    jQuery('[id$="_txtNumberOfCriticalDays"]').addClass('hidden');
    //$('.txtNumberOfCriticalDays').hide();
    return true;
}

function ResetCourseData() {
    jQuery('[id$="lblCourseMessage"]').html('');
    jQuery('[id$="hdCourseID"]').val('0');
    jQuery('[id$="txtCourseName"]').val('');
    jQuery('[id$="ddlCourseGroup"]').val('0');
    jQuery('[id$="ddlTrainingGroup"]').val('0');
    jQuery('[id$="txtExpiredInMonths"]').val('0');
    jQuery('[id$="txtNumberOfCriticalDays"]').val('0');
    jQuery('[id$="cbHasVA"]').attr('checked', true);
    jQuery('[id$="cbIsCritical"]').attr('checked', false);
    jQuery('[id$="cbIsActive"]').attr('checked', true);
    jQuery('[id$="cbIsOrientation"]').attr('checked', false);
    jQuery('[id$="txtEffectiveDate"]').val('');
    jQuery('[id$="txtMinPoint"]').val('0');
    jQuery('[id$="txtMaxPoint"]').val('0');

    //ResetControl("lblCourseMessage", "");
    //ResetControl("hdCourseID", "0");
    //ResetControl("txtCourseName", "");
    //ResetControl("ddlCourseGroup", "0");
    //ResetControl("ddlTrainingGroup", "0");
    //ResetControl("txtExpiredInMonths", "0");
    //ResetControl("txtNumberOfCriticalDays", "0");
    //ResetControl("cbHasVA", true);
    //ResetControl("cbIsCritical", false);
    //ResetControl("cbIsActive", true);
    //ResetControl("cbIsOrientation", false);
}

function CourseUpdateValidation() {
    if (Page_ClientValidate('vgcourse')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}

//function cvFile_ClientValidate(source, args) {
//    var hdUploadFileName = document.getElementById("ctl00_maincontent_hdUploadFileName");
//    var vFileName = hdUploadFileName.value;
//    if (vFileName == "")
//        args.IsValid = false;
//    else
//        args.IsValid = true;
//}

//function UploadCourseValidation() {
//    $find('bhmpeConfirmUpload').show();
//    return false;
//}

//function uploadStart(sender, args) {
//    //alert("uploadStart");
//}

//function uploadError(sender, args) {
//    //alert(args.get_errorMessage());
//}

//function uploadComplete(sender, args) {
//    try {
//        var fileName = args.get_fileName();
//        var fileExtension = fileName.substring(fileName.lastIndexOf('.') + 1);
//        var lblUploadStatus = document.getElementById("ctl00_maincontent_lblUploadStatus");
//        var hdUploadFileName = document.getElementById("ctl00_maincontent_hdUploadFileName");
//        if (fileExtension != 'xls' && fileExtension != 'xlsx') {
//            if (lblUploadStatus != null) {
//                lblUploadStatus.innerHTML = "File extension not support. Only Excel files should be accepted.";
//            }
//            hdUploadFileName.value = "";
//            $find('ctl00_maincontent_AsyncFUCourse').ErrorBackColor = "<span style='color:red;' />";
//            return;
//        }
//        else {
//            if (hdUploadFileName != null) {
//                hdUploadFileName.value = fileName;
//            }
//            lblUploadStatus.innerHTML = "";
//        }
//    }
//    catch (e) {
//        jQuery('[id$="lblUploadStatus"]').html(e.Message);
//    }
//}
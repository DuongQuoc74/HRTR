// JScript File
jQuery(document).ready(function () {

    jQuery(document).on('keypress', '.positivenumber', function (event) {
        return OnlyPositiveNumber();
    });


});
function NewCourseGroup() {

    ResetCourseGroupData();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');


    $find('bhvmpeCourseGroup').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    jQuery('[id$="_txtCourseGroupName"]').focus();
    return false;

}
function ResetCourseGroupData() {
    jQuery('[id$="lblCourseGroupMessage"]').html('');
    jQuery('[id$="hdCourseGroupID"]').val('0');
    jQuery('[id$="txtCourseGroupName"]').val('');
    jQuery('[id$="txtExpiredInMonths"]').val('0');
    jQuery('[id$="cbIsActive"]').attr('checked', true);
    //ResetControl("lblCourseGroupMessage", "");
    //ResetControl("hdCourseGroupID", "0");
    //ResetControl("txtCourseGroupName", "");
    //ResetControl("txtExpiredInMonths", "0");
}

function CourseGroupUpdateValidation() {

    if (Page_ClientValidate('vgcoursegroup')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}


// JScript File
jQuery.noConflict();
jQuery(document).ready(function () {
    ///Get EmployeeID_ID, save to hdEmployeeID_ID
    ///List course
    jQuery(document).on('keypress', '[id$="txtEmployeeID"]', function (event) {
        if (event.which == 13) {
            var employeeid = jQuery('[id$="txtEmployeeID"]').val();
            //            alert(employeeid);
            if (employeeid != "") {
                GetEmployeeProfile(employeeid);
                //                var employeeid_id = jQuery('[id$="hdEmployeeID_ID"]').val();
                //                    alert(employeeid_id);
                //                if (employeeid_id != 0) {
                //                    jQuery('[id$="btnSearch"]').trigger('click');
                //                }
            }
            return false;
        }
    });
    jQuery(document).on('keypress', '.positivenumber', function (event) {
        return OnlyPositiveNumber();
    });
});

function UpdateTrainingRecordValidation() {
    if (Page_ClientValidate('vgtrainingrecord')) {
        jQuery('[id$="_hdApplyKindID"]').val('1');
        jQuery('[id$="_lblApplyHeader"]').html('Update Training Record Confirmation');
        jQuery('[id$="_lblApplyMessage"]').html('Are you sure you want to update this training record?');
        $find('bhmpeConfirmApply').show();
        jQuery('[id$="cfmbApply"]').focus();
    }
    return false;
}
function DeleteTrainingRecordValidation() {
    jQuery('[id$="_hdApplyKindID"]').val('2');
    jQuery('[id$="_lblApplyHeader"]').html('Delete Training Record Confirmation');
    jQuery('[id$="_lblApplyMessage"]').html('Are you sure you want to delete this training record?');
    $find('bhmpeConfirmApply').show();
    jQuery('[id$="cfmbApply"]').focus();
    return false;
}

function cvEmployeeID_ClientValidate(source, args) {
    var employeeid_id = jQuery('[id$="hdEmployeeID_ID"]').val();
    if (employeeid_id == "" || employeeid_id == "0") {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
function EmployeeSelected(source, eventArgs) {
    if (source._serviceMethod == "GetEmployeeList") {
        var avalue = eventArgs.get_value();
        GetEmployeeProfile(avalue);
    }
}
function GetEmployeeProfile(employeeid) {
    if (employeeid != '') {
        var strurl = "../AjaxServer/ASEmployee.aspx?type=2&employeeid=" + employeeid;
        jQuery.ajax({
            type: "POST",
            url: strurl,
            contentType: "text/xml; charset=utf-8",
            dataType: "xml",
            async: false,
            success: function (response) {
                //            alert('aaaaaa');
                //            alert(response);
                jQuery(response).find('Employee').each(function () {
                    jQuery('[id$="txtEmployeeIDE"]').val(employeeid);

                    var strtemp = jQuery(this).find('EmployeeName').text();
                    jQuery('[id$="txtEmployeeName"]').val(strtemp);
                    jQuery('[id$="txtEmployeeNameE"]').val(strtemp);

                    strtemp = jQuery(this).find('EmployeeID_ID').text();
                    jQuery('[id$="hdEmployeeID_ID"]').val(strtemp);
                    //                    alert(strtemp);

                    strtemp = jQuery(this).find('OperatorGroupName').text();
                    jQuery('[id$="txtOperatorGroupName"]').val(strtemp);

                    strtemp = jQuery(this).find('CompanyName').text();
                    jQuery('[id$="txtCompanyName"]').val(strtemp);

                    strtemp = jQuery(this).find('DepartmentName').text();
                    jQuery('[id$="txtDepartmentName"]').val(strtemp);

                    strtemp = jQuery(this).find('JobTitle').text();
                    jQuery('[id$="txtJobTitle"]').val(strtemp);

                    strtemp = jQuery(this).find('PositionName').text();
                    jQuery('[id$="txtPositionName"]').val(strtemp);

                    strtemp = jQuery(this).find('ShiftName').text();
                    jQuery('[id$="txtShiftName"]').val(strtemp);

                    strtemp = jQuery(this).find('WorkcellName').text();
                    jQuery('[id$="txtWorkcellName"]').val(strtemp);

                    strtemp = jQuery(this).find('Supervisor').text();
                    jQuery('[id$="txtSupervisor"]').val(strtemp);

                    strtemp = jQuery(this).find('Supervisor').text();
                    jQuery('[id$="txtSupervisor"]').val(strtemp);
                    strtemp = jQuery(this).find('IsActive').text();
                    if (strtemp == "False") {
                        jQuery('[id$="cbIsActive"]').prop('checked', false);
                    }
                    else {
                        jQuery('[id$="cbIsActive"]').prop('checked', true);
                    }
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //                alert(textStatus);
                //            alert(errorThrown);
                //            ShowError('lblApply', 'Error in settings domain.');
            }
        });
    }
}

// JScript File
function cvFile_ClientValidate(source, args) {
    var hdUploadFileName = document.getElementById("ctl00_maincontent_hdUploadFileName");
    var vFileName = hdUploadFileName.value;
    if (vFileName == "")
        args.IsValid = false;
    else
        args.IsValid = true;
}

function UploadTrainingRecordValidation() {
    //    if (Page_ClientValidate('vgpreviewtrainingrecord')) {
    $find('bhmpeConfirmUpload').show();
    //    }
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

            $find('ctl00_maincontent_AsyncFUTrainingRecord').ErrorBackColor = "<span style='color:red;' />";

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
        jQuery('[id$="lblUploadStatus"]').html(e.Message);
        //alert(e.Message);
    }
}

function LoadScore(obj) {
    if (obj.checked) {
        jQuery('[id$="_txtScore"]').val('0');
        jQuery('[id$="_txtScore"]').prop('disabled', true);
    } else {
        jQuery('[id$="_txtScore"]').prop('disabled', false);
    }
}

function CheckValidation(obj) {
    if (obj.checked) {
        ValidatorEnable($get('[id$="_rfvTrainer"]'), true);
        ValidatorEnable($get('[id$="_rfvScore"]'), true);
        ValidatorEnable($get('[id$="_rfvCertDate"]'), true);
        ValidatorEnable($get('[id$="_rfvComments"]'), false);
    } else {
        ValidatorEnable($get('[id$="_rfvTrainer"]'), false);
        ValidatorEnable($get('[id$="_rfvScore"]'), false);
        ValidatorEnable($get('[id$="_rfvCertDate"]'), false);
        ValidatorEnable($get('[id$="_rfvComments"]'), true);
    }
}

//function requiredFamily() {
//    let familyDropdown = jQuery('[id$="ddlProduct"]')
//    let family = familyDropdown.val()
//    let isCertifiedPerFamily = jQuery('[id$="hdIsCertifiedPerFamily"]').val()

//    // Certified Per Family => Required Family
//    // Not Certified Per Family => Not Required Family
//    let isValid = false
//    if (isCertifiedPerFamily === "True") {
//        isValid = family !== "0" && family !== ""
//    }
//    else {
//        isValid = family !== ""
//    }

//    familyDropdown.IsValid = isValid
//}

function requiredFamily(source, arguments) {
    let familyDropdown = jQuery('[id$="ddlProduct"]')
    let selectedFamilyVal = familyDropdown.val()
    let selectedFamilyText = jQuery('[id$="ddlProduct"] option:selected').text()

    let isCertifiedPerFamily = jQuery('[id$="hdIsCertifiedPerFamily"]').val()

    // Certified Per Family => Required Family
    // Not Certified Per Family => Not Required Family
    let isValid = false
    if (isCertifiedPerFamily === "True") {
        isValid = selectedFamilyVal !== "0" && selectedFamilyVal !== "" && selectedFamilyText !== "All"
    }
    else {
        isValid = selectedFamilyVal !== ""
    }

    arguments.IsValid = isValid
}
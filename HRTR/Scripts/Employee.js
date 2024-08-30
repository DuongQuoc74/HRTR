// JScript File
function NewEmployee() {
    ResetEmployeeData();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');


    $find('bhvmpeEmployee').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    jQuery('[id$="_txtEmployeeID"]').focus();
    return false;
}
function EmployeeUpdateValidation() {

    if (Page_ClientValidate('vgemployee')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
}

function ResetEmployeeData() {
    jQuery('[id$="lblEmployeeMessage"]').html('');
    jQuery('[id$="hdEmployeeID_ID"]').val('0');
    jQuery('[id$="txtEmployeeID"]').val('');
    jQuery('[id$="txtEmployeeIDSAP"]').val('');
    jQuery('[id$="txtUserName"]').val('');
    jQuery('[id$="ddlOperatorGroup"]').val('0');
    jQuery('[id$="ddlCompany"]').val('0');
    jQuery('[id$="ddlDepartment"]').val('0');
    jQuery('[id$="txtJobTitle"]').val('');
    jQuery('[id$="ddlPosition"]').val('0');
    jQuery('[id$="ddlWorkcell"]').val('0');
    jQuery('[id$="txtSupervisor"]').val('');
    jQuery('[id$="cbIsActive"]').attr('checked', true);
    jQuery('[id$="cbIsSupervisor"]').attr('checked', false);
    jQuery('[id$="ddlWorkingStatus"]').val('0');

    //ResetControl("lblEmployeeMessage", "");
    //ResetControl("hdEmployeeID_ID", "0");
    //ResetControl("txtEmployeeID", "");
    //ResetControl("txtEmployeeIDSAP", "");
    //ResetControl("txtUserName", "");
    //ResetControl("txtEmployeeName", "");
    //ResetControl("ddlOperatorGroup", "0");
    //ResetControl("ddlCompany", "0");
    //ResetControl("ddlDepartment", "0");
    //ResetControl("txtJobTitle", "");
    //ResetControl("ddlPosition", "0");
    //ResetControl("ddlWorkcell", "0");
    //ResetControl("txtSupervisor", "");
    //ResetControl("cbIsActive", true);
    //ResetControl("cbIsSupervisor", false);
    //ResetControl("ddlWorkingStatus", "0");
}


function cvFile_ClientValidate(source, args) {
    var hdUploadFileName = document.getElementById("ctl00_maincontent_hdUploadFileName");
    var vFileName = hdUploadFileName.value;
    if (vFileName == "")
        args.IsValid = false;
    else
        args.IsValid = true;
}

function EmployeeUploadValidation() {
    if (Page_ClientValidate('vguploademployee')) {
        $find('bhmpeConfirmUpload').show();
    }
    return false;
}

function uploadStart(sender, args) {
    jQuery('[id$="lblUploadStatus"]').html('');
    //ResetControl("lblUploadStatus", "");
    var fileName = args.get_fileName();
    var fileExt = fileName.substring(fileName.lastIndexOf(".") + 1);

    if (fileExt == "xls" || fileExt == "xlsx") {
        return true;
    } else {
        //To cancel the upload, throw an error, it will fire OnClientUploadError 
        var err = new Error();
        err.name = "Upload Error";
        err.message = "File extension not supported, only Excel should be uploaded.";
        throw (err);

        return false;
    }

}
function uploadError(sender, args) {
    jQuery('[id$="lblUploadStatus"]').html(args.get_errorMessage());
    //    alert(args.get_errorMessage());
    //var errmessage = args.get_errorMessage();
    //var lblUploadStatus = document.getElementById("ctl00_maincontent_lblUploadStatus");
    //ResetControl("lblUploadStatus", errmessage);
}

function uploadComplete(sender, args) {

    try {
        jQuery('[id$="hdUploadFileName"]').val(args.get_fileName());
        //var fileName = args.get_fileName();
        //var hdUploadFileName = document.getElementById("ctl00_maincontent_hdUploadFileName");
        //hdUploadFileName.value = fileName;
    }
    catch (e) {
        jQuery('[id$="lblUploadStatus"]').html(e.Message);
        //alert(e.Message);
    }
}
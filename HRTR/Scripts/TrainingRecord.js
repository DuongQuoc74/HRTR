// JScript File
jQuery.noConflict();
var httpRequest = false;
var queryString;
function createHttpRequest() {
    if (window.ActiveXObject) {
        httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if (window.XMLHttpRequest) {
        httpRequest = new XMLHttpRequest();
    }
}

function EmployeeSelected(source, eventArgs) {
    if (source._serviceMethod == "GetEmployeeList") {
        var avalue = eventArgs.get_value();
        GetEmployeeProfile(avalue);
    }
}

function EmployeeNameSelected(source, eventArgs) {
    if (source._serviceMethod == "GetEmployeeListByName") {
        var controlToPopulate = document.getElementById('ctl00_maincontent_txtEmployeeID');
        if (controlToPopulate != null) {
            var avalue = eventArgs.get_value();
            controlToPopulate.value = avalue;
            GetEmployeeProfile(avalue);
        }
    }
}
function cvEmployeeIDS_ClientValidate(source, args) {
    var employeeid_id = jQuery('[id$="hdEmployeeID_ID"]').val();
    if (employeeid_id == "" || employeeid_id == "0") {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
function GetEmployeeProfile(employeeid) {
    if (employeeid != '') {
//        createHttpRequest();
//        queryString = "../Ajax/AjaxServer.aspx?type=2&employeeid=" + employeeid;
//        httpRequest.onreadystatechange = handleGetEmployeeProfile;
//        httpRequest.open("POST", queryString, true);
        //        httpRequest.send(null);
        var strurl = "../Ajax/AjaxServer.aspx?type=2&employeeid=" + employeeid;
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


                    var strtemp = jQuery(this).find('EmployeeName').text();
                    jQuery('[id$="txtEmployeeName"]').val(strtemp);

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
                    //                        var txtOperatorGroupName = document.getElementById("ctl00_maincontent_txtOperatorGroupName");
                    //    var txtCompanyName = document.getElementById("ctl00_maincontent_txtCompanyName");
                    //    var txtDepartmentName = document.getElementById("ctl00_maincontent_txtDepartmentName");
                    //    var txtJobTitle = document.getElementById("ctl00_maincontent_txtJobTitle");
                    //    var txtPositionName = document.getElementById("ctl00_maincontent_txtPositionName");
                    //    var txtShiftName = document.getElementById("ctl00_maincontent_txtShiftName");
                    //    var txtWorkcellName = document.getElementById("ctl00_maincontent_txtWorkcellName");
                    //    var txtSupervisor = document.getElementById("ctl00_maincontent_txtSupervisor");
                    //    var cbIsActive = document.getElementById("ctl00_maincontent_cbIsActive");
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
//function handleGetEmployeeProfile() {
//    if (httpRequest.readyState == 4 && httpRequest.status == 200) {
//        inputEmployeeProfile();
//    }
//}
//function inputEmployeeProfile() {
//    var responseText = httpRequest.responseText;

//    var myArray = responseText.split(";");

//    var txtEmployeeID = document.getElementById("ctl00_maincontent_txtEmployeeID");
//    var txtEmployeeName = document.getElementById("ctl00_maincontent_txtEmployeeName");
//    var txtOperatorGroupName = document.getElementById("ctl00_maincontent_txtOperatorGroupName");
//    var txtCompanyName = document.getElementById("ctl00_maincontent_txtCompanyName");
//    var txtDepartmentName = document.getElementById("ctl00_maincontent_txtDepartmentName");
//    var txtJobTitle = document.getElementById("ctl00_maincontent_txtJobTitle");
//    var txtPositionName = document.getElementById("ctl00_maincontent_txtPositionName");
//    var txtShiftName = document.getElementById("ctl00_maincontent_txtShiftName");
//    var txtWorkcellName = document.getElementById("ctl00_maincontent_txtWorkcellName");
//    var txtSupervisor = document.getElementById("ctl00_maincontent_txtSupervisor");
//    var cbIsActive = document.getElementById("ctl00_maincontent_cbIsActive");

//    if (myArray[0] == "0") {
//        txtEmployeeName.value = "";
//        txtOperatorGroupName.value = "";
//        txtCompanyName.value = "";
//        txtDepartmentName.value = "";
//        txtJobTitle.value = "";
//        txtPositionName.value = "";
//        txtShiftName.value = "";
//        txtWorkcellName.value = "";
//        txtSupervisor.value = "";
//        cbIsActive.checked = false;
//    }
//    else {

//        txtEmployeeName.value = myArray[1];
//        txtOperatorGroupName.value = myArray[2];
//        txtCompanyName.value = myArray[3];
//        txtDepartmentName.value = myArray[4];
//        txtJobTitle.value = myArray[5];
//        txtPositionName.value = myArray[6];
//        txtShiftName.value = myArray[7];
//        txtWorkcellName.value = myArray[8];
//        txtSupervisor.value = myArray[9];
//        if (myArray[10] == "False")
//            cbIsActive.checked = false;
//        else
//            cbIsActive.checked = true;
//    }
//}

function trainingGroupChange() {
    var ddlTrainingGroup = document.getElementById("ctl00_maincontent_ddlTrainingGroup");
    var vTrainingGroup = ddlTrainingGroup.value;
    if (vTrainingGroup == "0") {
        var ddlCourseGroup = document.getElementById('ctl00_maincontent_ddlCourseGroup');
        ddlCourseGroup.options.length = 0; //Xóa dữ liệu cũ
//        ddlCourseGroup.options[0] = new Option("[Please Select]", "");

        var ddlProduct = document.getElementById('ctl00_maincontent_ddlProduct');
        ddlProduct.options.length = 0; //Xóa dữ liệu cũ
//        ddlProduct.options[0] = new Option("[Please Select]", "");

        return;
    }
    createHttpRequest();
    queryString = "../Ajax/AjaxServer.aspx?type=3&traininggroupid=" + vTrainingGroup;
    httpRequest.onreadystatechange = handleCourseGroupProductChange;
    httpRequest.open("POST", queryString, true);
    httpRequest.send(null);

}
function handleCourseGroupProductChange() {
    if (httpRequest.readyState == 4 && httpRequest.status == 200) {
        inputCourseGroupProductList();
    }
}
function inputCourseGroupProductList() {
    var ddlProduct = document.getElementById('ctl00_maincontent_ddlProduct');
    var xml = httpRequest.responseXML;
    var c = xml.getElementsByTagName("Product");
    ddlProduct.options.length = 0; //Xóa dữ liệu cũ
    //    ddlProduct.options[0] = new Option("[Please Select]", "0");

    for (i = 0; i < c.length; i++) {
        var value = c[i].firstChild.nodeValue;
        var id = c[i].attributes[0].value;
        ddlProduct.options[i] = new Option(value, id);
    }

    //    ddlProduct.onchange();
    //    alert(c[0].attributes[0].value);
    if (c.length > 0)
        jQuery('[id$="hdProductID"]').val(c[0].attributes[0].value);
        //ResetControl("hdProductID", c[0].attributes[0].value);
    else
        jQuery('[id$="hdProductID"]').val('0');
        //ResetControl("hdProductID", "0");

    var ddlCourseGroup = document.getElementById('ctl00_maincontent_ddlCourseGroup');
    var xml = httpRequest.responseXML;
    var c = xml.getElementsByTagName("CourseGroup");
    ddlCourseGroup.options.length = 0; //Xóa dữ liệu cũ
    //    ddlCourseGroup.options[0] = new Option("[Please Select]", "0");

    for (i = 0; i < c.length; i++) {
        var value = c[i].firstChild.nodeValue;
        var id = c[i].attributes[0].value;
        ddlCourseGroup.options[i] = new Option(value, id);
    }
    //    ddlCourseGroup.onChange();
    if (c.length > 0)
        jQuery('[id$="hdCourseGroupID"]').val(c[0].attributes[0].value);
        //ResetControl("hdCourseGroupID", c[0].attributes[0].value);
    else
        jQuery('[id$="hdCourseGroupID"]').val('0');
        //ResetControl("hdCourseGroupID", "0");
}
function productChange() {
    var ddlProduct = document.getElementById('ctl00_maincontent_ddlProduct');
    if (ddlProduct != null)
        jQuery('[id$="hdProductID"]').val(ddlProduct.value);
        //ResetControl("hdProductID", ddlProduct.value);
}
function courseGroupChange() {
    var ddlCourseGroup = document.getElementById('ctl00_maincontent_ddlCourseGroup');
    if (ddlCourseGroup != null)
        jQuery('[id$="hdCourseGroupID"]').val(ddlCourseGroup.value);
        //ResetControl("hdCourseGroupID", ddlCourseGroup.value);
}

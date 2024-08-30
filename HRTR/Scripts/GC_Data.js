// JScript File
//function NewGrapeChart() {
//    ResetGrapeChartData();
//    //    $find('bhvmpeAdd').show();
//    //    document.getElementById("ctl00_maincontent_txtGrapeChartNoA").focus();
//    jQuery('[id$="_btnAdd"]').removeClass('invisible');
//    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
//    jQuery('[id$="_btnDelete"]').addClass('invisible');

//    $find('bhvmpeGrapeChart').show();
//    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
//    jQuery('[id$="_txtGrapeChartNo"]').focus();
//    return false;
//}

function GrapeChartUpdateValidation() {
    if (Page_ClientValidate('vggrapechart')) {
        $find('bhmpeUpdateGrapeChart').show();
    }
    return false;
}
//function cvDetectedEmployeeIDS_ClientValidate(source, args) {
//    var employeeid_id = jQuery('[id$="hdDetectedBy"]').val();
//    if (employeeid_id == "" || employeeid_id == "0") {
//        args.IsValid = false;
//    }
//    else {
//        args.IsValid = true;
//    }
//}
//function ResetGrapeChartData() {
//    ResetControl("lblGrapeChartMessage", "");
////    ResetControl("txtGrapeChartNo", "");
////    ResetControl("txtCustomsPN", "");
////    ResetControl("txtGrapeChartType", "");
////    ResetControl("txtHSCode", "");
////    ResetControl("txtDescription", "");
////    ResetControl("ddlGC_Customers", "0");
////    ResetControl("ddlFamily", "0");
////    ResetControl("txtUnitPrice", "");
////    ResetControl("txtNetWeight", "");
////    ResetControl("ddlUOM", "0");
////    ResetControl("ddlWeightUnit", "0");
////    ResetControl("cbIsActive", true);
//}
function EmployeeSelected(source, eventArgs) {
    if (source._serviceMethod == "GetEmployeeList") {
        var avalue = eventArgs.get_value();
        GetEmployeeProfile(avalue);
    }
}

//function EmployeeNameSelected(source, eventArgs) {
//    if (source._serviceMethod == "GetEmployeeListByName") {
//        var controlToPopulate = document.getElementById('ctl00_maincontent_txtDetectedEmployeeIDS');
//        if (controlToPopulate != null) {
//            var avalue = eventArgs.get_value();
//            controlToPopulate.value = avalue;
//            GetEmployeeProfile(avalue);
//        }
//    }
//}

function GetEmployeeProfile(employeeid) {
    if (employeeid != '') {
        //        createHttpRequest();
        //        queryString = "../Ajax/AjaxServer.aspx?type=2&employeeid=" + employeeid;
        //        httpRequest.onreadystatechange = handleGetEmployeeProfile;
        //        httpRequest.open("POST", queryString, true);
        //        httpRequest.send(null);
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


//                    var strtemp = jQuery(this).find('EmployeeName').text();
//                    jQuery('[id$="txtDetectedEmployeeNameS"]').val(strtemp);

//                    strtemp = jQuery(this).find('EmployeeID_ID').text();
//                    jQuery('[id$="hdDetectedBy"]').val(strtemp);
                    //                    alert(strtemp);

                    //                    strtemp = jQuery(this).find('OperatorGroupName').text();
                    //                    jQuery('[id$="txtOperatorGroupName"]').val(strtemp);

                    //                    strtemp = jQuery(this).find('CompanyName').text();
                    //                    jQuery('[id$="txtCompanyName"]').val(strtemp);

                    //                    strtemp = jQuery(this).find('DepartmentName').text();
                    //                    jQuery('[id$="txtDepartmentName"]').val(strtemp);

                    //                    strtemp = jQuery(this).find('JobTitle').text();
                    //                    jQuery('[id$="txtJobTitle"]').val(strtemp);

                    //                    strtemp = jQuery(this).find('PositionName').text();
                    //                    jQuery('[id$="txtPositionName"]').val(strtemp);

                    //                    strtemp = jQuery(this).find('ShiftName').text();
                    //                    jQuery('[id$="txtShiftName"]').val(strtemp);

                    //                    strtemp = jQuery(this).find('GC_CustomersName').text();
                    //                    jQuery('[id$="txtGC_CustomersName"]').val(strtemp);

                    //                    strtemp = jQuery(this).find('Supervisor').text();
                    //                    jQuery('[id$="txtSupervisor"]').val(strtemp);

                    //                    strtemp = jQuery(this).find('Supervisor').text();
                    //                    jQuery('[id$="txtSupervisor"]').val(strtemp);
                    //                    strtemp = jQuery(this).find('IsActive').text();
                    //                    if (strtemp == "False") {
                    //                        jQuery('[id$="cbIsActive"]').prop('checked', false);
                    //                    }
                    //                    else {

                    //                        jQuery('[id$="cbIsActive"]').prop('checked', true);
                    //                    }
                    //                        var txtOperatorGroupName = document.getElementById("ctl00_maincontent_txtOperatorGroupName");
                    //    var txtCompanyName = document.getElementById("ctl00_maincontent_txtCompanyName");
                    //    var txtDepartmentName = document.getElementById("ctl00_maincontent_txtDepartmentName");
                    //    var txtJobTitle = document.getElementById("ctl00_maincontent_txtJobTitle");
                    //    var txtPositionName = document.getElementById("ctl00_maincontent_txtPositionName");
                    //    var txtShiftName = document.getElementById("ctl00_maincontent_txtShiftName");
                    //    var txtGC_CustomersName = document.getElementById("ctl00_maincontent_txtGC_CustomersName");
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
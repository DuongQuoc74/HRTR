// JScript File
function RemoveUserFromRole(userprofileid, username, rolename) {
    var hdUserProfileIDR = document.getElementById("ctl00_maincontent_hdUserProfileIDR");
    if (hdUserProfileIDR != null)
        hdUserProfileIDR.value = userprofileid;

    var lblRemoveMessage = document.getElementById("ctl00_maincontent_lblRemoveMessage");
    if (lblRemoveMessage != null)
        lblRemoveMessage.innerHTML = "Are you sure you want to remove user " + username + " from permission role " + rolename + "?";
    $find('bhmpeConfirmRemove').show();
    document.getElementById("ctl00_maincontent_btnOKRemove").focus();
}

function AddValidation() {

    if (Page_ClientValidate('vgaddusertorole')) {
        var vUserNameA = ""; 
        var txtUserNameA = document.getElementById("ctl00_maincontent_txtUserNameA");
        if (txtUserNameA != null)
            vUserNameA = txtUserNameA.value;

        var vPermissionRoleNameA = "";
        var ddlPermissionRoleA = document.getElementById("ctl00_maincontent_ddlPermissionRoleA");
        if (ddlPermissionRoleA != null)
            vPermissionRoleNameA = ddlPermissionRoleA.options[ddlPermissionRoleA.selectedIndex].text;

        var lblAddMessage = document.getElementById("ctl00_maincontent_lblAddMessage");
        if (lblAddMessage != null)
            lblAddMessage.innerHTML = "Are you sure you want to add user " + vUserNameA + " to permission role " + vPermissionRoleNameA + "?";

        $find('bhmpeConfirmAdd').show();
        document.getElementById("ctl00_maincontent_btnOKAdd").focus();
    }
    return false;
}


function UserSelected(source, eventArgs) {
    var controlToPopulate;
    var avalue = eventArgs.get_value();
    if (source._serviceMethod == "GetUserProfileList") {
        controlToPopulate = document.getElementById('ctl00_maincontent_hdUserProfileIDA');
    }

    if (controlToPopulate != null) {
        controlToPopulate.value = avalue;
        GetUserProfile(avalue);
    }
}

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
function GetUserProfile(userprofileid) {
    if (userprofileid != '') {
        createHttpRequest();
        queryString = "../AjaxServer/ASUserProfile.aspx?type=1&userprofileid=" + userprofileid;
        httpRequest.onreadystatechange = handleGetUserProfile;
        httpRequest.open("POST", queryString, true);
        httpRequest.send(null);
    }
}
function handleGetUserProfile() {
    if (httpRequest.readyState == 4 && httpRequest.status == 200) {
        inputUserProfile();
    }
}
function inputUserProfile() {
    var responseText = httpRequest.responseText;
    
    var myArray = responseText.split(";");

    var txtUserNameA = jQuery('[id$="txtUserNameA"]');
    var txtEmployeeIDA = jQuery('[id$="txtEmployeeIDA"]');
    var txtFullNameA = jQuery('[id$="txtFullNameA"]');
    var txtEmailA = jQuery('[id$="txtEmailA"]');
    var ddlDepartmentA = jQuery('[id$="ddlDepartmentA"]');
    var txtContactNoA = jQuery('[id$="txtContactNoA"]');

//    var txtUserNameA = document.getElementById("ctl00_maincontent_txtUserNameA");
//    var txtEmployeeIDA = document.getElementById("ctl00_maincontent_txtEmployeeIDA");
//    var txtFullNameA = document.getElementById("ctl00_maincontent_txtFullNameA");
//    var txtEmailA = document.getElementById("ctl00_maincontent_txtEmailA");
//    var ddlDepartmentA = document.getElementById("ctl00_maincontent_ddlDepartmentA");
//    var txtContactNoA = document.getElementById("ctl00_maincontent_txtContactNoA");

    if (myArray[0] == "0") {
        txtUserNameA.val('');
        txtEmployeeIDA.val('');
        txtFullNameA.val('');
        txtEmailA.val('');
        ddlDepartmentA.val('0');
        txtContactNoA.val('');

//        txtUserNameA.value = "";
//        txtEmployeeIDA.value = "";
//        txtFullNameA.value = "";
//        txtEmailA.value = "";
//        ddlDepartmentA.value = "0";
//        txtContactNoA.value = "";
    }
    else {
        txtUserNameA.val(myArray[1]);
        txtEmployeeIDA.val(myArray[2]);
        txtFullNameA.val(myArray[3]);
        txtEmailA.val(myArray[4]);
        ddlDepartmentA.val(myArray[5]);
        txtContactNoA.val(myArray[6]);
//        txtUserNameA.value = myArray[1];
//        txtEmployeeIDA.value = myArray[2];
//        txtFullNameA.value = myArray[3];
//        txtEmailA.value = myArray[4];
//        ddlDepartmentA.value = myArray[5];
//        txtContactNoA.value = myArray[6];
    }
}

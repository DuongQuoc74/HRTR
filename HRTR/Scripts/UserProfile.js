// JScript File
function NewUserProfile() {
    //    ResetData();
    //    $find('bhvmpeAdd').show();
    //    document.getElementById("ctl00_maincontent_txtSearchUserA").focus();
    //    return false;

    ResetUserProfileData();
    //    $find('bhvmpeAdd').show();
    //    document.getElementById("ctl00_maincontent_txtPartNoA").focus();
    jQuery('[id$="_btnAdd"]').removeClass('invisible');
    jQuery('[id$="_lblSearchUser"]').removeClass('invisible');
    jQuery('[id$="_txtSearchUser"]').removeClass('invisible');
    jQuery('[id$="_btnUpdateAsk"]').addClass('invisible');
    jQuery('[id$="_btnDelete"]').addClass('invisible');


    $find('bhvmpeUserProfile').show();
    //    document.getElementById("ctl00_maincontent_txtBatchIDU").focus();
    jQuery('[id$="_txtSearchUser"]').focus();
    return false;
}

function ResetUserProfileData() {
    jQuery('[id$="hdUserProfileID"]').val('0');
    jQuery('[id$="txtSearchUser"]').val('');
    jQuery('[id$="txtUserName"]').val('');
    jQuery('[id$="txtEmployeeID"]').val('');
    jQuery('[id$="txtFullName"]').val('');
    jQuery('[id$="txtEmail"]').val('');
    jQuery('[id$="txtContactNo"]').val('');
    jQuery('[id$="cbIsActive"]').attr('checked', true);
    jQuery('[id$="ddlDepartment"]').val('0');
    jQuery('[id$="lblUserProfileMessage"]').html('');

    var cblUserPermissionRole = document.getElementById("ctl00_maincontent_cblUserPermissionRole");
//    var cblUserPermissionRole = jQuery('[id$="_cblUserPermissionRole"]');
    var cbList = cblUserPermissionRole.getElementsByTagName("input");
    for (i = 0; i < cbList.length; i++) {
        if (cbList[i].type == "checkbox")
            if (i == 0)
                cbList[i].checked = true;
            else
                cbList[i].checked = false;
        }

    var cblUserCustomer = document.getElementById("ctl00_maincontent_cblUserCustomer");
    //    var cblUserCustomer = jQuery('[id$="_cblUserCustomer"]');
    cbList = cblUserCustomer.getElementsByTagName("input");
    for (i = 0; i < cbList.length; i++) {
        if (cbList[i].type == "checkbox")
            if (i == 0)
                cbList[i].checked = true;
            else
                cbList[i].checked = false;
    }
}

function UserProfileUpdateValidation() {
    if (Page_ClientValidate('vguserprofile')) {
        $find('bhmpeConfirmUpdate').show();
    }
    return false;
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
function SearchUser(ojb) {
    var vSearch = ojb.value;
    if (vSearch != '' && vSearch.length >= 2) {
        createHttpRequest();
        queryString = "../AjaxServer/ASUserProfile.aspx?type=8&search=" + vSearch;
        httpRequest.onreadystatechange = handleSearchUser;
        httpRequest.open("POST", queryString, true);
        httpRequest.send(null);
    }
}
function handleSearchUser() {
    if (httpRequest.readyState == 4 && httpRequest.status == 200) {
        inputSearchUser();
    }
}
function inputSearchUser() {
    var responseText = httpRequest.responseText;
    var myArray = responseText.split(";");

    var txtUserName = jQuery('[id$="_txtUserName"]');
    var txtFullName = jQuery('[id$="_txtFullName"]');
    var txtEmail = jQuery('[id$="_txtEmail"]');
    var txtContactNo = jQuery('[id$="_txtContactNo"]');
    var txtEmployeeID = jQuery('[id$="_txtEmployeeID"]');

    if (myArray[0] == "0") {
        txtUserName.val('');
        txtFullName.val('');
        txtEmail.val('');
        txtContactNo.val('');
        txtEmployeeID.val('');
    }
    else {
        txtUserName.val(myArray[1]);
        txtFullName.val(myArray[2]);
        txtEmail.val(myArray[3]);
        txtContactNo.val(myArray[10]);
        txtEmployeeID.val(myArray[11]);
    }
}
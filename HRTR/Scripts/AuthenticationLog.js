// JScript File
jQuery.noConflict();
jQuery(document).ready(function () {
   
});
function cvEmployeeIDUserName_ClientValidate(source, args) {
    var employeeid = jQuery('[id$="txtEmployeeIDS"]').val();
    var username = jQuery('[id$="txtUserNameS"]').val();
    if (employeeid == "" && username == "") {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}
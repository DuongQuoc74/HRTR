jQuery(document).ready(function () {
    jQuery(document).on('keypress', '.positivenumber', function (event) {
        return OnlyPositiveNumber();
    });
});
function ConfirmationApplyCheck() {
    if (Page_ClientValidate('vgedit')) {
        $find('bhmpeConfirmUpdate').show();
        jQuery('[id$="btnUpdate"]').focus();
        return false;
    }
    return false;
};
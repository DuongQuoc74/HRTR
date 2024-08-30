function Left(str, n) {
    if (n <= 0)
        return "";
    else if (n > String(str).length)
        return str;
    else
        return String(str).substring(0, n);
}
function Right(str, n) {
    if (n <= 0)
        return "";
    else if (n > String(str).length)
        return str;
    else {
        var iLen = String(str).length;
        return String(str).substring(iLen, iLen - n);
    }
}

//function ResetControl(ctrlid, newvalue) {
//    //    alert(ctrl);
//    //    alert(newvalue);
//    var ctrl = document.getElementById("ctl00_maincontent_" + ctrlid);
//    if (ctrl != null) {

//        if (ctrl.type == "text") {
//            ctrl.value = newvalue;
//        }
//        else if (ctrl.type == "select-one") {
//            //            alert(ctrl);
//            //                    alert(ctrl.selectedIndex);
//            //        alert(newvalue);
//            ctrl.selectedIndex = newvalue;
//        }
//        else if (ctrl.type == "checkbox") {
//            //            alert(ctrl.checked);
//            //            alert(newvalue);
//            ctrl.checked = newvalue;
//        }
//        else if (ctrl.type == "hidden") {
//            //            alert(ctrl.value);
//            ctrl.value = newvalue;
//        }
//        else if (ctrl.type == "submit") {
//            //            alert("A");
//            ctrl.value = newvalue;
//        }
//        else if (ctrl.type == "button") {
//            //                        alert("A");
//            ctrl.value = newvalue;
//        }
//        else {
//            ctrl.innerHTML = newvalue;
//        }
//        //        alert(ctrlid + "=" + ctrl.checked);
//    }
//}
////Get control value,  not used at the moment
//function GetValueFromControl(ctrlid, defaultvalue) {
//    //    alert(ctrl);
//    //    alert(newvalue);
//    var returnvalue = defaultvalue;
//    var ctrl = document.getElementById("ctl00_maincontent_" + ctrlid);
//    if (ctrl != null) {
//        //        alert(ctrlid + ctrl.type);
//        if (ctrl.type == "text") {
//            returnvalue = ctrl.value;
//        }
//        else if (ctrl.type == "select-one") {
//            returnvalue = ctrl.value;
//        }
//        else if (ctrl.type == "checkbox") {
//            //            alert(ctrl.checked);
//            //            alert(newvalue);
//            returnvalue = ctrl.checked;
//        }
//        else if (ctrl.type == "hidden") {
//            //            alert(ctrl.value);
//            returnvalue = ctrl.value;
//        }
//        else if (ctrl.type == "submit") {
//            //            alert("A");
//            returnvalue = ctrl.value;
//        }
//        else if (ctrl.type == "button") {
//            //                        alert("A");
//            returnvalue = ctrl.value;
//        }
//        else {
//            returnvalue = ctrl.innerHTML;
//        }
//        //        alert(ctrlid + "=" + ctrl.checked);
//    }
//    return returnvalue;
//}

//function DisableControl(ctrlid) {
//    var ctrl = document.getElementById("ctl00_maincontent_" + ctrlid);
//    if (ctrl != null) {
//        ctrl.disabled = true;
//    }

//}
//function EnableControl(ctrlid) {
//    var ctrl = document.getElementById("ctl00_maincontent_" + ctrlid);
//    if (ctrl != null) {
//        ctrl.disabled = false;
//    }
//}
//function SetHidden(ctrlid) {
//    var ctrl = document.getElementById("ctl00_maincontent_" + ctrlid);
//    if (ctrl != null) {
//        ctrl.style.visibility = "hidden";
//    }
//}

function cv_ClientValidate(source, args) {
    //    alert("a");
    if (args.Value != "" && args.Value != "0")
        args.IsValid = true;
    else
        args.IsValid = false;
}
///100,000,000.00
function cvPositiveNumber_ClientValidate(source, args) {
    var n = args.Value.replace(',', '');
    if (n != "") {
        if (isNaN(n)) {
            args.IsValid = false;
        }
        else {
            if (eval(n) > 0) {
                args.IsValid = true;
            }
            else {
                args.IsValid = false;
            }
        }
    }
    else {
        args.IsValid = false;
    }
}
function cvNumber_ClientValidate(source, args) {
    //    alert(args.Value);
    if (args.Value != "") {
        //        alert("A");
        if (isNaN(args.Value)) {
            //            alert("B");
            args.IsValid = false;
        }
        else {
            //            alert("C");
            args.IsValid = true;
        }
    }
    else
        args.IsValid = false;
}
function OnlyPositiveNumber() {
    var charCode = (event.which) ? event.which : event.keyCode
    if (charCode > 47 && charCode < 58) {
        return true;
    }
    else {
        return false;
    }

};

function OnlyNumber() {
    var charCode = (event.which) ? event.which : event.keyCode
    if (charCode > 47 && charCode < 58)
        return true;
    else
        return false;

}

//function RowChecked(ojb, grvClientID, clientCheckboxID) {
//    //    alert(ojb.checked);
//    var grv = document.getElementById(grvClientID);
//    var cbNList = grv.getElementsByTagName("input");

//    var checkall = true;
//    var checkallid;
//    var cbN;
//    if (ojb.checked) {
//        var find1 = false;
//        var find2 = false;
//        for (i = 0; i < cbNList.length; i++) {
//            cbN = cbNList[i];
//            if (cbN.id != null) {
//                var clientlen = clientCheckboxID.length;
//                var cbNID = Right(cbN.id, clientlen);

//                if (cbNID == clientCheckboxID) {
//                    if (cbN.checked == false) {
//                        checkall = false;
//                        find1 = true;
//                    }
//                }
//                else if (Right(cbN.id, 8) == "cbHeader") {
//                    checkallid = cbN;
//                    find2 = true;

//                }
//            }
//            if (find1 == true && find2 == true)
//                break;
//        }
//        if (checkallid != null) {
//            checkallid.checked = checkall;
//        }
//    }
//    else {
//        // find head checkbox and unchecked
//        for (i = 0; i < cbNList.length; i++) {
//            cbN = cbNList[i];
//            if (cbN.id != null) {
//                if (Right(cbN.id, 8) == "cbHeader") {
//                    cbN.checked = false;
//                    break;
//                }
//            }
//        }
//    }
//}
//function SetCheckUnCheckAll(ojb, grvClientID, clientCheckboxID) {
//    var grv = document.getElementById(grvClientID);
//    var cbNList = grv.getElementsByTagName("input");
//    for (i = 0; i < cbNList.length; i++) {

//        var cbN = cbNList[i];
//        if (cbN.id != null) {
//            var clientlen = clientCheckboxID.length;
//            var cbNID = Right(cbN.id, clientlen);
//            if (cbNID == clientCheckboxID) {
//                //                if(cbN.disabled == false)
//                cbN.checked = ojb.checked;
//            }
//        }
//    }
//}
//// Kiem tra gridview, it nhat phai co 1 row duoc check, return true, neu ko return false
//function CheckorNot(grvClientID, clientCheckboxID) {
//    var grv = document.getElementById(grvClientID);
//    if (grv != null) {
//        var cbNList = grv.getElementsByTagName("input");
//        for (i = 0; i < cbNList.length; i++) {
//            var cbN = cbNList[i];
//            if (cbN.id != null) {
//                var clientlen = clientCheckboxID.length;
//                var cbNID = Right(cbN.id, clientlen);
//                if (cbNID == clientCheckboxID) {
//                    if (cbN.checked == true)
//                        return true;
//                }
//            }
//        }
//    }
//    return false;
//}
////Check, only check one row in gridview, return true, if else, return false
//function CheckOneRow(grvClientID, clientCheckboxID) {
//    var grv = document.getElementById(grvClientID);
//    if (grv != null) {
//        var cbNList = grv.getElementsByTagName("input");
//        var flag = false;
//        for (i = 0; i < cbNList.length; i++) {
//            var cbN = cbNList[i];
//            if (cbN.id != null) {
//                var clientlen = clientCheckboxID.length;
//                var cbNID = Right(cbN.id, clientlen);
//                if (cbNID == clientCheckboxID) {
//                    if (cbN.checked == true) {
//                        // the second row is checked
//                        if (flag == true)
//                            return false;
//                        else
//                            flag = true;
//                    }
//                }
//            }
//        }
//    }
//    return true;
//}

///For new UI
function CheckAllHeader(grv) {
    var cball = '[id$="' + grv + '"] input[id*="cbCheckAll"]:checkbox';
    var cbs = '[id$="' + grv + '"] input[id*="cbSelect"]:checkbox';
    jQuery(cball).live('click', function () {
        var ischeck = jQuery(this).is(':checked');
        jQuery(cbs).each(function () {
            if (jQuery(this).is(':disabled')) {
            }
            else {
                jQuery(this).attr('checked', ischeck);
            }
        });
    });

    jQuery(cbs).live('click', function () {
        jQuery(cbs).each(function () {
            if (jQuery(this).is(':checked')) {
                jQuery(cball).attr('checked', true);
            }
            else {
                jQuery(cball).attr('checked', false);
                return false;
            }
        });
    });
};
function DateChanged(sender, args) {
}
//function ClearSearch() {
//    //    alert('a');
//    jQuery('[id$="pnSearch"] input:text:not(.pagesizenumber)').val('');
//    jQuery('[id$="pnSearch"] select').prop("selectedIndex", 0);
//}
function ClearSearch(panelid) {
    //    alert('a');
    if (typeof panelid == 'undefined') panelid = 'pnSearch';
    jQuery('[id$="' + panelid + '"] input:text:not(.pagesizenumber)').val('');
    jQuery('[id$="' + panelid + '"] select').prop("selectedIndex", 0);
}
function ConfirmationDeleteCheck(deletekind, selectedgrid, errorlabel, errormessage, confirmmessage) {
    var cbSelect = '[id$="_' + selectedgrid + '"] input[id*="cbSelect"]:checkbox';
    if (jQuery(cbSelect).is(':checked')) {
        var lblErrorLabel = '[id$="_' + errorlabel + '"]';
        jQuery(lblErrorLabel).html("").hide("fast");
        //        jQuery('input[id$="hdDeleteKind"]').val(deletekind);
        //        jQuery('[id$="_cfmbDelete_lblConfirmationDetail"]').html('Do you want to delete?');
        //        $find('bhmpeDelete').show();
        //        jQuery('[id$="_cfmbDelete_btnOk"]').focus();
        jQuery('input[id$="hdDeleteKind"]').val(deletekind);
        if (confirmmessage == undefined)
            jQuery('[id$="_lblConfirmationDelete"]').html('Do you want to delete?');
        else
            jQuery('[id$="_lblConfirmationDelete"]').html(confirmmessage);
        //        jQuery('[id$="_lblConfirmationDelete"]').html('Do you want to delete?');
        $find('bhmpeConfirmDelete').show();
        jQuery('[id$="_btnDelete"]').focus();
    }
    else {
        if (errormessage == undefined)
            ShowError(errorlabel, 'No one selected.');
        else
            ShowError(errorlabel, errormessage);
    }
    return false;
};
function ShowMessage(lblmessage, strmessage, strcssclass) {
    if (!strcssclass) strcssclass = 'Msg';
    if (typeof strcssclass == 'undefined') strcssclass = 'Msg';
    var lbl = '[id$="_' + lblmessage + '"]';
    if (strcssclass == "") {
        strcssclass = "Msg";
    }
    jQuery(lbl).html(strmessage).show("fast").addClass(strcssclass);
    //    jQuery(lbl).delay(10000).fadeOut();

};
function ShowError(lblerror, strerror) {
    ShowMessage(lblerror, strerror, 'errorMsg');
};
function ClearMessage(lblmessage) {
    var lbl = '[id$="_' + lblmessage + '"]';
    var strcssclass = jQuery(lbl).attr('class');
    jQuery(lbl).html('').removeClass(strcssclass);
};


function IsIE() {
    if (navigator.appName.indexOf("Microsoft Internet") == -1) {
        return false;
    }
    else // if (navigator.appName.indexOf("Microsoft Internet")!=-1)
    {
        return true;
    }
}

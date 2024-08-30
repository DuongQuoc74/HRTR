function Logout() {
    try {
        if (window.XMLHttpRequest) {
            document.execCommand("ClearAuthenticationCache", false);

            if (top.location != location) {
                top.location.href = ".";
            }
        }
        else {
            alert("This feature requires Internet Explorer 6.0 Service Pack 1 or above. " + "Please close all browser windows in order to complete the logout process.");
        }
    }
    catch (e) {
        alert("This feature requires Internet Explorer 6.0 Service Pack 1 or above. " + "Please close all browser windows in order to complete the logout process.");
    }
}
function OpenHelp() {
    window.open("Help.html");
    return false;
}
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

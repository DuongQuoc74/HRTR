<%@ Page Language="C#" MasterPageFile="~/HCM.master" AutoEventWireup="true" CodeFile="UserProfile.aspx.cs"
    Inherits="HRTR_UserProfile" Title="User Profile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            User Profile</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/UserProfile.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Common2.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <asp:LinkButton ID="lbSearch" runat="server" CssClass="multiviewtabactive" OnCommand="mvUserProfile_Command"
                                    CommandName="Search">Search</asp:LinkButton>
                                <asp:LinkButton ID="lbImport" runat="server" CssClass="multiviewtabinactive" OnCommand="mvUserProfile_Command"
                                    CommandName="Import">Import User Profile From Excel File</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:MultiView ID="mvUserProfile" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="vSearchUserProfile" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                    <fieldset>
                                                        <legend>Search</legend>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label3" runat="server" Text="User Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtUserNameS" runat="server" Width="250px"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label48" runat="server" Text="Employee ID"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtEmployeeIDS" runat="server" Width="250px"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label46" runat="server" Text="Full Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtFullNameS" runat="server" Width="250px"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label49" runat="server" Text="Email"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtEmailS" runat="server" Width="250px"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label47" runat="server" Text="Department"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlDepartmentS" runat="server" AppendDataBoundItems="True"
                                                                            DataTextField="DepartmentName" DataValueField="DepartmentID" Width="250px">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label50" runat="server" Text="Contact No."></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtContactNoS" runat="server" Width="250px"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label44" runat="server" Text="Active"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="250px">
                                                                            <asp:ListItem Value="-1">[Please Select]</asp:ListItem>
                                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="8">
                                                                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                                            CssClass="button" UseSubmitBehavior="True"></asp:Button>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnAddControl" runat="server" Text="New" CssClass="button" UseSubmitBehavior="False"
                                                        OnClientClick="return showModalAdd();"></asp:Button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grvUserProfileList" runat="server" OnRowDataBound="grvUserProfileList_RowDataBound"
                                                        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="UserProfileID"
                                                        OnPageIndexChanging="grvUserProfileList_PageIndexChanging" OnSorting="grvUserProfileList_Sorting"
                                                        OnRowCommand="grvUserProfileList_RowCommand" CssClass="gridview" PagerStyle-CssClass="pgr"
                                                        EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                                        FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal"
                                                        PageSize="20">
                                                        <PagerSettings Mode="NumericFirstLast"></PagerSettings>
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="No.">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                <ItemStyle CssClass="rowno" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="FullName" HeaderText="Full Name" SortExpression="FullName">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"></asp:BoundField>
                                                            <asp:BoundField DataField="DepartmentName" HeaderText="Department" SortExpression="DepartmentName">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ContactNo" HeaderText="Contact No." SortExpression="ContactNo">
                                                            </asp:BoundField>
                                                            <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                                                                <ItemStyle CssClass="checkbox" />
                                                            </asp:CheckBoxField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                                        CssClass="ContextMenuTarget" />
                                                                    <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none;
                                                                        visibility: hidden;">
                                                                        <asp:LinkButton runat="server" Text="Edit" CommandName="Select" CausesValidation="False"
                                                                            CssClass="ContextMenuItem" ID="lbEdit" CommandArgument='<%# Eval("UserProfileID") %>'></asp:LinkButton>
                                                                        <asp:LinkButton runat="server" Text="Delete" CommandName="DelUser" CausesValidation="False"
                                                                            CssClass="ContextMenuItem" ID="lbDelete" CommandArgument='<%# Eval("UserProfileID") %>'></asp:LinkButton>
                                                                    </asp:Panel>
                                                                    <ajaxToolkit:DropDownExtender runat="server" ID="DDE" TargetControlID="TextLabel"
                                                                        DropDownControlID="DropPanel" />
                                                                </ItemTemplate>
                                                                <ItemStyle CssClass="select" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="vUploadUserProfile" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                    <fieldset>
                                                        <legend>Upload</legend>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <td style="width: 10%">
                                                                        <asp:Label ID="Upload" runat="server" Text="Select file"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 40%">
                                                                        <ajaxToolkit:AsyncFileUpload ID="AsyncFUUserProfile" runat="server" CssClass="FileUploadClass"
                                                                            Width="400px" OnClientUploadStarted="uploadStart" OnClientUploadComplete="uploadComplete"
                                                                            OnClientUploadError="uploadError" ThrobberID="myThrobber" OnUploadedComplete="AsyncFUUserProfile_UploadedComplete"
                                                                            FailedValidation="False"></ajaxToolkit:AsyncFileUpload>
                                                                    </td>
                                                                    <td style="width: 5%">
                                                                        <asp:Label ID="myThrobber" runat="server" Style="display: none">
                                                                            <img src="../Images/indicator.gif" align="middle" alt="loading" />
                                                                        </asp:Label>
                                                                    </td>
                                                                    <td style="width: 5%">
                                                                        <asp:CustomValidator ID="cvFile" runat="server" ValidationGroup="vgpreviewpart" ClientValidationFunction="cvFile_ClientValidate"
                                                                            ErrorMessage="Select file">(*)</asp:CustomValidator>
                                                                    </td>
                                                                    <td style="width: 10%">
                                                                        <asp:Button ID="btnPreview" runat="server" CssClass="button" ValidationGroup="vgpreviewuserprofile"
                                                                            Text="Preview" OnClick="btnPreview_Click" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:HyperLink ID="hlUserProfileTemplate" runat="server" NavigateUrl="../Templates/UserProfile.xlsx">User Profile Template</asp:HyperLink>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="6">
                                                                        <asp:Label ID="lblUploadStatus" runat="server" CssClass="errorMsg"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grvUserProfileTempList" runat="server" AllowPaging="True" AllowSorting="True"
                                                        AutoGenerateColumns="False" PageSize="30" OnPageIndexChanging="grvUserProfileTempList_PageIndexChanging"
                                                        OnSorting="grvUserProfileTempList_Sorting" CssClass="gridview" PagerStyle-CssClass="pgr"
                                                        EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                                        FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal">
                                                        <PagerSettings Mode="NumericFirstLast" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="No.">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                <ItemStyle CssClass="rowno" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="FullName" HeaderText="Full Name" SortExpression="FullName">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"></asp:BoundField>
                                                            <asp:BoundField DataField="DepartmentName" HeaderText="Department" SortExpression="DepartmentName">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ContactNo" HeaderText="Contact No." SortExpression="ContactNo">
                                                            </asp:BoundField>
                                                            <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                                                                <ItemStyle CssClass="checkbox" />
                                                            </asp:CheckBoxField>
                                                            <asp:CheckBoxField DataField="IsValid" HeaderText="Valid" SortExpression="IsValid">
                                                                <ItemStyle CssClass="checkbox" />
                                                            </asp:CheckBoxField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnUploadInfo" runat="server" Visible="false">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblUserProfileTemp" runat="server" Text="Total: " CssClass="boldlabel"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblUserProfileTempCount" runat="server" Text="" CssClass="message"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblUserProfileTempValid" runat="server" Text="Valid: " CssClass="boldlabel"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblUserProfileTempValidCount" runat="server" Text="" CssClass="message"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblUserProfileTempInValid" runat="server" Text="Invalid: " CssClass="boldlabel"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblUserProfileTempInValidCount" runat="server" Text="" CssClass="message"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnUploadAsk" runat="server" Text="Upload" CssClass="button" ValidationGroup="vguploaduserprofile"
                                                        Visible="false" OnClientClick="return uploadUserProfileValidate();"></asp:Button>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                </asp:MultiView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeUpdate" runat="server" BehaviorID="bhvmpeUpdate"
                                    PopupDragHandleControlID="PanelUpdate1" DropShadow="false" CancelControlID="btnCancelU"
                                    OkControlID="btnReturnU" BackgroundCssClass="modalBackgroundCommon" PopupControlID="PanelUpdate"
                                    TargetControlID="btnSaveControl" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none; width: 550px;" ID="PanelUpdate" runat="server" CssClass="modalPopupCommon">
                                    <asp:Panel ID="PanelUpdate1" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Update User Profile</p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%">
                                                    <asp:Label ID="Label1" runat="server">User Name</asp:Label>
                                                </td>
                                                <td style="width: 40%">
                                                    <asp:TextBox ID="txtUserNameU" runat="server" Width="99%">
                                                    </asp:TextBox>
                                                </td>
                                                <td style="width: 5%">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtUserNameU"
                                                        Display="Dynamic" ErrorMessage="User name is required." ToolTip="User name is required."
                                                        ValidationGroup="vgupdateuser">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td rowspan="7" valign="top" align="left">
                                                    <fieldset class="fieldsetrole">
                                                        <legend>Permission role</legend>
                                                        <asp:CheckBoxList ID="cblUserRoleU" runat="server" DataValueField="PermissionRoleID"
                                                            DataTextField="PermissionRoleName">
                                                        </asp:CheckBoxList>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label45" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeIDU" runat="server" ValidationGroup="vgupdateuser" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="EmailLabel" runat="server">E-mail</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmailU" runat="server" Width="99%" ValidationGroup="vgupdateuser"
                                                        AutoCompleteType="Email">
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtEmailU" ToolTip="Wrong email format"
                                                        ErrorMessage="(*)" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        runat="server" ID="RegularExpressionValidator3" ValidationGroup="vgupdateuser" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" Text="Full Name">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFullNameU" runat="server" Width="99%" ValidationGroup="vgupdateuser"
                                                        AutoCompleteType="DisplayName">
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ValidationGroup="vgupdateuser"
                                                        Display="Dynamic" ControlToValidate="txtFullNameU" ErrorMessage="Fullname is required.">(*)</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label16" runat="server" Text="Contact No.">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtContactNoU" runat="server" Width="99%" ValidationGroup="vgupdateuser">
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" Text="Department">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlDepartmentU" runat="server" Width="99%" DataValueField="DepartmentID"
                                                        DataTextField="DepartmentName" AppendDataBoundItems="True">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsActiveU" runat="server" Text="Active"></asp:CheckBox>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <asp:Label ID="lblUpdateErr" runat="server" Text="" CssClass="errorMsg"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <table class="applytable">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnSave" OnClientClick="return updateValidation();" runat="server"
                                                                        Text="Update" CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgupdateuser">
                                                                    </asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelU" runat="server" Text="Cancel" CssClass="button" UseSubmitBehavior="False"
                                                                        OnClientClick="return false;"></asp:Button>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeDelete" runat="server" BehaviorID="bhvmpeDelete"
                                    PopupDragHandleControlID="PanelDelete1" DropShadow="false" CancelControlID="btnCancelD"
                                    OkControlID="btnReturnD" BackgroundCssClass="modalBackgroundCommon" PopupControlID="PanelDelete"
                                    TargetControlID="btnDeleteControl" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 550px;" ID="PanelDelete"
                                    runat="server">
                                    <asp:Panel ID="PanelDelete1" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Delete User Profile</p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%">
                                                    <asp:Label ID="Label2" runat="server">User Name</asp:Label>
                                                </td>
                                                <td style="width: 45%">
                                                    <asp:TextBox ID="txtUserNameD" runat="server" Width="99%" Enabled="False"></asp:TextBox>
                                                </td>
                                                <td rowspan="7" valign="top" align="left">
                                                    <fieldset class="fieldsetrole">
                                                        <legend>Permission role</legend>
                                                        <asp:CheckBoxList ID="cblUserRoleD" runat="server" DataValueField="PermissionRoleID"
                                                            DataTextField="PermissionRoleName" Enabled="False">
                                                        </asp:CheckBoxList>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label8" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeIDD" runat="server" ValidationGroup="vgDeleteuser" Width="99%"
                                                        Enabled="False"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label9" runat="server">E-mail</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmailD" runat="server" Width="99%" ValidationGroup="vgDeleteuser"
                                                        AutoCompleteType="Email" Enabled="False"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label10" runat="server" Text="Full Name">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFullNameD" runat="server" Width="99%" ValidationGroup="vgDeleteuser"
                                                        AutoCompleteType="DisplayName" Enabled="False"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label15" runat="server" Text="Contact No.">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtContactNoD" runat="server" Width="99%" ValidationGroup="vgDeleteuser"
                                                        Enabled="False"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label11" runat="server" Text="Department">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlDepartmentD" runat="server" Width="99%" DataValueField="DepartmentID"
                                                        DataTextField="DepartmentName" AppendDataBoundItems="True" Enabled="False">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsActiveD" runat="server" Text="Active" Enabled="False"></asp:CheckBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:Label ID="lblDeleteErr" runat="server" Text="" CssClass="errorMsg"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <table class="applytable">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnDelete" OnClick="btnDelete_Click" runat="server" Text="Delete"
                                                                        CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelD" runat="server" Text="Cancel" CssClass="button" UseSubmitBehavior="False"
                                                                        OnClientClick="return false;"></asp:Button>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeAdd" runat="server" BehaviorID="bhvmpeAdd"
                                    PopupDragHandleControlID="PanelAdd1" DropShadow="false" CancelControlID="btnCancelA"
                                    OkControlID="btnReturnA" BackgroundCssClass="modalBackgroundCommon" PopupControlID="PanelAdd"
                                    TargetControlID="btnAddControl" CacheDynamicResults="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 550px;" ID="PanelAdd"
                                    runat="server">
                                    <asp:Panel ID="PanelAdd1" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add New User Profile</p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%">
                                                    <asp:Label ID="lblSearchUserA" runat="server">Search</asp:Label>
                                                </td>
                                                <td style="width: 45%">
                                                    <asp:TextBox ID="txtSearchUserA" runat="server" TabIndex="1" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 5%">
                                                </td>
                                                <td rowspan="8" valign="top" align="left">
                                                    <fieldset class="fieldsetrole">
                                                        <legend>Permission role</legend>
                                                        <asp:CheckBoxList ID="cblUserRoleA" runat="server" DataValueField="PermissionRoleID"
                                                            DataTextField="PermissionRoleName">
                                                        </asp:CheckBoxList>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="UserNameLabelAdd" runat="server">User Name</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtUserNameA" runat="server" TabIndex="1" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="txtUserNameA"
                                                        ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="vgnewuser">(*)</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Add0" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeIDA" runat="server" TabIndex="2" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="EmailLabelAdd" runat="server">E-mail</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmailA" TabIndex="5" runat="server" Width="99%" AutoCompleteType="Email"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtEmailA" ToolTip="Wrong email format"
                                                        ErrorMessage="(*)" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        runat="server" ID="RegularExpressionValidator1" ValidationGroup="vgnewuser" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Add" runat="server" Text="Full Name">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFullNameA" TabIndex="6" runat="server" Width="99%" AutoCompleteType="DisplayName"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="vgnewuser"
                                                        ToolTip="Fullname is required." ErrorMessage="Fullname is required." ControlToValidate="txtFullNameA">(*)</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label14" runat="server" Text="Contact No.">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtContactNoA" TabIndex="6" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label4Add" runat="server" Text="Department">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlDepartmentA" TabIndex="7" runat="server" Width="99%" DataValueField="DepartmentID"
                                                        DataTextField="DepartmentName" AppendDataBoundItems="True">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:CustomValidator ID="cvDepartmentA" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlDepartmentA" ErrorMessage="Department is required." ValidationGroup="vgnewuser">(*)</asp:CustomValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsActiveA" TabIndex="9" runat="server" Text="Active" Checked="True">
                                                    </asp:CheckBox>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <asp:Label ID="lblAddErr" runat="server" Text="" CssClass="error">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <table class="applytable">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnAdd" TabIndex="10" OnClick="btnAdd_Click" runat="server" Text="Save"
                                                                        CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgnewuser"></asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelA" runat="server" Text="Cancel" CssClass="button" UseSubmitBehavior="False"
                                                                        OnClientClick="return false;"></asp:Button>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeMessage" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    BehaviorID="bhmpeMessage" DropShadow="false" Enabled="True" OkControlID="btnMessage"
                                    PopupControlID="PanelConfirm" TargetControlID="lblMessageControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirm" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="confirmtable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaption" runat="server">User Profile</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/infoconfirm.jpg" alt="" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblMessage" runat="server" CssClass="confirmmessage">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Button ID="btnMessage" runat="server" Text="OK" CssClass="button" OnClientClick="return false;">
                                                    </asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate" runat="server" TargetControlID="lblUpdateControl"
                                    BackgroundCssClass="modalBackgroundConfirm" CancelControlID="btnCancelUpdate"
                                    OkControlID="btnOKUpdateR" PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmUpdate" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update User Profile Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this user?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table class="applytable">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnOKUpdate" runat="server" Width="70px" Text="OK" CssClass="button"
                                                                        OnClick="btnOKUpdate_Click"></asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelUpdate" runat="server" Width="70px" Text="Cancel" CssClass="button"
                                                                        OnClientClick="return false;"></asp:Button>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpload" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    BehaviorID="bhmpeConfirmUpload" CancelControlID="btnCancelUpload" OkControlID="btnUploadR"
                                    PopupControlID="PanelConfirmUpload" TargetControlID="lblUploadControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmUpload" runat="server" CssClass="modalPopupConfirm" Style="display: none">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="Label43" runat="server">Upload User Profile Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblConfirmUpload" runat="server" Text="Are you sure you want to upload user profile(s) from excel file?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table class="applytable">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnUpload" runat="server" CssClass="button" OnClick="btnUpload_Click"
                                                                        UseSubmitBehavior="false" Text="OK" Width="70px" />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelUpload" runat="server" CssClass="button" OnClientClick="return false;"
                                                                        Text="Cancel" Width="70px" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeProcessing" runat="server" Enabled="True"
                                    BackgroundCssClass="modalBackgroundProcessing" PopupControlID="PanelProcessing"
                                    DropShadow="false" BehaviorID="bhmpeProcessing" TargetControlID="lblProcessingControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="PanelProcessing" runat="server" CssClass="modalPopupProcessing">
                                    <table class="processingtable">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <img src="../Images/updateprogress.gif" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server">Processing...</asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="visibility: hidden">
                                    <asp:Label ID="lblMessageControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUploadControl" runat="server">
                                    </asp:Label><asp:HiddenField ID="hdUploadFileName" runat="server" />
                                    <asp:Button ID="btnUploadR" runat="server" CssClass="button" OnClientClick="return false;"
                                        UseSubmitBehavior="False" />
                                    <asp:HiddenField ID="hdUserProfileID" runat="server" />
                                    <asp:Button ID="btnSaveControl" runat="server" Text="Edit" CssClass="button" UseSubmitBehavior="False">
                                    </asp:Button>
                                    <asp:Button ID="btnDeleteControl" runat="server" Text="Delete" CssClass="button"
                                        UseSubmitBehavior="False"></asp:Button>
                                    <asp:Button ID="btnReturnU" OnClientClick="return false;" runat="server" CssClass="button"
                                        UseSubmitBehavior="False"></asp:Button><asp:Button ID="btnReturnD" OnClientClick="return false;"
                                            runat="server" CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                    <asp:Button ID="btnReturnA" OnClientClick="return false;" runat="server" Text="Save"
                                        CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgnewuser"></asp:Button>
                                    <asp:Button ID="btnOKUpdateR" OnClientClick="return false;" runat="server" UseSubmitBehavior="False"
                                        CssClass="button"></asp:Button></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1" runat="server"
            TargetControlID="UpdatePanel1">
            <Animations>
        <OnUpdating>   
        <Sequence>
         <ScriptAction Script="$find('bhmpeProcessing').show();"/>
                                <Parallel duration="0">
                               
                            <EnableAction AnimationTarget="btnSearch" Enabled="False" />
                            <EnableAction AnimationTarget="btnAdd" Enabled="False" />
                            <EnableAction AnimationTarget="btnDelete" Enabled="False" />
                            <EnableAction AnimationTarget="btnOKUpdate" Enabled="False" />
                        </Parallel>
                    </Sequence> </OnUpdating>
        <OnUpdated>   
        <Sequence>
        <ScriptAction Script="$find('bhmpeProcessing').hide();" />
         <Parallel duration="0">
         
                             <EnableAction AnimationTarget="btnSearch" Enabled="True" />
                             <EnableAction AnimationTarget="btnAdd" Enabled="True" />
                            <EnableAction AnimationTarget="btnDelete" Enabled="True" />
                            <EnableAction AnimationTarget="btnOKUpdate" Enabled="True" />
                              </Parallel>             
                    </Sequence></OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </div>
</asp:Content>

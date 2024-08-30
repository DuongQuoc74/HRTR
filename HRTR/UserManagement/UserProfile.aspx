<%@ Page Title="User Profile" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="UserProfile.aspx.cs" Inherits="SystemAuth.UserManagement.UserProfile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            User Profile</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/UserProfile.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Search</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 8%;">
                                                    <asp:Label ID="Label3" runat="server" Text="User Name"></asp:Label>
                                                </td>
                                                <td style="width: 30%;">
                                                    <asp:TextBox ID="txtUserNameS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 8%;">
                                                    <asp:Label ID="Label48" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td style="width: 12%;">
                                                    <asp:TextBox ID="txtEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 8%;">
                                                    <asp:Label ID="Label46" runat="server" Text="Full Name"></asp:Label>
                                                </td>
                                                <td style="width: 12%;">
                                                    <asp:TextBox ID="txtFullNameS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 8%;">
                                                    <asp:Label ID="Label49" runat="server" Text="Email"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmailS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label47" runat="server" Text="Department"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlDepartmentS" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="DepartmentName" DataValueField="DepartmentID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label50" runat="server" Text="Contact No."></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtContactNoS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label44" runat="server" Text="Active"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                        <asp:ListItem Value="-1">[All]</asp:ListItem>
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
                                                <td>
                                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                        CssClass="button" UseSubmitBehavior="True"></asp:Button>
                                                </td>
                                                <td colspan="7">
                                                    <asp:Label ID="lblUserProfile" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnNewUserProfile" runat="server" Text="New" CssClass="button" UseSubmitBehavior="False"
                                    OnClientClick="return NewUserProfile();"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvUserList" runat="server" OnRowDataBound="grvUserList_RowDataBound"
                                    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="UserProfileID"
                                    CssClass="gridview" PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing"
                                    SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header" FooterStyle-CssClass="footer"
                                    AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal" OnPageIndexChanging="grvUserList_PageIndexChanging"
                                    OnSorting="grvUserList_Sorting" OnRowCommand="grvUserList_RowCommand">
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
                                                    <asp:LinkButton runat="server" Text="Delete" CommandName="Del" CausesValidation="False"
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
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeUserProfile" runat="server" BehaviorID="bhvmpeUserProfile"
                                    PopupDragHandleControlID="pnUserProfilePopupDrag" DropShadow="false" CancelControlID="btnCancelUserProfile"
                                    OkControlID="btnReturnUserProfile" BackgroundCssClass="modalBackgroundCommon"
                                    PopupControlID="pnUserProfilePopup" TargetControlID="btnNewUserProfile" CacheDynamicResults="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 600px;" ID="pnUserProfilePopup"
                                    runat="server">
                                    <asp:Panel CssClass="modalPopupDrag" ID="pnUserProfilePopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add/ Update/ Delete User Profile</p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 15%;">
                                                    <asp:Label ID="lblSearchUser" runat="server">Search</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtSearchUser" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td rowspan="8" style="vertical-align: top; width: 25%;">
                                                    <fieldset class="fieldsetrole">
                                                        <legend>Permission Role</legend>
                                                        <asp:CheckBoxList ID="cblUserPermissionRole" runat="server" DataValueField="PermissionRoleID"
                                                            DataTextField="PermissionRoleName">
                                                        </asp:CheckBoxList>
                                                    </fieldset>
                                                </td>
                                                <td rowspan="8" style="vertical-align: top; width: 25%;">
                                                    <fieldset class="fieldsetrole">
                                                        <legend>Customer</legend>
                                                        <asp:CheckBoxList ID="cblUserCustomer" runat="server" DataValueField="Customer_ID"
                                                            DataTextField="Customer">
                                                        </asp:CheckBoxList>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server">User Name</asp:Label>
                                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="txtUserName"
                                                        ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="vguserprofile">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtUserName" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text="Employee ID"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvEmployeeIDAdd" runat="server" ControlToValidate="txtEmployeeID"
                                                        ErrorMessage="Employee ID is required." ToolTip="Employee ID is required." ValidationGroup="vguserprofile">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeID" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server">E-mail</asp:Label>
                                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ValidationGroup="vguserprofile"
                                                        ToolTip="E-mail is required." ErrorMessage="E-mail is required." ControlToValidate="txtEmail">(*)</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtEmail" ToolTip="Wrong email format"
                                                        ErrorMessage="(*)" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        runat="server" ID="RegularExpressionValidator1" ValidationGroup="vguserprofile" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmail" runat="server" Width="99%" AutoCompleteType="Email"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" Text="Full Name">
                                                    </asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="vguserprofile"
                                                        ToolTip="Fullname is required." ErrorMessage="Fullname is required." ControlToValidate="txtFullName">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFullName" runat="server" Width="99%" AutoCompleteType="DisplayName"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label14" runat="server" Text="Contact No.">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtContactNo" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label5" runat="server" Text="Department">
                                                    </asp:Label>
                                                    <asp:CustomValidator ID="cvDepartment" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlDepartment" ErrorMessage="Department is required." ValidationGroup="vguserprofile">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlDepartment" runat="server" Width="99%" DataValueField="DepartmentID"
                                                        DataTextField="DepartmentName" AppendDataBoundItems="True">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="Active" Checked="True"></asp:CheckBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;" colspan="4">
                                                    <asp:Label ID="lblUserProfileMessage" runat="server" Text="">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="text-align: center;">
                                                    <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Save" ValidationGroup="vguserprofile"></asp:Button>
                                                    <asp:Button ID="btnUpdateAsk" runat="server" Text="Update" CssClass="button" UseSubmitBehavior="False"
                                                        ValidationGroup="vguserprofile" OnClientClick="return UserProfileUpdateValidation();">
                                                    </asp:Button>
                                                    <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                        Text="Delete" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnCancelUserProfile" runat="server" UseSubmitBehavior="False" CssClass="button"
                                                        Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate" runat="server" TargetControlID="lblUpdateControl"
                                    BackgroundCssClass="modalBackgroundConfirm" CancelControlID="btnCancelUpdate"
                                    OkControlID="btnUpdateR" PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmUpdate" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update User Confirmation</asp:Label>
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
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:Button ID="btnUpdate" runat="server" Text="OK" CssClass="button" OnClick="btnUpdate_Click">
                                                    </asp:Button>
                                                    <asp:Button ID="btnCancelUpdate" runat="server" Text="Cancel" CssClass="button" OnClientClick="return false;">
                                                    </asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <ajaxToolkit:ModalPopupExtender ID="mpeProcessing" runat="server" Enabled="True"
                                    BackgroundCssClass="modalBackgroundProcessing" PopupControlID="PanelProcessing"
                                    DropShadow="false" BehaviorID="bhmpeProcessing" TargetControlID="lblProcessingControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="PanelProcessing" runat="server" CssClass="modalPopupProcessing">
                                    <table class="processingtable">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <img src="../Images/updateprogress.gif" alt="" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server">Processing...</asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <div style="visibility: hidden">
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                    <asp:HiddenField ID="hdUserProfileID" runat="server" Value="0" />
                                    <asp:Button ID="btnReturnUserProfile" runat="server" CssClass="button" OnClientClick="return false;"
                                        UseSubmitBehavior="False" />
                                    <asp:Button ID="btnUpdateR" runat="server" CssClass="button" OnClientClick="return false;"
                                        UseSubmitBehavior="False" />
                                </div>
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
                          
                        </Parallel>
                    </Sequence> </OnUpdating>
        <OnUpdated>   
        <Sequence>
        <ScriptAction Script="$find('bhmpeProcessing').hide();" />
                             <Parallel duration="0">
                            
                              </Parallel>             
                    </Sequence></OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </div>
</asp:Content>

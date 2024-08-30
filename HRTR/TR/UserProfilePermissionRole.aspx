<%@ Page Language="C#" MasterPageFile="~/HCM.master" AutoEventWireup="true" CodeFile="UserProfilePermissionRole.aspx.cs"
    Inherits="HRTR_UserProfilePermissionRole" Title="Permission Role/ User Profile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Permission Role/ User Profile</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/UserProfilePermissionRole.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Search User Profile by Permission Role</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%">
                                                    <asp:Label ID="Label46" runat="server" Text="Role"></asp:Label>
                                                </td>
                                                <td style="width: 15%">
                                                    <asp:DropDownList ID="ddlPermissionRoleR" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="PermissionRoleName" DataValueField="PermissionRoleID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%">
                                                </td>
                                                <td style="width: 15%">
                                                </td>
                                                <td style="width: 10%">
                                                </td>
                                                <td style="width: 15%">
                                                </td>
                                                <td style="width: 10%">
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label47" runat="server" Text="User Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtUserNameS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label48" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text="Full Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFullNameS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label49" runat="server" Text="Email"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmailS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" Text="Department"></asp:Label>
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
                                                    <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="99%">
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
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="button" OnClick="btnSearch_Click"
                                                        Text="Search" UseSubmitBehavior="True" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">
                                                    <asp:GridView ID="grvUserListR" runat="server" AllowPaging="True" AllowSorting="True"
                                                        AutoGenerateColumns="False" DataKeyNames="UserProfileID" OnPageIndexChanging="grvUserListR_PageIndexChanging"
                                                        OnRowCommand="grvUserListR_RowCommand" OnRowDataBound="grvUserListR_RowDataBound"
                                                        OnSorting="grvUserListR_Sorting" CssClass="gridview" PagerStyle-CssClass="pgr"
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
                                                            <asp:TemplateField ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="hlRemove" runat="server" Text='Remove' ToolTip="Remove this user from role."></asp:HyperLink>
                                                                </ItemTemplate>
                                                                <ItemStyle CssClass="select" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Add User Profile To Permission Role</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label2" runat="server" Text="Search"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtSearchA" runat="server" Width="99%" AutoCompleteType="Disabled"></asp:TextBox>
                                                </td>
                                                <td colspan="7"></td>
                                               
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label5" runat="server" Text="User Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtUserNameA" runat="server" Width="99%" AutoCompleteType="Disabled"></asp:TextBox>
                                                </td>
                                                <td style="width: 5%;">
                                                    <asp:RequiredFieldValidator ID="rfvUserNameA" runat="server" ControlToValidate="txtUserNameA"
                                                        ErrorMessage="User Name is required." ValidationGroup="vgaddusertorole">(*)</asp:RequiredFieldValidator>
                                                    <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="AutoCompleteEx" ID="autoComplete1"
                                                        TargetControlID="txtSearchA" ServicePath="../WebServices/HRTRUserProfile.asmx"
                                                        ServiceMethod="GetUserProfileList" MinimumPrefixLength="0" CompletionInterval="500"
                                                        EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                        DelimiterCharacters=";, :" OnClientItemSelected="UserSelected" FirstRowSelected="true">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label51" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtEmployeeIDA" runat="server" Width="99%" Enabled="False"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label52" runat="server" Text="Full Name"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtFullNameA" runat="server" Width="99%" Enabled="False"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label53" runat="server" Text="Email"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmailA" runat="server" Width="99%" Enabled="False"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label55" runat="server" Text="Department"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlDepartmentA" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="DepartmentName" DataValueField="DepartmentID" Width="99%" Enabled="False">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label54" runat="server" Text="Contact No."></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtContactNoA" runat="server" Width="99%" Enabled="False"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" Text="Role"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlPermissionRoleA" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="PermissionRoleName" DataValueField="PermissionRoleID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="9">
                                                    <asp:Button ID="btnAdd" runat="server" Text="Add To Permission Role" CssClass="button"
                                                        UseSubmitBehavior="False" OnClientClick="return addValidation();" ValidationGroup="vgaddusertorole">
                                                    </asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
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
                                                    <asp:Label ID="lblCaption" runat="server">Permission Role</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/infoconfirm.jpg" alt="!" />
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmRemove" runat="server" TargetControlID="lblRemoveControl"
                                    BackgroundCssClass="modalBackgroundConfirm" CancelControlID="btnCancelRemove"
                                    OkControlID="btnOKRemoveR" PopupControlID="PanelConfirmRemove" BehaviorID="bhmpeConfirmRemove">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmRemove" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" align="center" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Remove User Role Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRemoveMessage" runat="server" Text="Are you sure you want to remove this user profile?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <table class="applytable">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnOKRemove" runat="server" Width="70px" Text="OK" CssClass="button"
                                                                        OnClick="btnOKRemove_Click"></asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelRemove" runat="server" Width="70px" Text="Cancel" CssClass="button"
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmAdd" runat="server" TargetControlID="lblAddControl"
                                    BackgroundCssClass="modalBackgroundConfirm" CancelControlID="btnCancelAdd" OkControlID="btnOKAddR"
                                    PopupControlID="PanelConfirmAdd" BehaviorID="bhmpeConfirmAdd">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmAdd" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" align="center" colspan="2">
                                                    <asp:Label ID="Label1" runat="server">Add User Role Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblAddMessage" runat="server" Text="Are you sure you want to add this user profile?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <table class="applytable">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnOKAdd" runat="server" Width="70px" Text="OK" CssClass="button"
                                                                        OnClick="btnOKAdd_Click"></asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelAdd" runat="server" Width="70px" Text="Cancel" CssClass="button"
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
                                <div style="visibility: hidden">
                                    <asp:HiddenField ID="hdUserProfileIDR" runat="server" />
                                    <asp:HiddenField ID="hdUserProfileIDA" runat="server" />
                                    <asp:Label ID="lblMessageControl" runat="server">
                                    </asp:Label><asp:Label ID="lblRemoveControl" runat="server">
                                    </asp:Label><asp:Label ID="lblAddControl" runat="server">
                                    </asp:Label>
                                    <asp:Button ID="btnOKAddR" OnClientClick="return false;" runat="server" Text="Save"
                                        CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgnewuser"></asp:Button>
                                    <asp:Button ID="btnOKRemoveR" OnClientClick="return false;" runat="server" UseSubmitBehavior="False"
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
                                <Parallel duration="0">
                            <EnableAction AnimationTarget="btnAdd" Enabled="False" />
                            <EnableAction AnimationTarget="btnOKAdd" Enabled="False" />
                            
                            <EnableAction AnimationTarget="btnOKRemove" Enabled="False" />
                            <EnableAction AnimationTarget="btnCancelRemove" Enabled="False" />
                            <EnableAction AnimationTarget="btnCancelAdd" Enabled="False" />
                           
                        </Parallel>
                        <StyleAction Attribute="overflow" Value="hidden" />
                        
                       
                    </Sequence> </OnUpdating>
        <OnUpdated>   
        <Sequence>
         <Parallel duration="0">
         <EnableAction AnimationTarget="btnAdd" Enabled="True" />
                            <EnableAction AnimationTarget="btnOKAdd" Enabled="True" />
                            
                            <EnableAction AnimationTarget="btnOKRemove" Enabled="True" />
                            <EnableAction AnimationTarget="btnCancelRemove" Enabled="True" />
           <EnableAction AnimationTarget="btnCancelAdd" Enabled="True" />
                              </Parallel>             
                    </Sequence></OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </div>
</asp:Content>

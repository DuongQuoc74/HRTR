<%@ Page Title="Customer/ User Profile" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="UserProfileCustomers.aspx.cs" Inherits="SystemAuth.UserManagement.UserProfileCustomers" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Customer/ User Profile</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/UserProfileCustomers.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Search User Profile By Customer</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label46" runat="server" Text="Customer"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:DropDownList ID="ddlCustomersR" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="Customer" DataValueField="Customer_ID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td colspan="6">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label47" runat="server" Text="User Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtUserNameS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label48" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label3" runat="server" Text="Full Name"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtFullNameS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
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
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="button" OnClick="btnSearch_Click"
                                                        Text="Search" UseSubmitBehavior="True" />
                                                    <asp:Button ID="btnExport" OnClick="btnExport_Click" runat="server" Text="Export"
                                                            CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                </td>
                                                <td colspan="7">
                                                    <asp:Label ID="lblSearch" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">
                                                    <asp:GridView ID="grvUserListR" runat="server" AllowPaging="True" AllowSorting="True"
                                                        AutoGenerateColumns="False" DataKeyNames="UserProfileID" CssClass="gridview"
                                                        PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected"
                                                        HeaderStyle-CssClass="header" FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate"
                                                        RowStyle-CssClass="normal" OnPageIndexChanging="grvUserListR_PageIndexChanging"
                                                        OnRowCommand="grvUserListR_RowCommand" OnRowDataBound="grvUserListR_RowDataBound"
                                                        OnSorting="grvUserListR_Sorting">
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
                                                                    <asp:HyperLink ID="hlRemove" runat="server" Text='Remove' ToolTip="Remove this user from customer."></asp:HyperLink>
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
                                    <legend>Add User Profile To Customer</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label2" runat="server" Text="Search"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtSearchA" runat="server" Width="99%" AutoCompleteType="Disabled"></asp:TextBox>
                                                    <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="AutoCompleteEx" ID="acSearchA"
                                                        TargetControlID="txtSearchA" ServicePath="../WebServices/UserProfileS.asmx" ServiceMethod="GetUserProfileList"
                                                        MinimumPrefixLength="0" CompletionInterval="500" EnableCaching="true" CompletionSetCount="20"
                                                        CompletionListCssClass="autocomplete_completionListElement" CompletionListItemCssClass="autocomplete_listItem"
                                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" DelimiterCharacters=";, :"
                                                        OnClientItemSelected="UserSelected" FirstRowSelected="true">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td colspan="6">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label5" runat="server" Text="User Name"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvUserNameA" runat="server" ControlToValidate="txtUserNameA"
                                                        ErrorMessage="User Name is required." ValidationGroup="vgaddusertorole">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtUserNameA" runat="server" Width="99%" AutoCompleteType="Disabled"></asp:TextBox>
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
                                                    <asp:Label ID="Label54" runat="server" Text="Contact No."></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtContactNoA" runat="server" Width="99%" Enabled="False"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" Text="Customer"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCustomersA" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="Customer" DataValueField="Customer_ID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="button" UseSubmitBehavior="False"
                                                        OnClientClick="return AddValidation();" ValidationGroup="vgaddusertorole"></asp:Button>
                                                </td>
                                                <td colspan="7">
                                                    <asp:Label ID="lblAdd" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmRemove" runat="server" TargetControlID="lblRemoveControl"
                                    BackgroundCssClass="modalBackgroundCommon" CancelControlID="btnCancelRemove"
                                    OkControlID="btnOKRemoveR" PopupControlID="PanelConfirmRemove" BehaviorID="bhmpeConfirmRemove">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmRemove" runat="server" Style="display: none;" CssClass="modalPopupCommon">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Remove User Customer Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRemoveMessage" runat="server" Text="Are you sure you want to remove this user?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:Button ID="btnOKRemove" runat="server" Text="OK" CssClass="button" OnClick="btnOKRemove_Click">
                                                    </asp:Button>
                                                    <asp:Button ID="btnCancelRemove" runat="server" Text="Cancel" CssClass="button" OnClientClick="return false;">
                                                    </asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmAdd" runat="server" TargetControlID="lblAddControl"
                                    BackgroundCssClass="modalBackgroundCommon" CancelControlID="btnCancelAdd" OkControlID="btnOKAddR"
                                    PopupControlID="PanelConfirmAdd" BehaviorID="bhmpeConfirmAdd">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmAdd" runat="server" Style="display: none;" CssClass="modalPopupCommon">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="Label1" runat="server">Add User Customer Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblAddMessage" runat="server" Text="Are you sure you want to add this user?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:Button ID="btnOKAdd" runat="server" Text="OK" CssClass="button" OnClick="btnOKAdd_Click">
                                                    </asp:Button>
                                                    <asp:Button ID="btnCancelAdd" runat="server" Text="Cancel" CssClass="button" OnClientClick="return false;">
                                                    </asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <div style="visibility: hidden">
                                    <asp:HiddenField ID="hdUserProfileIDR" runat="server" />
                                    <asp:HiddenField ID="hdUserProfileIDA" runat="server" />
                                    <asp:Label ID="lblRemoveControl" runat="server">
                                    </asp:Label><asp:Label ID="lblAddControl" runat="server">
                                    </asp:Label>
                                    <asp:Button ID="btnOKAddR" OnClientClick="return false;" runat="server" UseSubmitBehavior="False">
                                    </asp:Button>
                                    <asp:Button ID="btnOKRemoveR" OnClientClick="return false;" runat="server" UseSubmitBehavior="False">
                                    </asp:Button>
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
                <Parallel duration="0">
                </Parallel>
                <StyleAction Attribute="overflow" Value="hidden" />
            </Sequence> 
            </OnUpdating>
            <OnUpdated>   
                <Sequence>
                <Parallel duration="0">
                </Parallel>             
                </Sequence>
            </OnUpdated>
        </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </div>
</asp:Content>

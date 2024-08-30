<%@ Page Title="CCS Login History" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="AuthenticationLog.aspx.cs" Inherits="HRTR.CCS.AuthenticationLog" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            CCS Login History
        </div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/AuthenticationLog.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <asp:Panel ID="pnSearch" runat="server">
                                    <fieldset>
                                        <legend>Search</legend>
                                        <table class="tablesearch">
                                            <tbody>
                                                <tr>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label3" runat="server" Text="Employee ID"></asp:Label>
                                                        <asp:CustomValidator ID="cvEmployeeID" runat="server" ClientValidationFunction="cvEmployeeIDUserName_ClientValidate" ValidateEmptyText="true" SetFocusOnError="true"
                                                            ControlToValidate="txtEmployeeIDS" ErrorMessage="Employee ID or User Name is required." ValidationGroup="vgsearch">(*)</asp:CustomValidator>
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:TextBox ID="txtEmployeeIDS" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label6" runat="server" Text="User Name"></asp:Label>
                                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="cvEmployeeIDUserName_ClientValidate" ValidateEmptyText="true" SetFocusOnError="true"
                                                            ControlToValidate="txtUserNameS" ErrorMessage="Employee ID or User Name is required." ValidationGroup="vgsearch">(*)</asp:CustomValidator>
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:TextBox ID="txtUserNameS" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label10" runat="server" Text="Login Time From"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:TextBox ID="txtLoginTimeFromS" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="imgLoginTimeFromS" class="dateselected" src="../Images/icon-calendar.gif"
                                                            runat="server" alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="caLoginTimeFromS" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtLoginTimeFromS" Enabled="True" PopupButtonID="imgLoginTimeFromS"
                                                            Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label1" runat="server" Text="Login Time To"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtLoginTimeToS" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="imgLoginTimeToS" class="dateselected" src="../Images/icon-calendar.gif"
                                                            runat="server" alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="caLoginTimeToS" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtLoginTimeToS" Enabled="True" PopupButtonID="imgLoginTimeToS"
                                                            Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="8" style="white-space: nowrap;">
                                                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                            CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgsearch"></asp:Button>
                                                        <asp:Button ID="btnExport" OnClick="btnExport_Click" runat="server" Text="Export"
                                                            CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgsearch"></asp:Button>
                                                        <asp:Label ID="lblSearch" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </fieldset>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvTrainingEmpLock" runat="server" AllowPaging="True" AllowSorting="True"
                                    PageSize="20" AutoGenerateColumns="True" OnPageIndexChanging="grvTrainingEmpLock_PageIndexChanging"
                                    OnRowDataBound="grvTrainingEmpLock_RowDataBound" OnSorting="grvTrainingEmpLock_Sorting"
                                    CssClass="gridview" PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing"
                                    SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header" FooterStyle-CssClass="footer"
                                    AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeProcessing" runat="server" BackgroundCssClass="modalBackgroundProcessing"
                                    BehaviorID="bhmpeProcessing" DropShadow="false" Enabled="True" PopupControlID="PanelProcessing"
                                    TargetControlID="lblProcessingControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelProcessing" runat="server" CssClass="modalPopupProcessing" Style="display: none">
                                    <table class="processingtable">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <img style="width: 45px; height: 45px" src="../Images/updateprogress.gif" alt="..." />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server" Style="text-align: center">Processing...</asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <div style="visibility: hidden">
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
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
                </Sequence> 
            </OnUpdating>
            <OnUpdated>   
                <Sequence>
                    <ScriptAction Script="$find('bhmpeProcessing').hide();" />
                    <Parallel duration="0">
                           
                    </Parallel>             
                </Sequence>
            </OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </div>
</asp:Content>

<%@ Page Title="Grape Chart Block Logs" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="GC_BlockLogs.aspx.cs" Inherits="HRTR.GrapeChart.GC_BlockLogs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Grape Chart Block Logs</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/GC_BlockLogs.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="upHRTR" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mvGC_BlockLogs" runat="server" ActiveViewIndex="0">
                    <asp:View ID="vSearch" runat="server">
                        <asp:Panel ID="pnSearch" runat="server">
                            <table>
                                <tr>
                                    <td>
                                        <fieldset>
                                            <legend>Search</legend>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td style="width: 10%;">
                                                            <asp:Label ID="Label21" runat="server" Text="Workcell"></asp:Label>
                                                        </td>
                                                        <td style="width: 15%;">
                                                            <asp:DropDownList ID="ddlGC_CustomersS" runat="server" AppendDataBoundItems="True"
                                                                DataTextField="Customer" DataValueField="Customer_ID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 10%;">
                                                            <asp:Label ID="Label5" runat="server" Text="Created From"></asp:Label>
                                                        </td>
                                                        <td style="width: 15%;">
                                                            <asp:TextBox ID="txtCreatedDateFromS" runat="server" Width="80px"></asp:TextBox>
                                                            <img id="imgCreatedDateFromS" class="dateselected" src="../Images/icon-calendar.gif"
                                                                runat="server" alt="" />
                                                            <ajaxToolkit:CalendarExtender ID="ceCreatedDateFromS" runat="server" CssClass="MyCalendar"
                                                                TargetControlID="txtCreatedDateFromS" Enabled="True" PopupButtonID="imgCreatedDateFromS"
                                                                Format="MM/dd/yyyy">
                                                            </ajaxToolkit:CalendarExtender>
                                                        </td>
                                                        <td style="width: 10%;">
                                                            <asp:Label ID="Label7" runat="server" Text="Created To"></asp:Label>
                                                        </td>
                                                        <td style="width: 15%;">
                                                            <asp:TextBox ID="txtCreatedDateToS" runat="server" Width="80px"></asp:TextBox>
                                                            <img id="imgCreatedDateToS" class="dateselected" src="../Images/icon-calendar.gif"
                                                                runat="server" alt="" />
                                                            <ajaxToolkit:CalendarExtender ID="ceCreatedDateToS" runat="server" CssClass="MyCalendar"
                                                                TargetControlID="txtCreatedDateToS" Enabled="True" PopupButtonID="imgCreatedDateToS"
                                                                Format="MM/dd/yyyy">
                                                            </ajaxToolkit:CalendarExtender>
                                                        </td>
                                                        <td style="width: 10%;">
                                                            <asp:Label ID="Label27" runat="server" Text="Employee ID"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label44" runat="server" Text="Blocked"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlIsBlockedS" runat="server" AppendDataBoundItems="True" Width="99%">
                                                                <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                <asp:ListItem Value="0">No</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label3" runat="server" Text="Confirmed"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlIsConfirmedS" runat="server" AppendDataBoundItems="True"
                                                                Width="99%">
                                                                <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                <asp:ListItem Value="0">No</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label4" runat="server" Text="Active"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="99%">
                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="8">
                                                            <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                                CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                            <asp:Button ID="btnExport" OnClick="btnExport_Click" runat="server" Text="Export"
                                                                CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                            <asp:Label ID="lblSearch" runat="server" Text=""></asp:Label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="grvBlockLogs" runat="server" OnRowDataBound="grvBlockLogs_RowDataBound"
                                            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="GC_BlockLogsID"
                                            OnPageIndexChanging="grvBlockLogs_PageIndexChanging" OnSorting="grvBlockLogs_Sorting"
                                            OnRowCommand="grvBlockLogs_RowCommand" CssClass="gridview" PagerStyle-CssClass="pgr"
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
                                                <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID">
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Employee Name" SortExpression="EmployeeName">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbEdit" runat="server" CausesValidation="False" Text='<%# Bind("EmployeeName") %>'
                                                            CommandArgument='<%# Eval("GC_BlockLogsID")%>' CommandName="Select" Enabled='<%# !(bool)DataBinder.Eval(Container.DataItem, "IsConfirmed")%>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" SortExpression="CreatedDate"
                                                    DataFormatString="{0:MM/dd/yyyy}"></asp:BoundField>
                                                <asp:BoundField DataField="Aging" HeaderText="Aging" SortExpression="Aging"></asp:BoundField>

                                                <asp:TemplateField HeaderText="Start Date" SortExpression="StartDate">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlStartDate" runat="server" NavigateUrl='<%# String.Format("GC_Data.aspx?f={0}&t={1}&ee={2}&cs={3}", Eval("StartDate", "{0:yyyyMMdd}"), Eval("EndDate", "{0:yyyyMMdd}"), Eval("EmployeeID"), Eval("Customer_ID")) %>'
                                                            Text='<%# Eval("StartDate", "{0:MM/dd/yyyy}") %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                               <%-- <asp:BoundField DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate"
                                                    DataFormatString="{0:MM/dd/yyyy}"></asp:BoundField>--%>
                                                <asp:BoundField DataField="EndDate" HeaderText="End Date" SortExpression="EndDate"
                                                    DataFormatString="{0:MM/dd/yyyy}"></asp:BoundField>
                                                
                                                <asp:BoundField DataField="TotalRedGrapes" HeaderText="Total Red Grapes" SortExpression="TotalRedGrapes">
                                                    <ItemStyle CssClass="right" />
                                                </asp:BoundField>
                                                <asp:CheckBoxField DataField="IsBlocked" HeaderText="Blocked" SortExpression="IsBlocked">
                                                    <ItemStyle CssClass="checkbox" />
                                                </asp:CheckBoxField>
                                                <asp:BoundField DataField="BlockedDate" HeaderText="Blocked Date" SortExpression="BlockedDate">
                                                </asp:BoundField>
                                                <asp:CheckBoxField DataField="IsConfirmed" HeaderText="Confirmed" SortExpression="IsConfirmed">
                                                    <ItemStyle CssClass="checkbox" />
                                                </asp:CheckBoxField>
                                                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ConfirmedDate" HeaderText="Confirmed Date" SortExpression="ConfirmedDate">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ConfirmedByFullName" HeaderText="Confirmed By" SortExpression="ConfirmedByFullName">
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </asp:View>
                    <asp:View ID="vEdit" runat="server">
                        <asp:Panel ID="pnEdit" runat="server">
                            <fieldset>
                                <legend>Block Logs Confirmation</legend>
                                <table>
                                    <tr>
                                        <td style="width: 10%;">
                                            <asp:Label ID="Label30" runat="server" Text="Workcell"></asp:Label>
                                        </td>
                                        <td style="width: 15%;">
                                            <asp:DropDownList ID="ddlGC_Customers" runat="server" AppendDataBoundItems="True"
                                                DataTextField="Customer" DataValueField="Customer_ID" Width="99%" Enabled="false">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10%;">
                                            <asp:Label ID="Label10" runat="server" Text="Created Date"></asp:Label>
                                        </td>
                                        <td style="width: 15%;">
                                            <asp:TextBox ID="txtCreatedDate" runat="server" Width="80px" Enabled="false"></asp:TextBox>
                                        </td>
                                        <td style="width: 10%;">
                                            <asp:Label ID="Label2" runat="server" Text="Start/ End Date"></asp:Label>
                                        </td>
                                        <td style="width: 15%; white-space: nowrap;">
                                            <asp:TextBox ID="txtStartDate" runat="server" Width="80px" Enabled="false"></asp:TextBox>
                                            <asp:TextBox ID="txtEndDate" runat="server" Width="80px" Enabled="false"></asp:TextBox>
                                        </td>
                                        <td style="width: 10%;">
                                            <asp:Label ID="Label8" runat="server" Text="Total Red Grapes"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalRedGrapes" runat="server" Width="99%" Enabled="false" CssClass="positivenumber"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text="Employee"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEmployeeIDFullName" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="cbIsBlocked" runat="server" Text="Blocked" Enabled="false" />
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="cbIsConfirmed" runat="server" Text="Confirmed" Enabled="false" />
                                        </td>
                                        <td colspan="2">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text="Comments"></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtComments"
                                                ErrorMessage="Comments is required." ToolTip="Comments is required." ValidationGroup="vgblocklogs">(*)</asp:RequiredFieldValidator>
                                        </td>
                                        <td colspan="7">
                                            <asp:TextBox ID="txtComments" runat="server" Width="99%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="text-align: right; white-space: nowrap;">
                                            <asp:Label ID="lblBlockLogsMessage" runat="server" CssClass="errorMsg">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="text-align: right; white-space: nowrap;">
                                            <asp:Button ID="btnConfirmAsk" runat="server" CssClass="button" OnClientClick="return BlockLogsConfirmValidation();"
                                                Text="Confirm" UseSubmitBehavior="False" ValidationGroup="vgblocklogs" />
                                            <asp:Button ID="btnCancel" runat="server" CssClass="button" OnClick="btnCancel_Click"
                                                Text="Close" UseSubmitBehavior="False" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </asp:Panel>
                    </asp:View>
                </asp:MultiView>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmBlockLogs" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    PopupControlID="pnConfirmBlockLogsPopup" BehaviorID="bhmpeConfirmBlockLogs" TargetControlID="lblConfirmBlockLogsControl"
                                    CancelControlID="btnCancelConfirmBlockLogs">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="pnConfirmBlockLogsPopup" runat="server" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Confirm Grape Chart Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to confirm?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                   
                                                                    <asp:Button ID="btnConfirm" runat="server" CssClass="button" OnClick="btnConfirm_Click"
                                                                        Text="OK"  />
                                                               
                                                                    <asp:Button ID="btnCancelConfirmBlockLogs" runat="server" CssClass="button" OnClientClick="return false;"
                                                                        Text="Cancel"  />
                                                               
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
                                                    <img src="../Images/updateprogress.gif" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server">Processing...</asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <div style="visibility: hidden">
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblConfirmBlockLogsControl" runat="server">  </asp:Label>
                                    <asp:HiddenField ID="hdGC_BlockLogsID" runat="server" />
                                    <asp:HiddenField ID="hdMenuID" runat="server" />
                                   
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <ajaxToolkit:UpdatePanelAnimationExtender ID="upaeHRTR" runat="server" TargetControlID="upHRTR">
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

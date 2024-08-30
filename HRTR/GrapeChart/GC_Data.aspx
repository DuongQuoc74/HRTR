<%@ Page Title="Grape Chart Record" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="GC_Data.aspx.cs" Inherits="HRTR.GrapeChart.GC_Data" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Grape Chart Record</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/GC_Data.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="upHRTR" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mvGC_Data" runat="server" ActiveViewIndex="0">
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
                                                                DataTextField="Customer" DataValueField="Customer_ID" Width="99%" AutoPostBack="true"
                                                                OnSelectedIndexChanged="ddlGC_CustomersS_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 10%;">
                                                            <asp:Label ID="Label5" runat="server" Text="Escaped From"></asp:Label>
                                                        </td>
                                                        <td style="width: 15%;">
                                                            <asp:TextBox ID="txtEscapedDateFromS" runat="server" Width="80px"></asp:TextBox>
                                                            <img id="imgEscapedDateFromS" class="dateselected" src="../Images/icon-calendar.gif"
                                                                runat="server" alt="" />
                                                            <ajaxToolkit:CalendarExtender ID="ceEscapedDateFromS" runat="server" CssClass="MyCalendar"
                                                                TargetControlID="txtEscapedDateFromS" Enabled="True" PopupButtonID="imgEscapedDateFromS"
                                                                Format="MM/dd/yyyy">
                                                            </ajaxToolkit:CalendarExtender>
                                                        </td>
                                                        <td style="width: 10%;">
                                                            <asp:Label ID="Label7" runat="server" Text="Escaped To"></asp:Label>
                                                        </td>
                                                        <td style="width: 15%;">
                                                            <asp:TextBox ID="txtEscapedDateToS" runat="server" Width="80px"></asp:TextBox>
                                                            <img id="imgEscapedDateToS" class="dateselected" src="../Images/icon-calendar.gif"
                                                                runat="server" alt="" />
                                                            <ajaxToolkit:CalendarExtender ID="ceEscapedDateToS" runat="server" CssClass="MyCalendar"
                                                                TargetControlID="txtEscapedDateToS" Enabled="True" PopupButtonID="imgEscapedDateToS"
                                                                Format="MM/dd/yyyy">
                                                            </ajaxToolkit:CalendarExtender>
                                                        </td>
                                                        <td style="width: 10%;">
                                                            <asp:Label ID="Label47" runat="server" Text="Shift"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlShiftS" runat="server" AppendDataBoundItems="True" DataTextField="ShiftName"
                                                                DataValueField="ShiftID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label3" runat="server" Text="Escaped Station"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlEscapedStationS" runat="server" AppendDataBoundItems="True"
                                                                DataTextField="StationName" DataValueField="GC_StationID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label28" runat="server" Text="Detected Station"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlDetectedStationS" runat="server" AppendDataBoundItems="True"
                                                                DataTextField="StationName" DataValueField="GC_StationID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label17" runat="server" Text="Defect"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlQM_DefectsS" runat="server" AppendDataBoundItems="True"
                                                                DataTextField="DefectText" DataValueField="Defect_ID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label44" runat="server" Text="MES Auto Linked"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlIsMESAutoLinkedS" runat="server" AppendDataBoundItems="True"
                                                                Width="99%">
                                                                <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                <asp:ListItem Value="0">No</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label27" runat="server" Text="Escaped By ID"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtEscapedByEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label48" runat="server" Text="Detected By ID"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtDetectedByEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label50" runat="server" Text="CRD"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtCRDS" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label29" runat="server" Text="Serial Number"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSerialNumberS" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="8">
                                                            <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                                CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                            <asp:Button ID="btnExport" OnClick="btnExport_Click" runat="server" Text="Export"
                                                                CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                            <asp:Button ID="btnNew" OnClick="btnNew_Click"  runat="server" Text="New" CssClass="button"
                                                                UseSubmitBehavior="False"></asp:Button>
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
                                        <asp:GridView ID="grvGrapeChart" runat="server" OnRowDataBound="grvGrapeChart_RowDataBound"
                                            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="GC_DataID"
                                            OnPageIndexChanging="grvGrapeChart_PageIndexChanging" OnSorting="grvGrapeChart_Sorting"
                                            OnRowCommand="grvGrapeChart_RowCommand" CssClass="gridview" PagerStyle-CssClass="pgr"
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
                                                <asp:BoundField DataField="EscapedDate" HeaderText="Escaped Date" SortExpression="EscapedDate"
                                                    DataFormatString="{0:MM/dd/yyyy}"></asp:BoundField>
                                                <asp:BoundField DataField="ShiftName" HeaderText="Shift" SortExpression="ShiftName">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DetectedByEmployeeID" HeaderText="Detected By" SortExpression="DetectedByEmployeeID">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DetectedByEmployeeName" HeaderText="Detected By Name"
                                                    SortExpression="DetectedByEmployeeName"></asp:BoundField>
                                                <asp:BoundField DataField="DetectedStationName" HeaderText="Detected Station" SortExpression="DetectedStationName">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="EscapedByEmployeeID" HeaderText="Escaped By" SortExpression="EscapedByEmployeeID">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="EscapedByEmployeeName" HeaderText="Escaped By Name" SortExpression="EscapedByEmployeeName">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="EscapedStationName" HeaderText="Escaped Station" SortExpression="EscapedStationName">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DefectText" HeaderText="Defect" SortExpression="DefectText">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CRD" HeaderText="CRD" SortExpression="CRD"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Serial Number" SortExpression="SerialNumber">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbEdit" Enabled='<%# (bool)IsAdmin %>' runat="server" CausesValidation="False" Text='<%# Bind("SerialNumber") %>'
                                                            CommandArgument='<%# Eval("GC_DataID")%>' CommandName="Select"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ChildSerialNumber" HeaderText="Child Serial Number" SortExpression="ChildSerialNumber">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Route" HeaderText="Route" SortExpression="Route"></asp:BoundField>
                                                <asp:BoundField DataField="FailureLabel" HeaderText="Failure Label" SortExpression="FailureLabel">
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Client Name" SortExpression="ClientName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlAuthenticationLog" runat="server" NavigateUrl='<%# String.Format("../CCS/AuthenticationLog.aspx?f={0}&t={1}&e={2}", Eval("EscapedDate", "{0:yyyyMMdd}"), Eval("EscapedDate", "{0:yyyyMMdd}"), Eval("EscapedByEmployeeID")) %>'
                                                            Text='<%# Eval("ClientName") %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                                                </asp:BoundField>
                                                <asp:CheckBoxField DataField="IsMESAutoLinked" HeaderText="MES Auto Linked" SortExpression="IsMESAutoLinked">
                                                    <ItemStyle CssClass="checkbox" />
                                                </asp:CheckBoxField>
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
                                <legend>Add/ Edit Grape Chart Record</legend>
                                <table>
                                    <tr>
                                        <td style="width: 10%;">
                                            <asp:Label ID="Label30" runat="server" Text="Workcell"></asp:Label>
                                            <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                ControlToValidate="ddlGC_Customers" ErrorMessage="Customer is required."
                                                ValidationGroup="vggrapechart">(*)</asp:CustomValidator>
                                        </td>
                                        <td style="width: 15%;">
                                            <asp:DropDownList ID="ddlGC_Customers" runat="server" AppendDataBoundItems="True"
                                                DataTextField="Customer" DataValueField="Customer_ID" Width="99%" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlGC_Customers_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10%;">
                                            <asp:Label ID="Label10" runat="server" Text="Escaped Date"></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEscapedDate"
                                                ErrorMessage="Escaped Date is required." ToolTip="Escaped Date is required."
                                                ValidationGroup="vggrapechart">(*)</asp:RequiredFieldValidator>
                                        </td>
                                        <td style="width: 15%;">
                                            <asp:TextBox ID="txtEscapedDate" runat="server" Width="80px"></asp:TextBox>
                                            <img id="imgEscapedDate" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                alt="" />
                                            <ajaxToolkit:CalendarExtender ID="ceEscapedDate" runat="server" CssClass="MyCalendar"
                                                Enabled="True" Format="MM/dd/yyyy" PopupButtonID="imgEscapedDate" TargetControlID="txtEscapedDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 10%;">
                                            <asp:Label ID="Label1" runat="server">Shift</asp:Label>
                                            <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                ControlToValidate="ddlShift" ErrorMessage="Shift is required." ValidationGroup="vggrapechart">(*)</asp:CustomValidator>
                                        </td>
                                        <td colspan="3">
                                            <asp:DropDownList ID="ddlShift" runat="server" AppendDataBoundItems="True" DataTextField="ShiftName"
                                                DataValueField="ShiftID" Width="99%">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label19" runat="server">Detected By</asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDetectedByEmployeeID"
                                                ErrorMessage="Detected By is required." ToolTip="Detected By is required." ValidationGroup="vggrapechart">(*)</asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDetectedByEmployeeID" runat="server" Width="99%"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="bhaceDetectedByEmployeeID"
                                                ID="aceDetectedByEmployeeID" TargetControlID="txtDetectedByEmployeeID" ServicePath="../WebServices/EmployeeS.asmx"
                                                ServiceMethod="GetEmployeeList" MinimumPrefixLength="2" CompletionInterval="500"
                                                EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                DelimiterCharacters=";, :" OnClientItemSelected="EmployeeSelected" FirstRowSelected="true">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label20" runat="server" Text="Detected Station"></asp:Label>
                                            <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                ControlToValidate="ddlDetectedStation" ErrorMessage="Detected Station is required."
                                                ValidationGroup="vggrapechart">(*)</asp:CustomValidator>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlDetectedStation" runat="server" AppendDataBoundItems="True"
                                                DataTextField="StationName" DataValueField="GC_StationID" Width="99%">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label4" runat="server">Escaped By</asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEscapedByEmployeeID"
                                                ErrorMessage="Escaped By is required." ToolTip="Escaped By is required." ValidationGroup="vggrapechart">(*)</asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEscapedByEmployeeID" runat="server" Width="99%"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="bhaceEscapedByEmployeeID"
                                                ID="aceEscapedByEmployeeID" TargetControlID="txtEscapedByEmployeeID" ServicePath="../WebServices/EmployeeS.asmx"
                                                ServiceMethod="GetEmployeeList" MinimumPrefixLength="2" CompletionInterval="500"
                                                EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                DelimiterCharacters=";, :" OnClientItemSelected="EmployeeSelected" FirstRowSelected="true">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td style="width: 10%;">
                                            <asp:Label ID="Label9" runat="server">Escaped Station</asp:Label>
                                            <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                ControlToValidate="ddlEscapedStation" ErrorMessage="Escaped Station is required."
                                                ValidationGroup="vggrapechart">(*)</asp:CustomValidator>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlEscapedStation" runat="server" AppendDataBoundItems="True"
                                                DataTextField="StationName" DataValueField="GC_StationID" Width="99%">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label2" runat="server">Defect</asp:Label>
                                            <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                ControlToValidate="ddlQM_Defects" ErrorMessage="Defect is required." ValidationGroup="vggrapechart">(*)</asp:CustomValidator>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlQM_Defects" runat="server" AppendDataBoundItems="True" DataTextField="DefectText"
                                                DataValueField="Defect_ID" Width="99%">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text="CRD"></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCRD"
                                                ErrorMessage="CRD is required." ToolTip="CRD is required." ValidationGroup="vggrapechart">(*)</asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCRD" runat="server" Width="99%"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label26" runat="server" Text="Serial Number"></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSerialNumber"
                                                ErrorMessage="Serial Number is required." ToolTip="Serial Number is required."
                                                ValidationGroup="vggrapechart">(*)</asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtSerialNumber" runat="server" Width="99%"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label8" runat="server" Text="Description"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDescription" runat="server" Width="99%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="text-align: right; white-space: nowrap;">
                                            <asp:Label ID="lblGrapeChartMessage" runat="server" CssClass="errorMsg">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="text-align: right; white-space: nowrap;">
                                            <asp:Button ID="btnAdd" runat="server" CssClass="button" OnClick="btnAdd_Click" Text="Save"
                                                UseSubmitBehavior="False" ValidationGroup="vggrapechart" />
                                            <asp:Button ID="btnUpdateAsk" runat="server" CssClass="button" OnClientClick="return GrapeChartUpdateValidation();"
                                                Text="Update" UseSubmitBehavior="False" ValidationGroup="vggrapechart" />
                                            <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                Text="Delete" UseSubmitBehavior="False" />
                                            <asp:Button ID="btnCancel" runat="server" CssClass="button" OnClick="btnCancel_Click"
                                                Text="Close" UseSubmitBehavior="False" />
                                            <%--    <asp:Button ID="btnCancel" runat="server" CssClass="button" OnClick="btnCancel_Click"
                                                Text="Cancel" UseSubmitBehavior="False" />--%>
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeUpdateGrapeChart" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    PopupControlID="pnUpdateGrapeChartPopup" BehaviorID="bhmpeUpdateGrapeChart" TargetControlID="lblUpdateGrapeChartControl"
                                    CancelControlID="btnCancelUpdateGrapeChart" OkControlID="btnReturnUpdateGrapeChart">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="pnUpdateGrapeChartPopup" runat="server" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update Grape Chart Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this grape chart?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table class="applytable">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnUpdate" runat="server" CssClass="button" OnClick="btnUpdate_Click"
                                                                        Text="OK"  />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelUpdateGrapeChart" runat="server" CssClass="button" OnClientClick="return false;"
                                                                        Text="Cancel"  />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
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
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateGrapeChartControl" runat="server">  </asp:Label>
                                    <asp:HiddenField ID="hdGC_DataID" runat="server" />
                                    <asp:HiddenField ID="hdIsAdmin" runat="server" Value="0"/>
                                    <asp:HiddenField ID="hdMenuID" runat="server" />
                                    <asp:Button ID="btnReturnUpdateGrapeChart" OnClientClick="return false;" runat="server"
                                        UseSubmitBehavior="False" CssClass="button"></asp:Button>
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

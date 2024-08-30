<%@ Page Title="Training Records Report" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="HRTR.TR.Reports" %>

<%@ Register Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Training Records Report
        </div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Reports.js"></asp:ScriptReference>
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
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td style="width: 10%">
                                                        <asp:Label ID="Label3" runat="server" Text="Employee ID"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%">
                                                        <asp:TextBox ID="txtEmployeeID" runat="server" Width="99%"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 10%">
                                                        <asp:Label ID="Label14" runat="server" Text="Employee ID SAP"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%">
                                                        <asp:TextBox ID="txtEmployeeIDSAP" runat="server" Width="99%"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 10%">
                                                        <asp:Label ID="Label2" runat="server" Text="Employee Name"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%">
                                                        <asp:TextBox ID="txtEmployeeName" runat="server" Width="99%"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 10%">
                                                        <asp:Label ID="Label46" runat="server" Text="Operator Group"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlOperatorGroup" runat="server" AppendDataBoundItems="True"
                                                            DataTextField="OperatorGroupName" DataValueField="OperatorGroupID" Width="99%">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label5" runat="server" Text="Company"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlCompany" runat="server" AppendDataBoundItems="True" DataTextField="CompanyName"
                                                            DataValueField="CompanyID" Width="99%">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label10" runat="server" Text="Department"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlDepartment" runat="server" AppendDataBoundItems="True" DataTextField="DepartmentName"
                                                            DataValueField="DepartmentID" Width="99%">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label6" runat="server" Text="Job Title"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtJobTitle" runat="server" Width="99%"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label8" runat="server" Text="Position"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlPosition" runat="server" AppendDataBoundItems="True" DataTextField="PositionName"
                                                            DataValueField="PositionID" Width="99%">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label36" runat="server" Text="Workcell"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlWorkcell" runat="server" AppendDataBoundItems="True" DataTextField="WorkcellName"
                                                            DataValueField="WorkcellID" Width="99%">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label18" runat="server" Text="Line Leader"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtSupervisor" runat="server" Width="99%"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label44" runat="server" Text="Employee Active"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsActive_EmployeeS" runat="server" AppendDataBoundItems="True" Width="50px">
                                                            <asp:ListItem Value="-1">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1" Selected="True">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td colspan="2"></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text="Training Group"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <%--<asp:DropDownList ID="ddlTrainingGroup" runat="server" AppendDataBoundItems="True"
                                                            DataTextField="TrainingGroupName" DataValueField="TrainingGroupID" Width="99%"
                                                            AutoPostBack="True" OnSelectedIndexChanged="ddlTrainingGroup_SelectedIndexChanged">
                                                        </asp:DropDownList>--%>
                                                        <cc1:DropDownCheckBoxes ID="ddcTrainingGroup" runat="server" CssClass="dropdowncheckboxes"
                                                            DataTextField="TrainingGroupName" DataValueField="TrainingGroupID" AutoPostBack="True" Width="99%" OnSelectedIndexChanged="ddcTrainingGroup_SelectedIndexChanged"
                                                            AppendDataBoundItems="True" UseSelectAllNode="True" AddJQueryReference="True">
                                                        </cc1:DropDownCheckBoxes>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label4" runat="server" Text="Course Group"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <%-- <asp:DropDownList ID="ddlCourseGroup" runat="server" AppendDataBoundItems="True"
                                                            DataTextField="CourseGroupName" DataValueField="CourseGroupID" Width="99%" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlCourseGroup_SelectedIndexChanged">
                                                        </asp:DropDownList>--%>
                                                        <cc1:DropDownCheckBoxes ID="ddcCourseGroup" runat="server" CssClass="dropdowncheckboxes"
                                                            DataTextField="CourseGroupName" DataValueField="CourseGroupID" AutoPostBack="True" Width="99%" OnSelectedIndexChanged="ddcCourseGroup_SelectedIndexChanged"
                                                            AppendDataBoundItems="True" UseSelectAllNode="True" AddJQueryReference="True">
                                                        </cc1:DropDownCheckBoxes>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label7" runat="server" Text="Family"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlProduct" runat="server" AppendDataBoundItems="True" DataTextField="ProductName"
                                                            DataValueField="ProductID" Width="99%">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label12" runat="server" Text="Course"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <%--  <asp:DropDownList ID="ddlCourse" runat="server" AppendDataBoundItems="True" DataTextField="CourseName"
                                                            DataValueField="CourseID" Width="99%">
                                                        </asp:DropDownList>--%>
                                                        <cc1:DropDownCheckBoxes ID="ddcCourse" runat="server" CssClass="dropdowncheckboxes"
                                                            DataTextField="CourseName" DataValueField="CourseName"
                                                            AppendDataBoundItems="True" UseSelectAllNode="True" AddJQueryReference="True">
                                                        </cc1:DropDownCheckBoxes>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label9" runat="server" Text="Expired From"></asp:Label>
                                                    </td>
                                                    <td style="white-space: nowrap;">
                                                        <asp:TextBox ID="txtExpDateFrom" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="imgExpDateFrom" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                            alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="ceExpDateFrom" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtExpDateFrom" Enabled="True" PopupButtonID="imgExpDateFrom"
                                                            Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                        <asp:Label ID="Label11" runat="server" Text="To"></asp:Label>
                                                        <asp:TextBox ID="txtExpDateTo" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="imgExpDateTo" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                            alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="ceExpDateTo" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtExpDateTo" Enabled="True" PopupButtonID="imgExpDateTo" Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label47" runat="server" Text="Certified From"></asp:Label>
                                                    </td>
                                                    <td style="white-space: nowrap;">
                                                        <asp:TextBox ID="txtCerDateFrom" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="imgCerDateFrom" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                            alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="ceCerDateFrom" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtCerDateFrom" Enabled="True" PopupButtonID="imgCerDateFrom"
                                                            Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                        <asp:Label ID="Label48" runat="server" Text="To"></asp:Label>
                                                        <asp:TextBox ID="txtCerDateTo" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="imgCerDateTo" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                            alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="ceCerDateTo" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtCerDateTo" Enabled="True" PopupButtonID="imgCerDateTo" Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label19" runat="server" Text="Certificate Level"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <cc1:DropDownCheckBoxes ID="ddcCertifiedLevel" runat="server" CssClass="dropdowncheckboxes"
                                                            DataTextField="CertifiedLevelName" DataValueField="CertifiedLevelID"
                                                            AppendDataBoundItems="True" UseSelectAllNode="True" AddJQueryReference="True">
                                                        </cc1:DropDownCheckBoxes>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:CheckBox ID="cbIsLatestRecords" runat="server" Text="Latest Records" Checked="true"></asp:CheckBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label15" runat="server" Text="Working Status"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <cc1:DropDownCheckBoxes ID="ddcWorkingStatus" runat="server" CssClass="dropdowncheckboxes"
                                                            DataTextField="WorkingStatusName" DataValueField="WorkingStatusID" Width="99%"
                                                            AppendDataBoundItems="True" UseSelectAllNode="True" AddJQueryReference="True">
                                                        </cc1:DropDownCheckBoxes>
                                                        <%--<asp:DropDownList ID="ddlWorkingStatus" runat="server" AppendDataBoundItems="True"
                                                            DataTextField="WorkingStatusName" DataValueField="WorkingStatusID" Width="99%">
                                                        </asp:DropDownList>--%>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label16" runat="server" Text="Working"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsWorking" runat="server" AppendDataBoundItems="True" Width="50px">
                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label17" runat="server" Text="Training Record Active"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsActive_TrainingRecordS" runat="server" AppendDataBoundItems="True" Width="50px">
                                                            <asp:ListItem Value="-1">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1" Selected="True">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td colspan="2"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="white-space: nowrap;">
                                                        <asp:Button ID="btnSearch" runat="server" CssClass="button" OnClick="btnSearch_Click"
                                                            Text="Search" />
                                                        <asp:Button ID="btnClear" runat="server" CssClass="button" OnClientClick="return ClearSearch();"
                                                            Text="Clear" />
                                                        <asp:Button ID="btnExport" runat="server" CssClass="button" OnClick="btnExport_Click"
                                                            Text="Export" />
                                                    </td>
                                                    <td colspan="6">
                                                        <asp:Label ID="lblSearch" runat="server" Text="" CssClass="Msg"></asp:Label>
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
                                <asp:GridView ID="grvTrainingRecord" runat="server" AllowPaging="True" AllowSorting="True"
                                    ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" DataKeyNames="TrainingRecordID"
                                    OnPageIndexChanging="grvTrainingRecord_PageIndexChanging" PageSize="20" OnRowCommand="grvTrainingRecord_RowCommand"
                                    OnRowDataBound="grvTrainingRecord_RowDataBound" OnSorting="grvTrainingRecord_Sorting"
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
                                        <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID" />
                                        <asp:BoundField DataField="EmployeeIDSAP" HeaderText="Employee ID SAP" SortExpression="EmployeeIDSAP" />
                                        <asp:BoundField DataField="WDNo" HeaderText="WD Number" SortExpression="WDNo" />
                                        <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                        <asp:BoundField DataField="DepartmentName" HeaderText="Department" SortExpression="DepartmentName" />
                                        <asp:BoundField DataField="JobTitle" HeaderText="Job Title" SortExpression="JobTitle" />
                                        <asp:BoundField DataField="PositionName" HeaderText="Position" SortExpression="PositionName" />
                                        <%--  <asp:BoundField DataField="ShiftName" HeaderText="Shift" SortExpression="ShiftName" />--%>
                                        <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName" />
                                        <asp:BoundField DataField="Supervisor" HeaderText="Supervisor" SortExpression="Supervisor" />
                                        
                                        <asp:BoundField DataField="TrainingGroupName" HeaderText="Training Group" SortExpression="TrainingGroupName" />
                                        <asp:BoundField DataField="CourseGroupName" HeaderText="Course Group" SortExpression="CourseGroupName" />
                                        <asp:BoundField DataField="CourseName" HeaderText="Course" SortExpression="CourseName" />
                                        <asp:BoundField DataField="Family" HeaderText="Family" SortExpression="Family" />
                                        <asp:BoundField DataField="CertDate" HeaderText="Certificate Date" SortExpression="CertDate"
                                            DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField DataField="ExpDate" HeaderText="Expired Date" SortExpression="ExpDate"
                                            DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:CheckBoxField DataField="OJT" HeaderText="OJT" SortExpression="OJT">
                                            <ItemStyle CssClass="checkbox" />
                                        </asp:CheckBoxField>
                                        <asp:CheckBoxField DataField="IsExpired" HeaderText="Expired" SortExpression="IsExpired">
                                            <ItemStyle CssClass="checkbox" />
                                        </asp:CheckBoxField>
                                         
                                        <asp:BoundField DataField="Trainer" HeaderText="Trainer" SortExpression="Trainer" />
                                        <asp:BoundField DataField="CertifiedLevelName" HeaderText="Certificate Level" SortExpression="CertifiedLevelName" />
                                        <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                                        <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                                            <ItemStyle CssClass="checkbox" />
                                        </asp:CheckBoxField>
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
                                                    <img src="../Images/updateprogress.gif" alt="" />
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
                                    <asp:HiddenField ID="hdMenuID" runat="server" />
                                    <asp:HiddenField ID="hdExport" runat="server" />
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

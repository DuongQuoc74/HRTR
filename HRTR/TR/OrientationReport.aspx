<%@ Page Title="Orientation Reports" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="OrientationReport.aspx.cs" Inherits="HRTR.TR.OrientationReport" %>

<%@ Register Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Orientation Reports
        </div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/OrientationReport.js"></asp:ScriptReference>
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
                                                        <asp:Label ID="Label44" runat="server" Text="Active"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="50px">
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
                                                        <cc1:DropDownCheckBoxes ID="ddcTrainingGroup" runat="server" CssClass="dropdowncheckboxes"
                                                            DataTextField="TrainingGroupName" DataValueField="TrainingGroupID" AutoPostBack="True" Width="99%" OnSelectedIndexChanged="ddcTrainingGroup_SelectedIndexChanged"
                                                            AppendDataBoundItems="True" UseSelectAllNode="True" AddJQueryReference="True">
                                                        </cc1:DropDownCheckBoxes>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label4" runat="server" Text="Course Group"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <cc1:DropDownCheckBoxes ID="ddcCourseGroup" runat="server" CssClass="dropdowncheckboxes"
                                                            DataTextField="CourseGroupName" DataValueField="CourseGroupID" AutoPostBack="True" Width="99%" OnSelectedIndexChanged="ddcCourseGroup_SelectedIndexChanged"
                                                            AppendDataBoundItems="True" UseSelectAllNode="True" AddJQueryReference="True">
                                                        </cc1:DropDownCheckBoxes>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label7" runat="server" Text="Product"></asp:Label>
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
                                                        <cc1:DropDownCheckBoxes ID="ddcCourse" runat="server" CssClass="dropdowncheckboxes"
                                                            DataTextField="CourseName" DataValueField="CourseName"
                                                            AppendDataBoundItems="True" UseSelectAllNode="True" AddJQueryReference="True">
                                                        </cc1:DropDownCheckBoxes>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label17" runat="server" Text="Expired From"></asp:Label>
                                                    </td>
                                                    <td style="white-space: nowrap;">
                                                        <asp:TextBox ID="txtExpDateFrom" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="imgExpDateFrom" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                            alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="ceExpDateFrom" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtExpDateFrom" Enabled="True" PopupButtonID="imgExpDateFrom"
                                                            Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                        <asp:Label ID="Label19" runat="server" Text="To"></asp:Label>
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
                                                        <asp:Label ID="Label16" runat="server" Text="Working"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsWorking" runat="server" AppendDataBoundItems="True" Width="50px">
                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td colspan="2"></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label9" runat="server" Text="Joined Date From"></asp:Label>
                                                    </td>
                                                    <td style="white-space: nowrap;">
                                                        <asp:TextBox ID="txtJoinedDateFrom" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="imgJoinedDateFrom" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                            alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="ceJoinedDateFrom" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtJoinedDateFrom" Enabled="True" PopupButtonID="imgJoinedDateFrom"
                                                            Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                        <asp:Label ID="Label11" runat="server" Text="To"></asp:Label>
                                                        <asp:TextBox ID="txtJoinedDateTo" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="imgJoinedDateTo" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                            alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="ceJoinedDateTo" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtJoinedDateTo" Enabled="True" PopupButtonID="imgJoinedDateTo" Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label15" runat="server" Text="Working Status"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <cc1:DropDownCheckBoxes ID="ddcWorkingStatus" runat="server" CssClass="dropdowncheckboxes"
                                                            DataTextField="WorkingStatusName" DataValueField="WorkingStatusID" Width="99%"
                                                            AppendDataBoundItems="True" UseSelectAllNode="True" AddJQueryReference="True">
                                                        </cc1:DropDownCheckBoxes>
                                                    </td>
                                                    <td colspan="4"></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label21" runat="server" Text="Expected to Complete Before (Days)"></asp:Label>
                                                        <%--            <asp:CompareValidator runat="server" ControlToValidate="txtExpectedToCompleteBefore_Days"
                                                            Operator="GreaterThanEqual" ValueToCompare="0" Type="Integer"
                                                            ErrorMessage="Only allow positive number" ToolTip="Only allow positive number" ValidationGroup="vgsearch"
                                                            Display="Dynamic" Text="*" ForeColor="Red" />--%>
                                                    </td>
                                                    <td style="white-space: nowrap;">
                                                        <asp:TextBox ID="txtExpectedToCompleteBefore_Days" runat="server" Width="80px" Text="2" CssClass="positivenumber"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label20" runat="server" Text="Output Type"></asp:Label>
                                                    </td>
                                                    <td style="white-space: nowrap;">
                                                        <asp:DropDownList ID="ddlOutputType" runat="server" Width="99%" >
                                                            <asp:ListItem Value="1" Text="Summary" />
                                                            <asp:ListItem Value="2" Text="Details" />
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label22" runat="server" Text="Status"></asp:Label>
                                                    </td>
                                                    <td style="white-space: nowrap;">
                                                        <asp:DropDownList ID="ddlTrainingStatus" runat="server" AppendDataBoundItems="True" DataTextField="TrainingStatusName"
                                                            DataValueField="TrainingStatusID" Width="99%">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td colspan="2"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="white-space: nowrap;">
                                                        <asp:Button ID="btnSearch" runat="server" CssClass="button" OnClick="btnSearch_Click"
                                                            Text="Search" ValidationGroup="vgsearch"  />
                                                        <asp:Button ID="btnClear" runat="server" CssClass="button" OnClientClick="return ClearSearch();"
                                                            Text="Clear"/>
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
                                <asp:GridView ID="grvOrientationRecord" runat="server" AllowPaging="True" AllowSorting="True"
                                    ShowHeaderWhenEmpty="true" AutoGenerateColumns="True"
                                    OnPageIndexChanging="grvOrientationRecord_PageIndexChanging" PageSize="20" OnRowCommand="grvOrientationRecord_RowCommand"
                                    OnRowDataBound="grvOrientationRecord_RowDataBound" OnSorting="grvOrientationRecord_Sorting"
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
                                    <asp:HiddenField ID="hdMenuID" runat="server" />
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

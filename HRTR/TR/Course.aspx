<%@ Page Title="Course" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="Course.aspx.cs" Inherits="HRTR.TR.Course" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Course
        </div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Course.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>

                        <%-- Search Panel --%>
                        <tr>
                            <td>
                                <asp:Panel ID="pnSearch" runat="server">
                                    <fieldset>
                                        <legend>Search</legend>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label10" runat="server" Text="Training Group"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:DropDownList ID="ddlTrainingGroupS" runat="server" AppendDataBoundItems="True"
                                                            DataTextField="TrainingGroupName" DataValueField="TrainingGroupID" Width="99%">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label46" runat="server" Text="Course Group"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:DropDownList ID="ddlCourseGroupS" runat="server" AppendDataBoundItems="True"
                                                            DataTextField="CourseGroupName" DataValueField="CourseGroupID" Width="99%">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label3" runat="server" Text="Course Name"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:TextBox ID="txtCourseNameS" runat="server" Width="99%"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label44" runat="server" Text="Has VA"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlHasVAS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label1" runat="server" Text="Critical"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsCriticalS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label4" runat="server" Text="Orientation"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsOrientationS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text="Active"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <%--<td colspan="6"></td>--%>

                                                    <td>
                                                        <asp:Label ID="Label8" runat="server" Text="Certified Per Family"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlCertifiedPerFamily" runat="server" AppendDataBoundItems="True" Width="80px">
                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>

                                                    <td colspan="4"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="10">
                                                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                            CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                        <%--   <asp:Button ID="btnImport" runat="server" CssClass="button" OnClick="btnImport_Click"
                                                                    Text="Import" />--%>
                                                        <asp:Button ID="btnExport" OnClick="btnExport_Click" runat="server" Text="Export"
                                                            CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                        <asp:Label ID="lblSearch" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </fieldset>
                                </asp:Panel>
                            </td>
                        </tr>

                        <%-- Add new Course button --%>
                        <tr>
                            <td>
                                <asp:Panel ID="pnNew" runat="server">
                                    <asp:Button ID="btnNewCourse" runat="server" OnClientClick="return NewCourse();"
                                        UseSubmitBehavior="False" CssClass="button" Text="New"></asp:Button>
                                    <asp:Label ID="lblCourse" runat="server" Text=""></asp:Label>
                                </asp:Panel>
                            </td>
                        </tr>

                        <%-- Courses --%>
                        <tr>
                            <td>
                                <asp:Panel ID="pnCourse" runat="server">
                                    <asp:GridView ID="grvCourseList" runat="server" OnRowDataBound="grvCourseList_RowDataBound"
                                        PageSize="20" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                        DataKeyNames="CourseID" OnPageIndexChanging="grvCourseList_PageIndexChanging"
                                        OnSorting="grvCourseList_Sorting" OnRowCommand="grvCourseList_RowCommand" CssClass="gridview"
                                        PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected"
                                        HeaderStyle-CssClass="header" FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate"
                                        RowStyle-CssClass="normal">
                                        <PagerSettings Mode="NumericFirstLast"></PagerSettings>
                                        <Columns>
                                            <asp:TemplateField HeaderText="No.">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="rowno" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="TrainingGroupName" HeaderText="Training Group" SortExpression="TrainingGroupName" />
                                            <asp:BoundField DataField="CourseGroupName" HeaderText="Course Group" SortExpression="CourseGroupName" />
                                            <asp:BoundField DataField="CourseName" HeaderText="Course Name" SortExpression="CourseName" />
                                            <asp:CheckBoxField DataField="IsCertifiedPerFamily" HeaderText="Certified Per Family" SortExpression="IsCertifiedPerFamily">
                                                <ItemStyle CssClass="checkbox" />
                                            </asp:CheckBoxField>
                                            <asp:BoundField DataField="ExpiredInMonths" HeaderText="Expired In (Month(s))" SortExpression="ExpiredInMonths">
                                                <ItemStyle CssClass="right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="MinPoint" HeaderText="Min Point" SortExpression="MinPoint">
                                                <ItemStyle CssClass="right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="MaxPoint" HeaderText="Max Point" SortExpression="MaxPoint">
                                                <ItemStyle CssClass="right" />
                                            </asp:BoundField>
                                            <asp:CheckBoxField DataField="HasVA" HeaderText="Has VA" SortExpression="HasVA">
                                                <ItemStyle CssClass="checkbox" />
                                            </asp:CheckBoxField>
                                            <asp:CheckBoxField DataField="IsCritical" HeaderText="Critical" SortExpression="IsCritical">
                                                <ItemStyle CssClass="checkbox" />
                                            </asp:CheckBoxField>
                                            <asp:CheckBoxField DataField="IsOrientation" HeaderText="Orientation" SortExpression="IsOrientation">
                                                <ItemStyle CssClass="checkbox" />
                                            </asp:CheckBoxField>
                                            <asp:BoundField DataField="EffectiveDate" HeaderText="Effective Date" SortExpression="EffectiveDate"
                                                DataFormatString="{0:MM/dd/yyyy}">
                                                <ItemStyle CssClass="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="NumberOfCriticalDays" HeaderText="Number Of Log In Day" SortExpression="NumberOfCriticalDays">
                                                <ItemStyle CssClass="right" />
                                            </asp:BoundField>
                                            <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                                                <ItemStyle CssClass="checkbox" />
                                            </asp:CheckBoxField>
                                            <asp:BoundField DataField="LastUpdatedByUserName" HeaderText="Last Updated By" SortExpression="LastUpdatedByUserName" />
                                            <asp:BoundField DataField="LastUpdated" HeaderText="Last Updated" SortExpression="LastUpdated" />
                                            <asp:TemplateField HeaderText="">
                                                <ItemTemplate>
                                                    <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                        CssClass="ContextMenuTarget" />
                                                    <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none; visibility: hidden;">
                                                        <asp:LinkButton runat="server" Text="Edit" CommandName="Select" CausesValidation="False"
                                                            CssClass="ContextMenuItem" ID="lbEdit" CommandArgument='<%# Eval("CourseID") %>'></asp:LinkButton>
                                                        <asp:LinkButton runat="server" Text="Delete" CommandName="Del" CausesValidation="False"
                                                            CssClass="ContextMenuItem" ID="lbDelete" CommandArgument='<%# Eval("CourseID") %>'></asp:LinkButton>
                                                    </asp:Panel>
                                                    <ajaxToolkit:DropDownExtender runat="server" ID="DDE" TargetControlID="TextLabel"
                                                        DropDownControlID="DropPanel" />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="select" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
                            </td>
                        </tr>

                        <%-- Add new Course --%>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender
                                    ID="mpeCourse" runat="server"
                                    TargetControlID="btnNewCourse"
                                    PopupControlID="pnCoursePopup"
                                    BackgroundCssClass="modalBackgroundCommon"
                                    CancelControlID="btnCancelCourse"
                                    DropShadow="false"
                                    PopupDragHandleControlID="pnCoursePopupDrag"
                                    BehaviorID="bhvmpeCourse">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel
                                    ID="pnCoursePopup"
                                    CssClass="modalPopupCommon"
                                    Style="display: none; width: 800px;"
                                    runat="server">
                                    <asp:Panel class="modalPopupDrag" ID="pnCoursePopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add/ Update/ Delete Course
                                            </p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <%-- Training Group --%>
                                            <tr>
                                                <td style="width: 20%;">
                                                    <asp:Label ID="Label14" runat="server" Text="Training Group"></asp:Label>
                                                    <asp:CustomValidator ID="cvTrainingGroup" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlTrainingGroup" ErrorMessage="Training Group is required."
                                                        ValidationGroup="vgcourse">(*)</asp:CustomValidator>
                                                </td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="ddlTrainingGroup" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="TrainingGroupName" DataValueField="TrainingGroupID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>

                                            <%-- Course Group --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label50" runat="server" Text="Course Group"></asp:Label>
                                                    <asp:CustomValidator ID="cvCourseGroup" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCourseGroup" ErrorMessage="Course Group is required." ValidationGroup="vgcourse">(*)</asp:CustomValidator>
                                                </td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="ddlCourseGroup" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="CourseGroupName" DataValueField="CourseGroupID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>

                                            <%-- Course Name --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Add" runat="server" Text="Course Name">
                                                    </asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvCourseName" runat="server" ValidationGroup="vgcourse"
                                                        ToolTip="Course Name is required." ErrorMessage="Course Name is required." ControlToValidate="txtCourseName">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtCourseName" runat="server" Width="99%" ValidationGroup="vgcourse">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>

                                            <%-- Expired In Month(s) --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label5" runat="server">Expired In Month(s)</asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvExpiredInMonths" runat="server" ControlToValidate="txtExpiredInMonths"
                                                        ErrorMessage="Expired In Month(s) is required." ToolTip="Expired In Month(s) is required."
                                                        ValidationGroup="vgcourse">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtExpiredInMonths" runat="server" Width="99%" CssClass="positivenumber"></asp:TextBox>
                                                </td>
                                            </tr>

                                            <%-- Min point, Max point --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" Text="Min Point"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvMinPoint" runat="server" ControlToValidate="txtMinPoint" Display="Dynamic"
                                                        ErrorMessage="Min Point is required." ToolTip="Min Point is required." ValidationGroup="vgcourse">(*)</asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="cvMinPoint" runat="server" ControlToValidate="txtMinPoint"
                                                        Operator="LessThanEqual" ValueToCompare="100" Type="Double"
                                                        ToolTip="Score must be greater than or equal 0 and less than or equal 100"
                                                        ValidationGroup="vgcourse" Display="Dynamic" Text="(*)" ForeColor="Red" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtMinPoint" runat="server" Width="60%" CssClass="positivenumber"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label7" runat="server" Text="Max Point"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvMaxPoint" runat="server" ControlToValidate="txtMaxPoint" Display="Dynamic"
                                                        ErrorMessage="Max Point is required." ToolTip="Max Point is required." ValidationGroup="vgcourse">(*)</asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="cvMaxPoint" runat="server" ControlToValidate="txtMaxPoint"
                                                        Operator="LessThanEqual" ValueToCompare="100" Type="Double"
                                                        ToolTip="Score must be greater than or equal 0 and less than or equal 100"
                                                        ValidationGroup="vgcourse" Display="Dynamic" Text="(*)" ForeColor="Red" />
                                                    <td>
                                                        <asp:TextBox ID="txtMaxPoint" runat="server" Width="60%" CssClass="positivenumber"></asp:TextBox>
                                                    </td>
                                            </tr>

                                            <%-- Has VA, Critical, Active, Number of Log day --%>
                                            <tr>
                                                <td></td>
                                                <td style="width: 30%;">
                                                    <asp:CheckBox ID="cbHasVA" runat="server" Text="Has VA" />
                                                    <asp:CheckBox ID="cbIsCritical" runat="server" Text="Critical" OnClientClick="return fnCritical();" />
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="Active" />
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:Label ID="lblNumberOfCriticalDays" runat="server" Text="Number Of Log In Day"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNumberOfCriticalDays" runat="server" Width="60%" CssClass="positivenumber"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <%-- Orientation --%>
                                                    <asp:CheckBox
                                                        ID="cbIsOrientation"
                                                        runat="server"
                                                        Text="Orientation"
                                                        onclick="return LoadEffectiveDate(this);" />

                                                    <%-- Effective date --%>
                                                    <asp:Label
                                                        ID="lblEffectiveDate"
                                                        runat="server"
                                                        Text="Effective Date" />

                                                    <asp:RequiredFieldValidator
                                                        ID="rfvEffectiveDate"
                                                        runat="server"
                                                        ValidationGroup="vgcourse"
                                                        ToolTip="Effective Date is required."
                                                        ErrorMessage="Effective Date is required."
                                                        ControlToValidate="txtEffectiveDate">(*)</asp:RequiredFieldValidator>

                                                    <asp:TextBox
                                                        ID="txtEffectiveDate"
                                                        runat="server"
                                                        Width="80px" />

                                                    <img
                                                        id="imgEffectiveDate"
                                                        runat="server"
                                                        class="dateselected"
                                                        src="../Images/icon-calendar.gif"
                                                        alt="" />

                                                    <ajaxToolkit:CalendarExtender
                                                        ID="ceEffectiveDate"
                                                        runat="server"
                                                        CssClass="MyCalendar"
                                                        TargetControlID="txtEffectiveDate"
                                                        Enabled="True"
                                                        PopupButtonID="imgEffectiveDate"
                                                        Format="MM/dd/yyyy">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>

                                                <%-- Certified per Family --%>
                                                <td>
                                                    <asp:CheckBox
                                                        ID="cbCertifiedPerFamily"
                                                        runat="server"
                                                        Text="Certified per family" />
                                                </td>

                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <asp:Label
                                                        ID="lblCourseMessage"
                                                        runat="server"
                                                        CssClass="errorMsg" />
                                                </td>
                                            </tr>

                                            <%-- Insert/Update commands --%>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <asp:Button
                                                        ID="btnAdd"
                                                        OnClick="btnAdd_Click"
                                                        runat="server"
                                                        UseSubmitBehavior="False"
                                                        CssClass="button"
                                                        Text="Save"
                                                        ValidationGroup="vgcourse" />

                                                    <asp:Button
                                                        ID="btnUpdateAsk"
                                                        runat="server"
                                                        Text="Update"
                                                        CssClass="button"
                                                        UseSubmitBehavior="False"
                                                        ValidationGroup="vgcourse"
                                                        OnClientClick="return CourseUpdateValidation();" />

                                                    <asp:Button
                                                        ID="btnDelete"
                                                        runat="server"
                                                        CssClass="button"
                                                        OnClick="btnDelete_Click"
                                                        Text="Delete"
                                                        UseSubmitBehavior="False" />

                                                    <asp:Button
                                                        ID="btnCancelCourse"
                                                        runat="server"
                                                        UseSubmitBehavior="False"
                                                        CssClass="button"
                                                        Text="Cancel"
                                                        OnClientClick="return false;" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>

                                <ajaxToolkit:ModalPopupExtender
                                    ID="mpeConfirmUpdate"
                                    runat="server"
                                    TargetControlID="lblUpdateControl"
                                    BackgroundCssClass="modalBackgroundConfirm"
                                    CancelControlID="btnCancelUpdate"
                                    PopupControlID="PanelConfirmUpdate"
                                    BehaviorID="bhmpeConfirmUpdate">
                                </ajaxToolkit:ModalPopupExtender>

                                <%-- Panel confirm update --%>
                                <asp:Panel ID="PanelConfirmUpdate" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" align="center" colspan="2">
                                                    <asp:Label
                                                        ID="lblCaptionC"
                                                        runat="server"
                                                        Text="Update Course Confirmation" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="" />
                                                </td>
                                                <td>
                                                    <asp:Label
                                                        ID="Label12"
                                                        runat="server"
                                                        Text="Are you sure you want to update this course?" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:Button
                                                        ID="btnUpdate"
                                                        runat="server"
                                                        Text="OK"
                                                        CssClass="button"
                                                        OnClick="btnUpdate_Click" />

                                                    <asp:Button
                                                        ID="btnCancelUpdate"
                                                        runat="server"
                                                        Text="Cancel"
                                                        CssClass="button"
                                                        OnClientClick="return false;" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>

                                <ajaxToolkit:ModalPopupExtender
                                    ID="mpeProcessing"
                                    runat="server"
                                    Enabled="True"
                                    BackgroundCssClass="modalBackgroundProcessing"
                                    PopupControlID="PanelProcessing"
                                    DropShadow="false"
                                    BehaviorID="bhmpeProcessing"
                                    TargetControlID="lblProcessingControl">
                                </ajaxToolkit:ModalPopupExtender>

                                <asp:Panel Style="display: none" ID="PanelProcessing" runat="server" CssClass="modalPopupProcessing">
                                    <table class="processingtable">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <img
                                                        src="../Images/updateprogress.gif"
                                                        alt="" />
                                                </td>
                                                <td>
                                                    <asp:Label
                                                        ID="Label13"
                                                        runat="server"
                                                        Text="Processing..." />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>

                                <div style="visibility: hidden">
                                    <asp:HiddenField ID="hdCourseID" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdMenuID" runat="server" />
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server"></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

        <ajaxToolkit:UpdatePanelAnimationExtender
            ID="UpdatePanelAnimationExtender1"
            runat="server"
            TargetControlID="UpdatePanel1">
            <Animations>
                <OnUpdating>
                    <Sequence>
                        <ScriptAction Script="$find('bhmpeProcessing').show();" />
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
<%@ Page Title="Traning Record By Employee" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="TrainingRecordBE.aspx.cs" Inherits="HRTR.TR.TrainingRecordBE" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <%-- Header --%>
        <div class="MainContainHeader">
            Training Record By Employee
        </div>

        <ajaxToolkit:ToolkitScriptManager
            ID="ToolkitScriptManager1"
            runat="server"
            CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/TrainingRecordBE.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>

        <asp:UpdatePanel ID="upHRTR" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <%-- Search panel --%>
                        <tr>
                            <td>
                                <asp:Panel ID="pnSearch" runat="server">
                                    <fieldset>
                                        <legend>Search</legend>
                                        <table cellspacing="1">
                                            <tbody>
                                                <tr>
                                                    <td style="width: 10%;">
                                                        <asp:Label
                                                            ID="Label4"
                                                            runat="server"
                                                            Text="Employee ID" />
                                                        <asp:RequiredFieldValidator
                                                            ID="rfvEmployeeID"
                                                            runat="server"
                                                            ValidationGroup="vgsearch"
                                                            ControlToValidate="txtEmployeeID"
                                                            ErrorMessage="Employee ID is required."
                                                            ToolTip="Employee ID is required.">(*)</asp:RequiredFieldValidator>
                                                        <asp:CustomValidator
                                                            ID="cvEmployeeID"
                                                            runat="server"
                                                            ClientValidationFunction="cvEmployeeID_ClientValidate"
                                                            ControlToValidate="txtEmployeeID"
                                                            ErrorMessage="Employee ID is required."
                                                            ValidationGroup="vgsearch">(*)</asp:CustomValidator>
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <%-- Employee ID --%>
                                                        <asp:TextBox
                                                            ID="txtEmployeeID"
                                                            runat="server"
                                                            Width="99%" />

                                                        <ajaxToolkit:AutoCompleteExtender
                                                            runat="server"
                                                            BehaviorID="bhaceEmployee"
                                                            ID="aceEmployee"
                                                            TargetControlID="txtEmployeeID"
                                                            ServicePath="../WebServices/EmployeeS.asmx"
                                                            ServiceMethod="GetEmployeeList"
                                                            MinimumPrefixLength="2"
                                                            CompletionInterval="500"
                                                            EnableCaching="true"
                                                            CompletionSetCount="20"
                                                            CompletionListCssClass="autocomplete_completionListElement"
                                                            CompletionListItemCssClass="autocomplete_listItem"
                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                            DelimiterCharacters=";, :"
                                                            OnClientItemSelected="EmployeeSelected"
                                                            FirstRowSelected="true">
                                                        </ajaxToolkit:AutoCompleteExtender>
                                                    </td>

                                                    <%-- Employee Name --%>
                                                    <td style="width: 10%;">
                                                        <asp:Label
                                                            ID="Label20"
                                                            runat="server"
                                                            Text="Employee Name" />
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:TextBox
                                                            ID="txtEmployeeName"
                                                            runat="server"
                                                            Width="99%"
                                                            Enabled="false" />
                                                    </td>

                                                    <%-- Operator Group --%>
                                                    <td style="width: 10%;">
                                                        <asp:Label
                                                            ID="Label46"
                                                            runat="server"
                                                            Text="Operator Group" />
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:TextBox
                                                            ID="txtOperatorGroupName"
                                                            runat="server"
                                                            Width="99%"
                                                            Enabled="false" />
                                                    </td>

                                                    <%-- Company --%>
                                                    <td style="width: 10%;">
                                                        <asp:Label
                                                            ID="Label2"
                                                            runat="server"
                                                            Text="Company" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtCompanyName"
                                                            runat="server"
                                                            Width="99%"
                                                            Enabled="false" />
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <%-- Department --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label14"
                                                            runat="server"
                                                            Text="Department" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtDepartmentName"
                                                            runat="server"
                                                            Width="99%"
                                                            Enabled="false" />
                                                    </td>

                                                    <%-- Job title --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label15"
                                                            runat="server"
                                                            Text="Job Title" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtJobTitle"
                                                            runat="server"
                                                            Width="99%"
                                                            Enabled="false" />
                                                    </td>

                                                    <%-- Position --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label16"
                                                            runat="server"
                                                            Text="Position" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtPositionName"
                                                            runat="server"
                                                            Width="99%"
                                                            Enabled="false" />
                                                    </td>

                                                    <%-- Shift --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label17"
                                                            runat="server"
                                                            Text="Shift" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtShiftName"
                                                            runat="server"
                                                            Width="99%"
                                                            Enabled="false" />
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <%-- Workcell --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label36"
                                                            runat="server"
                                                            Text="Workcell" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtWorkcellName"
                                                            runat="server"
                                                            Width="99%"
                                                            Enabled="false" />
                                                    </td>

                                                    <%-- Line Leader --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label18"
                                                            runat="server"
                                                            Text="Line Leader" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtSupervisor"
                                                            runat="server"
                                                            Width="99%"
                                                            Enabled="false" />
                                                    </td>

                                                    <%-- Active Employee --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label22"
                                                            runat="server"
                                                            Text="Active Employee" /></td>
                                                    <td>
                                                        <asp:CheckBox
                                                            ID="cbIsActive"
                                                            runat="server"
                                                            Enabled="false" />
                                                    </td>

                                                    <%-- Active Course --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label23"
                                                            runat="server"
                                                            Text="Active Course" />
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox
                                                            ID="cbIsActive_Course"
                                                            runat="server" Checked="true" />
                                                    </td>
                                                </tr>


                                                <tr>
                                                    <%-- Training Group --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label24"
                                                            runat="server"
                                                            Text="Training Group" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtTrainingGroupName"
                                                            runat="server"
                                                            Width="99%" />
                                                    </td>
                                                    <%-- Course Group --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label25"
                                                            runat="server"
                                                            Text="Course Group" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtCourseGroupName"
                                                            runat="server"
                                                            Width="99%" />
                                                    </td>
                                                    <%-- Course Group --%>
                                                    <td>
                                                        <asp:Label
                                                            ID="Label26"
                                                            runat="server"
                                                            Text="Course Name" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txtCourseName"
                                                            runat="server"
                                                            Width="99%" />
                                                    </td>
                                                </tr>

                                                <%-- Commands --%>
                                                <tr>
                                                    <td colspan="8" style="white-space: nowrap;">

                                                        <%-- Search --%>
                                                        <asp:Button
                                                            ID="btnSearch"
                                                            runat="server"
                                                            CssClass="button"
                                                            OnClick="btnSearch_Click"
                                                            Text="View"
                                                            ValidationGroup="vgsearch" />

                                                        <%-- Import --%>
                                                        <asp:Button
                                                            ID="btnImport"
                                                            runat="server"
                                                            CssClass="button"
                                                            OnClick="btnImport_Click"
                                                            Text="Import" />

                                                        <%--   <asp:Button
                                                            ID="btnClear"
                                                            runat="server"
                                                            CssClass="button"
                                                            OnClientClick="return ResetData();"
                                                        Text="Clear"  />--%>

                                                        <asp:Label
                                                            ID="lblSearch"
                                                            runat="server"
                                                            Text=""
                                                            CssClass="boldMsg" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </fieldset>
                                </asp:Panel>
                            </td>
                        </tr>

                        <%-- Search Result --%>
                        <tr>
                            <td>
                                <asp:Panel ID="pnTrainingRecord" runat="server" Visible="false">
                                    <asp:GridView
                                        ID="grvTrainingRecord"
                                        runat="server"
                                        AllowSorting="True"
                                        AutoGenerateColumns="False"
                                        PageSize="10"
                                        OnPageIndexChanging="grvTrainingRecord_PageIndexChanging"
                                        DataKeyNames="TrainingRecordID"
                                        OnRowCommand="grvTrainingRecord_RowCommand"
                                        OnRowDataBound="grvTrainingRecord_RowDataBound"
                                        AllowPaging="true"
                                        OnSorting="grvTrainingRecord_Sorting"
                                        CssClass="gridview"
                                        PagerStyle-CssClass="pgr"
                                        ShowHeaderWhenEmpty="true"
                                        EditRowStyle-CssClass="editing"
                                        SelectedRowStyle-CssClass="selected"
                                        HeaderStyle-CssClass="header"
                                        FooterStyle-CssClass="footer"
                                        AlternatingRowStyle-CssClass="alternate"
                                        RowStyle-CssClass="normal">
                                        <PagerSettings Mode="NumericFirstLast" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="No.">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="rowno" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID" />
                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                            <asp:BoundField DataField="TrainingGroupName" HeaderText="Training Group" SortExpression="TrainingGroupName" />
                                            <asp:BoundField DataField="CourseGroupName" HeaderText="Course Group" SortExpression="CourseGroupName" />
                                            <asp:TemplateField HeaderText="Course Name" SortExpression="CourseName">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbEdit"  Enabled='<%# (bool)IsAdmin %>' runat="server" CausesValidation="False" Text='<%# Bind("CourseName") %>'
                                                        CommandArgument='<%# Eval("TrainingRecordID")%>' CommandName="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField> 
                                            <asp:BoundField DataField="ProductName" HeaderText="Family" SortExpression="ProductName" />
                                            <asp:BoundField DataField="CertDate" HeaderText="Certificate Date" DataFormatString="{0:MM/dd/yyyy}"
                                                SortExpression="CertDate" />
                                            <asp:BoundField DataField="Score" HeaderText="Score" SortExpression="Score">
                                                <ItemStyle CssClass="right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CertifiedLevelName" HeaderText="Certified Level" SortExpression="CertifiedLevelName" />
                                            <asp:BoundField DataField="Trainer" HeaderText="Trainer" SortExpression="Trainer" />
                                            <asp:CheckBoxField DataField="OJT" HeaderText="OJT" SortExpression="OJT">
                                                <ItemStyle CssClass="checkbox" />
                                            </asp:CheckBoxField>
                                            <asp:BoundField DataField="ExpDate" HeaderText="Expired Date" DataFormatString="{0:MM/dd/yyyy}"
                                                SortExpression="ExpDate" />
                                            <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                                                <ItemStyle CssClass="checkbox" />
                                            </asp:CheckBoxField>
                                            <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:Button ID="btnNew" runat="server" CssClass="button" OnClick="btnNew_Click" Text="New" />
                                </asp:Panel>
                            </td>
                        </tr>

                        <%-- Add/ Edit/ Delete --%>
                        <tr>
                            <td>
                                <asp:Panel ID="pnEdit" runat="server" Visible="false">
                                    <fieldset>
                                        <legend>Add/ Edit/ Delete</legend>
                                        <table>
                                            <%-- Employee ID --%>
                                            <tr>
                                                <td>
                                                    <asp:Label
                                                        ID="Label11"
                                                        runat="server"
                                                        Text="Employee ID" />
                                                </td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txtEmployeeIDE"
                                                        runat="server"
                                                        Width="99%"
                                                        Enabled="false" />
                                                </td>

                                                <%-- Employee Name --%>
                                                <td>
                                                    <asp:Label
                                                        ID="Label12"
                                                        runat="server"
                                                        Text="Employee Name" />
                                                </td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txtEmployeeNameE"
                                                        runat="server"
                                                        Width="99%"
                                                        Enabled="false" />
                                                </td>
                                                <td colspan="4"></td>
                                            </tr>
                                            <tr>
                                                <%-- Training Group --%>
                                                <td style="width: 10%">
                                                    <asp:Label
                                                        ID="Label3"
                                                        runat="server"
                                                        Text="Training Group" />

                                                    <asp:CustomValidator
                                                        ID="cvTrainingGroup"
                                                        runat="server"
                                                        ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlTrainingGroup"
                                                        ErrorMessage="Training Group is required."
                                                        ValidationGroup="vgtrainingrecord">(*)</asp:CustomValidator>

                                                    <asp:CustomValidator
                                                        ID="CustomValidator3"
                                                        runat="server"
                                                        ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlTrainingGroup"
                                                        ErrorMessage="Training Group is required."
                                                        ValidationGroup="viewcourse">(*)</asp:CustomValidator>
                                                </td>

                                                <td style="width: 15%">
                                                    <asp:DropDownList
                                                        ID="ddlTrainingGroup"
                                                        runat="server"
                                                        AppendDataBoundItems="True"
                                                        AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlTrainingGroup_SelectedIndexChanged"
                                                        DataTextField="TrainingGroupName"
                                                        DataValueField="TrainingGroupID"
                                                        ValidationGroup="viewcourse"
                                                        Width="99%" />
                                                </td>

                                                <%-- Course Group --%>
                                                <td style="width: 10%">
                                                    <asp:Label
                                                        ID="Label1"
                                                        runat="server"
                                                        Text="Course Group" />

                                                    <asp:CustomValidator
                                                        ID="cvCourseGroup"
                                                        runat="server"
                                                        ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCourseGroup"
                                                        ErrorMessage="Course Group is required."
                                                        ValidationGroup="vgtrainingrecord">(*)</asp:CustomValidator>
                                                </td>

                                                <td style="width: 15%">
                                                    <asp:DropDownList
                                                        ID="ddlCourseGroup"
                                                        runat="server"
                                                        AppendDataBoundItems="True"
                                                        AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlCourseGroup_SelectedIndexChanged"
                                                        DataTextField="CourseGroupName"
                                                        DataValueField="CourseGroupID"
                                                        ValidationGroup="viewcourse"
                                                        Width="99%">
                                                    </asp:DropDownList>
                                                </td>

                                                <%-- Course --%>
                                                <td style="width: 10%">
                                                    <asp:Label
                                                        ID="Label5"
                                                        runat="server"
                                                        Text="Course" />

                                                    <asp:CustomValidator
                                                        ID="CustomValidator1"
                                                        runat="server"
                                                        ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCourse"
                                                        ErrorMessage="Course is required."
                                                        ValidationGroup="vgtrainingrecord">(*)</asp:CustomValidator>
                                                </td>

                                                <td style="width: 15%">
                                                    <asp:DropDownList
                                                        ID="ddlCourse"
                                                        runat="server"
                                                        AppendDataBoundItems="True"
                                                        DataTextField="CourseName"
                                                        DataValueField="CourseID"
                                                        Width="99%"
                                                        OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"
                                                        AutoPostBack="true">
                                                    </asp:DropDownList>
                                                    <asp:HiddenField ID="hdIsCertifiedPerFamily" runat="server" />
                                                </td>

                                                <%-- Family --%>
                                                <td style="width: 10%">
                                                    <%--<asp:Label ID="Label7" runat="server" Text="Product"></asp:Label>--%>
                                                    <asp:Label
                                                        ID="Label7"
                                                        runat="server"
                                                        Text="Family" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddlProduct"
                                                        runat="server"
                                                        AppendDataBoundItems="True"
                                                        DataTextField="ProductName"
                                                        DataValueField="ProductID"
                                                        ValidationGroup="vgtrainingrecord"
                                                        Width="99%">
                                                    </asp:DropDownList>

                                                    <asp:CustomValidator
                                                        ID="cvProduct"
                                                        runat="server"
                                                        ClientValidationFunction="requiredFamily"
                                                        ControlToValidate="ddlProduct"
                                                        ErrorMessage="Please select a specific family."
                                                        ValidationGroup="vgtrainingrecord"
                                                        Display="Dynamic" />
                                                </td>
                                            </tr>

                                            <%-- Cert Date --%>
                                            <tr>
                                                <td>
                                                    <asp:Label
                                                        ID="Label10"
                                                        runat="server"
                                                        Text="Cert Date" />

                                                    <asp:RequiredFieldValidator
                                                        ID="rfvCertDate"
                                                        runat="server"
                                                        ControlToValidate="txtCertDate"
                                                        ErrorMessage="Cert Date is required."
                                                        ToolTip="Cert Date is required."
                                                        ValidationGroup="vgtrainingrecord">(*)</asp:RequiredFieldValidator>
                                                </td>

                                                <td style="white-space: nowrap;">
                                                    <asp:TextBox
                                                        ID="txtCertDate"
                                                        runat="server"
                                                        Width="80px" />

                                                    <img
                                                        id="imgCertDate"
                                                        runat="server"
                                                        class="dateselected"
                                                        src="../Images/icon-calendar.gif"
                                                        alt="" />

                                                    <ajaxToolkit:CalendarExtender
                                                        ID="ceCertDate"
                                                        runat="server"
                                                        CssClass="MyCalendar"
                                                        Enabled="True"
                                                        Format="MM/dd/yyyy"
                                                        PopupButtonID="imgCertDate"
                                                        TargetControlID="txtCertDate">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>

                                                <%-- Exp Date --%>
                                                <td style="width: 10%;">
                                                    <asp:Label
                                                        ID="Label9"
                                                        runat="server"
                                                        Text="Exp Date" />

                                                    <%-- <asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator3"
                                                        runat="server"
                                                        ControlToValidate="txtExpDate"
                                                        ErrorMessage="Exp Date is required."
                                                        ToolTip="Exp Date is required."
                                                        ValidationGroup="vgtrainingrecord">(*)</asp:RequiredFieldValidator>--%>
                                                </td>

                                                <td style="width: 15%;">
                                                    <asp:TextBox
                                                        ID="txtExpDate"
                                                        runat="server"
                                                        Width="80px" />

                                                    <img
                                                        id="imgExpDate"
                                                        runat="server"
                                                        class="dateselected"
                                                        src="../Images/icon-calendar.gif"
                                                        alt="" />

                                                    <ajaxToolkit:CalendarExtender
                                                        ID="ceExpDate"
                                                        runat="server"
                                                        CssClass="MyCalendar"
                                                        Enabled="True"
                                                        Format="MM/dd/yyyy"
                                                        PopupButtonID="imgExpDate"
                                                        TargetControlID="txtExpDate">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>

                                                <%-- Score --%>
                                                <td>
                                                    <asp:Label
                                                        ID="Label19"
                                                        runat="server"
                                                        Text="Score" />

                                                    <asp:RequiredFieldValidator
                                                        ID="rfvScore"
                                                        runat="server"
                                                        ControlToValidate="txtScore"
                                                        Display="Dynamic"
                                                        ErrorMessage="Score is required."
                                                        ToolTip="Score is required."
                                                        ValidationGroup="vgtrainingrecord">(*)</asp:RequiredFieldValidator>

                                                    <%--<asp:CompareValidator
                                                        ID="cvScore"
                                                        runat="server"
                                                        ControlToValidate="txtScore"
                                                        Operator="LessThanEqual"
                                                        ValueToCompare="100"
                                                        Type="Double"
                                                        ToolTip="Score must be greater than or equal 0 and less than or equal 100" ValidationGroup="vgtrainingrecord"
                                                        Display="Dynamic" Text="(*)" ForeColor="Red" />--%>
                                                </td>

                                                <td>
                                                    <asp:TextBox
                                                        ID="txtScore"
                                                        runat="server"
                                                        Width="99%"
                                                        CssClass="positivenumber" />
                                                </td>
                                                <td>
                                                    <%--<asp:Label
                                                        ID="Label6"
                                                        runat="server"
                                                        Text="Certified Level" />

                                                    <asp:CustomValidator
                                                        ID="CustomValidator2"
                                                        runat="server"
                                                        ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCertifiedLevel"
                                                        ErrorMessage="Certified Level is required."
                                                        ValidationGroup="vgtrainingrecord">(*)</asp:CustomValidator>--%>
                                                </td>
                                                <td>
                                                    <%--<asp:DropDownList
                                                        ID="ddlCertifiedLevel"
                                                        Width="99%" runat="server"
                                                        AutoPostBack="false"
                                                        DataTextField="CertifiedLevelName"
                                                        DataValueField="CertifiedLevelID" />--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <%-- Trainer --%>
                                                <td>
                                                    <asp:Label
                                                        ID="Label8"
                                                        runat="server"
                                                        Text="Trainer" />

                                                    <asp:RequiredFieldValidator
                                                        ID="rfvTrainer"
                                                        runat="server"
                                                        ControlToValidate="txtTrainer"
                                                        ErrorMessage="Trainer is required."
                                                        ToolTip="Trainer is required."
                                                        ValidationGroup="vgtrainingrecord">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txtTrainer"
                                                        runat="server"
                                                        Width="99%" />
                                                </td>
                                                <td></td>

                                                <%-- OJT --%>
                                                <td>
                                                    <asp:CheckBox
                                                        ID="cbOJT"
                                                        runat="server"
                                                        Text="OJT"
                                                        Checked="False"
                                                        onclick="return LoadScore(this);" />
                                                </td>

                                                <%-- Active --%>
                                                <td>
                                                    <asp:Label
                                                        ID="Label21"
                                                        runat="server"
                                                        Text="Active" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox
                                                        ID="cbIsActive_TR"
                                                        runat="server"
                                                        Checked="True"
                                                        onclick="return CheckValidation(this);" />
                                                </td>

                                                <%-- Comments --%>
                                                <td>
                                                    <asp:Label
                                                        ID="Label6"
                                                        runat="server"
                                                        Text="Comments" />

                                                    <asp:RequiredFieldValidator
                                                        ID="rfvComments"
                                                        runat="server"
                                                        ControlToValidate="txtComments"
                                                        Enabled="false"
                                                        ErrorMessage="Comments is required."
                                                        ToolTip="Comments is required."
                                                        ValidationGroup="vgtrainingrecord"
                                                        Text="(*)" />
                                                </td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txtComments"
                                                        runat="server"
                                                        Width="99%" />
                                                </td>
                                            </tr>

                                            <%-- Commands: Save, Delete, Cancel --%>
                                            <tr>
                                                <td style="white-space: nowrap;" colspan="8">
                                                    <asp:Button
                                                        ID="btnSave"
                                                        runat="server"
                                                        Text="Save"
                                                        CssClass="button"
                                                        ValidationGroup="vgtrainingrecord"
                                                        UseSubmitBehavior="False"
                                                        OnClientClick="return UpdateTrainingRecordValidation();" />

                                                    <asp:Button
                                                        ID="btnDelete"
                                                        runat="server"
                                                        Text="Delete"
                                                        CssClass="button"
                                                        Visible="false"
                                                        UseSubmitBehavior="False"
                                                        OnClientClick="return DeleteTrainingRecordValidation();" />

                                                    <asp:Button
                                                        ID="btnCancel"
                                                        runat="server"
                                                        CssClass="button"
                                                        OnClick="btnCancel_Click"
                                                        Text="Close"
                                                        UseSubmitBehavior="False" />

                                                    <asp:Label
                                                        ID="lblSave"
                                                        runat="server"
                                                        Text=""
                                                        CssClass="boldMsg" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </asp:Panel>
                            </td>
                        </tr>

                        <%-- Import --%>
                        <tr>
                            <td>
                                <asp:Panel ID="pnImport" runat="server" Visible="false">
                                    <table>
                                        <tr>
                                            <td>
                                                <fieldset>
                                                    <legend>Upload</legend>
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <%-- Select file --%>
                                                                <td style="width: 10%">
                                                                    <asp:Label
                                                                        ID="Upload"
                                                                        runat="server"
                                                                        Text="Select file" />

                                                                    <asp:CustomValidator
                                                                        ID="cvFile"
                                                                        runat="server"
                                                                        ValidationGroup="vgpreviewtrainingrecord"
                                                                        ClientValidationFunction="cvFile_ClientValidate"
                                                                        ErrorMessage="Select file" />
                                                                </td>
                                                                <td>
                                                                    <ajaxToolkit:AsyncFileUpload
                                                                        ID="AsyncFUTrainingRecord"
                                                                        runat="server"
                                                                        CssClass="FileUploadClass"
                                                                        Width="400px"
                                                                        OnClientUploadStarted="uploadStart"
                                                                        OnClientUploadComplete="uploadComplete"
                                                                        OnClientUploadError="uploadError"
                                                                        ThrobberID="myThrobber"
                                                                        OnUploadedComplete="AsyncFUTrainingRecord_UploadedComplete"
                                                                        FailedValidation="False" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label
                                                                        ID="myThrobber"
                                                                        runat="server"
                                                                        Style="display: none">
                                                                        <img
                                                                            src="../Images/indicator.gif"
                                                                            style="text-align:center"
                                                                            alt="loading" />
                                                                    </asp:Label>
                                                                </td>

                                                                <td style="white-space: nowrap;">
                                                                    <%-- Preview button --%>
                                                                    <asp:Button
                                                                        ID="btnPreview"
                                                                        runat="server"
                                                                        CssClass="button"
                                                                        ValidationGroup="vgpreviewtrainingrecord"
                                                                        Text="Preview"
                                                                        OnClick="btnPreview_Click" />

                                                                    <%-- Cancel button --%>
                                                                    <asp:Button ID="btnCancel2"
                                                                        runat="server"
                                                                        CssClass="button"
                                                                        OnClick="btnCancel_Click"
                                                                        Text="Close"
                                                                        UseSubmitBehavior="False" />
                                                                </td>

                                                                <%-- Template --%>
                                                                <td>
                                                                    <asp:HyperLink
                                                                        ID="hlEmployeeTemplate"
                                                                        runat="server"
                                                                        NavigateUrl="../Templates/TrainingRecord.xlsx"
                                                                        Text="Template" />
                                                                </td>
                                                            </tr>

                                                            <%-- Upload status --%>
                                                            <tr>
                                                                <td colspan="5">
                                                                    <asp:Label
                                                                        ID="lblUploadStatus"
                                                                        runat="server"
                                                                        CssClass="error" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView
                                                    ID="grvTrainingRecordTemp"
                                                    runat="server"
                                                    AllowPaging="True"
                                                    AllowSorting="True"
                                                    AutoGenerateColumns="False"
                                                    PageSize="20"
                                                    OnPageIndexChanging="grvTrainingRecordTemp_PageIndexChanging"
                                                    OnSorting="grvTrainingRecordTemp_Sorting"
                                                    CssClass="gridview"
                                                    PagerStyle-CssClass="pgr"
                                                    EditRowStyle-CssClass="editing"
                                                    SelectedRowStyle-CssClass="selected"
                                                    HeaderStyle-CssClass="header"
                                                    FooterStyle-CssClass="footer"
                                                    AlternatingRowStyle-CssClass="alternate"
                                                    RowStyle-CssClass="normal" >
                                                    <PagerSettings Mode="NumericFirstLast" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="No.">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField
                                                            DataField="EmployeeID"
                                                            HeaderText="Employee ID"
                                                            SortExpression="EmployeeID" />
                                                        <asp:BoundField
                                                            DataField="EmployeeName"
                                                            HeaderText="Employee Name"
                                                            SortExpression="EmployeeName" />
                                                       
                                                        <asp:BoundField
                                                            DataField="TrainingGroupName"
                                                            HeaderText="Training Group"
                                                            SortExpression="TrainingGroupName" />
                                                        
                                                        <asp:BoundField
                                                            DataField="CourseGroupName"
                                                            HeaderText="Course Group"
                                                            SortExpression="CourseGroupName" />
                                                        <asp:BoundField
                                                            DataField="CourseName"
                                                            HeaderText="Course Name"
                                                            SortExpression="CourseName" />
                                                        <%-- Family go here --%>
                                                         <asp:BoundField
                                                            DataField="ProductName"
                                                            HeaderText="Family"
                                                            SortExpression="ProductName" />
                                                        <asp:BoundField
                                                            DataField="CertDate"
                                                            HeaderText="Certificate Date"
                                                            DataFormatString="{0:MM/dd/yyyy}"
                                                            SortExpression="CertDate" />
                                                        <asp:BoundField
                                                            DataField="Score"
                                                            HeaderText="Score"
                                                            SortExpression="Score"
                                                            ItemStyle-CssClass="right" />
                                                        <%--<asp:BoundField
                                                            DataField="CertifiedLevelName"
                                                            HeaderText="Certified Level"
                                                            SortExpression="CertifiedLevelName" />--%>
                                                        <asp:BoundField
                                                            DataField="Trainer"
                                                            HeaderText="Trainer"
                                                            SortExpression="Trainer" />
                                                        <asp:CheckBoxField
                                                            DataField="OJT"
                                                            HeaderText="OJT"
                                                            SortExpression="OJT"
                                                            ItemStyle-CssClass="checkbox" />
                                                        <asp:BoundField
                                                            DataField="ExpDate"
                                                            HeaderText="Expired Date"
                                                            DataFormatString="{0:MM/dd/yyyy}"
                                                            SortExpression="ExpDate" />
                                                        <asp:CheckBoxField
                                                            DataField="IsActive"
                                                            HeaderText="Active"
                                                            SortExpression="IsActive"
                                                            ItemStyle-CssClass="checkbox" />
                                                        <asp:BoundField
                                                            DataField="Comments"
                                                            HeaderText="Comments"
                                                            SortExpression="Comments" />
                                                        <asp:CheckBoxField
                                                            DataField="IsValid"
                                                            HeaderText="Valid"
                                                            SortExpression="IsValid"
                                                            ItemStyle-CssClass="checkbox" />

                                                        <asp:BoundField
                                                            DataField="ErrorMessage"
                                                            HeaderText="Error Message"
                                                            SortExpression="ErrorMessage" />
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td style="width: 10%">
                                                            <asp:Button
                                                                ID="btnUploadAsk"
                                                                runat="server"
                                                                Text="Upload"
                                                                CssClass="button"
                                                                OnClientClick="return UploadTrainingRecordValidation();" />
                                                        </td>
                                                        <td>
                                                            <asp:Label
                                                                ID="lblUpload"
                                                                runat="server"
                                                                Text=""
                                                                CssClass="boldMsg" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>

                        <%-- Confirmations --%>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender
                                    ID="mpeConfirmApply"
                                    runat="server"
                                    TargetControlID="lblApplyControl"
                                    BackgroundCssClass="modalBackgroundConfirm"
                                    CancelControlID="btnCancelApply"
                                    PopupControlID="PanelConfirmApply"
                                    BehaviorID="bhmpeConfirmApply">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmApply" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" align="center" colspan="2">
                                                    <asp:Label
                                                        ID="lblApplyHeader"
                                                        runat="server"
                                                        Text="Apply Training Record Confirmation" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="" />
                                                </td>
                                                <td>
                                                    <asp:Label
                                                        ID="lblApplyMessage"
                                                        runat="server"
                                                        Text="Are you sure you want to apply this training record?" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:Button
                                                        ID="cfmbApply"
                                                        runat="server"
                                                        Text="OK"
                                                        CssClass="button"
                                                        OnClick="cfmbApply_ClickOk" />
                                                    <asp:Button
                                                        ID="btnCancelApply"
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
                                    ID="mpeConfirmUpload"
                                    runat="server"
                                    BackgroundCssClass="modalBackgroundConfirm"
                                    BehaviorID="bhmpeConfirmUpload"
                                    CancelControlID="btnCancelUpload"
                                    PopupControlID="PanelConfirmUpload"
                                    TargetControlID="lblUploadControl">
                                </ajaxToolkit:ModalPopupExtender>

                                <asp:Panel ID="PanelConfirmUpload" runat="server" CssClass="modalPopupConfirm" Style="display: none">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td align="center" class="confirmheader" colspan="2">
                                                    <asp:Label
                                                        ID="Label43"
                                                        runat="server"
                                                        Text="Upload Training Record Confirmation" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img
                                                        style="width: 45px; height: 45px"
                                                        src="../Images/question.png
                                                        "
                                                        alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label
                                                        ID="lblConfirmUpload"
                                                        runat="server"
                                                        Text="Are you sure you want to upload record(s) from excel file?" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:Button
                                                        ID="btnUpload"
                                                        runat="server"
                                                        CssClass="button"
                                                        OnClick="btnUpload_Click"
                                                        UseSubmitBehavior="false"
                                                        Text="OK" />
                                                    <asp:Button
                                                        ID="btnCancelUpload"
                                                        runat="server"
                                                        CssClass="button"
                                                        OnClientClick="return false;"
                                                        Text="Cancel" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>

                                <ajaxToolkit:ModalPopupExtender
                                    ID="mpeProcessing"
                                    runat="server"
                                    BackgroundCssClass="modalBackgroundProcessing"
                                    BehaviorID="bhmpeProcessing"
                                    DropShadow="false"
                                    Enabled="True"
                                    PopupControlID="PanelProcessing"
                                    TargetControlID="lblProcessingControl">
                                </ajaxToolkit:ModalPopupExtender>

                                <asp:Panel ID="PanelProcessing" runat="server" CssClass="modalPopupProcessing" Style="display: none">
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
                                    <asp:Label ID="lblUploadControl" runat="server"></asp:Label>
                                    <asp:Label ID="lblApplyControl" runat="server"></asp:Label>
                                    <asp:HiddenField ID="hdAdminPermission" runat="server" Value="0"/>
                                    <asp:HiddenField ID="hdUploadFileName" runat="server" />
                                    <asp:HiddenField ID="hdEmployeeID_ID" runat="server" />
                                    <asp:HiddenField ID="hdApplyKindID" runat="server" />
                                    <asp:HiddenField ID="hdTrainingRecordID" runat="server" Value="0" />
                                    <%--<asp:HiddenField ID="hdAction" runat="server" />--%>
                                    <asp:HiddenField ID="hdMenuID" runat="server" Value="0" />
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
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
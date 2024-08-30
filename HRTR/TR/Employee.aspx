<%@ Page Title="Employee List" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="Employee.aspx.cs" Inherits="HRTR.TR.Employee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Employee List
        </div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Employee.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <asp:LinkButton ID="lbSearch" runat="server" CssClass="multiviewtabactive" OnCommand="mvEmployee_Command"
                                    CommandName="Search">Search</asp:LinkButton>
                                <asp:LinkButton ID="lbImport" runat="server" CssClass="multiviewtabinactive" OnCommand="mvEmployee_Command"
                                    CommandName="Import">Import Employee From Excel File</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:MultiView ID="mvEmployee" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="vSearchEmp" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                    <fieldset>
                                                        <legend>Search</legend>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <td style="width: 9%">
                                                                        <asp:Label ID="Label3" runat="server" Text="Employee ID"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 15%">
                                                                        <asp:TextBox ID="txtEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 9%">
                                                                        <asp:Label ID="Label4" runat="server" Text="Employee ID SAP"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 15%">
                                                                        <asp:TextBox ID="txtEmployeeIDSAPS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 9%">
                                                                        <asp:Label ID="Label49" runat="server" Text="User Name"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 15%">
                                                                        <asp:TextBox ID="txtUserNameS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 9%">
                                                                        <asp:Label ID="Label2" runat="server" Text="Employee Name"></asp:Label>
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <asp:TextBox ID="txtEmployeeNameS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label46" runat="server" Text="Operator Group"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlOperatorGroupS" runat="server" AppendDataBoundItems="True"
                                                                            DataTextField="OperatorGroupName" DataValueField="OperatorGroupID" Width="99%">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label5" runat="server" Text="Company"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlCompanyS" runat="server" AppendDataBoundItems="True" DataTextField="CompanyName"
                                                                            DataValueField="CompanyID" Width="99%">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label10" runat="server" Text="Department"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlDepartmentS" runat="server" AppendDataBoundItems="True"
                                                                            DataTextField="DepartmentName" DataValueField="DepartmentID" Width="99%">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label6" runat="server" Text="Job Title"></asp:Label>
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <asp:TextBox ID="txtJobTitleS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label8" runat="server" Text="Position"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlPositionS" runat="server" AppendDataBoundItems="True" DataTextField="PositionName"
                                                                            DataValueField="PositionID" Width="99%">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label36" runat="server" Text="Workcell"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlWorkcellS" runat="server" AppendDataBoundItems="True" DataTextField="WorkcellName"
                                                                            DataValueField="WorkcellID" Width="99%">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label18" runat="server" Text="Line Leader"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtSupervisorS" runat="server" Width="99%"></asp:TextBox>
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
                                                                    <td>
                                                                        <asp:Label ID="Label15" runat="server" Text="Supervisor"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlIsSupervisorS" runat="server" AppendDataBoundItems="True"
                                                                            Width="50px">
                                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label52" runat="server" Text="WD No."></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtWDNoS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label51" runat="server" Text="Joined Date"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtJoinedDateS" runat="server" Width="80px"></asp:TextBox>
                                                                        <img id="imgJoinedDateS" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                                            alt="" />
                                                                        <ajaxToolkit:CalendarExtender ID="ceJoinedDateS" runat="server" CssClass="MyCalendar"
                                                                            TargetControlID="txtJoinedDateS" Enabled="True" PopupButtonID="imgJoinedDateS"
                                                                            Format="MM/dd/yyyy">
                                                                        </ajaxToolkit:CalendarExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label7" runat="server" Text="Working Status"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlWorkingStatusS" runat="server" AppendDataBoundItems="True"
                                                                            DataTextField="WorkingStatusName" DataValueField="WorkingStatusID" Width="99%">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label9" runat="server" Text="Working"></asp:Label>
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <asp:DropDownList ID="ddlIsWorkingS" runat="server" AppendDataBoundItems="True" Width="50px">
                                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="10" style="white-space: nowrap;">
                                                                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                                            CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                                        <asp:Button ID="btnExport" OnClick="btnExport_Click" runat="server" Text="Export"
                                                                            CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                                        <asp:Label ID="lblEmployee" runat="server" Text=""></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnNewEmployee" runat="server" CssClass="button" OnClientClick="return NewEmployee();"
                                                        Text="New" UseSubmitBehavior="False" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grvEmployeeList" runat="server" AllowPaging="True" AllowSorting="True"
                                                        PageSize="20" AutoGenerateColumns="False" DataKeyNames="EmployeeID_ID" OnPageIndexChanging="grvEmployeeList_PageIndexChanging"
                                                        OnRowCommand="grvEmployeeList_RowCommand" OnRowDataBound="grvEmployeeList_RowDataBound"
                                                        OnSorting="grvEmployeeList_Sorting" CssClass="gridview" PagerStyle-CssClass="pgr"
                                                        EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                                        FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal">
                                                        <PagerSettings Mode="NumericFirstLast" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="No.">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID" />
                                                            <asp:BoundField DataField="WDNo" HeaderText="WD No." SortExpression="WDNo" />
                                                            <asp:BoundField DataField="EmployeeIDSAP" HeaderText="Employee ID SAP" SortExpression="EmployeeIDSAP" />
                                                            <asp:BoundField DataField="UserName" HeaderText="User Name (NTID)" SortExpression="UserName" />
                                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                                            <asp:BoundField DataField="OperatorGroupName" HeaderText="Operator Group" SortExpression="OperatorGroupName" />
                                                            <asp:BoundField DataField="CompanyName" HeaderText="Company" SortExpression="CompanyName" />
                                                            <asp:BoundField DataField="DepartmentName" HeaderText="Department" SortExpression="DepartmentName" />
                                                            <asp:BoundField DataField="JobTitle" HeaderText="Job Title" SortExpression="JobTitle" />
                                                            <asp:BoundField DataField="PositionName" HeaderText="Position" SortExpression="PositionName" />
                                                            <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName" />
                                                            <asp:BoundField DataField="Supervisor" HeaderText="Line Leader" SortExpression="Supervisor" />
                                                            <asp:BoundField DataField="JoinedDate" HeaderText="Joined Date" SortExpression="JoinedDate"
                                                                DataFormatString="{0:MM/dd/yyyy}" />
                                                            <asp:BoundField DataField="WorkingStatusName" HeaderText="Working Status" SortExpression="WorkingStatusName" />
                                                            <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                                                                <ItemStyle CssClass="checkbox" />
                                                            </asp:CheckBoxField>
                                                            <asp:CheckBoxField DataField="IsSupervisor" HeaderText="Supervisor" SortExpression="IsSupervisor">
                                                                <ItemStyle CssClass="checkbox" />
                                                            </asp:CheckBoxField>
                                                            <asp:BoundField DataField="LastUpdatedByUserName" HeaderText="Last Updated By" SortExpression="LastUpdatedByUserName" />
                                                            <asp:BoundField DataField="LastUpdated" HeaderText="Last Updated" SortExpression="LastUpdated" />
                                                            <asp:TemplateField HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                                        CssClass="ContextMenuTarget" />
                                                                    <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none; visibility: hidden;">
                                                                        <asp:LinkButton ID="lbEdit" runat="server" CausesValidation="False" CommandArgument='<%# Eval("EmployeeID_ID")%>'
                                                                            CommandName="Select" Text="Edit" CssClass="ContextMenuItem"></asp:LinkButton>
                                                                        <asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("EmployeeID_ID")%>'
                                                                            CommandName="Del" Text="Delete" CssClass="ContextMenuItem"></asp:LinkButton>
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
                                        </table>
                                    </asp:View>
                                    <asp:View ID="vUploadEmployee" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                    <fieldset>
                                                        <legend>Upload</legend>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <td style="width: 10%">
                                                                        <asp:Label ID="Upload" runat="server" Text="Select file"></asp:Label>
                                                                        <asp:CustomValidator ID="cvFile" runat="server" ValidationGroup="vgpreviewpart" ClientValidationFunction="cvFile_ClientValidate"
                                                                            ErrorMessage="Select file">(*)</asp:CustomValidator>
                                                                    </td>
                                                                    <td>
                                                                        <ajaxToolkit:AsyncFileUpload ID="AsyncFUEmployee" runat="server" CssClass="FileUploadClass"
                                                                            Width="400px" OnClientUploadStarted="uploadStart" OnClientUploadComplete="uploadComplete"
                                                                            OnClientUploadError="uploadError" ThrobberID="myThrobber" OnUploadedComplete="AsyncFUEmployee_UploadedComplete"
                                                                            FailedValidation="False"></ajaxToolkit:AsyncFileUpload>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="myThrobber" runat="server" Style="display: none">
                                                                            <img src="../Images/indicator.gif" Style="text-align:center" alt="Loading" />
                                                                        </asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnPreview" runat="server" CssClass="button" ValidationGroup="vgpreviewpart"
                                                                            Text="Preview" OnClick="btnPreview_Click" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:HyperLink ID="hlEmployeeTemplate" runat="server" NavigateUrl="../Templates/Employee.xlsx">Employee Template</asp:HyperLink>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="5">
                                                                        <asp:Label ID="lblUploadStatus" runat="server" CssClass="errorMsg"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grvEmployeeTempList" runat="server" AllowPaging="True" AllowSorting="True"
                                                        AutoGenerateColumns="False" PageSize="30" OnPageIndexChanging="grvEmployeeTempList_PageIndexChanging"
                                                        OnSorting="grvEmployeeTempList_Sorting" CssClass="gridview" PagerStyle-CssClass="pgr"
                                                        EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                                        FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal">
                                                        <PagerSettings Mode="NumericFirstLast" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="No.">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="Employee" />
                                                            <asp:BoundField DataField="EmployeeIDSAP" HeaderText="Employee ID SAP" SortExpression="EmployeeIDSAP" />
                                                            <asp:BoundField DataField="UserName" HeaderText="User Name (NTID)" SortExpression="UserName" />
                                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                                            <asp:BoundField DataField="OperatorGroupName" HeaderText="Operator Group" SortExpression="OperatorGroupName" />
                                                            <asp:BoundField DataField="CompanyName" HeaderText="Company" SortExpression="CompanyName" />
                                                            <asp:BoundField DataField="DepartmentName" HeaderText="Department" SortExpression="DepartmentName" />
                                                            <asp:BoundField DataField="JobTitle" HeaderText="Job Title" SortExpression="JobTitle" />
                                                            <asp:BoundField DataField="PositionName" HeaderText="Position" SortExpression="PositionName" />
                                                            <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName" />
                                                            <asp:BoundField DataField="Supervisor" HeaderText="Line Leader" SortExpression="Supervisor" />
                                                            <asp:BoundField DataField="WorkingStatusName" HeaderText="Working Status" SortExpression="WorkingStatusName" />
                                                            <asp:BoundField DataField="JoinedDate" HeaderText="Joined Date" SortExpression="JoinedDate"
                                                                DataFormatString="{0:MM/dd/yyyy}" />
                                                            <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                                                                <ItemStyle CssClass="checkbox" />
                                                            </asp:CheckBoxField>
                                                            <asp:CheckBoxField DataField="IsValid" HeaderText="Valid" SortExpression="IsValid">
                                                                <ItemStyle CssClass="checkbox" />
                                                            </asp:CheckBoxField>
                                                            <asp:BoundField DataField="ErrorMessage" HeaderText="Error Message" SortExpression="ErrorMessage" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 10%">
                                                                <asp:Button ID="btnUploadAsk" runat="server" Text="Upload" CssClass="button" OnClientClick="return EmployeeUploadValidation();" Visible="false"></asp:Button>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblUpload" runat="server" Text="" CssClass="boldMsg"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                </asp:MultiView>
                                <tr>
                                    <td>
                                        <ajaxToolkit:ModalPopupExtender ID="mpeEmployee" runat="server" TargetControlID="btnNewEmployee"
                                            PopupControlID="pnEmployeePopup" BackgroundCssClass="modalBackgroundCommon" CancelControlID="btnCancelEmployee"
                                            DropShadow="false" PopupDragHandleControlID="pnEmployeePopupDrag" BehaviorID="bhvmpeEmployee">
                                        </ajaxToolkit:ModalPopupExtender>
                                        <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 800px;" ID="pnEmployeePopup"
                                            runat="server">
                                            <asp:Panel class="modalPopupDrag" ID="pnEmployeePopupDrag" runat="server">
                                                <div>
                                                    <p>
                                                        Add/ Update/ Delete Employee
                                                    </p>
                                                </div>
                                            </asp:Panel>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label17" runat="server">Employee ID</asp:Label>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmployeeID"
                                                                ErrorMessage="Employee ID is required." ToolTip="Employee ID is required." ValidationGroup="vgemployee">(*)</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td style="width: 35%">
                                                            <asp:TextBox ID="txtEmployeeID" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 5%"></td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label47" runat="server">User Name</asp:Label>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtUserName"
                                                                ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="vgemployee">(*)</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtUserName" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label1" runat="server">Employee ID SAP</asp:Label>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmployeeIDSAP"
                                                                ErrorMessage="Employee ID SAP is required." ToolTip="Employee ID SAP is required."
                                                                ValidationGroup="vgemployee">(*)</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmployeeIDSAP" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="EmailLabelAdd" runat="server">Employee Name</asp:Label>
                                                            <asp:RequiredFieldValidator ID="vfrEmployeeIDA" runat="server" ControlToValidate="txtEmployeeName"
                                                                ErrorMessage="Employee Name is required." ToolTip="Employee Name is required."
                                                                ValidationGroup="vgemployee">(*)</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmployeeName" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label50" runat="server" Text="Operator Group"></asp:Label>
                                                            <asp:CustomValidator ID="cvOperatorGroup" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                                ControlToValidate="ddlOperatorGroup" ErrorMessage="Operator Group is required."
                                                                ValidationGroup="vgemployee">(*)</asp:CustomValidator>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlOperatorGroup" runat="server" AppendDataBoundItems="True"
                                                                DataTextField="OperatorGroupName" DataValueField="OperatorGroupID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label19" runat="server" Text="Company"></asp:Label>
                                                            <asp:CustomValidator ID="cvCompany" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                                ControlToValidate="ddlCompany" ErrorMessage="Company is required." ValidationGroup="vgemployee">(*)</asp:CustomValidator>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlCompany" runat="server" AppendDataBoundItems="True" DataTextField="CompanyName"
                                                                DataValueField="CompanyID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label14" runat="server" Text="Department"></asp:Label>
                                                            <asp:CustomValidator ID="cvDepartment" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                                ControlToValidate="ddlDepartment" ErrorMessage="Department is required." ValidationGroup="vgemployee">(*)</asp:CustomValidator>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlDepartment" runat="server" AppendDataBoundItems="True" DataTextField="DepartmentName"
                                                                DataValueField="DepartmentID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label20" runat="server">Job Title</asp:Label>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtJobTitle"
                                                                ErrorMessage="Job title is required." ToolTip="Job title is required." ValidationGroup="vgemployee">(*)</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtJobTitle" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label21" runat="server" Text="Position"></asp:Label>
                                                            <asp:CustomValidator ID="cvPosition" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                                ControlToValidate="ddlPosition" ErrorMessage="Position is required." ValidationGroup="vgemployee">(*)</asp:CustomValidator>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlPosition" runat="server" AppendDataBoundItems="True" DataTextField="PositionName"
                                                                DataValueField="PositionID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label38" runat="server" Text="Workcell"></asp:Label>
                                                            <asp:CustomValidator ID="cvWorkcell" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                                ControlToValidate="ddlWorkcell" ErrorMessage="Workcell is required." ValidationGroup="vgemployee">(*)</asp:CustomValidator>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlWorkcell" runat="server" AppendDataBoundItems="True" DataTextField="WorkcellName"
                                                                DataValueField="WorkcellID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label23" runat="server">Line Leader</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSupervisor" runat="server" Width="99%"></asp:TextBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label40" runat="server">Joined Date</asp:Label>
                                                            <asp:RequiredFieldValidator ID="rfvJoinedDate" runat="server" ControlToValidate="txtJoinedDate"
                                                                ErrorMessage="Joined Date is required." ToolTip="Joined Date is required." ValidationGroup="vgemployee">(*)</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtJoinedDate" runat="server" Width="80px" Style="text-align: right;"></asp:TextBox>
                                                            <img id="imgJoinedDate" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                                alt="" />
                                                            <ajaxToolkit:CalendarExtender ID="cvJoinedDate" runat="server" CssClass="MyCalendar"
                                                                TargetControlID="txtJoinedDate" Enabled="True" PopupButtonID="imgJoinedDate"
                                                                Format="MM/dd/yyyy">
                                                            </ajaxToolkit:CalendarExtender>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label11" runat="server" Text="Working Status"></asp:Label>
                                                            <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                                ControlToValidate="ddlWorkingStatus" ErrorMessage="Working Status is required." ValidationGroup="vgemployee">(*)</asp:CustomValidator>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlWorkingStatus" runat="server" AppendDataBoundItems="True" DataTextField="WorkingStatusName"
                                                                DataValueField="WorkingStatusID" Width="99%">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td>
                                                            <asp:CheckBox ID="cbIsActive" runat="server" Text="Active" Checked="true" />
                                                            <asp:CheckBox ID="cbIsSupervisor" runat="server" Text="Supervisor" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5" style="text-align: center;">
                                                            <asp:Label ID="lblEmployeeMessage" runat="server" CssClass="errorMsg">
                                                            </asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center;" colspan="5">
                                                            <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" UseSubmitBehavior="False"
                                                                CssClass="button" Text="Save" ValidationGroup="vgemployee"></asp:Button>
                                                            <asp:Button ID="btnUpdateAsk" runat="server" Text="Update" CssClass="button" UseSubmitBehavior="False"
                                                                ValidationGroup="vgemployee" OnClientClick="return EmployeeUpdateValidation();"></asp:Button>
                                                            <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                                Text="Delete" UseSubmitBehavior="False" />
                                                            <asp:Button ID="btnCancelEmployee" runat="server" UseSubmitBehavior="False" CssClass="button"
                                                                Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                            PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate" TargetControlID="lblUpdateControl"
                                            CancelControlID="btnCancelUpdate">
                                        </ajaxToolkit:ModalPopupExtender>
                                        <asp:Panel Style="display: none" ID="PanelConfirmUpdate" runat="server" CssClass="modalPopupConfirm">
                                            <table class="questiontable">
                                                <tbody>
                                                    <tr>
                                                        <td align="center" class="confirmheader" colspan="2">
                                                            <asp:Label ID="lblCaptionC" runat="server">Update Employee Confirmation</asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <img src="../Images/question.png" alt="" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this employee?"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="text-align: center; white-space: nowrap;">

                                                            <asp:Button ID="btnUpdate" runat="server" CssClass="button" OnClick="btnUpdate_Click"
                                                                Text="OK" />

                                                            <asp:Button ID="btnCancelUpdate" runat="server" CssClass="button" OnClientClick="return false;"
                                                                Text="Cancel" />

                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </asp:Panel>

                                        <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpload" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                            BehaviorID="bhmpeConfirmUpload" CancelControlID="btnCancelUpload" PopupControlID="PanelConfirmUpload"
                                            TargetControlID="lblUploadControl">
                                        </ajaxToolkit:ModalPopupExtender>
                                        <asp:Panel ID="PanelConfirmUpload" runat="server" CssClass="modalPopupConfirm" Style="display: none">
                                            <table class="questiontable">
                                                <tbody>
                                                    <tr>
                                                        <td align="center" class="confirmheader" colspan="2">
                                                            <asp:Label ID="Label43" runat="server">Upload Employee Confirmation</asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <img src="../Images/question.png" alt="?" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblConfirmUpload" runat="server" Text="Are you sure you want to upload employee(s) from excel file?"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="text-align: center; white-space: nowrap;">

                                                            <asp:Button ID="btnUpload" runat="server" CssClass="button" OnClick="btnUpload_Click"
                                                                UseSubmitBehavior="false" Text="OK" />

                                                            <asp:Button ID="btnCancelUpload" runat="server" CssClass="button" OnClientClick="return false;"
                                                                Text="Cancel" />

                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </asp:Panel>

                                        <ajaxToolkit:ModalPopupExtender ID="mpeProcessing" runat="server" BackgroundCssClass="modalBackgroundProcessing"
                                            BehaviorID="bhmpeProcessing" DropShadow="false" Enabled="True" PopupControlID="PanelProcessing"
                                            TargetControlID="lblProcessingControl">
                                        </ajaxToolkit:ModalPopupExtender>
                                        <asp:Panel ID="PanelProcessing" runat="server" CssClass="modalPopupProcessing" Style="display: none">
                                            <table class="processingtable">
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <img src="../Images/updateprogress.gif" alt="..." />
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
                                            <asp:Label ID="lblUpdateControl" runat="server">
                                            </asp:Label>
                                            <asp:Label ID="lblProcessingControl" runat="server">
                                            </asp:Label>
                                            <asp:Label ID="lblUploadControl" runat="server">
                                            </asp:Label>
                                            <asp:HiddenField ID="hdEmployeeID_ID" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdUploadFileName" runat="server" />
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

<%@ Page Title="Training Employee Lock IL" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="TrainingEmpLock.aspx.cs" Inherits="HRTR.AutoLock.TrainingEmpLock" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Training Employee Lock IL
        </div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/TrainingEmpLock.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <asp:LinkButton ID="lbSearch" runat="server" CssClass="multiviewtabactive" OnCommand="mvTrainingEmpLock_Command"
                                    CommandName="Search">Search</asp:LinkButton>
                                <asp:LinkButton ID="lbImport" runat="server" CssClass="multiviewtabinactive" OnCommand="mvTrainingEmpLock_Command"
                                    CommandName="Import">Import From Excel File</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:MultiView ID="mvTrainingEmpLock" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="vSearchTrainingEmpLock" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                    <fieldset>
                                                        <legend>Search</legend>
                                                        <table class="tablesearch">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="width: 10%;">
                                                                        <asp:Label ID="Label3" runat="server" Text="Employee ID"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 15%;">
                                                                        <asp:TextBox ID="txtEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <asp:Label ID="Label6" runat="server" Text="Employee ID SAP"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 15%;">
                                                                        <asp:TextBox ID="txtEmployeeIDSAPS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <asp:Label ID="Label2" runat="server" Text="User Name"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 15%;">
                                                                        <asp:TextBox ID="txtUserNameS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <asp:Label ID="Label9" runat="server" Text="Employee Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtEmployeeNameS" runat="server" Width="99%" ></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label36" runat="server" Text="WD No."></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtWDNoS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label8" runat="server" Text="Code ID"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtTrainingCodeIDS" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label10" runat="server" Text="Due Date"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtDueDateS" runat="server" Width="80px"></asp:TextBox>
                                                                        <img id="img1" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                                            alt="" />
                                                                        <ajaxToolkit:CalendarExtender ID="caDueDateS" runat="server" CssClass="MyCalendar"
                                                                            TargetControlID="txtDueDateS" Enabled="True" PopupButtonID="imgDueDateS" Format="MM/dd/yyyy">
                                                                        </ajaxToolkit:CalendarExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label15" runat="server" Text="Extend Day"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtExtendDayS" runat="server" Text="0" Width="99%" CssClass="positivenumber"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label5" runat="server" Text="Complete Date"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtCompleteDateS" runat="server" Width="80px"></asp:TextBox>
                                                                        <img id="imgCompleteDateS" class="dateselected" src="../Images/icon-calendar.gif"
                                                                            runat="server" alt="" />
                                                                        <ajaxToolkit:CalendarExtender ID="caCompleteDateS" runat="server" CssClass="MyCalendar"
                                                                            TargetControlID="txtCompleteDateS" Enabled="True" PopupButtonID="imgCompleteDateS"
                                                                            Format="MM/dd/yyyy">
                                                                        </ajaxToolkit:CalendarExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label16" runat="server" Text="Active"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="50px">
                                                                            <asp:ListItem Value="-1">[All]</asp:ListItem>
                                                                            <asp:ListItem Value="1" Selected="True">Yes</asp:ListItem>
                                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td colspan="4">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="white-space: nowrap;" colspan="8">
                                                                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                                            CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                                        <asp:Button ID="btnExport" OnClick="btnExport_Click" runat="server" Text="Export"
                                                                            CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                                         <asp:Button ID="btnUpdateInactiveEmployeeCourses" OnClick="btnUpdateInactiveEmployeeCourses_Click" runat="server" Text="Remove"
                                                                            CssClass="button" UseSubmitBehavior="False" ToolTip="Remove training courses of inactivated/resigned employees"></asp:Button>
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
                                                    <asp:Button ID="btnNewTrainingEmpLock" runat="server" CssClass="button" OnClientClick="return NewTrainingEmpLock();"
                                                        Text="New" UseSubmitBehavior="False" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grvTrainingEmpLock" runat="server" AllowPaging="True" AllowSorting="True"
                                                        PageSize="20" AutoGenerateColumns="False" DataKeyNames="LockID" OnPageIndexChanging="grvTrainingEmpLock_PageIndexChanging"
                                                        OnRowCommand="grvTrainingEmpLock_RowCommand" OnRowDataBound="grvTrainingEmpLock_RowDataBound"
                                                        OnSorting="grvTrainingEmpLock_Sorting" CssClass="gridview" PagerStyle-CssClass="pgr"
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
                                                            <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID" />
                                                            <asp:BoundField DataField="WDNo" HeaderText="WD No." SortExpression="WDNo" />
                                                            <asp:BoundField DataField="EmployeeIDSAP" HeaderText="Employee ID SAP" SortExpression="EmployeeIDSAP" />
                                                            <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
                                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                                            <asp:BoundField DataField="TrainingCodeID" HeaderText="Code ID" SortExpression="TrainingCodeID" />
                                                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                                            <asp:BoundField DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate"
                                                                DataFormatString="{0:MM/dd/yyyy}" />
                                                            <asp:BoundField DataField="ExtendDay" HeaderText="Extend Day" SortExpression="ExtendDay" />
                                                            <asp:BoundField DataField="ExtendFromDate" HeaderText="Extend From Date" SortExpression="ExtendFromDate"
                                                                DataFormatString="{0:MM/dd/yyyy}" />
                                                            <asp:BoundField DataField="CompleteDate" HeaderText="Complete Date" SortExpression="CompleteDate"
                                                                DataFormatString="{0:MM/dd/yyyy}" />
                                                            <asp:BoundField DataField="LastUpdated" HeaderText="Last Updated" SortExpression="LastUpdated" />
                                                            <asp:BoundField DataField="LastUpdatedByFullName" HeaderText="Last Updated By" SortExpression="LastUpdatedByFullName" />
                                                            <asp:TemplateField HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                                        CssClass="ContextMenuTarget" />
                                                                    <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none; visibility: hidden;">
                                                                        <asp:LinkButton ID="lbEdit" runat="server" CausesValidation="False" CommandArgument='<%# Eval("LockID") %>'
                                                                            CommandName="Select" Text="Edit" CssClass="ContextMenuItem"></asp:LinkButton>
                                                                        <asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("LockID") %>'
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
                                    <asp:View ID="vUploadTrainingEmpLock" runat="server">
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
                                                                        <asp:CustomValidator ID="cvFile" runat="server" ValidationGroup="vgpreviewtrainingemplock"
                                                                            ClientValidationFunction="cvFile_ClientValidate" ErrorMessage="Select file">(*) Please select file!</asp:CustomValidator>
                                                                    </td>
                                                                    <td>
                                                                        <ajaxToolkit:AsyncFileUpload ID="AsyncFUTrainingEmpLock" runat="server" CssClass="FileUploadClass"
                                                                            Width="400px" OnClientUploadStarted="uploadStart" OnClientUploadComplete="uploadComplete"
                                                                            OnClientUploadError="uploadError" ThrobberID="myThrobber" OnUploadedComplete="AsyncFUTrainingEmpLock_UploadedComplete"
                                                                            FailedValidation="False"></ajaxToolkit:AsyncFileUpload>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="myThrobber" runat="server" Style="display: none">
                                                                            <img src="../Images/indicator.gif" style="text-align:center" alt="loading" />
                                                                        </asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnPreview" runat="server" CssClass="button" ValidationGroup="vgpreviewtrainingemplock"
                                                                            Text="Preview" OnClick="btnPreview_Click" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:HyperLink ID="hlEmployeeTemplate" runat="server" NavigateUrl="../Templates/TrainingEmpLockTemplate_v01.xlsx">Template</asp:HyperLink>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="5">
                                                                        <asp:Label ID="lblUploadStatus" runat="server" CssClass="error"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grvTrainingEmpLockTemp" runat="server" AllowPaging="True" AllowSorting="True"
                                                        AutoGenerateColumns="False" PageSize="30" OnPageIndexChanging="grvTrainingEmpLockTemp_PageIndexChanging"
                                                        OnSorting="grvTrainingEmpLockTemp_Sorting" CssClass="gridview" PagerStyle-CssClass="pgr"
                                                        DataKeyNames="UserName,TrainingCodeID" EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected"
                                                        HeaderStyle-CssClass="header" FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate"
                                                        RowStyle-CssClass="normal">
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
                                                            <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
                                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                                            <asp:BoundField DataField="TrainingCodeID" HeaderText="Code ID" SortExpression="TrainingCodeID" />
                                                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                                            <asp:BoundField DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate"
                                                                DataFormatString="{0:MM/dd/yyyy}" />
                                                            <asp:BoundField DataField="ExtendDay" HeaderText="Extend Day" SortExpression="ExtendDay" />
                                                            <asp:BoundField DataField="ExtendFromDate" HeaderText="Extend From Date" SortExpression="ExtendFromDate"
                                                                DataFormatString="{0:MM/dd/yyyy}" />
                                                            <asp:BoundField DataField="CompleteDate" HeaderText="Complete Date" SortExpression="CompleteDate"
                                                                DataFormatString="{0:MM/dd/yyyy}" />
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
                                                                <asp:Button ID="btnUploadAsk" runat="server" Text="Upload" CssClass="button" OnClientClick="return UploadTrainingEmpLockValidation();" Visible="false"></asp:Button>
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
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeTrainingEmpLock" runat="server" TargetControlID="btnNewTrainingEmpLock"
                                    PopupControlID="pnTrainingEmpLockPopup" BackgroundCssClass="modalBackgroundCommon"
                                    CancelControlID="btnCancelEmployee" DropShadow="false" PopupDragHandleControlID="pnTrainingEmpLockPopupDrag"
                                    BehaviorID="bhvmpeTrainingEmpLock" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 600px;" ID="pnTrainingEmpLockPopup"
                                    runat="server">
                                    <asp:Panel CssClass="modalPopupDrag" ID="pnEmployeePopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add/ Update/ Delete Training Emp Lock Record
                                            </p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label4" runat="server">Employee ID</asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmployeeID"
                                                        ErrorMessage="Employee ID is required." ToolTip="Employee ID is required." ValidationGroup="vgtrainingemplock">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeID" runat="server" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label26" runat="server">Employee ID SAP</asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEmployeeIDSAP"
                                                        ErrorMessage="Employee ID SAP is required." ToolTip="Employee ID SAP is required."
                                                        ValidationGroup="vgtrainingemplock">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeIDSAP" runat="server" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server">User Name</asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtUserName"
                                                        ErrorMessage="User name is required." ToolTip="User name is required." ValidationGroup="vgtrainingemplock">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtUserName" runat="server" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label7" runat="server">Employee Name</asp:Label>
                                                    <asp:RequiredFieldValidator ID="vfrEmployeeID" runat="server" ControlToValidate="txtEmployeeName"
                                                        ErrorMessage="Employee name is required." ToolTip="Employee name is required."
                                                        ValidationGroup="vgtrainingemplock">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeName" runat="server" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label11" runat="server">Training Code ID</asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTrainingCodeID"
                                                        ErrorMessage="Training Code ID is required." ToolTip="Training Code ID is required."
                                                        ValidationGroup="vgtrainingemplock">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTrainingCodeID" runat="server" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label14" runat="server">Description</asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDescription"
                                                        ErrorMessage="Description is required." ToolTip="Description is required." ValidationGroup="vgtrainingemplock">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDescription" runat="server" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label42" runat="server">Due Date</asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvDueDate" runat="server" ControlToValidate="txtDueDate"
                                                        ErrorMessage="Due Date is required." ToolTip="Due Date is required." ValidationGroup="vgtrainingemplock">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDueDate" runat="server" Width="100px" Style="text-align: right;"></asp:TextBox>
                                                    <img id="imgDueDate" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                        alt="" />
                                                    <ajaxToolkit:CalendarExtender ID="caDueDate" runat="server" CssClass="MyCalendar"
                                                        TargetControlID="txtDueDate" Enabled="True" PopupButtonID="imgDueDate" Format="MM/dd/yyyy">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblExtendDay" runat="server">Extend Day</asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtExtendDay"
                                                        ErrorMessage="Extend Day is required." ToolTip="Extend Day is required." ValidationGroup="vgtrainingemplock">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtExtendDay" runat="server" Width="98%" CssClass="positivenumber"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblExtendFromDate" runat="server">Extend From Date</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtExtendFromDate" runat="server" Width="100px" Style="text-align: right;"></asp:TextBox>
                                                    <img id="imgExtendFromDate" class="dateselected" src="../Images/icon-calendar.gif"
                                                        runat="server" alt="" />
                                                    <ajaxToolkit:CalendarExtender ID="caExtendFromDate" runat="server" CssClass="MyCalendar"
                                                        TargetControlID="txtExtendFromDate" Enabled="True" PopupButtonID="imgExtendFromDate"
                                                        Format="MM/dd/yyyy">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCompleteDate" runat="server">Complete Date</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCompleteDate" runat="server" Width="100px" Style="text-align: right;"></asp:TextBox>
                                                    <img id="imgCompleteDate" class="dateselected" src="../Images/icon-calendar.gif"
                                                        runat="server" alt="" />
                                                    <ajaxToolkit:CalendarExtender ID="caCompleteDate" runat="server" CssClass="MyCalendar"
                                                        TargetControlID="txtCompleteDate" Enabled="True" PopupButtonID="imgCompleteDate"
                                                        Format="MM/dd/yyyy">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="Active" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;" colspan="2">
                                                    <asp:Label ID="lblTrainingEmpLockMessage" ForeColor="Red" runat="server" EnableViewState="False">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center;">
                                                    <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Save" ValidationGroup="vgtrainingemplock"></asp:Button>
                                                    <asp:Button ID="btnUpdateAsk" runat="server" Text="Update" CssClass="button" UseSubmitBehavior="False"
                                                        ValidationGroup="vgtrainingemplock" OnClientClick="return TrainingEmpLockUpdateValidation();"></asp:Button>
                                                    <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                        Text="Delete" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnCancelEmployee" runat="server" UseSubmitBehavior="False" CssClass="button"
                                                        Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate" TargetControlID="lblUpdateEmployeeControl"
                                    CancelControlID="btnCancelUpdate" >
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="PanelConfirmUpdate" runat="server" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update Training Emp Lock Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this record?"></asp:Label>
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
                                    BehaviorID="bhmpeConfirmUpload" CancelControlID="btnCancelUpload" 
                                    PopupControlID="PanelConfirmUpload" TargetControlID="lblUploadControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmUpload" runat="server" CssClass="modalPopupConfirm" Style="display: none">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td align="center" class="confirmheader" colspan="2">
                                                    <asp:Label ID="Label43" runat="server">Upload Training Emp Lock Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblConfirmUpload" runat="server" Text="Are you sure you want to upload record(s) from excel file?"></asp:Label>
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
                                    <asp:Label ID="lblMessageControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUploadControl" runat="server">
                                    </asp:Label>
                                    <asp:HiddenField ID="hdLockID" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdUploadFileName" runat="server" />
                                    
                                    <asp:Label ID="lblUpdateEmployeeControl" runat="server">
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

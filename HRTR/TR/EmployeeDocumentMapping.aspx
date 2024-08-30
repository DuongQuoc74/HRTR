<%@ Page Title="Employee Document Mapping" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="EmployeeDocumentMapping.aspx.cs" Inherits="HRTR.TR.EmployeeDocumentMapping" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Employee Document Mapping</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/EmployeeDocumentMapping.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Search Employee</legend>
                                    <table >
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label2" runat="server" Text="Training Group"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlTrainingGroupS" ErrorMessage="Training Group is required."
                                                        ValidationGroup="vgsearchemployee">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:DropDownList ID="ddlTrainingGroupS" runat="server" AppendDataBoundItems="True"
                                                        AutoPostBack="True" DataTextField="TrainingGroupName" DataValueField="TrainingGroupID"
                                                        OnSelectedIndexChanged="ddlTrainingGroupS_SelectedIndexChanged" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label1" runat="server" Text="Course Group"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCourseGroupS" ErrorMessage="Course Group is required."
                                                        ValidationGroup="vgsearchemployee">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:DropDownList ID="ddlCourseGroupS" runat="server" AppendDataBoundItems="True"
                                                        AutoPostBack="True" DataTextField="CourseGroupName" DataValueField="CourseGroupID"
                                                        OnSelectedIndexChanged="ddlCourseGroupS_SelectedIndexChanged" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label3" runat="server" Text="Course"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator6" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCourseS" ErrorMessage="Course is required." ValidationGroup="vgsearchemployee">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCourseS" runat="server" AppendDataBoundItems="True" DataTextField="CourseName"
                                                        DataValueField="CourseID" AutoPostBack="True" OnSelectedIndexChanged="ddlCourseS_SelectedIndexChanged"
                                                        Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 12%;">
                                                    <asp:Label ID="lblWorkcellS" runat="server" Text="Workcell"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlWorkcellS" ErrorMessage="Workcell is required." ValidationGroup="vgsearchemployee">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:DropDownList ID="ddlWorkcellS" runat="server" AppendDataBoundItems="True" DataTextField="WorkcellName"
                                                        DataValueField="WorkcellID" Width="99%" AutoPostBack="True" OnSelectedIndexChanged="ddlWorkcellS_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="lblStationS" runat="server" Text="Station"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator12" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlStationS" ErrorMessage="Workcell is required." ValidationGroup="vgsearchemployee">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:DropDownList ID="ddlStationS" runat="server" AppendDataBoundItems="True" DataTextField="StationName"
                                                        DataValueField="StationID" Width="99%" AutoPostBack="True" OnSelectedIndexChanged="ddlStationS_SelectedIndexChanged">
                                                    </asp:DropDownList>
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
                                            </tr>
                                            <tr>
                                                <td style="width: 12%;">
                                                    <asp:Label ID="Label4" runat="server" Text="Document Number"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="txtDocNumber" ErrorMessage="Document number is required." ValidationGroup="vgsearchemployee">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:TextBox ID="txtDocNumber" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label5" runat="server" Text="Revision"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="txtDocRev" ErrorMessage="Document revision is required." ValidationGroup="vgsearchemployee">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:TextBox ID="txtDocRev" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td colspan="2" ></td>
                                            </tr>
                                            <tr>
                                                <td style="white-space: nowrap;">
                                                    <asp:Button ID="btnSearchEmployee" runat="server" CssClass="button" OnClick="btnSearchEmployee_Click"
                                                        ValidationGroup="vgsearchemployee" Text="Create" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnSearchMap" runat="server" CssClass="button" OnClick="btnSearchMap_Click"
                                                        Text="Search" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnClearS" runat="server" CssClass="button" OnClick="btnClearS_Click"
                                                        Text="Clear" UseSubmitBehavior="False" />
                                                </td>
                                                 <td colspan="4">
                                                    <asp:Label ID="lblSearchEmployeeMsg" runat="server" Text="" CssClass="errorMsg"></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnSaveDocument" runat="server" CssClass="button" OnClick="btnSaveDocument_Click"
                                                        ValidationGroup="vgadddocument" Text="Save" UseSubmitBehavior="False" />
                                <asp:Button ID="btnSaveAll" runat="server" CssClass="button" OnClick="btnSaveAll_Click"
                                                        ValidationGroup="vgadddocument" Text="Save All" UseSubmitBehavior="False" />
                                <asp:Label ID="lblSaveDocumentMsg" runat="server" Text="" CssClass="errorMsg"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvSearchEmployee" runat="server" AllowPaging="True" AllowSorting="True"
                                    ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" DataKeyNames="TrainingRecordID"
                                    OnPageIndexChanging="grvTrainingRecord_PageIndexChanging" PageSize="20" OnRowCommand="grvTrainingRecord_RowCommand"
                                    OnRowDataBound="grvTrainingRecord_RowDataBound" OnSorting="grvTrainingRecord_Sorting"
                                    CssClass="gridview" PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing"
                                    SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header" FooterStyle-CssClass="footer"
                                    AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkAll" runat="server" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbSelect" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID" />
                                        <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                        <asp:BoundField DataField="WorkcellName" HeaderText="Workcell Employee" SortExpression="WorkcellName" />
                                        <asp:TemplateField HeaderText="Workcell Doc">
                                            <ItemTemplate>
                                                <%# ddlWorkcellS.SelectedItem.Text %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Station Doc">
                                            <ItemTemplate>
                                                <%# ddlStationS.SelectedItem.Text %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TrainingGroupName" HeaderText="Training Group" SortExpression="TrainingGroupName" />
                                        <asp:BoundField DataField="CourseGroupName" HeaderText="Course Group" SortExpression="CourseGroupName" />
                                        <asp:BoundField DataField="CourseName" HeaderText="Course" SortExpression="CourseName" />
                                        <asp:BoundField DataField="CertDate" HeaderText="Certificate Date" SortExpression="CertDate"
                                            DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:TemplateField HeaderText="Document Number">
                                            <ItemTemplate>
                                                <%# txtDocNumber.Text %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Revision">
                                            <ItemTemplate>
                                                <%# txtDocRev.Text %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel  class="panelMapDocument" ID="panelMapError" runat="server">
                                    <fieldset>
                                        <legend style="color:red">Below records failed to map</legend>
                                        <asp:GridView ID="grvMapDocumentError" runat="server" AllowPaging="False" AllowSorting="True"
                                            ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" DataKeyNames="TrainingRecordID"
                                            PageSize="20" OnRowCommand="grvMapDocumentError_RowCommand"
                                            OnRowDataBound="grvMapDocumentError_RowDataBound" OnSorting="grvMapDocumentError_Sorting"
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
                                                <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                                <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName" />
                                                <asp:BoundField DataField="StationName" HeaderText="Station" SortExpression="StationName" />
                                                <asp:BoundField DataField="TrainingGroupName" HeaderText="Training Group" SortExpression="TrainingGroupName" />
                                                <asp:BoundField DataField="CourseGroupName" HeaderText="Course Group" SortExpression="CourseGroupName" />
                                                <asp:BoundField DataField="CourseName" HeaderText="Course" SortExpression="CourseName" />
                                                <asp:BoundField DataField="CertDate" HeaderText="Certificate Date" SortExpression="CertDate"
                                                    DataFormatString="{0:MM/dd/yyyy}" />
                                            </Columns>
                                        </asp:GridView>
                                    </fieldset>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvSearchDocumentMap" runat="server" AllowPaging="True" AllowSorting="True"
                                    ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" DataKeyNames="EmployeeDocID"
                                    OnPageIndexChanging="grvSearchDocumentMap_PageIndexChanging" PageSize="20" OnRowCommand="grvSearchDocumentMap_RowCommand"
                                    OnRowDataBound="grvSearchDocumentMap_RowDataBound" OnSorting="grvSearchDocumentMap_Sorting"
                                    CssClass="gridview" PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing"
                                    SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header" FooterStyle-CssClass="footer"
                                    AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkSMAll" runat="server" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbSMSelect" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" Text='<%# Eval("EmployeeID") %>' CommandName="UpdateDocMap" CausesValidation="False"
                                                    ID="lbUpdate" CommandArgument='<%# Eval("EmployeeDocID") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="select" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                        <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName" />
                                        <asp:BoundField DataField="StationName" HeaderText="Station" SortExpression="StationName" />
                                        <asp:BoundField DataField="TrainingGroupName" HeaderText="Training Group" SortExpression="TrainingGroupName" />
                                        <asp:BoundField DataField="CourseGroupName" HeaderText="Course Group" SortExpression="CourseGroupName" />
                                        <asp:BoundField DataField="CourseName" HeaderText="Course" SortExpression="CourseName" />
                                        <asp:BoundField DataField="DocumentNumber" HeaderText="Document No." SortExpression="DocumentNumber" />
                                        <asp:BoundField DataField="Revision" HeaderText="Revision" SortExpression="Revision" />
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel runat="server" ID="panelUnmapButtons" Visible="false">
                                    <asp:Button ID="btnUnmap" runat="server" CssClass="button" OnClientClick="if (!confirmDelete()) return false;" OnClick="btnUnMap_Click"
                                            Text="Delete" UseSubmitBehavior="False" />
                                    <asp:Button ID="btnDeleteAllDocumentMap" runat="server" CssClass="button" OnClientClick="if (!confirmDelete()) return false;" OnClick="btnDeleteAllDocumentMap_Click"
                                            Text="Delete All" UseSubmitBehavior="False" />
                                    <asp:Button ID="btnExport" runat="server" CssClass="button" OnClick="btnExport_Click"
                                            Text="Export" UseSubmitBehavior="False" />
                                    <asp:Label ID="lblUnmapExportMsg" runat="server" Text="" CssClass="errorMsg"></asp:Label>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeUpdateDocumentMap" runat="server" TargetControlID="lblProcessingControl"
                                    PopupControlID="pnUpdateDocumentMapPopup" BackgroundCssClass="modalBackgroundCommon"
                                    CancelControlID="btnCancelUpdateDocumentMap" DropShadow="false" PopupDragHandleControlID="pnUpdateDocumentMapPopupDrag"
                                    BehaviorID="bhvmpeUpdateDocumentMap" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none;" ID="pnUpdateDocumentMapPopup"
                                    runat="server">
                                    <asp:Panel  class="modalPopupDrag" ID="pnUpdateDocumentMapPopupDrag" runat="server">
                                        <div>
                                            <p>Update Document Number/Revision</p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label14" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeID" ReadOnly="true" Enabled="false" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label7" runat="server"  Text="Employee Name" ></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeName" ReadOnly="true" Enabled="false" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label8" runat="server" Text="Course" ></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCourseName" ReadOnly="true" Enabled="false" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label10" runat="server" Text="Training Group" ></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTrainingGroupName" ReadOnly="true" Enabled="false" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label11" runat="server" Text="Course Group" ></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCourseGroupName" ReadOnly="true" Enabled="false" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label12" runat="server" Text="Workcell" ></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWorkcellName" ReadOnly="true" Enabled="false" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label15" runat="server" Text="Station" ></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStationName" ReadOnly="true" Enabled="false" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label6" runat="server" Text="Document Number"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator7" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="txtUpdateDocNumber" ErrorMessage="Document number is required." ValidationGroup="vgUpdateDocumentMap">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtUpdateDocNumber" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label9" runat="server" Text="Revision"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator8" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="txtUpdateDocRevision" ErrorMessage="Document revision is required." ValidationGroup="vgUpdateDocumentMap">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtUpdateDocRevision" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td colspan="2" ></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:HiddenField ID="hdUpdateEmpDocID" runat="server" />
                                                    <asp:Button ID="btnUpdateDocumentMap" OnClick="btnUpdateDocumentMap_Click" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Update" ValidationGroup="vgUpdateDocumentMap"></asp:Button>
                                                    <asp:Button ID="btnCancelUpdateDocumentMap" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                    <asp:Label ID="lblUpdateDocMapMsg" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeProcessing" runat="server" Enabled="True"
                                    BackgroundCssClass="modalBackgroundProcessing" PopupControlID="PanelProcessing"
                                    DropShadow="false" BehaviorID="bhmpeProcessing" TargetControlID="lblProcessingControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="PanelProcessing" runat="server" CssClass="modalPopupProcessing">
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
                                    <asp:Label ID="lblProcessingControl" runat="server"></asp:Label>
                                    <asp:Label ID="lblUpdateDocumentMapControl" runat="server"></asp:Label>
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
    <script type="text/javascript">
        // A function to select or unselect all checkboxes in the gridview
        function SelectAllCheckboxes(chkAll) {
            // Get the gridview element
            var grid = document.getElementById("<%= grvSearchEmployee.ClientID %>");

            // Loop through the rows and cells
            for (var i = 0; i < grid.rows.length; i++) {
                var row = grid.rows[i];
                var cell = row.cells[0];
                if (cell.childNodes.length > 0) {
                    var chkSelect = cell.childNodes[1];
                    if (chkSelect != null && chkSelect.type == "checkbox") {
                        chkSelect.checked = chkAll.checked;
                    }
                }
            }
        }

        function SelectSearchMapAllCheckboxes(chkAll) {
            // Get the gridview element
            var grid = document.getElementById("<%= grvSearchDocumentMap.ClientID %>");

            // Loop through the rows and cells
            for (var i = 0; i < grid.rows.length; i++) {
                var row = grid.rows[i];
                var cell = row.cells[0];
                if (cell.childNodes.length > 0) {
                    var chkSelect = cell.childNodes[1];
                    if (chkSelect != null && chkSelect.type == "checkbox") {
                        chkSelect.checked = chkAll.checked;
                    }
                }
            }
        }
    </script>
</asp:Content>

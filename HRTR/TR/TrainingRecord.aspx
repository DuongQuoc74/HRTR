<%@ Page AutoEventWireup="true" CodeFile="TrainingRecord.aspx.cs" Inherits="HRTR_TrainingRecord"
    EnableEventValidation="false" Language="C#" MasterPageFile="~/HCM.master" Title="Training Record" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Training Record</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/jquery-1.7.min.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/TrainingRecord.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Common2.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <asp:Label ID="Label9" runat="server" Text="Select employee, training group, course group and product then click view button."
                                    CssClass="message"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Select employee</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%">
                                                    <asp:Label ID="Label3" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td style="width: 35%; white-space: nowrap;">
                                                    <asp:TextBox ID="txtEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvEmployeeID" runat="server" ValidationGroup="viewtrainingrecord"
                                                        ControlToValidate="txtEmployeeIDS" ErrorMessage="Employee ID is required." ToolTip="Employee ID is required.">(*)</asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="cvEmployeeIDS" runat="server" ClientValidationFunction="cvEmployeeIDS_ClientValidate"
                                                        ControlToValidate="txtEmployeeIDS" ErrorMessage="Employee is required." ValidationGroup="viewtrainingrecord">(*)</asp:CustomValidator>
                                                    <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="bhaceEmployee" ID="aceEmployee"
                                                        TargetControlID="txtEmployeeIDS" ServicePath="../WebServices/HRTRUserProfile.asmx"
                                                        ServiceMethod="GetEmployeeList" MinimumPrefixLength="2" CompletionInterval="500"
                                                        EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                        DelimiterCharacters=";, :" OnClientItemSelected="EmployeeSelected" FirstRowSelected="true">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td style="width: 10%">
                                                    <asp:Label ID="Label2" runat="server" Text="Employee Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeName" runat="server" Width="99%"></asp:TextBox>
                                                    <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="bhaceEmployeeName" ID="aceEmployeeName"
                                                        TargetControlID="txtEmployeeName" ServicePath="../WebServices/HRTRUserProfile.asmx"
                                                        ServiceMethod="GetEmployeeListByName" MinimumPrefixLength="2" CompletionInterval="500"
                                                        EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                        DelimiterCharacters=";, :" OnClientItemSelected="EmployeeNameSelected" FirstRowSelected="true">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <hr />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label46" runat="server" Text="Operator Group"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtOperatorGroupName" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label5" runat="server" Text="Company"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCompanyName" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label10" runat="server" Text="Department"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDepartmentName" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" Text="Job Title"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtJobTitle" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label8" runat="server" Text="Position"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPositionName" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label16" runat="server" Text="Shift"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtShiftName" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label36" runat="server" Text="Workcell"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWorkcellName" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label18" runat="server" Text="Line Leader"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtSupervisor" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="Active" Enabled="false" />
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Select training group, course group and product</legend>
                                    <table>
                                        <tr>
                                            <td style="width: 10%">
                                                <asp:Label ID="Label1" runat="server" Text="Training Group"></asp:Label>
                                            </td>
                                            <td style="width: 20%">
                                                <asp:DropDownList ID="ddlTrainingGroup" runat="server" AppendDataBoundItems="True"
                                                    DataTextField="TrainingGroupName" DataValueField="TrainingGroupID" ValidationGroup="viewcourse"
                                                    Width="99%">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 5%">
                                                <asp:CustomValidator ID="cvTrainingGroup" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                    ControlToValidate="ddlTrainingGroup" ErrorMessage="Training group is required."
                                                    ValidationGroup="viewtrainingrecord">(*)</asp:CustomValidator>
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label ID="Label4" runat="server" Text="Course Group"></asp:Label>
                                            </td>
                                            <td style="width: 20%">
                                                <asp:DropDownList ID="ddlCourseGroup" runat="server" AppendDataBoundItems="True"
                                                    DataTextField="CourseGroupName" DataValueField="CourseGroupID" ValidationGroup="viewcourse"
                                                    Width="99%">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 5%">
                                                <asp:CustomValidator ID="cvCourseGroup" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                    ControlToValidate="ddlCourseGroup" ErrorMessage="Course group is required." ValidationGroup="viewtrainingrecord">(*)</asp:CustomValidator>
                                            </td>
                                            <td style="width: 5%">
                                                <asp:Label ID="Label7" runat="server" Text="Product"></asp:Label>
                                            </td>
                                            <td style="width: 20%">
                                                <asp:DropDownList ID="ddlProduct" runat="server" AppendDataBoundItems="True" DataTextField="ProductName"
                                                    DataValueField="ProductID" ValidationGroup="viewcourse" Width="99%">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:CustomValidator ID="cvProduct" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                    ControlToValidate="ddlProduct" ErrorMessage="Product is required." ValidationGroup="viewtrainingrecord">(*)</asp:CustomValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnView" runat="server" CssClass="button" OnClick="btnView_Click"
                                    ValidationGroup="viewtrainingrecord" Text="View" Width="70px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvTrainingRecord" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                    DataKeyNames="TrainingRecordID,CourseID" OnRowCommand="grvTrainingRecord_RowCommand"
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
                                        <asp:BoundField DataField="CourseName" HeaderText="Course Name" SortExpression="LineItem" />
                                        <asp:TemplateField HeaderText="Certificate Date" SortExpression="CertDate">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtCertDate" runat="server" Width="80px" Style="text-align: right"
                                                    Text='<%# Eval("CertDate","{0:MM/dd/yyyy}")%>'></asp:TextBox>
                                                <img id="imgCertDate" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                    alt="" />
                                                <ajaxToolkit:CalendarExtender ID="ceCertDate" runat="server" CssClass="MyCalendar"
                                                    TargetControlID="txtCertDate" Enabled="True" PopupButtonID="imgCertDate" Format="MM/dd/yyyy">
                                                </ajaxToolkit:CalendarExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Score" SortExpression="Score">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtScore" runat="server" Width="99%" Text='<%# Eval("Score", "{0:0.0}")%>'
                                                    CssClass="number"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Certified Level">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlCertifiedLevel" Width="99%" runat="server" AutoPostBack="false"
                                                    DataTextField="CertifiedLevelName" DataValueField="CertifiedLevelID" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Trainer" SortExpression="Trainer">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTrainer" runat="server" Width="99%" Text='<%# Eval("Trainer")%>'></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="OJT" SortExpression="OJT">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkOJT" Checked='<%# Eval("OJT")%>' runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle CssClass="checkbox" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Expired Date" SortExpression="ExpDate">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtExpDate" runat="server" Width="80px" Style="text-align: right"
                                                    Text='<%# Eval("ExpDate","{0:MM/dd/yyyy}")%>'></asp:TextBox>
                                                <img id="imgExpDate" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                    alt="" />
                                                <ajaxToolkit:CalendarExtender ID="ceExpDate" runat="server" CssClass="MyCalendar"
                                                    TargetControlID="txtExpDate" Enabled="True" PopupButtonID="imgExpDate" Format="MM/dd/yyyy">
                                                </ajaxToolkit:CalendarExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnSave" runat="server" CssClass="button" OnClick="btnSave_Click"
                                    Text="Save" Width="70px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeMessage" runat="server" TargetControlID="lblMessageControl"
                                    BackgroundCssClass="modalBackgroundConfirm" OkControlID="btnMessage" PopupControlID="PanelConfirm"
                                    BehaviorID="bhmpeMessage" DropShadow="false" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirm" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="confirmtable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2" style="text-align: center">
                                                    <asp:Label ID="lblCaption" runat="server" Text="Training Record">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center">
                                                    <img src="../Images/infoconfirm.jpg" alt="" />
                                                </td>
                                                <td style="text-align: center">
                                                    <asp:Label ID="lblMessage" runat="server" CssClass="confirmmessage" Style="text-align: center">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btnMessage" runat="server" CssClass="button" OnClientClick="return false;"
                                                        Text="OK" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
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
                                <asp:HiddenField ID="hdProductID" runat="server" />
                                <asp:HiddenField ID="hdEmployeeID_ID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdCourseGroupID" runat="server" />
                                <div style="visibility: hidden">
                                    <asp:Label ID="lblMessageControl" runat="server">
                                    </asp:Label>
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
                      <%--  <EnableAction AnimationTarget="btnAdd" Enabled="False" />
                        <EnableAction AnimationTarget="btnUpdateAsk" Enabled="False" />
                        <EnableAction AnimationTarget="btnDelete" Enabled="False" />
                        <EnableAction AnimationTarget="btnCancelA" Enabled="False" />
                        <EnableAction AnimationTarget="btnCancelD" Enabled="False" />
                        <EnableAction AnimationTarget="btnCancelU" Enabled="False" />--%>
                    </Parallel>
                </Sequence> 
            </OnUpdating>
            <OnUpdated>   
                <Sequence>
                    <ScriptAction Script="$find('bhmpeProcessing').hide();" />
                    <Parallel duration="0">
                     <%--   <EnableAction AnimationTarget="btnAdd" Enabled="True" />
                        <EnableAction AnimationTarget="btnUpdateAsk" Enabled="True" />
                        <EnableAction AnimationTarget="btnDelete" Enabled="True" />
                        <EnableAction AnimationTarget="btnCancelA" Enabled="True" />
                        <EnableAction AnimationTarget="btnCancelD" Enabled="True" />
                        <EnableAction AnimationTarget="btnCancelU" Enabled="True" />--%>
                    </Parallel>             
                </Sequence>
            </OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </div>
</asp:Content>

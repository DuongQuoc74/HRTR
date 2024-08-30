<%@ Page Title="Course Station Mapping" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="CourseStation.aspx.cs" Inherits="HRTR.TR.CourseStation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Course Station Mapping</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/CourseStation.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Search Course</legend>
                                    <table >
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label2" runat="server" Text="Training Group"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlTrainingGroupS" ErrorMessage="Training Group is required."
                                                        ValidationGroup="vgsearchcourse">(*)</asp:CustomValidator>
                                                    <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlTrainingGroupS" ErrorMessage="Training Group is required."
                                                        ValidationGroup="vgsearchstation">(*)</asp:CustomValidator>
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
                                                        ValidationGroup="vgsearchcourse">(*)</asp:CustomValidator>
                                                    <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCourseGroupS" ErrorMessage="Course Group is required."
                                                        ValidationGroup="vgsearchstation">(*)</asp:CustomValidator>
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
                                                        ControlToValidate="ddlCourseS" ErrorMessage="Course is required." ValidationGroup="vgsearchcourse">(*)</asp:CustomValidator>
                                                    <asp:CustomValidator ID="CustomValidator10" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCourseS" ErrorMessage="Course is required." ValidationGroup="vgsearchstation">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCourseS" runat="server" AppendDataBoundItems="True" DataTextField="CourseName"
                                                        DataValueField="CourseID" AutoPostBack="True" OnSelectedIndexChanged="ddlCourseS_SelectedIndexChanged"
                                                        Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="white-space: nowrap;">
                                                    <asp:Button ID="btnSearchCourse" runat="server" CssClass="button" OnClick="btnSearchCourse_Click"
                                                        ValidationGroup="vgsearchcourse" Text="Search Course" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnExport" runat="server" CssClass="button" OnClick="btnExport_Click"
                                                        Text="Export" UseSubmitBehavior="False" />
                                                </td>
                                                 <td colspan="5">
                                                    <asp:Label ID="lblSearch" runat="server" Text="" CssClass="errorMsg"></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvCourseStationList" runat="server" AllowPaging="True" AllowSorting="True"
                                    AutoGenerateColumns="False" DataKeyNames="CourseStationID" PageSize="20" OnPageIndexChanging="grvCourseStationList_PageIndexChanging"
                                    OnRowCommand="grvCourseStationList_RowCommand" OnRowDataBound="grvCourseStationList_RowDataBound"
                                    OnSorting="grvCourseStationList_Sorting" CssClass="gridview" PagerStyle-CssClass="pgr"
                                    EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                    ShowHeaderWhenEmpty="true" FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate"
                                    RowStyle-CssClass="normal">
                                    <PagerSettings Mode="NumericFirstLast" />
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
                                        <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName" />
                                        <asp:BoundField DataField="StationName" HeaderText="Station" SortExpression="StationName" />
                                          <asp:BoundField DataField="LastUpdatedByUserName" HeaderText="Last Updated By" SortExpression="LastUpdatedByUserName" />
                                            <asp:BoundField DataField="LastUpdated" HeaderText="Last Updated" SortExpression="LastUpdated" />
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("CourseStationID")%>'
                                                    CommandName="Del" Text="Delete"></asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="select" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Search e-DCC Station</legend>
                                    <table >
                                        <tbody>
                                            <tr>
                                                <td style="width: 12%;">
                                                    <asp:Label ID="Label4" runat="server" Text="Workcell"></asp:Label>
                                                    <asp:CustomValidator ID="cvWorkcell" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlWorkcellS" ErrorMessage="Workcell is required." ValidationGroup="vgsearchstation">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:DropDownList ID="ddlWorkcellS" runat="server" AppendDataBoundItems="True" DataTextField="WorkcellName"
                                                        DataValueField="WorkcellID" Width="99%" AutoPostBack="True" OnSelectedIndexChanged="ddlWorkcellS_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="lblStationNameS" runat="server" Text="Station Name"></asp:Label>
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:TextBox ID="txtStationNameS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td colspan="2" ></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSearchStation" runat="server" CssClass="button" OnClick="btnSearchStation_Click"
                                                        ValidationGroup="vgsearchstation" Text="Search Station" UseSubmitBehavior="False" />
                                                </td>
                                                <td colspan="2">
                                                    <asp:Label ID="lblSearchStationMessage" runat="server" Text="" CssClass="errorMsg"></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvStationList" runat="server" OnRowDataBound="grvStationList_RowDataBound"
                                    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="StationID"
                                    OnPageIndexChanging="grvStationList_PageIndexChanging" OnSorting="grvStationList_Sorting"
                                    OnRowCommand="grvStationList_RowCommand" CssClass="gridview" PagerStyle-CssClass="pgr"
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
                                        <asp:BoundField DataField="StationName" HeaderText="Station Name" SortExpression="StationName">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName">
                                        </asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" Text="Add" CommandName="Add" CausesValidation="False"
                                                    ID="lbAdd" CommandArgument='<%# Eval("StationID") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="select" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeCourseStation" runat="server" TargetControlID="lblCourseStationControl"
                                    PopupControlID="pnCourseStationPopup" BackgroundCssClass="modalBackgroundCommon"
                                    CancelControlID="btnCancelCourseStation" DropShadow="false" PopupDragHandleControlID="pnCourseStationPopupDrag"
                                    BehaviorID="bhvmpeCourseStation" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none;" ID="pnCourseStationPopup"
                                    runat="server">
                                    <asp:Panel  class="modalPopupDrag" ID="pnCourseStationPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add/ Update/ Delete Course Station</p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label14" runat="server" Text="Training Group"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator7" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlTrainingGroup" ErrorMessage="Training Group is required."
                                                        ValidationGroup="vgcoursestation">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTrainingGroup" runat="server" AppendDataBoundItems="True"
                                                        AutoPostBack="false" DataTextField="TrainingGroupName" DataValueField="TrainingGroupID"
                                                        Width="99%" Enabled="false">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label15" runat="server" Text="Course Group"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator8" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCourseGroup" ErrorMessage="Course Group is required." ValidationGroup="vgcoursestation">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCourseGroup" runat="server" AppendDataBoundItems="True"
                                                        AutoPostBack="false" DataTextField="CourseGroupName" DataValueField="CourseGroupID"
                                                        Width="99%" Enabled="false">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label16" runat="server" Text="Course"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator9" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlCourse" ErrorMessage="Course is required." ValidationGroup="vgcoursestation">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCourse" runat="server" AppendDataBoundItems="True" DataTextField="CourseName"
                                                        DataValueField="CourseID" Width="99%" Enabled="false">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" Text="Station"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator11" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlStation" ErrorMessage="Station is required." ValidationGroup="vgcoursestation">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlStation" runat="server" AppendDataBoundItems="True" DataTextField="StationName"
                                                        DataValueField="StationID" Width="99%" Enabled="false">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center;">
                                                    <asp:Label ID="lblCourseStationMessage" runat="server" CssClass="errorMsg">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Save" ValidationGroup="vgcoursestation"></asp:Button>
                                                    <asp:Button ID="btnUpdateAsk" runat="server" Text="Update" CssClass="button" UseSubmitBehavior="False"
                                                        ValidationGroup="vgcoursestation" OnClientClick="return updateValidation();">
                                                    </asp:Button>
                                                    <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                        Text="Delete" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnCancelCourseStation" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                           
                                <ajaxToolkit:ModalPopupExtender ID="mpeUpdateCourseStation" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    PopupControlID="pnUpdateCourseStationPopup" BehaviorID="bhmpeUpdateCourseStation"
                                    TargetControlID="lblUpdateCourseStationControl" CancelControlID="btnCancelUpdateCourseStation"
                                    >
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="pnUpdateCourseStationPopup" runat="server" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update Course Station Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this Course Station?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                   
                                                                    <asp:Button ID="btnUpdate" runat="server" CssClass="button" OnClick="btnUpdate_Click"
                                                                        Text="OK" />
                                                               
                                                                    <asp:Button ID="btnCancelUpdateCourseStation" runat="server" CssClass="button" OnClientClick="return false;"
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
                                    <asp:Label ID="lblCourseStationControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateCourseStationControl" runat="server">  </asp:Label>
                                    <asp:HiddenField ID="hdCourseStationID" runat="server" />
                                  
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

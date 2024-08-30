<%@ Page Title="Step Instance Station Mapping" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="StepInsStation.aspx.cs" Inherits="HRTR.GrapeChart.StepInsStation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Step Instance Station Mapping</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/StepInsStation.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>Search</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label23" runat="server" Text="Workcell"></asp:Label>
                                                </td>
                                                <td style="width: 15%">
                                                    <asp:DropDownList ID="ddlGC_CustomersS" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="Customer" OnSelectedIndexChanged="ddlGC_CustomersS_SelectedIndexChanged"
                                                        AutoPostBack="true" DataValueField="Customer_ID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label1" runat="server" Text="Step Instance"></asp:Label>
                                                </td>
                                                <td style="width: 15%">
                                                    <asp:TextBox ID="txtStepInsS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label2" runat="server" Text="Station"></asp:Label>
                                                </td>
                                                <td style="width: 15%">
                                                    <asp:TextBox ID="txtStationNameS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label44" runat="server" Text="Active"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="99%">
                                                        <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="0">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="button" OnClick="btnSearch_Click"
                                                        Text="Search" UseSubmitBehavior="False" />
                                                        <asp:Label ID="lblSearch" runat="server" Text="s"></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnAddControl" runat="server" CssClass="button" OnClientClick="return NewGC_StepInsStation();"
                                    Text="New" UseSubmitBehavior="False" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvGC_StepInsStationList" runat="server" AllowPaging="True" AllowSorting="True"
                                    AutoGenerateColumns="False" DataKeyNames="GC_StepInsStationID" PageSize="20"
                                    OnPageIndexChanging="grvGC_StepInsStationList_PageIndexChanging" OnRowCommand="grvGC_StepInsStationList_RowCommand"
                                    OnRowDataBound="grvGC_StepInsStationList_RowDataBound" OnSorting="grvGC_StepInsStationList_Sorting"
                                    CssClass="gridview" PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing"
                                    SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header" ShowHeaderWhenEmpty="true"
                                    FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
                                        <asp:BoundField DataField="StepIns" HeaderText="Step Instance" SortExpression="StepIns" />
                                        <asp:BoundField DataField="StationName" HeaderText="Station" SortExpression="StationName" />
                                        <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                                            <ItemStyle CssClass="checkbox" />
                                        </asp:CheckBoxField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                    CssClass="ContextMenuTarget" />
                                                <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none;
                                                    visibility: hidden;">
                                                    <asp:LinkButton runat="server" Text="Edit" CommandName="Select" CausesValidation="False"
                                                        CssClass="ContextMenuItem" ID="lbEdit" CommandArgument='<%# Eval("GC_StepInsStationID") %>'></asp:LinkButton>
                                                    <asp:LinkButton runat="server" Text="Delete" CommandName="Del" CausesValidation="False"
                                                        CssClass="ContextMenuItem" ID="lbDelete" CommandArgument='<%# Eval("GC_StepInsStationID") %>'></asp:LinkButton>
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
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeGC_StepInsStation" runat="server" TargetControlID="lblGC_StepInsStationControl"
                                    PopupControlID="pnGC_StepInsStationPopup" BackgroundCssClass="modalBackgroundCommon"
                                    CancelControlID="btnCancelGC_StepInsStation" DropShadow="false" PopupDragHandleControlID="pnGC_StepInsStationPopupDrag"
                                    BehaviorID="bhvmpeGC_StepInsStation" Enabled="True" OnOkScript="btnReturnGC_StepInsStation">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 550px;" ID="pnGC_StepInsStationPopup"
                                    runat="server">
                                    <asp:Panel CssClass="modalPopupDrag" ID="pnGC_StepInsStationPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add/ Update/ Delete Step Instance Station</p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label14" runat="server" Text="Workcell"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCustomer" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label15" runat="server" Text="Step Instance"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator8" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlStepIns" ErrorMessage="Step Instance is required." ValidationGroup="vggc_stepinsstation">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlStepIns" runat="server" AppendDataBoundItems="True" AutoPostBack="false"
                                                        DataTextField="StepIns" DataValueField="StepIns" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" Text="Station"></asp:Label>
                                                    <asp:CustomValidator ID="cvGC_Station" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlGC_Station" ErrorMessage="Station is required." ValidationGroup="vggc_stepinsstation">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlGC_Station" runat="server" AppendDataBoundItems="True" DataTextField="StationName"
                                                        DataValueField="GC_StationID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="Active"></asp:CheckBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center;">
                                                    <asp:Label ID="lblGC_StepInsStationMessage" runat="server" CssClass="errorMsg">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Save" ValidationGroup="vggc_stepinsstation"></asp:Button>
                                                    <asp:Button ID="btnUpdateAsk" runat="server" Text="Update" CssClass="button" UseSubmitBehavior="False"
                                                        ValidationGroup="vggc_stepinsstation" OnClientClick="return GC_StepInsStationUpdateValidation();">
                                                    </asp:Button>
                                                    <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                        Text="Delete" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnCancelGC_StepInsStation" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <ajaxToolkit:ModalPopupExtender ID="mpeUpdateGC_StepInsStation" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    PopupControlID="pnUpdateGC_StepInsStationPopup" BehaviorID="bhmpeUpdateGC_StepInsStation"
                                    TargetControlID="lblUpdateGC_StepInsStationControl" CancelControlID="btnCancelUpdateGC_StepInsStation"
                                    OkControlID="btnReturnUpdateGC_StepInsStation">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="pnUpdateGC_StepInsStationPopup" runat="server"
                                    CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="Label3" runat="server">Update Step Instance Station Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this step instance station?"></asp:Label>
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
                                                                    <asp:Button ID="btnCancelUpdateGC_StepInsStation" runat="server" CssClass="button"
                                                                        OnClientClick="return false;" Text="Cancel"  />
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
                                    <asp:HiddenField ID="hdGC_StepInsStationID" runat="server" />
                                    <asp:HiddenField ID="hdMESCustomer_ID" runat="server" />
                                    <asp:HiddenField ID="hdCustomer_ID" runat="server" />
                                    <asp:Label ID="lblGC_StepInsStationControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateGC_StepInsStationControl" runat="server">  </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                    <asp:Button ID="btnReturnGC_StepInsStation" OnClientClick="return false;" runat="server"
                                        UseSubmitBehavior="False" CssClass="button"></asp:Button>
                                    <asp:Button ID="btnReturnUpdateGC_StepInsStation" OnClientClick="return false;" runat="server"
                                        UseSubmitBehavior="False" CssClass="button"></asp:Button>
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

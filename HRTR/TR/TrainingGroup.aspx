<%@ Page Title="Training Group" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="TrainingGroup.aspx.cs" Inherits="HRTR.TR.TrainingGroup" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Training Group
        </div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/TrainingGroup.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
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
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label2" runat="server" Text="Active"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                            <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                            CssClass="button" UseSubmitBehavior="False"></asp:Button>
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
                        <tr>
                            <td>
                                <asp:Button ID="btnNewTrainingGroup" runat="server" OnClientClick="return NewTrainingGroup();"
                                    UseSubmitBehavior="False" CssClass="button" Text="New"></asp:Button>
                                <asp:Label ID="lblTrainingGroup" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvTrainingGroupList" runat="server" OnRowDataBound="grvTrainingGroupList_RowDataBound"
                                    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PageSize="20"
                                    DataKeyNames="TrainingGroupID" OnPageIndexChanging="grvTrainingGroupList_PageIndexChanging"
                                    OnSorting="grvTrainingGroupList_Sorting" OnRowCommand="grvTrainingGroupList_RowCommand"
                                    CssClass="gridview" PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing"
                                    SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header" FooterStyle-CssClass="footer"
                                    AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal">
                                    <PagerSettings Mode="NumericFirstLast"></PagerSettings>
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TrainingGroupName" HeaderText="Training Group" SortExpression="TrainingGroupName"></asp:BoundField>
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
                                                        CssClass="ContextMenuItem" ID="lbEdit" CommandArgument='<%# Eval("TrainingGroupID") %>'></asp:LinkButton>
                                                    <asp:LinkButton runat="server" Text="Delete" CommandName="Del" CausesValidation="False"
                                                        CssClass="ContextMenuItem" ID="lbDelete" CommandArgument='<%# Eval("TrainingGroupID") %>'></asp:LinkButton>
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeTrainingGroup" runat="server" TargetControlID="btnNewTrainingGroup"
                                    PopupControlID="pnTrainingGroupPopup" BackgroundCssClass="modalBackgroundCommon"
                                    CancelControlID="btnCancelTrainingGroup" DropShadow="false" PopupDragHandleControlID="pnTrainingGroupPopupDrag"
                                    BehaviorID="bhvmpeTrainingGroup">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 800px;" ID="pnTrainingGroupPopup"
                                    runat="server">
                                    <asp:Panel class="modalPopupDrag" ID="pnTrainingGroupPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add/ Update/ Delete Training Group
                                            </p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Add" runat="server" Text="Training Group">
                                                    </asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvTrainingGroupName" runat="server" ValidationGroup="vgtraininggroup"
                                                        ToolTip="Training Group is required." ErrorMessage="Training Group is required."
                                                        ControlToValidate="txtTrainingGroupName">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTrainingGroupName" runat="server" Width="99%" ValidationGroup="vgtraininggroup">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text="Active"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Checked="true" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Label ID="lblTrainingGroupMessage" runat="server" EnableViewState="False">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Save" ValidationGroup="vgtraininggroup"></asp:Button>
                                                    <asp:Button ID="btnUpdateAsk" runat="server" Text="Update" CssClass="button" UseSubmitBehavior="False"
                                                        ValidationGroup="vgtraininggroup" OnClientClick="return TrainingGroupUpdateValidation();"></asp:Button>
                                                    <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                        Text="Delete" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnCancelTrainingGroup" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate" runat="server" TargetControlID="lblUpdateControl"
                                    BackgroundCssClass="modalBackgroundConfirm" CancelControlID="btnCancelUpdate"
                                    PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmUpdate" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update Training Group Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this training group?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                    <asp:Button ID="btnUpdate" runat="server" Text="OK" CssClass="button"
                                                        OnClick="btnUpdate_Click"></asp:Button>
                                                    <asp:Button ID="btnCancelUpdate" runat="server" Text="Cancel" CssClass="button"
                                                        OnClientClick="return false;"></asp:Button>
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
                                    <asp:HiddenField ID="hdTrainingGroupID" runat="server" Value="0" />
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
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

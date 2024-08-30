<%@ Page Title="Workcell" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="Workcell.aspx.cs" Inherits="HRTR.TR.Workcell" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Workcell
        </div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Workcell.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <asp:Button ID="btnNewWorkcell" runat="server" OnClientClick="return NewWorkcell();"
                                    UseSubmitBehavior="False" CssClass="button" Text="New"></asp:Button>
                                <asp:Label ID="lblWorkcell" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvWorkcellList" runat="server" OnRowDataBound="grvWorkcellList_RowDataBound"
                                    PageSize="20" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                    DataKeyNames="WorkcellID" OnPageIndexChanging="grvWorkcellList_PageIndexChanging"
                                    OnSorting="grvWorkcellList_Sorting" OnRowCommand="grvWorkcellList_RowCommand"
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
                                        <asp:BoundField DataField="WorkcellCode" HeaderText="Workcell Code" SortExpression="WorkcellCode"></asp:BoundField>
                                        <asp:BoundField DataField="JdocWorkcellCode" HeaderText="Jdoc Workcell Code" SortExpression="JdocWorkcellCode"></asp:BoundField>
                                        <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName"></asp:BoundField>
                                        <asp:BoundField DataField="LastUpdatedByUserName" HeaderText="Last Updated By" SortExpression="LastUpdatedByUserName" />
                                        <asp:BoundField DataField="LastUpdated" HeaderText="Last Updated" SortExpression="LastUpdated"/>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                    CssClass="ContextMenuTarget" />
                                                <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none; visibility: hidden;">
                                                    <asp:LinkButton runat="server" Text="Edit" CommandName="Select" CausesValidation="False"
                                                        CssClass="ContextMenuItem" ID="lbEdit" CommandArgument='<%# Eval("WorkcellID") %>'></asp:LinkButton>
                                                    <asp:LinkButton runat="server" Text="Delete" CommandName="Del" CausesValidation="False"
                                                        CssClass="ContextMenuItem" ID="lbDelete" CommandArgument='<%# Eval("WorkcellID") %>'></asp:LinkButton>
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeWorkcell" runat="server" TargetControlID="btnNewWorkcell"
                                    PopupControlID="pnWorkcellPopup" BackgroundCssClass="modalBackgroundCommon" CancelControlID="btnCancelWorkcell"
                                    DropShadow="false" PopupDragHandleControlID="pnWorkcellPopupDrag" BehaviorID="bhvmpeWorkcell">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 800px;" ID="pnWorkcellPopup"
                                    runat="server">
                                    <asp:Panel class="modalPopupDrag" ID="pnWorkcellPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add/ Update/ Delete Workcell
                                            </p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label4" runat="server" Text="Workcell Code">
                                                    </asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvWorkcellCode" runat="server" ValidationGroup="vgworkcell"
                                                        ToolTip="Workcell code is required." ErrorMessage="Workcell code is required."
                                                        ControlToValidate="txtWorkcellCode">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWorkcellCode" runat="server" Width="99%" ValidationGroup="vgworkcell">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblJdocWorkcellCode" runat="server" Text="Jdoc Workcell Code"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtJdocWorkcellCode" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Add" runat="server" Text="Workcell Name">
                                                    </asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvWorkcellName" runat="server" ValidationGroup="vgworkcell"
                                                        ToolTip="Workcell name is required." ErrorMessage="Workcell name is required."
                                                        ControlToValidate="txtWorkcellName">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWorkcellName" runat="server" Width="99%" ValidationGroup="vgworkcell">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Label ID="lblWorkcellMessage" runat="server" CssClass="errorMsg">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Save" ValidationGroup="vgworkcell"></asp:Button>
                                                    <asp:Button ID="btnUpdateAsk" runat="server" Text="Update" CssClass="button" UseSubmitBehavior="False"
                                                        ValidationGroup="vgworkcell" OnClientClick="return WorkcellUpdateValidation();"></asp:Button>
                                                    <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                        Text="Delete" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnCancelWorkcell" runat="server" UseSubmitBehavior="False" CssClass="button"
                                                        Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>

                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate" runat="server" TargetControlID="lblUpdateControl"
                                    BackgroundCssClass="modalBackgroundConfirm" CancelControlID="btnCancelUpdate"
                                    PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmUpdate" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" align="center" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update Workcell Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this workcell?"></asp:Label>
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
                                    <asp:HiddenField ID="hdWorkcellID" runat="server" Value="0" />
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

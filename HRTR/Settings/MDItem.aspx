<%@ Page Title="Master Data Item" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="MDItem.aspx.cs" Inherits="SystemAuth.Settings.MDItem" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Master Data Item</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/MDItem.js"></asp:ScriptReference>
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
                                                    <asp:Label ID="Label14" runat="server" Text="Master Data Type"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:DropDownList ID="ddlMDTypeS" runat="server" AppendDataBoundItems="True" DataTextField="MDTypeName"
                                                        DataValueField="MDTypeID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label7" runat="server" Text="Code"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtMDItemCodeS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label48" runat="server" Text="Description"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtDescriptionS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label44" runat="server" Text="Active"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                        <asp:ListItem Value="-1">[All]</asp:ListItem>
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="0">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                        CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                </td>
                                                <td colspan="7">
                                                  <asp:Label ID="lblMDItem" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnNewMDItem" runat="server" CssClass="button" OnClientClick="return NewMDItem();"
                                    Text="New" UseSubmitBehavior="False" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvMDItemList" runat="server" AllowPaging="True" AllowSorting="True"
                                    AutoGenerateColumns="False" DataKeyNames="MDItemID" CssClass="gridview" PagerStyle-CssClass="pgr"
                                    EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                    FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal"
                                    OnPageIndexChanging="grvMDItemList_PageIndexChanging" OnRowCommand="grvMDItemList_RowCommand"
                                    OnRowDataBound="grvMDItemList_RowDataBound" OnSorting="grvMDItemList_Sorting">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="MDTypeName" HeaderText="Master Data Type" SortExpression="MDTypeName" />
                                        <asp:BoundField DataField="MDItemCode" HeaderText="Code" SortExpression="MDItemCode" />
                                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                        <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                                            <ItemStyle CssClass="checkbox" />
                                        </asp:CheckBoxField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                    CssClass="ContextMenuTarget" />
                                                <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none;
                                                    visibility: hidden;">
                                                    <asp:LinkButton ID="lbEdit" runat="server" CausesValidation="False" CommandArgument='<%# Eval("MDItemID") %>'
                                                        CssClass="ContextMenuItem" CommandName="Select" Text="Edit"></asp:LinkButton>
                                                    <asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("MDItemID") %>'
                                                        CssClass="ContextMenuItem" CommandName="Del" Text="Delete"></asp:LinkButton>
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeMDItem" runat="server" BehaviorID="bhvmpeMDItem"
                                    PopupDragHandleControlID="pnMDItemPopupDrag" DropShadow="false" CancelControlID="btnCancelMDItem"
                                    BackgroundCssClass="modalBackgroundCommon" PopupControlID="pnMDItemPopup" TargetControlID="btnNewMDItem"
                                    OkControlID="btnReturnMDItem">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 400px;" ID="pnMDItemPopup"
                                    runat="server">
                                    <asp:Panel ID="pnMDItemPopupDrag" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                New Master Data Item</p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 25%;">
                                                    <asp:Label ID="Label15" runat="server" Text="Master Data Type"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlMDType" runat="server" AppendDataBoundItems="True" DataTextField="MDTypeName"
                                                        DataValueField="MDTypeID" Enabled="False" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text="Item Code">
                                                    </asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvMDItemCode" runat="server" ControlToValidate="txtMDItemCode"
                                                        ErrorMessage="Item Code is required." ToolTip="Item Code is required." ValidationGroup="vgmditem">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtMDItemCode" runat="server" Width="99%" ValidationGroup="vgmditem">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Add0" runat="server" Text="Description">
                                                    </asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDescription"
                                                        ErrorMessage="Description is required." ToolTip="Description is required." ValidationGroup="vgmditem">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDescription" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="Active" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;" colspan="2">
                                                    <asp:Label ID="lblMDItemMessage" runat="server" EnableViewState="False">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center;">
                                                    <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Save" ValidationGroup="vgmditem"></asp:Button>
                                                    <asp:Button ID="btnUpdateAsk" runat="server" Text="Update" CssClass="button" UseSubmitBehavior="False"
                                                        ValidationGroup="vgmditem" OnClientClick="return MDItemUpdateValidation();">
                                                    </asp:Button>
                                                    <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                        Text="Delete" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnCancelMDItem" runat="server" UseSubmitBehavior="False" CssClass="button"
                                                        Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <ajaxToolkit:ModalPopupExtender ID="mpeMessage" runat="server" TargetControlID="lblMessageControl"
                                    BackgroundCssClass="modalBackgroundConfirm" OkControlID="btnMessage" PopupControlID="PanelConfirm"
                                    BehaviorID="bhmpeMessage" DropShadow="false" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirm" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="confirmtable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaption" runat="server" Text="Master Data">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/infoconfirm.jpg" alt="!" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblMessage" runat="server" CssClass="confirmmessage">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Button ID="btnMessage" runat="server" CssClass="button" OnClientClick="return false;"
                                                        Text="OK" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate" TargetControlID="lblUpdateControl"
                                    CancelControlID="btnCancelUpdate" OkControlID="btnUpdateR">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="PanelConfirmUpdate" runat="server" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update Master Data Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this item?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnUpdate" runat="server" CssClass="button" OnClick="btnUpdate_Click"
                                                                        Text="OK"  />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelUpdate" runat="server" CssClass="button" OnClientClick="return false;"
                                                                        Text="Cancel"  />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
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
                                                    <img src="../Images/updateprogress.gif" alt="Processing..." />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server">Processing...</asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                <div style="visibility: hidden">
                                    <asp:HiddenField ID="hdMDItemID" runat="server" />
                                    <asp:Label ID="lblMessageControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                    <asp:Button ID="btnReturnMDItem" runat="server" CssClass="button" OnClientClick="return false;"
                                        UseSubmitBehavior="False" />
                                    <asp:Button ID="btnUpdateR" runat="server" CssClass="button" OnClientClick="return false;"
                                        UseSubmitBehavior="False" />
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

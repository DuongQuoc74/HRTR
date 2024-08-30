<%@ Page Title="Family" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="Product.aspx.cs" Inherits="HRTR.TR.Product" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Family</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Product.js"></asp:ScriptReference>
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
                                                    <asp:Label ID="Label10" runat="server" Text="Training Group"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:DropDownList ID="ddlTrainingGroupS" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="TrainingGroupName" DataValueField="TrainingGroupID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label3" runat="server" Text="Family Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtProductNameS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                        CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnNewProduct" runat="server" OnClientClick="return NewProduct();"
                                    UseSubmitBehavior="False" CssClass="button" Text="New"></asp:Button>
                                <asp:Label ID="lblProduct" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvProductList" runat="server" OnRowDataBound="grvProductList_RowDataBound"
                                    PageSize="20" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                    DataKeyNames="ProductID" OnPageIndexChanging="grvProductList_PageIndexChanging"
                                    OnSorting="grvProductList_Sorting" OnRowCommand="grvProductList_RowCommand" CssClass="gridview"
                                    PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected"
                                    HeaderStyle-CssClass="header" FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate"
                                    RowStyle-CssClass="normal">
                                    <PagerSettings Mode="NumericFirstLast"></PagerSettings>
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ProductName" HeaderText="Family Name" SortExpression="ProductName" />
                                        <asp:BoundField DataField="TrainingGroupName" HeaderText="Training Group" SortExpression="TrainingGroupName" />
                                          <asp:BoundField DataField="LastUpdatedBy" HeaderText="Last Updated By" SortExpression="LastUpdatedBy" />
                                            <asp:BoundField DataField="LastUpdated" HeaderText="Last Updated" SortExpression="LastUpdated" />
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                    CssClass="ContextMenuTarget" />
                                                <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none;
                                                    visibility: hidden;">
                                                    <asp:LinkButton runat="server" Text="Edit" CommandName="Select" CausesValidation="False"
                                                        CssClass="ContextMenuItem" ID="lbEdit" CommandArgument='<%# Eval("ProductID") %>'></asp:LinkButton>
                                                    <asp:LinkButton runat="server" Text="Delete" CommandName="Del" CausesValidation="False"
                                                        CssClass="ContextMenuItem" ID="lbDelete" CommandArgument='<%# Eval("ProductID") %>'></asp:LinkButton>
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeProduct" runat="server" TargetControlID="btnNewProduct"
                                    PopupControlID="pnProductPopup" BackgroundCssClass="modalBackgroundCommon" CancelControlID="btnCancelProduct"
                                    DropShadow="false" PopupDragHandleControlID="pnProductPopupDrag" BehaviorID="bhvmpeProduct">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 800px;" ID="pnProductPopup"
                                    runat="server">
                                    <asp:Panel  class="modalPopupDrag" ID="pnProductPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add/ Update/ Delete Family</p>
                                        </div>
                                    </asp:Panel>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 30%;">
                                                    <asp:Label ID="Label14" runat="server" Text="Training Group"></asp:Label>
                                                    <asp:CustomValidator ID="cvTrainingGroup" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlTrainingGroup" ErrorMessage="Training Group is required."
                                                        ValidationGroup="vgproduct">(*)</asp:CustomValidator>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTrainingGroup" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="TrainingGroupName" DataValueField="TrainingGroupID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Add" runat="server" Text="Family Name">
                                                    </asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ValidationGroup="vgproduct"
                                                        ToolTip="Family Name is required." ErrorMessage="Family Name is required."
                                                        ControlToValidate="txtProductName">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtProductName" runat="server" Width="99%" ValidationGroup="vgproduct">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Label ID="lblProductMessage" runat="server" CssClass="errorMsg">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" UseSubmitBehavior="False"
                                                        CssClass="button" Text="Save" ValidationGroup="vgproduct"></asp:Button>
                                                    <asp:Button ID="btnUpdateAsk" runat="server" Text="Update" CssClass="button" UseSubmitBehavior="False"
                                                        ValidationGroup="vgproduct" OnClientClick="return ProductUpdateValidation();">
                                                    </asp:Button>
                                                    <asp:Button ID="btnDelete" runat="server" CssClass="button" OnClick="btnDelete_Click"
                                                        Text="Delete" UseSubmitBehavior="False" />
                                                    <asp:Button ID="btnCancelProduct" runat="server" UseSubmitBehavior="False" CssClass="button"
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
                                                    <asp:Label ID="lblCaptionC" runat="server">Update Family Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../Images/question.png" alt="" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this Family?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                                     <asp:Button ID="btnUpdate" runat="server"  Text="OK" CssClass="button"
                                                                        OnClick="btnUpdate_Click"></asp:Button>
                                                    <asp:Button ID="btnCancelUpdate" runat="server"  Text="Cancel" CssClass="button"
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
                                    <asp:HiddenField ID="hdMenuID" runat="server" />
                                    <asp:HiddenField ID="hdProductID" runat="server" Value="0" />
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

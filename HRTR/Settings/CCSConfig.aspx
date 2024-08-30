<%@ Page Title="CCS Config" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="CCSConfig.aspx.cs" Inherits="SystemAuth.Settings.CCSConfig" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            CCS Config
        </div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/CCSConfig.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>CCS Config</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label14" runat="server" Text="Open VA"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlRequireVABeforeMES" ErrorMessage="Open VA is required." ValidationGroup="vgedit">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:DropDownList ID="ddlRequireVABeforeMES" runat="server" AppendDataBoundItems="True" Width="150px">
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="2">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                 <td style="width: 10%;">
                                                    <asp:Label ID="Label1" runat="server" Text="Applied CCS"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                        ControlToValidate="ddlIsAppliedCCS" ErrorMessage="Applied CCS is required." ValidationGroup="vgedit">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:DropDownList ID="ddlIsAppliedCCS" runat="server" AppendDataBoundItems="True" Width="150px">
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="2">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label8" runat="server" Text="Comments"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtComments"
                                                        ErrorMessage="Comments is required." ToolTip="Comments is required." ValidationGroup="vgedit">(*)</asp:RequiredFieldValidator>
                                                </td>
                                                <td style="width: 25%;">
                                                    <asp:TextBox ID="txtComments" runat="server" Width="99%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="7">
                                                    <table class="tableapply">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblApply" runat="server" Text=""></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Button ID="btnApplyAsk" runat="server" Text="Apply" CssClass="button" UseSubmitBehavior="False"
                                                                    ValidationGroup="vgedit" OnClientClick="return ConfirmationApplyCheck();"></asp:Button>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                    PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate" TargetControlID="lblUpdateControl"
                    CancelControlID="btnCancelUpdate">
                </ajaxToolkit:ModalPopupExtender>
                <asp:Panel Style="display: none" ID="PanelConfirmUpdate" runat="server" CssClass="modalPopupConfirm">
                    <table class="questiontable">
                        <tbody>
                            <tr>
                                <td class="confirmheader" colspan="2">
                                    <asp:Label ID="lblCaptionC" runat="server">Update Configuration Confirmation</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <img src="../Images/question.png" alt="?" />
                                </td>
                                <td>
                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update?"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center; white-space: nowrap;">
                                    <asp:Button ID="btnUpdate" runat="server" CssClass="button" OnClick="btnUpdate_Click"
                                        Text="OK" Width="70px" />
                                    <asp:Button ID="btnCancelUpdate" runat="server" CssClass="button" OnClientClick="return false;"
                                        Text="Cancel" Width="70px" />
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
                    <asp:HiddenField ID="hdMenuID" runat="server" />
                    <asp:Label ID="lblUpdateControl" runat="server">
                    </asp:Label>
                    <asp:Label ID="lblProcessingControl" runat="server">
                    </asp:Label>
                </div>
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

<%@ Page Title="Station" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="Station.aspx.cs" Inherits="HRTR.TR.Station" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">Station</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True" EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Station.js"></asp:ScriptReference>
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
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text="Station Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStationNameS" runat="server" Width="250px" CssClass="edccinput"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label47" runat="server" Text="Workcell"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlWorkcellS" runat="server" AppendDataBoundItems="True" CssClass="edccinput"
                                                        DataTextField="WorkcellName" DataValueField="WorkcellID" Width="250px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search" CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                </td>
                                                <td>
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
                                <asp:Button ID="btnAddControl" runat="server" UseSubmitBehavior="False" CssClass="button"
                                    Text="New" OnClientClick="return showModalAdd();"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvStationList" runat="server" CssClass="gridview" PagerStyle-CssClass="pgr"
                                    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="StationID"
                                    EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                    FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal"
                                    OnPageIndexChanging="grvStationList_PageIndexChanging"
                                    OnSorting="grvStationList_Sorting" OnRowCommand="grvStationList_RowCommand" PageSize="20">
                                    <PagerSettings Mode="NumericFirstLast"></PagerSettings>
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="StationName" HeaderText="Station Name" SortExpression="StationName">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName">
                                        </asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                    CssClass="ContextMenuTarget" />
                                                <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none;
                                                    visibility: hidden;">
                                                    <asp:LinkButton runat="server" Text="Edit" CommandName="Select" CausesValidation="False"
                                                        CssClass="ContextMenuItem" ID="lbEdit" CommandArgument='<%# Eval("StationID") + "@$" + Eval("StationName") + "@$" + Eval("WorkcellID") %>'></asp:LinkButton>
                                                    <asp:LinkButton runat="server" Text="Delete" CommandName="DelStation" CausesValidation="False"
                                                        CssClass="ContextMenuItem" ID="lbDelete" CommandArgument='<%# Eval("StationID") + "@$" + Eval("StationName") + "@$" + Eval("WorkcellID") %>'></asp:LinkButton>
                                                </asp:Panel>
                                                <ajaxToolkit:DropDownExtender runat="server" ID="DDE" TargetControlID="TextLabel"
                                                    DropDownControlID="DropPanel" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeUpdate" runat="server" BehaviorID="bhvmpeUpdate"
                                    PopupDragHandleControlID="PanelUpdate1" DropShadow="false" CancelControlID="btnCancelU"
                                    OnOkScript="btnReturnU" BackgroundCssClass="modalBackgroundCommon" PopupControlID="PanelUpdate"
                                    TargetControlID="btnUpdateControl" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 350px;" ID="PanelUpdate"
                                    runat="server">
                                    <asp:Panel ID="PanelUpdate1" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Update Station</p>
                                        </div>
                                    </asp:Panel>
                                    <table border="0" align="center">
                                        <tbody>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label6" runat="server" Text="Name">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStationNameU" runat="server" CssClass="edccinput" ValidationGroup="vgupdatestation"
                                                        Width="224px">
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="rfvStationName" runat="server" ValidationGroup="vgupdatestation"
                                                        Display="Dynamic" ControlToValidate="txtStationNameU" ErrorMessage="Station name is required."
                                                        ToolTip="Station name is required.">(*)</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label4" runat="server" Text="Workcell"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlWorkcellU" runat="server" CssClass="edccinput" Width="224px"
                                                        meta:resourcekey="ddlWorkCellResource1" AppendDataBoundItems="True" DataTextField="WorkcellName"
                                                        DataValueField="WorkcellID">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:CustomValidator ID="cvWorkcellU" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                                ControlToValidate="ddlWorkcellU" ErrorMessage="Workcell is required."
                                                                ValidationGroup="vgupdatestation">(*)</asp:CustomValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: red" align="center" colspan="3">
                                                    <asp:Label ID="lblUpdateErr" runat="server" EnableViewState="False">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: red" align="center" colspan="3">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnUpdateAsk" OnClientClick="return updateValidation();" runat="server"
                                                                        Text="Update" CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgupdatestation">
                                                                    </asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelU" runat="server" Text="Cancel" CssClass="button" UseSubmitBehavior="False"
                                                                        OnClientClick="return false;"></asp:Button>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeAdd" runat="server" BehaviorID="bhvmpeAdd"
                                    PopupDragHandleControlID="PanelAdd1" DropShadow="false" CancelControlID="btnCancelA"
                                    BackgroundCssClass="modalBackgroundCommon" PopupControlID="PanelAdd" TargetControlID="btnAddControl"
                                    OkControlID="btnReturnA">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 350px;" ID="PanelAdd"
                                    runat="server">
                                    <asp:Panel ID="PanelAdd1" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                New Station</p>
                                        </div>
                                    </asp:Panel>
                                    <table border="0" align="center">
                                        <tbody>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Add" runat="server" Text="Name">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStationNameA" runat="server" CssClass="edccinput" Width="99%"
                                                        ValidationGroup="vgnewStation" AutoCompleteType="DisplayName">
                                                    </asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="rfvStationNameA" runat="server" ValidationGroup="vgnewStation"
                                                        ToolTip="Station name is required." ErrorMessage="Station name is required."
                                                        ControlToValidate="txtStationNameA">(*)</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label4Add" runat="server" Text="Workcell"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlWorkcellA" runat="server" CssClass="edccinput" Width="99%"
                                                        DataValueField="WorkcellID" DataTextField="WorkcellName" AppendDataBoundItems="True"
                                                        meta:resourcekey="ddlWorkCellResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:CustomValidator ID="cvWorkcellA" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                                ControlToValidate="ddlWorkcellA" ErrorMessage="Workcell is required."
                                                                ValidationGroup="vgnewStation">(*)</asp:CustomValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: red" align="center" colspan="3">
                                                    <asp:Label ID="lblAddErr" runat="server" EnableViewState="False">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <table >
                                                        <tbody>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:Button ID="btnAdd" OnClick="btnAdd_Click"  runat="server" UseSubmitBehavior="False"
                                                                        CssClass="button" Text="Save" ValidationGroup="vgnewStation"></asp:Button>
                                                                
                                                                    <asp:Button ID="btnCancelA" runat="server" UseSubmitBehavior="False" CssClass="button"
                                                                        Text="Cancel" OnClientClick="return false;"></asp:Button>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeDelete" runat="server" BehaviorID="bhvmpeDelete"
                                    PopupDragHandleControlID="PanelDelete1" DropShadow="false" CancelControlID="btnCancelD"
                                    BackgroundCssClass="modalBackgroundCommon" PopupControlID="PanelDelete" TargetControlID="btnDeleteControl"
                                    Enabled="True" OkControlID="btnReturnD">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 350px;" ID="PanelDelete"
                                    runat="server">
                                    <asp:Panel ID="PanelDelete1" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Delete Station</p>
                                        </div>
                                    </asp:Panel>
                                    <table border="0" align="center">
                                        <tbody>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label2" runat="server" Text="Name">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStationNameD" runat="server" CssClass="edccinput" Enabled="False"
                                                        Width="224px">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label3" runat="server" Text="Workcell">
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlWorkcellD" runat="server" CssClass="edccinput" Enabled="False"
                                                        Width="224px" meta:resourcekey="ddlWorkCellResource1" AppendDataBoundItems="True"
                                                        DataTextField="WorkcellName" DataValueField="WorkcellID">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: red" align="center" colspan="2">
                                                    <asp:Label ID="lblDeleteErr" runat="server" EnableViewState="False">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: red" align="center" colspan="2">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnDelete"  runat="server" Text="Delete" OnClick="btnDelete_Click"
                                                                        CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelD" runat="server" Text="Cancel" CssClass="button" UseSubmitBehavior="False"
                                                                        OnClientClick="return false;"></asp:Button>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeMessage" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    BehaviorID="bhmpeMessage" DropShadow="false" Enabled="True" OkControlID="btnMessage"
                                    PopupControlID="PanelConfirm" TargetControlID="lblMessageControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirm" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="confirmtable">
                                        <tbody>
                                            <tr>
                                                <td style="text-align: center" class="confirmheader" colspan="2">
                                                    <asp:Label ID="lblCaption" runat="server">Station</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center">
                                                    <img style="width: 45px; height: 45px" src="../Images/infoconfirm.jpg" alt="?" />
                                                </td>
                                                <td style="text-align: center">
                                                    <asp:Label Style="text-align: center" ID="lblMessage" runat="server" CssClass="confirmmessage">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btnMessage" runat="server" Text="OK" CssClass="button" OnClientClick="return false;">
                                                    </asp:Button>
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
                                    OkControlID="btnUpdateR" PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmUpdate" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" align="center" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update Station Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img style="width: 45px; height: 45px" src="../Images/question.png" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this station?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" runat="server" Width="70px" Text="OK" CssClass="button"></asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelUpdate" runat="server" Width="70px" Text="Cancel" CssClass="button" OnClientClick="return false;"></asp:Button>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
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
                                                    <img style="width: 45px; height: 45px" src="../Images/updateprogress.gif" alt="?" />
                                                </td>
                                                <td>
                                                    <asp:Label Style="text-align: center" ID="Label13" runat="server">Processing...</asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="visibility: hidden">
                                    <asp:HiddenField ID="hdStationID" runat="server" Value="0" />
                                    <asp:Label ID="lblMessageControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                    <asp:Button ID="btnDeleteControl" runat="server" UseSubmitBehavior="False" Text="Delete">
                                    </asp:Button>
                                    <asp:Button ID="btnUpdateControl" runat="server" UseSubmitBehavior="False" Text="Update">
                                    </asp:Button>
                                    <asp:Button ID="btnReturnU" OnClientClick="return false;" runat="server" UseSubmitBehavior="False">
                                    </asp:Button>
                                    <asp:Button ID="btnUpdateR" OnClientClick="return false;" runat="server" UseSubmitBehavior="False">
                                    </asp:Button>
                                    <asp:Button ID="btnReturnD" OnClientClick="return false;" runat="server" UseSubmitBehavior="False">
                                    </asp:Button>
                                    <asp:Button ID="btnReturnA" OnClientClick="return false;" runat="server" UseSubmitBehavior="False">
                                    </asp:Button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>   
            </ContentTemplate>
        </asp:UpdatePanel>
       
    </div>
</asp:Content>

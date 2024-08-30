<%@ Page Title="" Language="C#" MasterPageFile="~/HCM.master" AutoEventWireup="true" CodeFile="Config.aspx.cs" Inherits="HRTR_Config" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" Runat="Server">


    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Config Data</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/UserProfile.js">
                </asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Common2.js">
                </asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnAddControl" runat="server" Text="New"
                                    CssClass="button" UseSubmitBehavior="False" 
                                    OnClientClick="return showModalAdd();" >
                                </asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvConfig" runat="server"
                                    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                                    CellPadding="2" CellSpacing="1" 
                                    ForeColor="#333333" OnRowCommand="grvConfig_RowCommand">
                                    <PagerSettings Mode="NumericFirstLast">
                                    </PagerSettings>
                                    <RowStyle ForeColor="#333333" Height="20px"></RowStyle>
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Name" HeaderText="Name"></asp:BoundField>
                                        <asp:BoundField DataField="Value" HeaderText="Value"></asp:BoundField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:Label ID="TextLabel" runat="server" Text="Select" Style="display: block; width: 50px;"
                                                    class="ContextMenuTarget" />
                                                <asp:Panel ID="DropPanel" runat="server" CssClass="ContextMenuPanel" Style="display: none;
                                                    visibility: hidden;">
                                                    <asp:LinkButton runat="server" Text="Edit" CommandName="Select" CausesValidation="False"
                                                        ID="LinkButton1" CommandArgument='<%# Eval("Name") %>' CssClass="ContextMenuItem"></asp:LinkButton>
                                                   <%-- <asp:LinkButton runat="server" Text="Delete" CommandName="DelUser" CausesValidation="False"
                                                        ID="LinkButton2" CommandArgument='<%# Eval("Name") %>' CssClass="ContextMenuItem"></asp:LinkButton>--%>
                                                </asp:Panel>
                                                <ajaxToolkit:DropDownExtender runat="server" ID="DDE" TargetControlID="TextLabel"
                                                    DropDownControlID="DropPanel" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White">
                                    </FooterStyle>
                                    <PagerStyle HorizontalAlign="Right" BackColor="#284775" ForeColor="White">
                                    </PagerStyle>
                                    <SelectedRowStyle BackColor="#EDDA74" Font-Bold="True" ForeColor="#333333">
                                    </SelectedRowStyle>
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Height="20px">
                                    </HeaderStyle>
                                    <EditRowStyle BackColor="#999999"></EditRowStyle>
                                    <AlternatingRowStyle Wrap="True" BackColor="AliceBlue" ForeColor="#284775">
                                    </AlternatingRowStyle>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeUpdate" runat="server" BehaviorID="bhvmpeUpdate"
                                    PopupDragHandleControlID="PanelUpdate1" DropShadow="false" CancelControlID="btnCancelU"
                                    OkControlID="btnReturnU" BackgroundCssClass="modalBackgroundCommon" PopupControlID="PanelUpdate"
                                    TargetControlID="btnUpdateControl" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none; width: 550px;" ID="PanelUpdate" runat="server" CssClass="modalPopupCommon">
                                    <asp:Panel ID="PanelUpdate1" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Update Config</p>
                                        </div>
                                    </asp:Panel>
                                    <table border="0" align="center">
                                        <tbody>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="UserNameLabel11" runat="server">Name</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNameU" runat="server" CssClass="hrtrinput" Width="224px" 
                                                        Enabled="False"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNameU"
                                                        Display="Dynamic" ErrorMessage="User name is required." ToolTip="User name is required."
                                                        ValidationGroup="vgupdateuser">(*)</asp:RequiredFieldValidator>
                                                </td>
                                           
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label45" runat="server" Text="Value"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtValueU" runat="server" CssClass="hrtrinput" ValidationGroup="vgupdateuser"
                                                        Width="224px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="rfvEmployeeIDUpdate" runat="server" ControlToValidate="txtValueU"
                                                        Display="Dynamic" ErrorMessage="txtValueU ID is required." ToolTip="txtValueU ID is required."
                                                        ValidationGroup="vgupdateuser">(*)</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        
                                        
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnUpdate" OnClientClick="return updateValidation();" runat="server"
                                                                        Text="Update" CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgupdateuser">
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeDelete" runat="server" BehaviorID="bhvmpeDelete"
                                    PopupDragHandleControlID="PanelDelete1" DropShadow="false" CancelControlID="btnCancelD"
                                    OkControlID="btnReturnD" BackgroundCssClass="modalBackgroundCommon" PopupControlID="PanelDelete"
                                    TargetControlID="btnDeleteControl" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 550px;" ID="PanelDelete"
                                    runat="server">
                                    <asp:Panel ID="PanelDelete1" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Delete Config</p>
                                        </div>
                                    </asp:Panel>
                                    <table border="0" align="center">
                                        <tbody>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label2" runat="server">Name</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNameD" runat="server" CssClass="hrtrinput" Width="224px"
                                                        Enabled="False"></asp:TextBox>
                                                </td>
                                      
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label8" runat="server" Text="Value"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtValueD" runat="server" CssClass="hrtrinput" ValidationGroup="vgDeleteuser"
                                                        Width="224px" Enabled="False"></asp:TextBox>
                                                </td>
                                            </tr>
                            
                                            <tr>
                                                <td style="color: red" align="center" colspan="3">
                                                    <asp:Label ID="lblDeleteErr" runat="server" Text="" CssClass="error"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: red" align="center" colspan="3">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnDelete" OnClick="btnDelete_Click" runat="server" Text="Delete"
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
                            <td style="height: 19px">
                                <ajaxToolkit:ModalPopupExtender ID="mpeAdd" runat="server" BehaviorID="bhvmpeAdd"
                                    PopupDragHandleControlID="PanelAdd1" DropShadow="false" CancelControlID="btnCancelA"
                                    OkControlID="btnReturnA" BackgroundCssClass="modalBackgroundCommon" PopupControlID="PanelAdd"
                                    TargetControlID="btnAddControl" CacheDynamicResults="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 550px;" ID="PanelAdd"
                                    runat="server">
                                    <asp:Panel ID="PanelAdd1" class="modalPopupDrag" runat="server">
                                        <div>
                                            <p>
                                                Add New User</p>
                                        </div>
                                    </asp:Panel>
                                    <table border="0" align="center">
                                        <tbody>
                                            <tr>
                                                <td>
                                                </td>
                                          
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="UserNameLabelAdd" runat="server">Name</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNameA" runat="server" CssClass="hrtrinput" TabIndex="1" Width="224px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="txtNameA"
                                                        ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="vgnewuser">(*)</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Add0" runat="server" Text="Value"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtValueA" runat="server" CssClass="hrtrinput" TabIndex="2"
                                                        Width="224px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="rfvEmployeeIDAdd" runat="server" ControlToValidate="txtValueA"
                                                        ErrorMessage="txtValueA is required." ToolTip="txtValueA is required." ValidationGroup="vgnewuser">(*)</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                               
                                            <tr>
                                                <td style="color: red" align="center" colspan="4">
                                                    <asp:Label ID="lblAddErr" runat="server" Text="" CssClass="error">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td style="width: 3px">
                                                                    <asp:Button ID="btnAdd" TabIndex="10" OnClick="btnAdd_Click" runat="server" Text="Save"
                                                                        CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgnewuser">
                                                                    </asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelA" runat="server" Text="Cancel" CssClass="button" UseSubmitBehavior="False"
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
                                                    <asp:Label ID="lblCaption" runat="server" __designer:wfdid="w36">User Profile</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center">
                                                    <img style="width: 45px; height: 45px" src="images/infoconfirm.jpg" />
                                                </td>
                                                <td style="text-align: center">
                                                    <asp:Label Style="text-align: center" ID="lblMessage" runat="server" CssClass="confirmmessage"
                                                        __designer:wfdid="w37">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btnMessage" runat="server" Text="OK" CssClass="button" __designer:wfdid="w38"
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate" runat="server" TargetControlID="lblUpdateControl"
                                    BackgroundCssClass="modalBackgroundConfirm" CancelControlID="btnCancelUpdate"
                                    OkControlID="btnOKUpdateR" PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirmUpdate" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                    <table class="questiontable">
                                        <tbody>
                                            <tr>
                                                <td class="confirmheader" align="center" colspan="2">
                                                    <asp:Label ID="lblCaptionC" runat="server">Update User Confirmation</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img style="width: 45px; height: 45px" src="images/question.png" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Are you sure you want to update this user?"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnOKUpdate" runat="server" Width="70px" Text="OK" CssClass="button"
                                                                        OnClick="btnOKUpdate_Click"></asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelUpdate" runat="server" Width="70px" Text="Cancel" CssClass="button"
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
                                <ajaxToolkit:ModalPopupExtender ID="mpeProcessing" runat="server" Enabled="True"
                                    BackgroundCssClass="modalBackgroundProcessing" PopupControlID="PanelProcessing"
                                    DropShadow="false" BehaviorID="bhmpeProcessing" TargetControlID="lblProcessingControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="PanelProcessing" runat="server" CssClass="modalPopupProcessing">
                                    <table class="processingtable">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <img style="width: 45px; height: 45px" src="images/updateprogress.gif" />
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
                                    <asp:Label ID="lblMessageControl" runat="server" __designer:wfdid="w39">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateControl" runat="server" __designer:wfdid="w15">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server" __designer:wfdid="w15">
                                    </asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hdUserProfileID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="visibility: hidden">
                                    <asp:Button ID="btnUpdateControl" runat="server" Text="Edit" __designer:wfdid="w79"
                                        CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                    <asp:Button ID="btnDeleteControl" runat="server" Text="Delete" __designer:wfdid="w79"
                                        CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                    <asp:Button ID="btnReturnU" OnClientClick="return false;" runat="server" CssClass="button"
                                        __designer:wfdid="w76" UseSubmitBehavior="False"></asp:Button>
                                    <asp:Button ID="btnReturnD"
                                            OnClientClick="return false;" runat="server" CssClass="button" __designer:wfdid="w76"
                                            UseSubmitBehavior="False"></asp:Button>
                                    <asp:Button ID="btnReturnA" OnClientClick="return false;" runat="server" Text="Save"
                                        CssClass="button" UseSubmitBehavior="False" ValidationGroup="vgnewuser">
                                    </asp:Button>
                                    <asp:Button ID="btnOKUpdateR" OnClientClick="return false;" runat="server" __designer:wfdid="w76"
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
                               
                            <EnableAction AnimationTarget="btnSearch" Enabled="False" />
                            <EnableAction AnimationTarget="btnAdd" Enabled="False" />
                            <EnableAction AnimationTarget="btnDelete" Enabled="False" />
                            <EnableAction AnimationTarget="btnOKUpdate" Enabled="False" />
                        </Parallel>
                    </Sequence> </OnUpdating>
        <OnUpdated>   
        <Sequence>
        <ScriptAction Script="$find('bhmpeProcessing').hide();" />
         <Parallel duration="0">
         
                             <EnableAction AnimationTarget="btnSearch" Enabled="True" />
                             <EnableAction AnimationTarget="btnAdd" Enabled="True" />
                            <EnableAction AnimationTarget="btnDelete" Enabled="True" />
                            <EnableAction AnimationTarget="btnOKUpdate" Enabled="True" />
                              </Parallel>             
                    </Sequence></OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </div>


</asp:Content>


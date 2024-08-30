<%@ Page Title="Grape Chart Dashboards" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true" CodeBehind="GC_Dashboards.aspx.cs" Inherits="HRTR.GrapeChart.GC_Dashboards" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader" runat="server" id="divheader">
            Grape Chart Dashboards</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/GC_Dashboards.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="upHRTR" runat="server">
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
                                                    <asp:Label ID="Label22" runat="server" Text="Workcell"></asp:Label>
                                                    <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="cv_ClientValidate"
                                                ControlToValidate="ddlGC_CustomersS" ErrorMessage="Customer is required."
                                                ValidationGroup="vgsearch">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 15%">
                                                    <asp:DropDownList ID="ddlGC_CustomersS" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="Customer" DataValueField="Customer_ID" Width="99%">
                                                    </asp:DropDownList>
                                                    <%-- <asp:DropDownList ID="ddlWorkcellS" runat="server" AppendDataBoundItems="True" DataTextField="WorkcellName"
                                                        DataValueField="WorkcellID" Width="99%">
                                                    </asp:DropDownList>--%>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label44" runat="server" Text="Grape Chart Type"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:DropDownList ID="ddlGrapeChartTypeS" runat="server" AppendDataBoundItems="True"
                                                        Width="99%">
                                                        <asp:ListItem Value="1">Defect Escapee</asp:ListItem>
                                                        <asp:ListItem Value="2">Defect Finder</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 5%;">
                                                    <asp:Label ID="Label2" runat="server">Month</asp:Label>
                                                </td>
                                                <td style="width: 5%;">
                                                    <asp:DropDownList ID="ddlMonthS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 5%;">
                                                    <asp:Label ID="Label1" runat="server">Year</asp:Label>
                                                </td>
                                                <td style="width: 5%;">
                                                    <asp:DropDownList ID="ddlYearS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbTopTen" runat="server" Text="Top 10"></asp:CheckBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="white-space: nowrap;">
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="button" OnClick="btnSearch_Click"
                                                        Text="View"  ValidationGroup="vgsearch" />
                                                </td>
                                                <td colspan="8">
                                                    <asp:Label ID="lblGrapeChartDashboards" runat="server" Text="" CssClass="message"></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
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
                                <div style="visibility: hidden">
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <ajaxToolkit:UpdatePanelAnimationExtender ID="upaeHRTR" runat="server" TargetControlID="upHRTR">
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

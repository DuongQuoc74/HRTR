<%@ Page Title="My Grape Chart" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="MyGrapeChart.aspx.cs" Inherits="HRTR.GrapeChart.MyGrapeChart" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader" runat="server" id="divheader">
            My Grape Chart</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/GrapeChartHTML_HTML5_Canvas.js?1627809471379"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/MyGrapeChart.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="upHRTR" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td colspan="2">
                                <fieldset>
                                    <legend>Search</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="width: 5%;">
                                                    <asp:Label ID="Label2" runat="server">Selected To Date</asp:Label>
                                                </td>
                                                <td style="width: 5%;">
                                                   <asp:TextBox
                                                        ID="txtToDate"
                                                        runat="server"
                                                        Width="80px" />

                                                    <img
                                                        id="imgToDate"
                                                        runat="server"
                                                        class="dateselected"
                                                        src="../Images/icon-calendar.gif"
                                                        alt="" />

                                                    <ajaxToolkit:CalendarExtender
                                                        ID="ceToDate"
                                                        runat="server"
                                                        CssClass="MyCalendar"
                                                        Enabled="True"
                                                        Format="MM/dd/yyyy"
                                                        PopupButtonID="imgToDate"
                                                        TargetControlID="txtToDate">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>                                                
                                            </tr>
                                            <tr>
                                                <td style="white-space: nowrap;">
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="button" OnClientClick="return RefreshGrapeChart(1);"
                                                        Text="View"  ValidationGroup="vgsearch" />
                                                </td>
                                                <td colspan="3">
                                                    <asp:Label ID="lblMyGrapeChart" runat="server" Text="" CssClass="message"></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="5" style="vertical-align: top; width: 50%;">                                
                                <div id="divMyGrapeChartByMonth">                                    
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="messageGrapeChart">
                                <asp:Label ID="lblGrapeChart" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="messageGrapeChart">
                                <asp:Label ID="lblEmployeeName" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="messageGrapeChart">
                                <asp:Label ID="lblMonthYear" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="GrapeChart">                                
                                <div id="animation_container" style="background-color:rgba(255, 255, 255, 1.00); width:300px; height:460px; margin:auto;">
		                            <canvas id="canvas" width="300" height="460" style="position: absolute; display: block; background-color:rgba(255, 255, 255, 1.00);"></canvas>
		                            <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:300px; height:460px; position: absolute; left: 0px; top: 0px; display: block;">
		                            </div>
	                            </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
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
                                <asp:HiddenField ID="hdIsLoaded" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdIsValidEmployeeID_ID" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdEmployeeID_ID" runat="server" />
                                    <asp:HiddenField ID="hdEmployeeName" runat="server" />
                                    <asp:HiddenField ID="hdServerDate" runat="server" />
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

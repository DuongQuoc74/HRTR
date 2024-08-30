<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GC_Dashboards_Workcell.aspx.cs"
    Inherits="HRTR.GrapeChart.GC_Dashboards_Workcell" Title="Grape Chart Dashboards Workcell" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Grape Chart Dashboards Workcell</title>
    <meta http-equiv="refresh" content="600" />
    <script src="../Scripts/jquery-1.7.min.js" type="text/javascript"></script>
    <script src="https://code.createjs.com/createjs-2015.11.26.min.js"></script>
    <script src="../Scripts/GrapeChartHTML_HTML5_Canvas.js?1627809471379" type="text/javascript"></script>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src="../Scripts/GC_Dashboards_Workcell.js" type="text/javascript"></script>
    <link href="../Styles/HRTR.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="frmGrapeChartDashboardsDetail" runat="server">
    <div id="divMainContent" style="height: 100%">
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="upHRTR" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="messageGrapeChart" colspan="4">
                                            <asp:Label ID="lblGrapeChart" runat="server" Text="" CssClass="GrapeChartDashboardsDetailTitle"></asp:Label>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="messageGrapeChart" style="width: 25%;">
                                            <asp:Label ID="lblEmployeeName1" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td class="messageGrapeChart" style="width: 25%;">
                                            <asp:Label ID="lblEmployeeName2" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td class="messageGrapeChart" style="width: 25%;">
                                            <asp:Label ID="lblEmployeeName3" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td class="messageGrapeChart">
                                            <asp:Label ID="lblEmployeeName4" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="GrapeChart">                                            
                                            <div id="animation_container1" style="background-color:rgba(255, 255, 255, 1.00); width:300px; height:460px; margin:auto;">
		                                        <canvas id="canvas1" width="300" height="460" style="position: absolute; display: block; background-color:rgba(255, 255, 255, 1.00);"></canvas>
		                                        <div id="dom_overlay_container1" style="pointer-events:none; overflow:hidden; width:300px; height:460px; position: absolute; left: 0px; top: 0px; display: block;">
		                                        </div>
	                                        </div>
                                        </td>
                                        <td class="GrapeChart">                                            
                                            <div id="animation_container2" style="background-color:rgba(255, 255, 255, 1.00); width:300px; height:460px; margin:auto;">
		                                        <canvas id="canvas2" width="300" height="460" style="position: absolute; display: block; background-color:rgba(255, 255, 255, 1.00);"></canvas>
		                                        <div id="dom_overlay_container2" style="pointer-events:none; overflow:hidden; width:300px; height:460px; position: absolute; left: 0px; top: 0px; display: block;">
		                                        </div>
	                                        </div>
                                        </td>
                                        <td class="GrapeChart">                                            
                                            <div id="animation_container3" style="background-color:rgba(255, 255, 255, 1.00); width:300px; height:460px; margin:auto;">
		                                        <canvas id="canvas3" width="300" height="460" style="position: absolute; display: block; background-color:rgba(255, 255, 255, 1.00);"></canvas>
		                                        <div id="dom_overlay_container3" style="pointer-events:none; overflow:hidden; width:300px; height:460px; position: absolute; left: 0px; top: 0px; display: block;">
		                                        </div>
	                                        </div>
                                        </td>
                                        <td class="GrapeChart">                                            
                                            <div id="animation_container4" style="background-color:rgba(255, 255, 255, 1.00); width:300px; height:460px; margin:auto;">
		                                        <canvas id="canvas4" width="300" height="460" style="position: absolute; display: block; background-color:rgba(255, 255, 255, 1.00);"></canvas>
		                                        <div id="dom_overlay_container4" style="pointer-events:none; overflow:hidden; width:300px; height:460px; position: absolute; left: 0px; top: 0px; display: block;">
		                                        </div>
	                                        </div>
                                        </td>
                                    </tr>
                                </table>
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
                                    <asp:HiddenField ID="hdEmployeeID_ID" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdCustomer_ID" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdCustomer" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdGrapeChartTypeID" runat="server" Value="1" />
                                    <asp:HiddenField ID="hdYear" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdMonth" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdDay" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdIsGrapeChartLoaded1" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdIsGrapeChartLoaded2" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdIsGrapeChartLoaded3" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdIsGrapeChartLoaded4" runat="server" Value="0" />
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
    </form>
</body>
</html>

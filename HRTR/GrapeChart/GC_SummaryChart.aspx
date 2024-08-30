<%@ Page Title="Summary Chart" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="GC_SummaryChart.aspx.cs" Inherits="HRTR.GrapeChart.GC_SummaryChart" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Summary Chart</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/GC_SummaryChart.js"></asp:ScriptReference>
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
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label21" runat="server" Text="Workcell"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:DropDownList ID="ddlGC_CustomersS" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="Customer" DataValueField="Customer_ID" Width="99%" AutoPostBack="false">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label5" runat="server" Text="Escaped From"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtEscapedDateFromS" runat="server" Width="80px"></asp:TextBox>
                                                    <img id="imgEscapedDateFromS" class="dateselected" src="../Images/icon-calendar.gif"
                                                        runat="server" alt="" />
                                                    <ajaxToolkit:CalendarExtender ID="ceEscapedDateFromS" runat="server" CssClass="MyCalendar"
                                                        TargetControlID="txtEscapedDateFromS" Enabled="True" PopupButtonID="imgEscapedDateFromS"
                                                        Format="MM/dd/yyyy">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label7" runat="server" Text="Escaped To"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:TextBox ID="txtEscapedDateToS" runat="server" Width="80px"></asp:TextBox>
                                                    <img id="imgEscapedDateToS" class="dateselected" src="../Images/icon-calendar.gif"
                                                        runat="server" alt="" />
                                                    <ajaxToolkit:CalendarExtender ID="ceEscapedDateToS" runat="server" CssClass="MyCalendar"
                                                        TargetControlID="txtEscapedDateToS" Enabled="True" PopupButtonID="imgEscapedDateToS"
                                                        Format="MM/dd/yyyy">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label47" runat="server" Text="Shift"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlShiftS" runat="server" AppendDataBoundItems="True" DataTextField="ShiftName"
                                                        DataValueField="ShiftID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label27" runat="server" Text="Employee ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text="Top N"></asp:Label>
                                                </td>
                                                <td>
                                                    <%--      <asp:TextBox ID="txtTopN" runat="server" Width="99%" Text="10"></asp:TextBox>--%>
                                                    <asp:DropDownList ID="ddlTopNS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text="Grape Chart Type"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlGrapeChartTypeS" runat="server" AppendDataBoundItems="True"
                                                        Width="99%">
                                                        <asp:ListItem Value="1">Defect Escapee</asp:ListItem>
                                                        <asp:ListItem Value="2">Defect Finder</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text="Group Type"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlGroupTypeS" runat="server" AppendDataBoundItems="True" Width="99%">
                                                        <asp:ListItem Value="1">CRD</asp:ListItem>
                                                        <asp:ListItem Value="2">Defect</asp:ListItem>
                                                        <asp:ListItem Value="3">Station</asp:ListItem>
                                                        <asp:ListItem Value="4">Employee</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" Text="Group By"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlGroupByS" runat="server" AppendDataBoundItems="True" Width="99%">
                                                        <asp:ListItem Value="1">Day</asp:ListItem>
                                                        <asp:ListItem Value="2">Week</asp:ListItem>
                                                        <asp:ListItem Value="3">Month</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <%--   <td>
                                                    <asp:CheckBox ID="cbShowParetoChart" runat="server" Text="Show Pareto Chart" Checked="true">
                                                    </asp:CheckBox>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbShowTrendChart" runat="server" Text="Show Trend Chart" Checked="true">
                                                    </asp:CheckBox>
                                                </td>--%>
                                                <td colspan="6">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="button" OnClick="btnSearch_Click"
                                                        Text="Search"  ValidationGroup="vgsearch" />
                                                    <%-- <asp:Button ID="btnClear" runat="server" CssClass="button" OnClientClick="return ResetData();"
                                                        Text="Clear"  />--%>
                                                </td>
                                                <td colspan="7">
                                                    <asp:Label ID="lblGC_SummaryChart" runat="server" Text="" CssClass="message"></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td class="chartArea">
                                <asp:Chart ID="chartGC_ParetoChart" runat="server" Width="600px" Height="400px" Visible="false">
                                    <Series>
                                        <asp:Series Name="Total" IsValueShownAsLabel="true" IsVisibleInLegend="true" LabelFormat="{#}"
                                            BorderColor="180, 26, 59, 105">
                                        </asp:Series>
                                    </Series>
                                    <ChartAreas>
                                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White"
                                            ShadowColor="Transparent" BackGradientStyle="TopBottom">
                                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                                WallWidth="0" IsClustered="False" />
                                            <AxisY LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" Format="{#}" />
                                                <MajorGrid LineColor="64, 64, 64, 64" />
                                            </AxisY>
                                            <AxisX LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8" Interval="1">
                                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsEndLabelVisible="False" Angle="-90" />
                                                <MajorGrid LineColor="64, 64, 64, 64" />
                                            </AxisX>
                                        </asp:ChartArea>
                                    </ChartAreas>
                                    <BorderSkin SkinStyle="Emboss"></BorderSkin>
                                    <Titles>
                                        <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                                            Text="" Name="Title1" ForeColor="26, 59, 105">
                                        </asp:Title>
                                        <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 12.25pt, style=Bold" ShadowOffset="3"
                                            Text="" Name="Title2" ForeColor="252, 180, 65">
                                        </asp:Title>
                                    </Titles>
                                    <Legends>
                                        <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent"
                                            Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="True"
                                            Name="Default">
                                        </asp:Legend>
                                    </Legends>
                                </asp:Chart>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvGC_ParetoChart" runat="server" AutoGenerateColumns="True" OnRowCommand="grvGC_ParetoChart_RowCommand"
                                    OnRowDataBound="grvGC_ParetoChart_RowDataBound" CssClass="gridview" PagerStyle-CssClass="pgr"
                                    EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                    FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal"
                                    Visible="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td class="chartArea">
                                <asp:Chart ID="chartGC_TrendChart" runat="server" Width="600px" Height="400px" Visible="false"
                                    Palette="Excel">
                                    <Series>
                                    </Series>
                                    <ChartAreas>
                                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White"
                                            ShadowColor="Transparent" BackGradientStyle="TopBottom">
                                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                                WallWidth="0" IsClustered="False" />
                                            <AxisY LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" Format="{#}" />
                                                <MajorGrid LineColor="64, 64, 64, 64" />
                                            </AxisY>
                                            <AxisX LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8" Interval="1">
                                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsEndLabelVisible="False" Angle="-90" />
                                                <MajorGrid LineColor="64, 64, 64, 64" />
                                            </AxisX>
                                        </asp:ChartArea>
                                    </ChartAreas>
                                    <BorderSkin SkinStyle="Emboss"></BorderSkin>
                                    <Titles>
                                        <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                                            Text="" Name="Title1" ForeColor="26, 59, 105">
                                        </asp:Title>
                                        <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 12.25pt, style=Bold" ShadowOffset="3"
                                            Text="" Name="Title2" ForeColor="252, 180, 65">
                                        </asp:Title>
                                    </Titles>
                                    <Legends>
                                        <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent"
                                            Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="True"
                                            Name="Default">
                                        </asp:Legend>
                                    </Legends>
                                </asp:Chart>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvGC_TrendChart" runat="server" AutoGenerateColumns="True" OnRowCommand="grvGC_TrendChart_RowCommand"
                                    OnRowDataBound="grvGC_TrendChart_RowDataBound" CssClass="gridview" PagerStyle-CssClass="pgr"
                                    EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                    FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal"
                                    Visible="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
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

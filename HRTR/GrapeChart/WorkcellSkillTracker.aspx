<%@ Page Title="Workcell Skill Performance Tracker" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="WorkcellSkillTracker.aspx.cs" Inherits="HRTR.GrapeChart.WorkcellSkillTracker" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Workcell Skill Performance Tracker</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/WorkcellSkillTracker.js"></asp:ScriptReference>
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
                                                    <asp:Label ID="Label4" runat="server">Workcell</asp:Label>
                                                </td>
                                                <td style="width: 30%;">
                                                    <asp:DropDownList ID="ddlWorkcellS" runat="server" AppendDataBoundItems="True" DataTextField="WorkcellName"
                                                        DataValueField="WorkcellID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:Label ID="Label1" runat="server">Year</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlYearS" runat="server" AppendDataBoundItems="True" Width="80px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="white-space: nowrap;">
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="button" OnClick="btnSearch_Click"
                                                        Text="Search"  ValidationGroup="vgsearch" />
                                                    <asp:Button ID="btnClear" runat="server" CssClass="button" OnClientClick="return ResetData();"
                                                        Text="Clear"  />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Chart ID="chartWorkcellSkillTracker" runat="server" Width="800px">
                                    <Series>
                                        <asp:Series Name="Series1" ChartType="StackedColumn" BorderColor="White" Color="Green"
                                            XValueMember="MonthName" YValueMembers="Green" IsValueShownAsLabel="true" LabelFormat="{#.00}%"
                                            LabelForeColor="White" Font="Microsoft Sans Serif, 6.25pt, style=Bold">
                                        </asp:Series>
                                    </Series>
                                    <ChartAreas>
                                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White"
                                            BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                                WallWidth="0" IsClustered="False" />
                                            <AxisY LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8" Maximum="100">
                                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" Format="{#}%" />
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
                                    </Titles>
                                    <Legends>
                                        <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent"
                                            Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="False"
                                            Name="Default">
                                        </asp:Legend>
                                    </Legends>
                                </asp:Chart>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvWorkcellSkillTracker" runat="server" AutoGenerateColumns="False"
                                    AllowPaging="True" AllowSorting="True" OnRowCommand="grvWorkcellSkillTracker_RowCommand"
                                    OnRowDataBound="grvWorkcellSkillTracker_RowDataBound" OnPageIndexChanging="grvWorkcellSkillTracker_PageIndexChanging"
                                    CssClass="gridview" PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing"
                                    OnSorting="grvWorkcellSkillTracker_Sorting" PageSize="20" SelectedRowStyle-CssClass="selected"
                                    HeaderStyle-CssClass="header" FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate"
                                    RowStyle-CssClass="normal">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID" />
                                        <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                        <asp:BoundField DataField="January" HeaderText="January" SortExpression="January">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="February" HeaderText="February" SortExpression="February">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="March" HeaderText="March" SortExpression="March">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="April" HeaderText="April" SortExpression="April">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="May" HeaderText="May" SortExpression="May">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="June" HeaderText="June" SortExpression="June">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="July" HeaderText="July" SortExpression="July">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="August" HeaderText="August" SortExpression="August">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="September" HeaderText="September" SortExpression="September">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="October" HeaderText="October" SortExpression="October">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="November" HeaderText="November" SortExpression="November">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="December" HeaderText="December" SortExpression="December">
                                            <ItemStyle CssClass="center" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
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
                            </td>
                        </tr>
                        <tr>
                            <td>
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

<%@ Page Title="Employee Skill Performance Tracker" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="EmployeeSkillTracker.aspx.cs" Inherits="HRTR.GrapeChart.EmployeeSkillTracker" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Employee Skill Performance Tracker</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/GrapeChartHTML_HTML5_Canvas.js?1627809471379"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/EmployeeSkillTracker.js"></asp:ScriptReference>
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
                                                    <asp:Label ID="Label4" runat="server">Employee ID</asp:Label>
                                                    <asp:RequiredFieldValidator ID="rfvEmployeeID" runat="server" ValidationGroup="vgsearch"
                                                        ControlToValidate="txtEmployeeID" ErrorMessage="Employee ID is required." ToolTip="Employee ID is required.">(*)</asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="cvEmployeeID" runat="server" ClientValidationFunction="cvEmployeeID_ClientValidate"
                                                        ControlToValidate="txtEmployeeID" ErrorMessage="Employee ID is required." ValidationGroup="vgsearch">(*)</asp:CustomValidator>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:TextBox ID="txtEmployeeID" runat="server" Width="99%"></asp:TextBox>
                                                    <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="bhaceEmployee" ID="aceEmployee"
                                                        TargetControlID="txtEmployeeID" ServicePath="../WebServices/EmployeeS.asmx"
                                                        ServiceMethod="GetEmployeeList" MinimumPrefixLength="1" CompletionInterval="500"
                                                        EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                        DelimiterCharacters=";, :" OnClientItemSelected="EmployeeSelected" FirstRowSelected="true">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td style="width: 10%">
                                                    <asp:Label ID="Label2" runat="server" Text="Employee Name"></asp:Label>
                                                </td>
                                                <td style="width: 20%;">
                                                    <asp:TextBox ID="txtEmployeeName" runat="server" Width="99%" Enabled="false"></asp:TextBox>
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
                                                <td colspan="6" style="white-space: nowrap;">
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
                                <asp:Chart ID="chartEmployeeSkillTracker" runat="server" Width="800px" Visible="false" >
                                    <Series>
                                        <asp:Series Name="Green" ChartType="StackedColumn100" BorderColor="White" Color="Green"
                                            XValueMember="MonthName" YValueMembers="Green">
                                        </asp:Series>                                        
                                        <asp:Series Name="Red" ChartType="StackedColumn100" BorderColor="White" Color="Red"
                                            XValueMember="MonthName" YValueMembers="Red" >
                                        </asp:Series>
                                    </Series>
                                    <ChartAreas>
                                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White"
                                            BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                                WallWidth="0" IsClustered="False" />
                                            <AxisY LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" Format="{#}%" />
                                                <MajorGrid LineColor="64, 64, 64, 64" />
                                            </AxisY>
                                            <AxisX LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8" Interval="1">
                                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsEndLabelVisible="False" />
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
                            <td>
                                <asp:GridView ID="grvEmployeeSkillTracker" runat="server" AutoGenerateColumns="False"
                                    CssClass="gridview" PagerStyle-CssClass="pgr" EditRowStyle-CssClass="editing"
                                    SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header" FooterStyle-CssClass="footer"
                                    AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Month" SortExpression="MonthName">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbEdit" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Month")%>'
                                                    CommandName="Select" Text='<%# Eval("MonthName")%>' OnClientClick='<%# "javascript: return RefreshGrapeChart(" + Eval("Month") + "," + Eval("Year") + ");" %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="WorkcellName" HeaderText="Workcell" SortExpression="WorkcellName" />
                                        <asp:BoundField DataField="Green" HeaderText="" SortExpression="Green">
                                            <ItemStyle CssClass="center" />
                                            <HeaderStyle CssClass="greencenter" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Red" HeaderText="" SortExpression="Red">
                                            <ItemStyle CssClass="center" />
                                            <HeaderStyle CssClass="redcenter" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblEmployeeSkillTrackerByMonthMessage" runat="server" Text="" CssClass="message"
                                    Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="5" style="vertical-align: top; width: 50%;">
                                <div id="divEmployeeSkillTrackerByMonth">
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
                                    <asp:HiddenField ID="hdEmployeeID_ID" runat="server" />
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

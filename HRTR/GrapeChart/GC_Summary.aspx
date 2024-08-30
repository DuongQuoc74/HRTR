<%@ Page Title="Grape Chart Summary" Language="C#" MasterPageFile="~/HCM.Master"
    AutoEventWireup="true" CodeBehind="GC_Summary.aspx.cs" Inherits="HRTR.GrapeChart.GC_Summary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Grape Chart Summary</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/GC_Summary.js"></asp:ScriptReference>
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
                                                    <asp:Label ID="Label21" runat="server" Text="Workcell"></asp:Label>
                                                </td>
                                                <td style="width: 15%;">
                                                    <asp:DropDownList ID="ddlGC_CustomersS" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="Customer" DataValueField="Customer_ID" Width="99%" AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlGC_CustomersS_SelectedIndexChanged">
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
                                                    <asp:Label ID="Label3" runat="server" Text="Escaped Station"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlEscapedStationS" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="StationName" DataValueField="GC_StationID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label28" runat="server" Text="Detected Station"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlDetectedStationS" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="StationName" DataValueField="GC_StationID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label17" runat="server" Text="Defect"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlQM_DefectsS" runat="server" AppendDataBoundItems="True"
                                                        DataTextField="DefectText" DataValueField="Defect_ID" Width="99%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label44" runat="server" Text="MES Auto Linked"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlIsMESAutoLinkedS" runat="server" AppendDataBoundItems="True"
                                                        Width="99%">
                                                        <asp:ListItem Value="-1" Selected="True">[All]</asp:ListItem>
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="0">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label27" runat="server" Text="Escaped By ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEscapedByEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label48" runat="server" Text="Detected By ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDetectedByEmployeeIDS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label50" runat="server" Text="CRD"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCRDS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label29" runat="server" Text="Serial Number"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtSerialNumberS" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
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
                                                <td colspan="6">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">
                                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"
                                                        CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                    <asp:Button ID="btnExport" OnClick="btnExport_Click" runat="server" Text="Export"
                                                        CssClass="button" UseSubmitBehavior="False"></asp:Button>
                                                        <asp:Label ID="lblSearch" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvGrapeChart" runat="server" OnRowDataBound="grvGrapeChart_RowDataBound"
                                    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="EmployeeID_ID"
                                    OnPageIndexChanging="grvGrapeChart_PageIndexChanging" OnSorting="grvGrapeChart_Sorting"
                                    OnRowCommand="grvGrapeChart_RowCommand" CssClass="gridview" PagerStyle-CssClass="pgr"
                                    EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
                                    FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal"
                                    PageSize="20">
                                    <PagerSettings Mode="NumericFirstLast"></PagerSettings>
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="rowno" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TotalDefect" HeaderText="Total Defect" SortExpression="TotalDefect">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DefectText" HeaderText="Defect"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
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
                                                    <img src="../Images/updateprogress.gif" alt="?" />
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

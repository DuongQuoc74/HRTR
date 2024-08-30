<%@ Page Title="Lock Record Report" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="LockRecordReport.aspx.cs" Inherits="HRTR.AutoLock.LockRecordReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="maincontent">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Lock Record Report</div>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">
            <Scripts>
                <asp:ScriptReference Path="../Scripts/Common.js"></asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <asp:Panel ID="pnSearch" runat="server">
                                    <fieldset>
                                        <legend>Search</legend>
                                        <table class="tablesearch">
                                            <tbody>
                                                <tr>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label3" runat="server" Text="Employee ID"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:TextBox ID="txtEmployeeIDS" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label6" runat="server" Text="Employee ID SAP"></asp:Label>
                                                    </td>
                                                    <td style="width: 15%;">
                                                        <asp:TextBox ID="txtEmployeeIDSAPS" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 10%;">
                                                        <asp:Label ID="Label2" runat="server" Text="User Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtUserNameS" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label36" runat="server" Text="Employee Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtEmployeeNameS" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label8" runat="server" Text="Code ID"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtTrainingCodeIDS" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label10" runat="server" Text="Due Date"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDueDateS" runat="server" Width="80px"></asp:TextBox>
                                                        <img id="img1" class="dateselected" src="../Images/icon-calendar.gif" runat="server"
                                                            alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="caDueDateS" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtDueDateS" Enabled="True" PopupButtonID="imgDueDateS" Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label44" runat="server" Text="Extend Day"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtExtendDayS" runat="server" Text="0"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label5" runat="server" Text="Complete Date"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtCompleteDateS" runat="server"  Width="80px"></asp:TextBox>
                                                        <img id="imgCompleteDateS" class="dateselected" src="../Images/icon-calendar.gif"
                                                            runat="server" alt="" />
                                                        <ajaxToolkit:CalendarExtender ID="caCompleteDateS" runat="server" CssClass="MyCalendar"
                                                            TargetControlID="txtCompleteDateS" Enabled="True" PopupButtonID="imgCompleteDateS"
                                                            Format="MM/dd/yyyy">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label16" runat="server" Text="Active"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsActiveS" runat="server" AppendDataBoundItems="True" Width="50px">
                                                            <asp:ListItem Value="-1">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1" Selected="True">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text="IL/ DL"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsDL" runat="server" AppendDataBoundItems="True" Width="50px">
                                                            <asp:ListItem Selected="True" Value="-1">[All]</asp:ListItem>
                                                            <asp:ListItem Value="0">[IL]</asp:ListItem>
                                                            <asp:ListItem Value="1">[DL]</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label46" runat="server" Text="Complete"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIsComplete" runat="server" AppendDataBoundItems="True" Width="140px">
                                                            <asp:ListItem Selected="True" Value="-1">[All]</asp:ListItem>
                                                            <asp:ListItem Value="1">[Completed]</asp:ListItem>
                                                            <asp:ListItem Value="0">[Uncompleted]</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" style="white-space: nowrap;">
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
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvTrainingEmpLock" runat="server" AllowPaging="True" AllowSorting="True"
                                    PageSize="20" AutoGenerateColumns="False" DataKeyNames="LockID" OnPageIndexChanging="grvTrainingEmpLock_PageIndexChanging"
                                    OnRowDataBound="grvTrainingEmpLock_RowDataBound" OnSorting="grvTrainingEmpLock_Sorting"
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
                                        <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID" />
                                        <asp:BoundField DataField="EmployeeIDSAP" HeaderText="EmployeeID SAP" SortExpression="EmployeeIDSAP" />
                                        <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
                                        <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                                        <asp:BoundField DataField="TrainingCodeID" HeaderText="Code ID" SortExpression="TrainingCodeID" />
                                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                        <asp:BoundField DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate"
                                            DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField DataField="ExtendDay" HeaderText="Extend Day" SortExpression="ExtendDay" />
                                        <asp:BoundField DataField="ExtendFromDate" HeaderText="Extend From Date" SortExpression="ExtendFromDate"
                                            DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField DataField="CompleteDate" HeaderText="Complete Date" SortExpression="CompleteDate"
                                            DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField DataField="LastUpdated" HeaderText="Last Updated" SortExpression="LastUpdated" />
                                        <asp:BoundField DataField="LastUpdatedByFullName" HeaderText="Last Updated By" SortExpression="LastUpdatedByFullName" />
                                        <asp:BoundField DataField="IsDL" HeaderText="ID/ DL" SortExpression="IsDL" />
                                        <asp:BoundField DataField="Reminder" HeaderText="Reminder" SortExpression="Reminder" />
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
                                                    <img style="width: 45px; height: 45px" src="../Images/updateprogress.gif" alt="..." />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server" Style="text-align: center">Processing...</asp:Label>
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

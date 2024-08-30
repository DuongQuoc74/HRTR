<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ASGrapeChart.aspx.cs" Inherits="HRTR.ASGrapeChart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="frmMain" runat="server">
    <div>
        <asp:GridView ID="grvEmployeeSkillTrackerByMonth" runat="server" AutoGenerateColumns="False"
            OnRowCommand="grvEmployeeSkillTrackerByMonth_RowCommand" OnRowDataBound="grvEmployeeSkillTrackerByMonth_RowDataBound"
            OnPreRender="grvEmployeeSkillTrackerByMonth_PreRender" CssClass="gridview" PagerStyle-CssClass="pgr"
            EditRowStyle-CssClass="editing" SelectedRowStyle-CssClass="selected" HeaderStyle-CssClass="header"
            FooterStyle-CssClass="footer" AlternatingRowStyle-CssClass="alternate" RowStyle-CssClass="normal"
            Visible="true">
            <PagerSettings Mode="NumericFirstLast" />
            <Columns>
                <asp:TemplateField HeaderText="No.">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <ItemStyle CssClass="rowno" />
                </asp:TemplateField>
                <asp:BoundField DataField="EscapedDate" HeaderText="Date" SortExpression="EscapedDate"
                    DataFormatString="{0:MM/dd/yyyy}">
                    <ItemStyle Width="10%" />
                </asp:BoundField>
                <asp:BoundField DataField="TotalDefect" HeaderText="Total Defect">
                    <ItemStyle CssClass="center" Width="10%" />
                </asp:BoundField>
                <asp:BoundField DataField="DefectText" HeaderText="Defect"></asp:BoundField>
            </Columns>
        </asp:GridView>
    </div>
    </form>
</body>
</html>

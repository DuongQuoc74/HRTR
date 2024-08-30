<%@ Page Title="HR Training Record - e Grape Chart - Info" Language="C#" MasterPageFile="~/HCM.Master" AutoEventWireup="true"
    CodeBehind="Info.aspx.cs" Inherits="HRTR.Info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="server">
    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Info</div>
        <table>
            <tr>
                <td>
                    <asp:Label ID="lblInfo" runat="server" Text="You have no right to access this page"></asp:Label>
                    <asp:LinkButton ID="lbHome" runat="server" PostBackUrl="~/Home.aspx">Home</asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

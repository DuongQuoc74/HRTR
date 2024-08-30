<%@ Page Title="" Language="C#" MasterPageFile="~/HCM.master" AutoEventWireup="true" CodeFile="ConfigClient.aspx.cs" Inherits="HRTR_ConfigClient" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" Runat="Server">

<div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Config Process&nbsp; For ClientName </div>

              <script language="javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js">
                </script>

        <script language="javascript">
            $(document).ready(function () {
                var chkboxrow = "#<%=grv.ClientID%> input[id*='chkSelection']:checkbox";
                var chkall = $("input[id$='chkAll']");
                var chkall2 = $("input[id$='chkAll2']");
                var i = 0;
                //  CheckAllHeader("grvCCOwnerListqqqq");

                $(chkall2).live('click', function () {
                    var ischeck = $(this).is(':checked');
                    $(chkboxrow).each(function () {
                        if ($(this).is(':disabled')) {
                        }
                        else {
                            $(this).attr('checked', ischeck);
                        }
                    });
                });

                $(chkboxrow).live('click', function () {
                    $(chkboxrow).each(function () {
                        if ($(this).is(':checked')) {
                            $(chkall2).attr('checked', true);
                        }
                        else {
                            $(chkall2).attr('checked', false);
                            return false;
                        }
                    });
                });



                $(chkall).change(function () {


                    if ($(chkall).is(':checked')) {
                        $(chkboxrow).each(function () {

                            $(this).attr('checked', true);
                        });
                    }
                    else {
                        $(chkboxrow).each(function () {

                            $(this).attr('checked', false);
                        });
                    }


                });

            });


            function CheckAllHeader(grv) {
                var cball = '[id$="' + grv + '"] input[id*="chkAll2"]:checkbox';
                var cbs = '[id$="' + grv + '"] input[id*="chkboxrow"]:checkbox';
                $(cball).live('click', function () {
                    var ischeck = $(this).is(':checked');
                    $(cbs).each(function () {
                        if ($(this).is(':disabled')) {
                        }
                        else {
                            $(this).attr('checked', ischeck);
                        }
                    });
                });

                $(cbs).live('click', function () {
                    $(cbs).each(function () {
                        if ($(this).is(':checked')) {
                            $(cball).attr('checked', true);
                        }
                        else {
                            $(cball).attr('checked', false);
                            return false;
                        }
                    });
                });
            };
    
    </script>





        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" CombineScripts="True"
            EnablePageMethods="True">

              
            <Scripts>
                <asp:ScriptReference Path="../Scripts/UserProfile.js">
                </asp:ScriptReference>
                <asp:ScriptReference Path="../Scripts/Common2.js">
                </asp:ScriptReference>
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>



        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td style="width: 947px">
                                <fieldset>
                                    <legend>Search</legend>
                                    <table>
                                        <tbody>
                                           
                                            
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label47" runat="server" Text="Client Name" ForeColor="Blue"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlClientName" runat="server" AppendDataBoundItems="True"
                                                        CssClass="hrtrinput" DataTextField="ClientName" DataValueField="ClientID"
                                                        Width="250px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTrainingGroup" runat="server" ForeColor="Blue" 
                                                        Text="Training Group"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTrainingGroup" runat="server" 
                                                        AppendDataBoundItems="True" CssClass="hrtrinput" DataTextField="TrainingGroupName" 
                                                        DataValueField="TrainingGroupID" Width="250px" AutoPostBack="True" 
                                                        onselectedindexchanged="ddlTrainingGroup_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                    
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblProcessGroup1" runat="server" ForeColor="Blue" 
                                                        Text="Process Group"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlProcessGroup" runat="server" 
                                                        AppendDataBoundItems="True" CssClass="hrtrinput" DataTextField="CourseGroupName" 
                                                        DataValueField="CourseGroupID" Width="250px" AutoPostBack="True" 
                                                        onselectedindexchanged="ddlProcessGroup_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblProcess0" runat="server" ForeColor="Blue" Text="Process"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlProcess" runat="server" AppendDataBoundItems="True" 
                                                        CssClass="hrtrinput" DataTextField="CourseName" 
                                                        DataValueField="CourseID" Width="250px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="button" Height="26px" 
                                                        onclick="btnSearch_Click1" Text="Search" UseSubmitBehavior="False" 
                                                        Width="70px" />
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 947px">
                                <asp:Label ID="lblOldCCOwner" runat="server" ForeColor="Blue" 
                                    Text="Process List"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 947px">
                                <asp:Label ID="lblCheckAll" runat="server" ForeColor="Blue" Text="Check All"></asp:Label>
                                <asp:CheckBox ID="chkAll" runat="server" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                            <td>
                            
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width: 947px">
                                <asp:GridView ID="grv" runat="server"
                                    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                                    CellPadding="2" CellSpacing="1" 
                                    ForeColor="#333333" PageSize="20" 
                                    onpageindexchanging="grv_PageIndexChanging">
                                    <PagerSettings Mode="NumericFirstLast">
                                    </PagerSettings>
                                    <RowStyle ForeColor="#333333" Height="20px"></RowStyle>
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="ClientID" HeaderText="ClientID" Visible="False" />
                                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" />
                                        <asp:BoundField DataField="ProcessID" HeaderText="ProcessID" Visible="False" />

                                        <asp:BoundField DataField="CourseName" HeaderText="Process  Name">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CourseGroupName" HeaderText="Process Group Name">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TrainingGroupName" 
                                            HeaderText="Training Process Name">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ExpiredInMonths" HeaderText="Expired In Months">
                                        </asp:BoundField>
                                      <asp:TemplateField>
                                       
                                            <HeaderTemplate>
                                                <asp:CheckBox runat="server" ID="chkAll2" TextAlign="Right"  />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkSelection"  Checked ='<%# Convert.ToBoolean(Eval("Active"))%>'  />
                                            </ItemTemplate>
                                    </asp:TemplateField>

                                    </Columns>
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White">
                                    </FooterStyle>
                                    <PagerStyle HorizontalAlign="Right" BackColor="#284775" ForeColor="White">
                                    </PagerStyle>
                                    <SelectedRowStyle BackColor="#EDDA74" Font-Bold="True" ForeColor="#333333">
                                    </SelectedRowStyle>
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Height="20px">
                                    </HeaderStyle>
                                    <EditRowStyle BackColor="#999999"></EditRowStyle>
                                    <AlternatingRowStyle Wrap="True" BackColor="AliceBlue" ForeColor="#284775">
                                    </AlternatingRowStyle>
                                </asp:GridView>
                            
                            
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 947px">
                                <div style="visibility: hidden">
                                    <asp:Label ID="lblMessageControl" runat="server" __designer:wfdid="w39">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateControl" runat="server" __designer:wfdid="w15">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server" __designer:wfdid="w15">
                                    </asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 947px">
                                
                                <asp:Button ID="btnApply" runat="server" CssClass="button" Height="26px" 
                                    onclick="btnApply_Click" Text="Apply" UseSubmitBehavior="False" Width="70px" />
                                
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
                               
                            <EnableAction AnimationTarget="btnSearch" Enabled="False" />
                            <EnableAction AnimationTarget="btnAdd" Enabled="False" />
                            <EnableAction AnimationTarget="btnDelete" Enabled="False" />
                            <EnableAction AnimationTarget="btnOKUpdate" Enabled="False" />
                        </Parallel>
                    </Sequence> </OnUpdating>
        <OnUpdated>   
        <Sequence>
        <ScriptAction Script="$find('bhmpeProcessing').hide();" />
         <Parallel duration="0">
         
                             <EnableAction AnimationTarget="btnSearch" Enabled="True" />
                             <EnableAction AnimationTarget="btnAdd" Enabled="True" />
                            <EnableAction AnimationTarget="btnDelete" Enabled="True" />
                            <EnableAction AnimationTarget="btnOKUpdate" Enabled="True" />
                              </Parallel>             
                    </Sequence></OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </div>
</asp:Content>


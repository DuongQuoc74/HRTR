<%@ Page Title="" Language="C#" MasterPageFile="~/HCM.master" AutoEventWireup="true" CodeFile="CourseMapDocument.aspx.cs" Inherits="HRTR_CouseMapDocument" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" Runat="Server">

    <div id="divMainContent" style="height: 100%">
        <div class="MainContainHeader">
            Course Map Document</div>

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
                <asp:ScriptReference Path="../Scripts/Course.js">
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
                                                    <asp:Label ID="Label53" runat="server" ForeColor="Blue" Text="Course"></asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblTrainingGroup" runat="server" ForeColor="Blue" 
                                                        Text="Training Group"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTrainingGroup" runat="server" 
                                                        AppendDataBoundItems="True" AutoPostBack="True" CssClass="hrtrinput" 
                                                        DataTextField="TrainingGroupName" DataValueField="TrainingGroupID" 
                                                        onselectedindexchanged="ddlTrainingGroup_SelectedIndexChanged" Width="250px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="height: 31px">
                                                    <asp:Label ID="lblProcessGroup1" runat="server" ForeColor="Blue" 
                                                        Text="Course Group"></asp:Label>
                                                </td>
                                                <td style="height: 31px">
                                                    <asp:DropDownList ID="ddlProcessGroup" runat="server" 
                                                        AppendDataBoundItems="True" AutoPostBack="True" CssClass="hrtrinput" 
                                                        DataTextField="CourseGroupName" DataValueField="CourseGroupID" 
                                                        onselectedindexchanged="ddlProcessGroup_SelectedIndexChanged" Width="250px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="height: 31px">
                                                    &nbsp;</td>
                                                <td style="height: 31px">
                                                    &nbsp;</td>
                                                <td style="height: 31px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblProcess0" runat="server" ForeColor="Blue" Text="Course"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlProcess" runat="server" AppendDataBoundItems="True" 
                                                        CssClass="hrtrinput" DataTextField="CourseName" DataValueField="CourseID" 
                                                        Width="250px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSearchByProcess" runat="server" CssClass="button" 
                                                        Height="26px" onclick="btnSearchByProcess_Click" Text="Search Course" 
                                                        UseSubmitBehavior="False" Width="141px" />
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
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
                                <fieldset>
                                    <legend>Search</legend>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label50" runat="server" ForeColor="Blue" Text="Station"></asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                <td style="width: 3px">
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label49" runat="server" ForeColor="Blue" 
                                                        Text="Workcell"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlWorkcell" runat="server" 
                                                        AppendDataBoundItems="True" AutoPostBack="True" CssClass="hrtrinput" 
                                                        DataTextField="WorkcellCode" DataValueField="WorkcellCode" 
                                                        Width="250px" onselectedindexchanged="ddlWorkcell_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 3px">
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="height: 31px">
                                                    <asp:Label ID="Label55" runat="server" ForeColor="Blue" Text="Station Name"></asp:Label>
                                                </td>
                                                <td style="height: 31px">
                                                    <asp:DropDownList ID="ddlStationName" runat="server" 
                                                        AppendDataBoundItems="True" AutoPostBack="True" CssClass="hrtrinput" 
                                                        DataTextField="StationName" DataValueField="StationID" Width="250px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="height: 31px; width: 3px;">
                                                    &nbsp;</td>
                                                <td style="height: 31px">
                                                    &nbsp;</td>
                                                <td style="height: 31px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="height: 31px">
                                                    &nbsp;</td>
                                                <td style="height: 31px">
                                                    &nbsp;</td>
                                                <td style="height: 31px; width: 3px;">
                                                    &nbsp;</td>
                                                <td style="height: 31px">
                                                    &nbsp;</td>
                                                <td style="height: 31px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="button" Height="26px" 
                                                        onclick="btnSearch_Click1" Text="Search Station" UseSubmitBehavior="False" 
                                                        Width="141px" />
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                <td style="width: 3px">
                                                    &nbsp;</td>
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
                            <td style="height: 19px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grv" runat="server" AllowPaging="True" AllowSorting="True" 
                                    AutoGenerateColumns="False" CellPadding="2" CellSpacing="1" ForeColor="#333333" 
                                    onpageindexchanging="grv_PageIndexChanging" PageSize="20" 
                                    DataKeyNames="StationID">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <RowStyle ForeColor="#333333" Height="20px" />
                                    <Columns>
                                        <asp:BoundField DataField="RowNum" HeaderText="No." />
                                        <asp:BoundField DataField="courseName" HeaderText="Course Name" />
                                        <asp:BoundField DataField="WorkcellName" 
                                            HeaderText="Workcell" />
                                        <asp:BoundField DataField="StationName" HeaderText="Station Name" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkAll2" runat="server" TextAlign="Right" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelection" runat="server"  Checked ='<%# Convert.ToBoolean(Eval("Active"))%>'  />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#EDDA74" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" 
                                        Height="20px" />
                                    <EditRowStyle BackColor="#999999" />
                                    <AlternatingRowStyle BackColor="AliceBlue" ForeColor="#284775" Wrap="True" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeUpdate0" runat="server" TargetControlID="btnUpdateControl"
                                    PopupControlID="PanelUpdate" BackgroundCssClass="modalBackgroundCommon" CancelControlID="btnCancelU"
                                    DropShadow="false" PopupDragHandleControlID="PanelUpdate1" BehaviorID="bhvmpeUpdate"
                                    Enabled="True" OnOkScript="btnReturnU">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 400px;" ID="PanelUpdate"
                                    runat="server">
                                    <asp:Panel CssClass="modalPopupDrag" ID="PanelUpdate1" runat="server">
                                        <div>
                                            <p>
                                                Update Course</p>
                                        </div>
                                    </asp:Panel>
                                  
                                </asp:Panel>
                                <asp:Button ID="btnApply" runat="server" CssClass="button" Height="26px" 
                                    onclick="btnApply_Click" Text="Apply" UseSubmitBehavior="False" Width="70px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel CssClass="modalPopupCommon" Style="display: none; width: 400px;" ID="PanelAdd"
                                    runat="server">
                                    <asp:Panel CssClass="modalPopupDrag" ID="PanelAdd1" runat="server">
                                        <div>
                                            <p>
                                                New Course</p>
                                        </div>
                                    </asp:Panel>
                                
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeDelete0" BehaviorID="bhvmpeDelete" DropShadow="false"
                                    Enabled="True" runat="server" TargetControlID="btnDeleteControl" PopupControlID="PanelDelete"
                                    BackgroundCssClass="modalBackgroundCommon" OkControlID="btnReturnD" CancelControlID="btnCancelD"
                                    PopupDragHandleControlID="PanelDelete1">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelDelete" runat="server" Style="display: none; width: 400px;" CssClass="modalPopupCommon">
                                    <asp:Panel ID="PanelDelete1" runat="server" CssClass="modalPopupDrag">
                                        <div>
                                            <p>
                                                Delete Course</p>
                                        </div>
                                    </asp:Panel>
                                
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeMessage0" runat="server" TargetControlID="lblMessageControl"
                                    BackgroundCssClass="modalBackgroundConfirm" OkControlID="btnMessage" PopupControlID="PanelConfirm"
                                    BehaviorID="bhmpeMessage" DropShadow="false" Enabled="True">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelConfirm" runat="server" Style="display: none;" CssClass="modalPopupConfirm">
                                 
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeConfirmUpdate0" runat="server" BackgroundCssClass="modalBackgroundConfirm"
                                    PopupControlID="PanelConfirmUpdate" BehaviorID="bhmpeConfirmUpdate" TargetControlID="lblUpdateControl"
                                    CancelControlID="btnCancelUpdate" OkControlID="btnUpdateR">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel Style="display: none" ID="PanelConfirmUpdate" runat="server" CssClass="modalPopupConfirm">
                                   
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ajaxToolkit:ModalPopupExtender ID="mpeProcessing0" runat="server" BackgroundCssClass="modalBackgroundProcessing"
                                    BehaviorID="bhmpeProcessing" DropShadow="false" Enabled="True" PopupControlID="PanelProcessing"
                                    TargetControlID="lblProcessingControl">
                                </ajaxToolkit:ModalPopupExtender>
                                <asp:Panel ID="PanelProcessing" runat="server" CssClass="modalPopupProcessing" Style="display: none">
                                    <table class="processingtable">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <img style="width: 45px; height: 45px" src="../Images/updateprogress.gif" alt="" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server" Style="text-align: center">Processing...</asp:Label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hdCourseID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="visibility: hidden">
                                    <asp:Label ID="lblMessageControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblUpdateControl" runat="server">
                                    </asp:Label>
                                    <asp:Label ID="lblProcessingControl" runat="server">
                                    </asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="visibility: hidden">
                                    <asp:Button ID="btnReturnA" runat="server" CssClass="button" OnClientClick="return false;"
                                        UseSubmitBehavior="False" />
                                    <asp:Button ID="btnReturnU" runat="server" CssClass="button" OnClientClick="return false;"
                                        UseSubmitBehavior="False" />
                                    <asp:Button ID="btnReturnD" runat="server" CssClass="button" OnClientClick="return false;"
                                        UseSubmitBehavior="False" />
                                    <asp:Button ID="btnUpdateR" runat="server" CssClass="button" OnClientClick="return false;"
                                        UseSubmitBehavior="False" />
                                    <asp:Button ID="btnUpdateControl" runat="server" CssClass="button" Text="Update"
                                        UseSubmitBehavior="False" />
                                    <asp:Button ID="btnDeleteControl" runat="server" CssClass="button" Text="Delete"
                                        UseSubmitBehavior="False" />
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
                        <EnableAction AnimationTarget="btnAdd" Enabled="False" />
                        <EnableAction AnimationTarget="btnUpdateAsk" Enabled="False" />
                        <EnableAction AnimationTarget="btnDelete" Enabled="False" />
                        <EnableAction AnimationTarget="btnCancelA" Enabled="False" />
                        <EnableAction AnimationTarget="btnCancelD" Enabled="False" />
                        <EnableAction AnimationTarget="btnCancelU" Enabled="False" />
                    </Parallel>
                </Sequence> 
            </OnUpdating>
            <OnUpdated>   
                <Sequence>
                    <ScriptAction Script="$find('bhmpeProcessing').hide();" />
                    <Parallel duration="0">
                        <EnableAction AnimationTarget="btnAdd" Enabled="True" />
                        <EnableAction AnimationTarget="btnUpdateAsk" Enabled="True" />
                        <EnableAction AnimationTarget="btnDelete" Enabled="True" />
                        <EnableAction AnimationTarget="btnCancelA" Enabled="True" />
                        <EnableAction AnimationTarget="btnCancelD" Enabled="True" />
                        <EnableAction AnimationTarget="btnCancelU" Enabled="True" />
                    </Parallel>             
                </Sequence>
            </OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </div>

</asp:Content>


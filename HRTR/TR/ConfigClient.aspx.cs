using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRTR.Server;
using System.Data;

public partial class HRTR_ConfigClient : System.Web.UI.Page
{
   // Course Co = new Course();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            ddlClientName.DataSource = HRTR.Server.Course.Client_SelectAll();
            ddlClientName.DataBind();

            ddlTrainingGroup.DataSource = HRTR.Server.Course.TrainingGroup_SelectAll_Config();
            ddlTrainingGroup.DataBind();

            ddlProcessGroup.DataSource = HRTR.Server.Course.ProcessGroup_SelectAll();
            ddlProcessGroup.DataBind();

            loadProcess();

            loadGrid();

        }

    }

    private void loadProcess()
    {
        int iProcessGroupID = int.Parse(ddlProcessGroup.SelectedValue.ToString());
        int iTrainingGroupID = int.Parse(ddlTrainingGroup.SelectedValue.ToString());
        ddlProcess.DataSource = HRTR.Server.Course.Process_Select_By_Train_Group(iProcessGroupID, iTrainingGroupID);
        ddlProcess.DataBind();

    }

    private void loadGrid()
    {
        DataTable dt = new DataTable();
        int iClientID = 0;
        int iProcessGroupID = 0;
        int iTrainGroupID = 0;
        int iProcessID = 0;
        try
        {
             iClientID = int.Parse(ddlClientName.SelectedValue.ToString());
             iProcessGroupID = int.Parse(ddlProcessGroup.SelectedValue.ToString());
             iTrainGroupID = int.Parse(ddlTrainingGroup.SelectedValue.ToString());
             iProcessID = int.Parse(ddlProcess.SelectedValue.ToString());
        }
        catch
        {
 
        }

        dt = HRTR.Server.Course.ClientProcess_Search(iClientID, iProcessID, iProcessGroupID, iTrainGroupID);
        Common.dtConfigClient = dt;
        grv.DataSource = dt;
        grv.DataBind();


    }

    protected void btnApply_Click(object sender, EventArgs e)
    {


        if (chkAll.Checked == true)
        {
            string strClientName, strProcessName,strGroupName,strTrainGroupName;
            int iActive = 0;
            for (int i = 0; i < Common.dtConfigClient.Rows.Count; i++)
            {
                strClientName = Common.dtConfigClient.Rows[i]["ClientName"].ToString();
                strProcessName = Common.dtConfigClient.Rows[i]["CourseName"].ToString();
                strGroupName = Common.dtConfigClient.Rows[i]["CourseGroupName"].ToString();
                strTrainGroupName = Common.dtConfigClient.Rows[i]["TrainingGroupName"].ToString();
                
                iActive = 1;
                DataTable dt = HRTR.Server.Course.ClientProcess_Update(strClientName, strProcessName,strGroupName,strTrainGroupName, iActive, 1);

                Alert.ShowAlertMessage("Save successfully");
            }


        }
        else
        {
            //int iClientID = 0, iProcessID = 0, 
            int iActive = 0;
            for (int i = 0; i < grv.Rows.Count; i++)
            {
                string strtemp = grv.Rows[i].Cells[1].Text;
                CheckBox chk = (CheckBox)grv.Rows[i].FindControl("chkSelection");
                if (chk.Checked == true)
                    iActive = 1;
                else
                    iActive = 0;

                string strClientName = grv.Rows[i].Cells[2].Text.Replace("&nbsp;", "");
                string strProcessName = grv.Rows[i].Cells[4].Text.Replace("&nbsp;", "");
                string strGroupName = grv.Rows[i].Cells[5].Text.Replace("&nbsp;", "");
                string strTrainingGroupName = grv.Rows[i].Cells[6].Text.Replace("&nbsp;", "");

                DataTable dt = HRTR.Server.Course.ClientProcess_Update(strClientName, strProcessName, strGroupName, strTrainingGroupName, iActive, 0);

                Alert.ShowAlertMessage("Save successfully");

            }
        }
        loadGrid();


    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        loadGrid();
    }

 
    protected void btnSearch_Click1(object sender, EventArgs e)
    {
        loadGrid();
    }
    protected void ddlTrainingGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadProcess();
    }
    protected void ddlProcessGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadProcess();
    }
    protected void grvList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
       
    }
    protected void grvList_SelectedIndexChanged1(object sender, EventArgs e)
    {

    }
    protected void grvList_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void grv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grv.PageIndex = e.NewPageIndex;
        loadGrid();
    }
}
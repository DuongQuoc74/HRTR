using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class HRTR_CouseMapDocument : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        

            ddlTrainingGroup.DataSource = HRTR.Server.Course.TrainingGroup_SelectAll_Config();
            ddlTrainingGroup.DataBind();

          

            ddlWorkcell.DataSource = HRTR.Server.Course.Workcell_SelectAll_Map();
            ddlWorkcell.DataBind();


            //loadProcess();
            //loadDocument();
            loadStation();
            loadGrid();

        }
    }

    private void loadProcess()
    {
        ddlProcess.Items.Clear();
        int iProcessGroupID = int.Parse(ddlProcessGroup.SelectedValue.ToString());
        int iTrainingGroupID = int.Parse(ddlTrainingGroup.SelectedValue.ToString());
        ddlProcess.DataSource = HRTR.Server.Course.Process_Select_By_Train_Group(iProcessGroupID, iTrainingGroupID);
        ddlProcess.DataBind();

    }
    private void loadDocument()
    {
        
      //  DataTable dt = HRTR.Server.Course.Document_Select_By_DocumentType( ddlWorkcell.SelectedValue.ToString());
     

    }

    private DataTable loadGrid()
    {
        try
        {
            //int iCourseID = int.Parse(ddlProcess.SelectedValue.ToString());
            //int iCourseID = 0;

            
            string strWorkcell = ddlWorkcell.SelectedValue.ToString();
            //int iCourseGroupID = int.Parse(ddlProcessGroup.SelectedValue.ToString());
            //int iTrainingGroupID = int.Parse(ddlTrainingGroup.SelectedValue.ToString());
            //int iCourseGroupID = 0;
            int iStationID =int.Parse(ddlStationName.SelectedValue.ToString());

            DataTable dt = HRTR.Server.Course.Document_Search(strWorkcell, iStationID);
            grv.DataSource = dt;
            grv.DataBind();

            Common.dt=dt;
            return dt;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnApply_Click(object sender, EventArgs e)
    {
        if (ddlProcess.SelectedValue.ToString() == "0" || ddlProcess.SelectedValue.ToString() == "" || ddlProcess.SelectedValue.ToString() == null)
        {
            Alert.ShowAlertMessage("Please choose process");
            return;
        }

        string strusername = "";
        try
        {
            strusername = NameWithoutDomain(Page.User.Identity.Name);
        }
        catch (Exception ex)
        {
            throw ex;
        }

        int iActive = 0;
        int iProcessID = int.Parse(ddlProcess.SelectedValue.ToString());
        //string strDocumentID;
        //CheckBox chkAll = (CheckBox)grv.Rows[0].FindControl("chkAll2");
        CheckBox chkAll = (CheckBox)grv.HeaderRow.FindControl("chkAll2");
        DataTable dt = Common.dt;
        if (chkAll.Checked == true)
        {
           
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //strDocumentID=dt.Rows[i]["Documentid"].ToString();
                int iStationID = int.Parse(dt.Rows[i]["StationID"].ToString());
                HRTR.Server.Course.VA_Process_MAP_Create(iProcessID,1,iStationID,strusername);
            }

            Alert.ShowAlertMessage("Save successfully");
            //return;
        }
        else
        {
            for (int i = 0; i < grv.Rows.Count; i++)
            {
                CheckBox chkSelection = (CheckBox)grv.Rows[i].FindControl("chkSelection");
                if (chkSelection.Checked == true)
                    iActive = 1;
                else
                    iActive = 0;
                string strNumIndex = grv.Rows[i].Cells[0].Text.Replace("&nbsp;", "");
                int iIndex = int.Parse(strNumIndex) - 1;
               // strDocumentID = dt.Rows[iIndex]["DocumentID"].ToString();
                int iStationID = int.Parse(dt.Rows[iIndex]["StationID"].ToString());

               
                HRTR.Server.Course.VA_Process_MAP_Create(iProcessID, iActive, iStationID, strusername);

                Alert.ShowAlertMessage("Save successfully");
                
            }
        }
        loadGrid();
        return;
    }

    private static string NameWithoutDomain(string strname)
    {
        string[] straname = strname.Split(new char[] { '\\' });
        return straname[1];
    }

    protected void ddlTrainingGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlProcessGroup.Items.Clear();
            ddlProcessGroup.DataSource = HRTR.Server.Course.CourseGroup_Select_By_TrainingGroupID(int.Parse(ddlTrainingGroup.SelectedValue.ToString()));
            ddlProcessGroup.DataBind();

            loadProcess();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void ddlProcessGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadProcess();
    }


    protected void btnSearch_Click1(object sender, EventArgs e)
    {
        Common.iFlagSearchProcess = 0;
        Common.iFlagSearchStation = 1;
        loadGrid();
    }
    protected void grv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grv.PageIndex = e.NewPageIndex;
        if (Common.iFlagSearchStation == 1)
            loadGrid();
        else
            loadGrid_ByProcess();
    }
  
    protected void ddlWorkcell_SelectedIndexChanged(object sender, EventArgs e)
    {


        loadStation();
    }
    private void loadStation()
    {
        string strWorkcellID = ddlWorkcell.SelectedValue.ToString();
        ddlStationName.Items.Clear();
        ddlStationName.DataSource = HRTR.Server.Course.Load_Station(strWorkcellID);
        ddlStationName.DataBind();
    }
    protected void btnSearchByProcess_Click(object sender, EventArgs e)
    {
        Common.iFlagSearchProcess = 1;
        Common.iFlagSearchStation = 0;
        loadGrid_ByProcess();
    }

    private DataTable loadGrid_ByProcess()
    {
        try
        {
            int iCourseID = int.Parse(ddlProcess.SelectedValue.ToString());
           

            //string strDocumentType = ddlDocumentType.SelectedValue.ToString();
            string strWorkcell = ddlWorkcell.SelectedValue.ToString();
            int iCourseGroupID = int.Parse(ddlProcessGroup.SelectedValue.ToString());
            int iTrainingGroupID = int.Parse(ddlTrainingGroup.SelectedValue.ToString());


            DataTable dt = HRTR.Server.Course.Document_Search_By_Process(iCourseID,iCourseGroupID,iTrainingGroupID);
            grv.DataSource = dt;
            grv.DataBind();

            Common.dt = dt;
            return dt;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
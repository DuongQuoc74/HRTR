using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class HRTR_Config : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadgrid();
        }

    }

    private void loadgrid()
    {
        grvConfig.DataSource = HRTR.Server.Course.Config_Select();
        grvConfig.DataBind();

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        DataTable dt = HRTR.Server.Course.Config_Create(txtNameA.Text,txtValueA.Text,Common.iUserID);
        Alert.ShowAlertMessage("Save successfully");
        loadgrid();
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        DataTable dt = HRTR.Server.Course.Config_Delete(txtNameD.Text);
        Alert.ShowAlertMessage("Delete successfully");
        loadgrid();

    }

    protected void btnOKUpdate_Click(object sender, EventArgs e)
    {
        DataTable dt = HRTR.Server.Course.Config_Update(txtNameU.Text, txtValueU.Text, Common.iUserID);
        Alert.ShowAlertMessage("Save successfully");
        loadgrid();

    }
    protected void grvConfig_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            string  strName = e.CommandArgument.ToString();
            LoadForUpdate(strName);
            mpeUpdate.Show();
           
        }
        else if (e.CommandName == "DelUser")
        {
            string strName = e.CommandArgument.ToString();
            LoadForDelete(strName);
            mpeDelete.Show();
            btnDelete.Focus();
        }

    }

    private void LoadForUpdate(string p_Name)
    {
        DataTable dt = HRTR.Server.Course.Config_Select_By_Name(p_Name);
        txtNameU.Text = dt.Rows[0]["Name"].ToString();
        txtValueU.Text = dt.Rows[0]["Value"].ToString();
    }

    private void LoadForDelete(string p_Name)
    {
        DataTable dt = HRTR.Server.Course.Config_Select_By_Name(p_Name);
        txtNameD.Text = dt.Rows[0]["Name"].ToString();
        txtValueD.Text = dt.Rows[0]["Value"].ToString();
    }
}
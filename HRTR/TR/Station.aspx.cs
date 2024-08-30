using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using HRTR.Server;
using System.IO;
using eUtilities;

namespace HRTR.TR
{
    public partial class Station : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dtWorkcell = CR_Workcell.Search();

                ddlWorkcellS.DataSource = dtWorkcell;
                ddlWorkcellS.DataBind();
                ddlWorkcellS.Items.Insert(0, new ListItem("[All]", "0"));

                ddlWorkcellU.DataSource = dtWorkcell;
                ddlWorkcellU.DataBind();
                ddlWorkcellU.Items.Insert(0, new ListItem("[Please Select]", "0"));

                ddlWorkcellA.DataSource = dtWorkcell;
                ddlWorkcellA.DataBind();
                ddlWorkcellA.Items.Insert(0, new ListItem("[Please Select]", "0"));

                ddlWorkcellD.DataSource = dtWorkcell;
                ddlWorkcellD.DataBind();

                Session["StationListSort"] = "";
                BindData();
            }
            btnAddControl.Focus();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                CR_Station sta = new CR_Station();
                sta.Id = Convert.ToInt32(hdStationID.Value);
                sta.Name = txtStationNameA.Text;
                sta.WorkcellID = Int32.Parse(ddlWorkcellA.SelectedValue.ToString());
                string result = sta.Save();
                if (string.IsNullOrEmpty(result))
                {
                    BindData();
                    string strmess = "Saved station " + txtStationNameA.Text + " successfully.";
                    lblMessage.Text = strmess;
                    mpeMessage.Show();
                }
                else
                {
                    lblMessage.Text = result;
                    mpeMessage.Show();
                }
            }
            catch (Exception ex)
            {
                lblAddErr.Text = ex.Message;
                mpeAdd.Show();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                CR_Station dept = new CR_Station();

                dept.Id = Convert.ToInt32(hdStationID.Value);
                dept.Delete();
                BindData();
                string strmess = "Deleted station " + txtStationNameD.Text + " successfully.";
                lblMessage.Text = strmess;
                btnMessage.Focus();
                mpeMessage.Show();
            }
            catch (Exception ex)
            {
                lblDeleteErr.Text = ex.Message;
                mpeDelete.Show();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                CR_Station dept = new CR_Station();
                dept.Id = Convert.ToInt32(hdStationID.Value);
                dept.Name = txtStationNameU.Text;
                dept.WorkcellID = Int32.Parse(ddlWorkcellU.SelectedValue.ToString());
                string result = dept.Save();
                if (string.IsNullOrEmpty(result))
                {
                    BindData();
                    string strmess = "Updated station " + txtStationNameA.Text + " successfully.";
                    lblMessage.Text = strmess;
                    mpeMessage.Show();
                }
                else
                {
                    lblMessage.Text = result;
                    mpeMessage.Show();
                }
            }
            catch (Exception ex)
            {
                lblUpdateErr.Text = ex.Message;
                mpeUpdate.Show();
            }
        }

        protected void grvStationList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "StationListSort";
            string strSort = e.SortExpression.ToString();
            string str_sort = "" + strSort + " " + "ASC" + "";
            try
            {
                if (Session[str_ssname].ToString().Length > 4)
                {
                    string str_temp = "";
                    string str_temp2 = Session[str_ssname].ToString();
                    if (str_temp2.EndsWith("ASC"))
                    {
                        str_temp = str_temp2.Remove(str_temp2.Length - 3, 3);
                        str_temp = str_temp.Trim();
                        if (str_temp.Equals(strSort, StringComparison.OrdinalIgnoreCase))
                        {
                            str_temp2 = str_temp2.Replace("ASC", "DESC");
                            str_sort = str_temp2;
                        }
                    }
                }
            }
            catch
            {
                //error
            }
            Session[str_ssname] = str_sort;
            BindData(str_sort);
        }

        protected void grvStationList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string[] commandArgsAccept = e.CommandArgument.ToString().Split(new string[] { "@$" }, StringSplitOptions.None);
                try
                {
                    hdStationID.Value = commandArgsAccept[0].ToString();
                    txtStationNameU.Text = commandArgsAccept[1].ToString();
                    ddlWorkcellU.SelectedValue = commandArgsAccept[2].ToString();
                }
                catch
                {
                    //error
                }
                mpeUpdate.Show();
                txtStationNameU.Focus();
            }
            else if (e.CommandName == "DelStation")
            {
                string[] commandArgsAccept = e.CommandArgument.ToString().Split(new string[] { "@$" }, StringSplitOptions.None);
                try
                {
                    hdStationID.Value = commandArgsAccept[0].ToString();
                    txtStationNameD.Text = commandArgsAccept[1].ToString();

                    ddlWorkcellD.SelectedValue = commandArgsAccept[2].ToString();
                }
                catch
                {
                    //error
                }
                mpeDelete.Show();
                btnDelete.Focus();
            }
        }

        protected void grvStationList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvStationList.PageIndex = e.NewPageIndex;
            BindData();
        }

        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                try
                {
                    pstr_sort = Session["StationListSort"].ToString();
                }
                catch
                {
                    //error
                }
            }
            string strstationname = txtStationNameS.Text;
            int strworkcellid = Int32.Parse(ddlWorkcellS.SelectedValue.ToString());
            DataTable dtStation = CR_Station.Search(strstationname, strworkcellid);
            if (!string.IsNullOrEmpty(pstr_sort))
                dtStation.DefaultView.Sort = pstr_sort;
            grvStationList.DataSource = dtStation;
            grvStationList.DataBind();
        }

    }
}
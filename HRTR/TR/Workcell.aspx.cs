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
    public partial class Workcell : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {

                Session["WorkcellListSort"] = "";
                BindData();
            }
            else if (IsAsync)
            {
            }
            else { }
            btnNewWorkcell.Focus();
        }
        protected void grvWorkcellList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvWorkcellList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvWorkcellList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvWorkcellList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "WorkcellListSort";
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
            }
            Session[str_ssname] = str_sort;
            BindData(str_sort);
        }
        protected void grvWorkcellList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                try
                {
                    int iworkcellid = Convert.ToInt32(e.CommandArgument);
                    LoadWorkcell(iworkcellid);
                    //mpeUserProfile.Show();
                }
                catch (Exception ex)
                {
                    ShowError(lblWorkcell, ex.Message);
                    return;
                }

                if (e.CommandName == "Select") /// For editing
                {
                    btnAdd.CssClass = "button invisible";
                    btnUpdateAsk.CssClass = "button";
                    btnDelete.CssClass = "button invisible";
                    btnUpdateAsk.Focus();
                }
                else /// For deleting
                {
                    btnAdd.CssClass = "button invisible";
                    btnUpdateAsk.CssClass = "button invisible";
                    btnDelete.CssClass = "button";
                    btnDelete.Focus();
                }
                mpeWorkcell.Show();

            }

            //if (e.CommandName == "Select")
            //{
            //    string[] commandArgsAccept = e.CommandArgument.ToString().Split(new string[] { "@$" }, StringSplitOptions.None);
            //    try
            //    {
            //        hdWorkcellIDU.Value = commandArgsAccept[0].ToString();
            //        txtWorkcellCodeU.Text = commandArgsAccept[1].ToString();
            //        txtWorkcellNameU.Text = commandArgsAccept[2].ToString();

            //    }
            //    catch
            //    {
            //    }
            //    mpeUpdate.Show();
            //    txtWorkcellCodeU.Focus();
            //}
            //else if (e.CommandName == "DelWorkcell")
            //{
            //    string[] commandArgsAccept = e.CommandArgument.ToString().Split(new string[] { "@$" }, StringSplitOptions.None);
            //    try
            //    {
            //        int index = Convert.ToInt32(commandArgsAccept[0]);
            //        hdWorkcellIDD.Value = commandArgsAccept[1].ToString();
            //        txtWorkcellCodeD.Text = commandArgsAccept[2].ToString();
            //        txtWorkcellNameD.Text = commandArgsAccept[3].ToString();
            //        grvWorkcellList.SelectedIndex = index;
            //    }
            //    catch { }
            //    mpeDelete.Show();
            //    btnDelete.Focus();
            //}
        }
        private void LoadWorkcell(int pi_workcellid)
        {
            using (CR_Workcell us = new CR_Workcell())
            {
                hdWorkcellID.Value = pi_workcellid.ToString();
                us.WorkcellID = pi_workcellid;
                us.Select();
                txtWorkcellCode.Text = us.WorkcellCode;
                txtWorkcellName.Text = us.WorkcellName;
                txtJdocWorkcellCode.Text = us.JdocWorkcellCode;
                lblWorkcellMessage.Text = "";
            }
        }
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["WorkcellListSort"] != null)
                {
                    pstr_sort = Session["WorkcellListSort"].ToString();
                }
            }
            DataTable dtWorkcell = HRTR.Server.CR_Workcell.Search();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtWorkcell.DefaultView.Sort = pstr_sort;
            grvWorkcellList.DataSource = dtWorkcell;
            grvWorkcellList.DataBind();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_Workcell dept = new HRTR.Server.CR_Workcell())
                {
                    dept.WorkcellID = Convert.ToInt32(hdWorkcellID.Value);
                    dept.WorkcellCode = txtWorkcellCode.Text;
                    dept.WorkcellName = txtWorkcellName.Text;
                    dept.JdocWorkcellCode = txtJdocWorkcellCode.Text;
                    string result = dept.Save();
                    if (result != null && result != "")
                    {
                        ShowError(lblWorkcellMessage, result);
                        btnAdd.CssClass = "button invisible";
                        btnUpdateAsk.CssClass = "button";
                        btnDelete.CssClass = "button invisible";
                        mpeWorkcell.Show();
                    }
                    else
                    {
                        BindData();
                        ShowMessage(lblWorkcellMessage, string.Format("Saved workcell {0} successfully.", txtWorkcellName.Text));
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError(lblWorkcellMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeWorkcell.Show();
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_Workcell dept = new HRTR.Server.CR_Workcell())
                {
                    dept.WorkcellID = Convert.ToInt32(hdWorkcellID.Value);
                    dept.Delete();
                }
                BindData();
                ShowMessage(lblWorkcellMessage, string.Format("Deleted workcell {0} successfully.", txtWorkcellName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblWorkcellMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeWorkcell.Show();
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_Workcell dept = new HRTR.Server.CR_Workcell())
                {
                    dept.WorkcellID = Convert.ToInt32(hdWorkcellID.Value);
                    dept.WorkcellCode = txtWorkcellCode.Text;
                    dept.JdocWorkcellCode = txtJdocWorkcellCode.Text;
                    dept.WorkcellName = txtWorkcellName.Text;
                    string result = dept.Save();
                    if (result != null && result != "")
                    {
                        ShowError(lblWorkcellMessage, result);
                        btnAdd.CssClass = "button invisible";
                        btnUpdateAsk.CssClass = "button";
                        btnDelete.CssClass = "button invisible";
                        mpeWorkcell.Show();
                    }
                    else
                    {
                        BindData();
                        ShowMessage(lblWorkcellMessage, string.Format("Updated workcell {0} successfully.", txtWorkcellName.Text));
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError(lblWorkcellMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeWorkcell.Show();
            }
        }
    }
}
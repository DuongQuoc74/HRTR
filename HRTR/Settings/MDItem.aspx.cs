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
using SystemAuth;

namespace SystemAuth.Settings
{
    public partial class MDItem : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                DataTable dtMDType = SY_MDType.Search();
                //MDItem
                ddlMDTypeS.DataSource = dtMDType;
                ddlMDTypeS.DataBind();
                //ListItem li = new ListItem("[All]", "0");
                //ddlMDTypeS.Items.Insert(0, li);

                //MDItem
                ddlMDType.DataSource = dtMDType;
                ddlMDType.DataBind();
                //ddlMDTypeA.Items.Insert(0, li);

                ////MDItem
                //ddlMDTypeU.DataSource = dtMDType;
                //ddlMDTypeU.DataBind();
                //ddlMDTypeU.Items.Insert(0, li);

                ////MDItem
                //ddlMDTypeD.DataSource = dtMDType;
                //ddlMDTypeD.DataBind();
                //ddlMDTypeD.Items.Insert(0, li);

                Session["MDItemListSort"] = "";
                BindData();
            }
            btnNewMDItem.Focus();
        }
        protected void grvMDItemList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvMDItemList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvMDItemList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvMDItemList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "MDItemListSort";
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
        protected void grvMDItemList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                int imditemid = Convert.ToInt32(e.CommandArgument);
                try
                {
                    //hdMDItemID.Value = commandArgsAccept[0].ToString();
                    //ddlMDTypeU.SelectedValue = commandArgsAccept[1].ToString();
                    //txtMDItemCodeU.Text = commandArgsAccept[2].ToString();
                    //txtDescriptionU.Text = commandArgsAccept[3].ToString();
                    //if (Convert.ToBoolean(commandArgsAccept[4]) == true)
                    //    cbIsActiveU.Checked = true;
                    //else
                    //    cbIsActiveU.Checked = false;
                    LoadMDItem(imditemid);

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

                    mpeMDItem.Show();
                    //txtMDItemCode.Focus();
                }
                catch(Exception ex)
                {
                    ShowError(lblMDItem, ex.Message);
                }
               
            }
            //else if (e.CommandName == "DelMDItem")
            //{
            //    string[] commandArgsAccept = e.CommandArgument.ToString().Split(new char[] { '@' });
            //    try
            //    {
            //        hdMDItemID.Value = commandArgsAccept[0].ToString();
            //        ddlMDTypeD.SelectedValue = commandArgsAccept[1].ToString();
            //        txtMDItemCodeD.Text = commandArgsAccept[2].ToString();
            //        txtDescriptionD.Text = commandArgsAccept[3].ToString();
            //        if (Convert.ToBoolean(commandArgsAccept[4]) == true)
            //            cbIsActiveD.Checked = true;
            //        else
            //            cbIsActiveD.Checked = false;
            //    }
            //    catch
            //    {
            //    }
            //    mpeDelete.Show();
            //    btnDelete.Focus();
            //}
        }
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                try
                {
                    if (Session["MDItemListSort"] != null)
                    {
                        pstr_sort = Session["MDItemListSort"].ToString();
                    }
                }
                catch
                {
                }
            }
            ddlMDType.SelectedValue = ddlMDTypeS.SelectedValue;
            int i_mdtypeid = Convert.ToInt32(ddlMDTypeS.SelectedValue);
            string strmditemcode = txtMDItemCodeS.Text.Trim();
            string strdescription = txtDescriptionS.Text.Trim();
            int iisactive = Convert.ToInt16(ddlIsActiveS.SelectedValue);

            DataTable dtMDItem = SY_MDItem.Search(i_mdtypeid, strmditemcode, strdescription, iisactive);
            if (!string.IsNullOrEmpty(pstr_sort))
                dtMDItem.DefaultView.Sort = pstr_sort;
            grvMDItemList.DataSource = dtMDItem;
            grvMDItemList.DataBind();
            grvMDItemList.SelectedIndex = -1;

            //btnNewMDItem.Enabled = true;
        }
        private void LoadMDItem(int pi_mditemid)
        {
            using (SY_MDItem mdi = new SY_MDItem())
            {
                hdMDItemID.Value = pi_mditemid.ToString();
                mdi.MDItemID = pi_mditemid;
                mdi.Select();

                ddlMDType.SelectedValue = mdi.MDTypeID.ToString();
                txtMDItemCode.Text = mdi.MDItemCode;
                txtDescription.Text = mdi.Description;
                cbIsActive.Checked = mdi.IsActive;
               
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string strmditemcode = txtMDItemCode.Text.Trim();
                using (SY_MDItem mdi = new SY_MDItem())
                {
                    int i_mdtypeid =Convert.ToInt32(ddlMDTypeS.SelectedValue);
                    mdi.MDTypeID = i_mdtypeid;
                    mdi.MDItemCode = strmditemcode;
                    mdi.Description = txtDescription.Text.Trim();
                    mdi.IsActive = cbIsActive.Checked;
                    mdi.Save();
                }

                BindData();
                string strmess = "Saved master data item " + strmditemcode + " successfully.";
                lblMessage.Text = strmess;
                btnMessage.Focus();
                mpeMessage.Show();
            }
            catch (Exception ex)
            {
                ShowError(lblMDItemMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeMDItem.Show();
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                string strmditemcode = txtMDItemCode.Text.Trim();
                using (SY_MDItem mdi = new SY_MDItem())
                {
                    mdi.MDItemID = Convert.ToInt32(hdMDItemID.Value);
                    mdi.Delete();
                }
                BindData();
                string strmess = "Deleted master data item " + strmditemcode + " successfully.";
                lblMessage.Text = strmess;
                mpeMessage.Show();
            }
            catch (Exception ex)
            {
                ShowError(lblMDItemMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeMDItem.Show();
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string strmditemcode = txtMDItemCode.Text.Trim();
                using (SY_MDItem mdi = new SY_MDItem())
                {
                    mdi.MDItemID = Convert.ToInt32(hdMDItemID.Value);
                    mdi.MDTypeID = Convert.ToInt32(ddlMDTypeS.SelectedValue);
                    mdi.MDItemCode = strmditemcode;
                    mdi.Description = txtDescription.Text.Trim();
                    mdi.IsActive = cbIsActive.Checked;

                    mdi.Save();
                }
                BindData();
                string strmess = "Updated master data item " + strmditemcode + " successfully.";
                lblMessage.Text = strmess;
                btnMessage.Focus();
                mpeMessage.Show();
            }
            catch (Exception ex)
            {
                ShowError(lblMDItemMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeMDItem.Show();
            }
        }

        protected void ddlMDType_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
    }
}
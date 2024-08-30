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
    public partial class Product : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                
                //Code 1: TrainingGroup, refer to MDType table
                DataTable dtTrainingGroup = HRTR.Server.CR_TrainingGroup.Search(1);
                //TrainingGroup
                ddlTrainingGroupS.DataSource = dtTrainingGroup;
                ddlTrainingGroupS.DataBind();
                ddlTrainingGroupS.Items.Insert(0, new ListItem("[All]", "0"));

                //TrainingGroup

                ddlTrainingGroup.DataSource = dtTrainingGroup;
                ddlTrainingGroup.DataBind();
                ddlTrainingGroup.Items.Insert(0, new ListItem("[Please Select]", "0"));



                Session["ProductListSort"] = "";
                BindData();
            }
            else if (IsAsync)
            {
            }
            else { }
            btnNewProduct.Focus();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void grvProductList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvProductList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvProductList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvProductList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "ProductListSort";
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
        protected void grvProductList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                try
                {
                    int iproductid = Convert.ToInt32(e.CommandArgument);
                    LoadProduct(iproductid);
                    //mpeUserProfile.Show();
                }
                catch (Exception ex)
                {
                    ShowError(lblProduct, ex.Message);
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
                mpeProduct.Show();

            }
        }
        private void LoadProduct(int pi_productid)
        {
            using (HRTR.Server.CR_Product us = new HRTR.Server.CR_Product())
            {
                hdProductID.Value = pi_productid.ToString();
                us.ProductID = pi_productid;
                us.Select();
                txtProductName.Text = us.ProductName;
                ddlTrainingGroup.SelectedValue = us.TrainingGroupID.ToString();
               
                lblProductMessage.Text = "";
            }
        }
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["ProductListSort"] != null)
                {
                    pstr_sort = Session["ProductListSort"].ToString();
                }
            }
            string strproductname = txtProductNameS.Text;
            int itraininggroup = Convert.ToInt32(ddlTrainingGroupS.SelectedValue);
            DataTable dtProduct = HRTR.Server.CR_Product.Search(strproductname, itraininggroup);
            if (!string.IsNullOrEmpty(pstr_sort))
                dtProduct.DefaultView.Sort = pstr_sort;
            grvProductList.DataSource = dtProduct;
            grvProductList.DataBind();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_Product dept = new HRTR.Server.CR_Product())
                {
                    dept.ProductID = Convert.ToInt32(hdProductID.Value);
                    dept.ProductName = txtProductName.Text;
                    dept.TrainingGroupID = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
                    dept.Save();
                }
                BindData();
                ShowMessage(lblProductMessage, string.Format("Saved product {0} successfully.", txtProductName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblProductMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeProduct.Show();
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_Product dept = new HRTR.Server.CR_Product())
                {
                    dept.ProductID = Convert.ToInt32(hdProductID.Value);
                    dept.Delete();
                }
                BindData();
                ShowMessage(lblProductMessage, string.Format("Deleted product {0} successfully.", txtProductName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblProductMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeProduct.Show();
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_Product dept = new HRTR.Server.CR_Product())
                {
                    dept.ProductID = Convert.ToInt32(hdProductID.Value);
                    dept.ProductName = txtProductName.Text;
                    dept.TrainingGroupID = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
                    dept.Save();
                }
                BindData();
                ShowMessage(lblProductMessage, string.Format("Updated product {0} successfully.", txtProductName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblProductMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeProduct.Show();
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using HRTR.Server;

namespace HRTR.GrapeChart
{
    public partial class StepInsStation : HCM.BasePage.BasePage
    {
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {

                #region GC_Customers
                DataTable dtGC_Customers = GC_Customers.Search();
                ddlGC_CustomersS.DataSource = dtGC_Customers;
                ddlGC_CustomersS.DataBind();

                #endregion

                #region StepInsAndStation
                BindStepInsAndStation();
                #endregion

                BindData();
            }
        }
        #endregion

        #region Search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void grvGC_StepInsStationList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvGC_StepInsStationList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvGC_StepInsStationList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvGC_StepInsStationList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "GC_StepInsStationListSort";
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
        protected void grvGC_StepInsStationList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                int iGC_StepInsStationID = Convert.ToInt32(e.CommandArgument);
                LoadGC_StepInsStation(iGC_StepInsStationID);
                if (e.CommandName == "Select") /// For editing
                {
                    btnAdd.CssClass = "button invisible";
                    btnUpdateAsk.CssClass = "button";
                    btnDelete.CssClass = "button invisible";
                }
                else /// For deleting
                {

                    btnAdd.CssClass = "button invisible";
                    btnUpdateAsk.CssClass = "button invisible";
                    btnDelete.CssClass = "button";
                }
                mpeGC_StepInsStation.Show();
            }
        }
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["GC_StepInsStationListSort"] != null)
                {
                    pstr_sort = Session["GC_StepInsStationListSort"].ToString();
                }
            }
            int imescustomer_id = Convert.ToInt32(ddlGC_CustomersS.SelectedValue);
            string strstepins = txtStepInsS.Text.Trim();
            string strstationname = txtStationNameS.Text.Trim();
            int iisactive = Convert.ToInt16(ddlIsActiveS.SelectedValue);

            DataTable dtGC_StepInsStation = HRTR.Server.GC_StepInsStation.Search(imescustomer_id, strstepins, strstationname, iisactive);
            if (!string.IsNullOrEmpty(pstr_sort))
                dtGC_StepInsStation.DefaultView.Sort = pstr_sort;
            grvGC_StepInsStationList.DataSource = dtGC_StepInsStation;
            grvGC_StepInsStationList.DataBind();

        }
        #endregion

        #region GC_StepInsStation
        private void LoadGC_StepInsStation(int pi_GC_StepInsStationID)
        {
            using (GC_StepInsStation gc = new GC_StepInsStation())
            {
                hdGC_StepInsStationID.Value = pi_GC_StepInsStationID.ToString();
                gc.GC_StepInsStationID = pi_GC_StepInsStationID;
                gc.Select();

                hdCustomer_ID.Value = gc.Customer_ID.ToString();
                using (GC_Customers w = new GC_Customers())
                {
                    w.Customer_ID = gc.Customer_ID;
                    w.Select();
                    txtCustomer.Text = w.Customer;
                }
                ///In case step ins or station has been removed before
                try
                {
                    ddlStepIns.SelectedValue = gc.StepIns;
                    ddlGC_Station.SelectedValue = gc.GC_StationID.ToString();
                }
                catch
                {
                }
                cbIsActive.Checked = gc.IsActive;
                lblGC_StepInsStationMessage.Text = "";
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (GC_StepInsStation gc = new GC_StepInsStation())
                {
                    gc.GC_StepInsStationID = Convert.ToInt32(hdGC_StepInsStationID.Value);
                    gc.Delete();
                }
                BindData();
                ShowMessage(lblSearch, "Deleted successfully.");
            }
            catch (Exception ex)
            {
                ShowError(lblGC_StepInsStationMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeGC_StepInsStation.Show();
            }

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (GC_StepInsStation gc = new GC_StepInsStation())
                {
                    gc.Customer_ID = Convert.ToInt32(hdCustomer_ID.Value);
                    gc.MESCustomer_ID = Convert.ToInt32(hdMESCustomer_ID.Value);

                    gc.StepIns = ddlStepIns.SelectedValue.ToString();
                    gc.GC_StationID = Convert.ToInt32(ddlGC_Station.SelectedValue);
                    gc.IsActive = cbIsActive.Checked;

                    gc.Save();
                }

                BindData();
                ShowMessage(lblSearch, "Saved successfully.");
            }
            catch (Exception ex)
            {
                ShowError(lblGC_StepInsStationMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeGC_StepInsStation.Show();
            }


        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (GC_StepInsStation gc = new GC_StepInsStation())
                {
                    gc.GC_StepInsStationID = Convert.ToInt32(hdGC_StepInsStationID.Value);
                    gc.Customer_ID = Convert.ToInt32(hdCustomer_ID.Value);
                    gc.MESCustomer_ID = Convert.ToInt32(hdMESCustomer_ID.Value);
                    gc.StepIns = ddlStepIns.SelectedValue.ToString();
                    gc.GC_StationID = Convert.ToInt32(ddlGC_Station.SelectedValue);
                    gc.IsActive = cbIsActive.Checked;
                    gc.Save();
                }
                BindData();
                ShowMessage(lblSearch, "Updated successfully.");
            }
            catch (Exception ex)
            {
                ShowError(lblGC_StepInsStationMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeGC_StepInsStation.Show();
            }
        }
        #endregion

        #region Private Methods
        private void BindStepInsAndStation()
        {
            int icustomer_id = Convert.ToInt32(ddlGC_CustomersS.SelectedValue);
            int imescustomer_id = 0;
            using (GC_Customers w = new GC_Customers())
            {
                w.Customer_ID = icustomer_id;
                w.Select();
                imescustomer_id = w.MESCustomer_ID;
            }
            hdCustomer_ID.Value = imescustomer_id.ToString();

            DataTable dtStation = GC_Station.Search(string.Empty, icustomer_id);
            ddlGC_Station.Items.Clear();
            ddlGC_Station.DataSource = dtStation;
            ddlGC_Station.DataBind();
            ddlGC_Station.Items.Insert(0, new ListItem("[Please Select]", "0"));

            hdMESCustomer_ID.Value = imescustomer_id.ToString();

            string strCustomer = ddlGC_CustomersS.SelectedItem.Text;
            txtCustomer.Text = strCustomer;

            DataTable dtStepIns = MESReports.GetStepIns(imescustomer_id);
            ddlStepIns.Items.Clear();
            ddlStepIns.DataSource = dtStepIns;
            ddlStepIns.DataBind();
            ddlStepIns.Items.Insert(0, new ListItem("[Please Select]", "0"));

        }
        #endregion

        #region Control Events
        protected void ddlGC_CustomersS_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData();

            //ddlGC_Customers.ClearSelection();
            //foreach (ListItem li in ddlGC_Customers.Items)
            //{
            //    if (li.Value == strmescustomer_id)
            //    {
            //        li.Selected = true;
            //        break;
            //    }
            //}
            //ddlGC_Customers.Text = ddlGC_CustomersS.SelectedItem.Text;
            //ddlGC_Customers.SelectedValue = ddlGC_CustomersS.SelectedValue;
            BindStepInsAndStation();
        }
        #endregion
    }
}
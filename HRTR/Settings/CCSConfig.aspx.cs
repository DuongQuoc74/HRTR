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
using SystemAuth;

namespace SystemAuth.Settings
{
    public partial class CCSConfig : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                //string strRequireVABeforeMES = string.Empty;
                using (CCS_Config cf = new CCS_Config())
                {
                    cf.ConfigName = "RequireVABeforeMES";
                    cf.Select();
                    ddlRequireVABeforeMES.SelectedValue = StringToBoolean(cf.ConfigValue) == true ? "1" : "2";
                }

                using (CCS_Config cf = new CCS_Config())
                {
                    cf.ConfigName = "IsAppliedCCS";
                    cf.Select();
                    ddlIsAppliedCCS.SelectedValue = StringToBoolean(cf.ConfigValue) == true ? "1" : "2";
                }
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (CCS_Config cf = new CCS_Config())
                {
                    cf.ConfigName = "RequireVABeforeMES";
                    cf.ConfigValue = ddlRequireVABeforeMES.SelectedValue == "1" ? "1" : "0";
                    cf.Comments = txtComments.Text.Trim();
                    cf.Save();
                }
                using (CCS_Config cf = new CCS_Config())
                {
                    cf.ConfigName = "IsAppliedCCS";
                    cf.ConfigValue = ddlIsAppliedCCS.SelectedValue == "1" ? "1" : "0";
                    cf.Comments = txtComments.Text.Trim();
                    cf.Save();
                }
                ShowMessage(lblApply, "Applied successfully.");
            }
            catch (Exception ex)
            {
                ShowError(lblApply, ex.Message);
            }
        }
        #region Private Methods
        #endregion Private Methods
    }
}
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
using System.Text;
using eUtilities;
using SystemAuth;
using HRTR.Server;

namespace HRTR
{
    public partial class ASEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int i_type = 0;
            if (Request.QueryString["type"] != null)
            {
                i_type = Convert.ToInt32(Request.QueryString["type"]);
            }
            #region Load Employee
            if (i_type == 2)
            {
                string str_employeeid = "";
                if (Request.QueryString["employeeid"] != null)
                {
                    str_employeeid = Convert.ToString(Request.QueryString["employeeid"]);
                }
                GetEmployee(str_employeeid);
            }
            #endregion
        }
        private void GetEmployee(string pstr_employeeid)
        {
            StringBuilder sb = new StringBuilder();
            string strerror = string.Empty;
            sb.Append("<?xml version=\"1.0\" ?>");
            sb.Append("<Employees>");
            try
            {
                HR_Employee emp = new HR_Employee();
                emp.EmployeeID = pstr_employeeid;
                emp.SelectByEmployeeID();
                string stroperatorgroupname = string.Empty;
                string strcompanyname = string.Empty;
                string strdepartmentname = string.Empty;
                string strpositionname = string.Empty;
                string strshiftname = string.Empty;
                string strworkcellname = string.Empty;

                using (CR_OperatorGroup opg = new CR_OperatorGroup())
                {
                    opg.OperatorGroupID = emp.OperatorGroupID;
                    opg.Select();
                    stroperatorgroupname = opg.OperatorGroupName;
                }
                using (CR_Company cmp = new CR_Company())
                {
                    cmp.CompanyID = emp.CompanyID;
                    cmp.Select();
                    strcompanyname = cmp.CompanyName;
                }
                using (SY_Department dept = new SY_Department())
                {
                    dept.DepartmentID = emp.DepartmentID;
                    dept.Select();
                    strdepartmentname = dept.DepartmentName;
                }
                using (CR_Position pos = new CR_Position())
                {
                    pos.PositionID = emp.PositionID;
                    pos.Select();
                    strpositionname = pos.PositionName;
                }
                //using (CR_Shift sft = new CR_Shift())
                //{
                //    sft.ShiftID = emp.ShiftID;
                //    sft.Select();
                //    strshiftname = sft.ShiftName;
                //}
                using (CR_Workcell wc = new CR_Workcell())
                {
                    wc.WorkcellID = emp.WorkcellID;
                    wc.Select();
                    strworkcellname = wc.WorkcellName;
                }

                sb.Append("<Employee>");
                sb.Append(("<EmployeeID_ID><![CDATA[") + emp.EmployeeID_ID.ToString() + "]]></EmployeeID_ID>");
                sb.Append(("<EmployeeName><![CDATA[") + emp.EmployeeName + "]]></EmployeeName>");
                sb.Append(("<OperatorGroupName><![CDATA[") + stroperatorgroupname + "]]></OperatorGroupName>");
                sb.Append(("<CompanyName><![CDATA[") + strcompanyname + "]]></CompanyName>");
                sb.Append(("<DepartmentName><![CDATA[") + strdepartmentname + "]]></DepartmentName>");
                sb.Append(("<JobTitle><![CDATA[") + emp.JobTitle + "]]></JobTitle>");
                sb.Append(("<PositionName><![CDATA[") + strpositionname + "]]></PositionName>");
                sb.Append(("<ShiftName><![CDATA[") + strshiftname + "]]></ShiftName>");
                sb.Append(("<WorkcellName><![CDATA[") + strworkcellname + "]]></WorkcellName>");
                sb.Append(("<Supervisor><![CDATA[") + emp.Supervisor + "]]></Supervisor>");
                sb.Append(("<IsActive><![CDATA[") + emp.IsActive.ToString() + "]]></IsActive>");

                sb.Append("</Employee>");

                emp.Dispose();

            }
            catch (Exception ex)
            {
                strerror = ex.Message;
            }
            sb.Append(("<Error><![CDATA[") + strerror + "]]></Error>");
            sb.Append("</Employees>");
            Response.Clear();
            Response.ContentType = "text/xml; charset=utf-8";
            Response.Write(sb.ToString());
            Response.End();
        }
    }
}
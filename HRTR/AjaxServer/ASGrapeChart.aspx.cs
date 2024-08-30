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
using System.IO;
using eUtilities;
using HRTR.Server;

namespace HRTR
{
    public partial class ASGrapeChart : System.Web.UI.Page
    {
        #region Override
        public override void VerifyRenderingInServerForm(Control control)
        {

        }
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            int i_type = 0;
            if (Request.QueryString["type"] != null)
            {
                i_type = Convert.ToInt32(Request.QueryString["type"]);
            }
            #region My Grape Chart
            if (i_type == 9)
            {
                int i_employeeid_id = 0;
                if (Request.QueryString["employeeid_id"] != null)
                {
                    i_employeeid_id = Convert.ToInt32(Request.QueryString["employeeid_id"]);
                }
                int i_year = 0;
                if (Request.QueryString["year"] != null)
                {
                    i_year = Convert.ToInt32(Request.QueryString["year"]);
                }
                int i_month = 0;
                if (Request.QueryString["month"] != null)
                {
                    i_month = Convert.ToInt32(Request.QueryString["month"]);
                }
                int i_day = 0;
                if (Request.QueryString["day"] != null)
                {
                    i_day = Convert.ToInt32(Request.QueryString["day"]);
                }
                DateTime d_selecteddate = new DateTime(i_year, i_month, i_day);
                EmployeeSkillTrackerToDate(i_employeeid_id, d_selecteddate);
            }
            #endregion
            #region Grape Chart Dashboards Workcell
            else if (i_type == 10)
            {
                int pi_customer_id = 0;
                if (Request.QueryString["w"] != null)
                {
                    pi_customer_id = Convert.ToInt32(Request.QueryString["w"]);
                }
                int i_grapecharttypeid = 0;
                if (Request.QueryString["t"] != null)
                {
                    i_grapecharttypeid = Convert.ToInt32(Request.QueryString["t"]);
                }

                int i_year = 0;
                if (Request.QueryString["year"] != null)
                {
                    i_year = Convert.ToInt32(Request.QueryString["year"]);
                }
                int i_month = 0;
                if (Request.QueryString["month"] != null)
                {
                    i_month = Convert.ToInt32(Request.QueryString["month"]);
                }
                int i_employeeid_id = 0;
                if (Request.QueryString["employeeid_id"] != null)
                {
                    i_employeeid_id = Convert.ToInt32(Request.QueryString["employeeid_id"]);
                }
                int i_topn = 0;
                if (Request.QueryString["tn"] != null)
                {
                    i_topn = Convert.ToInt32(Request.QueryString["tn"]);
                }
                CG_Dashboards_Workcell(pi_customer_id, i_grapecharttypeid, i_month, i_year, i_employeeid_id, i_topn);
            }
            #endregion
            #region Employee Grape Chart by Month
            else if (i_type == 11)
            {
                int i_employeeid_id = 0;
                if (Request.QueryString["employeeid_id"] != null)
                {
                    i_employeeid_id = Convert.ToInt32(Request.QueryString["employeeid_id"]);
                }
                int i_year = 0;
                if (Request.QueryString["year"] != null)
                {
                    i_year = Convert.ToInt32(Request.QueryString["year"]);
                }
                int i_month = 0;
                if (Request.QueryString["month"] != null)
                {
                    i_month = Convert.ToInt32(Request.QueryString["month"]);
                }
                EmployeeSkillTrackerByMonth(i_employeeid_id, i_year, i_month);
            }
            #endregion
        }
        private void EmployeeSkillTrackerByMonth(int pi_employeeid_id
                               , int pi_year
                               , int pi_month)
        {


            DataTable dt = HRTR.Server.GC_Data.EmployeeSkillTrackerByMonth(pi_employeeid_id, pi_year, pi_month);

            RenderEmployeeSkill(dt);
        }



        private void EmployeeSkillTrackerToDate(int pi_employeeid_id
                               , DateTime SelectedDate)
        {

            DataTable dtEmployeeSkillTrackerByMonth = HRTR.Server.GC_Data.EmployeeSkillTrackerToDate(pi_employeeid_id, SelectedDate);
            RenderEmployeeSkill(dtEmployeeSkillTrackerByMonth);

        }
        #region Grape Chart Dashboards Workcell

        private void CG_Dashboards_Workcell(int pi_customer_id
                                  , int pi_grapecharttypeid
                                  , int pi_gc_month
                                  , int pi_gc_year

                                  , int pi_employeeid_id
                                  , int pi_topn)
        {
            string stremployeename = string.Empty;
            string stremployeeid = string.Empty;
            int iemployeeid_id = 0;
            StringBuilder sb = new StringBuilder();
            sb.Append("<?xml version=\"1.0\" ?>");
            sb.Append("<GrapeChartCharts>");
            DataTable dtGC_Dashboards_EmployeeID_ID = HRTR.Server.GC_Data.GC_Dashboards_Customer(pi_customer_id
                , pi_grapecharttypeid
                , pi_gc_month
                , pi_gc_year
                , pi_employeeid_id
                , pi_topn);
            foreach (DataRow dr in dtGC_Dashboards_EmployeeID_ID.Rows)
            {
                using (GC_Chart gcc = new GC_Chart())
                {
                    gcc.Fill(dr);
                    sb.Append("<GrapeChartChart>");
                    sb.Append(("<Day><![CDATA[") + gcc.Day.ToString() + "]]></Day>");
                    sb.Append(("<DayStatus><![CDATA[") + gcc.DayStatus.ToString() + "]]></DayStatus>");
                    sb.Append("</GrapeChartChart>");
                    if (iemployeeid_id == 0)
                        iemployeeid_id = gcc.EmployeeID_ID;
                }
            }
            using (HR_Employee em = new HR_Employee())
            {
                em.EmployeeID_ID = iemployeeid_id;
                try
                {
                    em.Select();
                    stremployeename = em.EmployeeName;
                    stremployeeid = em.EmployeeID;
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            sb.Append(("<EmployeeName><![CDATA[") + stremployeename + "]]></EmployeeName>");
            sb.Append(("<EmployeeID><![CDATA[") + stremployeeid + "]]></EmployeeID>");
            sb.Append(("<EmployeeID_ID><![CDATA[") + iemployeeid_id.ToString() + "]]></EmployeeID_ID>");
            sb.Append("</GrapeChartCharts>");

            Page.Session["EmployeeID_ID"] = iemployeeid_id;

            Response.Clear();
            Response.ContentType = "text/xml; charset=utf-8";
            Response.Write(sb.ToString());
            Response.End();
        }
        #endregion
        #region EmployeeSkillTrackerByMonth
        protected void grvEmployeeSkillTrackerByMonth_PreRender(object sender, EventArgs e)
        {
            if (grvEmployeeSkillTrackerByMonth.HeaderRow != null && !grvEmployeeSkillTrackerByMonth.AllowPaging)
            {
                grvEmployeeSkillTrackerByMonth.UseAccessibleHeader = true;
                grvEmployeeSkillTrackerByMonth.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }
        protected void grvEmployeeSkillTrackerByMonth_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int idaystatus = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "DayStatus"));
                //-1: Invisible (hide date), 0: Not working, 1: Green, 2: Yellow, 3: Red
                if (idaystatus == 1)
                {
                    e.Row.CssClass = "green";
                }
                else if (idaystatus == 2)
                {
                    e.Row.CssClass = "yellow";
                }
                else if (idaystatus == 3)
                {
                    e.Row.CssClass = "red";
                }
                else if (idaystatus == 4)
                {
                    e.Row.CssClass = "brown";
                }
                else
                {
                    e.Row.CssClass = "normal";
                }
            }
        }
        protected void grvEmployeeSkillTrackerByMonth_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }
        #endregion
        #region Private Methods
        public static string RenderControl(Control control)
        {
            StringWriter tw = new StringWriter();
            Html32TextWriter writer = new Html32TextWriter(tw);
            control.RenderControl(writer);
            writer.Close();
            return tw.ToString();
        }
        private void RenderEmployeeSkill(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<?xml version=\"1.0\" ?>");
            sb.Append("<GrapeChartCharts>");
            foreach (DataRow dr in dt.Rows)
            {
                using (GC_Chart gcc = new GC_Chart())
                {
                    gcc.Fill(dr);
                    sb.Append("<GrapeChartChart>");
                    sb.Append(("<Day><![CDATA[") + gcc.Day.ToString() + "]]></Day>");
                    sb.Append(("<DayStatus><![CDATA[") + gcc.DayStatus.ToString() + "]]></DayStatus>");
                    sb.Append("</GrapeChartChart>");
                }
            }
            grvEmployeeSkillTrackerByMonth.DataSource = dt;
            grvEmployeeSkillTrackerByMonth.DataBind();
            string strEmployeeSkillTrackerByMonth = RenderControl(grvEmployeeSkillTrackerByMonth);
            sb.Append(("<EmployeeSkillTrackerByMonth><![CDATA[") + strEmployeeSkillTrackerByMonth + "]]></EmployeeSkillTrackerByMonth>");
            sb.Append("</GrapeChartCharts>");
            Response.Clear();
            Response.ContentType = "text/xml; charset=utf-8";
            Response.Write(sb.ToString());
            Response.End();
        }
        #endregion
    }
}
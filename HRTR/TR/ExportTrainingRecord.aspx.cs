using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using HRTR.Server;

public partial class HRTR_ExportTrainingRecord : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.AppendHeader("Content-Disposition", "attachment; filename=TrainingRecord.xls");
        Response.ContentType = "application/vnd.ms-excel";
        Response.ContentEncoding = System.Text.Encoding.Unicode;
        Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

        string sep = "";
        DataTable dt = ExportData();
        foreach (DataColumn dc in dt.Columns)
        {
            Response.Write(sep + dc.ColumnName);
            sep = "\t";
        }
        Response.Write("\n");

        int i;
        foreach (DataRow dr in dt.Rows)
        {
            sep = "";
            for (i = 0; i < dt.Columns.Count; i++)
            {
                if (dt.Columns[i].DataType == typeof(DateTime))
                {
                    try
                    {
                        DateTime da = DateTime.Parse(dr[i].ToString());
                        Response.Write(sep + da.ToString("yyyy-MM-dd HH:mm:ss"));
                    }
                    catch
                    {
                        Response.Write(sep + dr[i].ToString());
                    }
                }
                else
                {
                    Response.Write(sep + dr[i].ToString());
                }
                sep = "\t";
            }
            Response.Write("\n");
        }

        Response.End();
    }
    private DataTable ExportData()
    {
        try
        {
            string stremployeeid = DecryptStr(Convert.ToString(getValue("empid", "")));
            string stremployeename = DecryptStr(Convert.ToString(getValue("empn", "")));

            int ioperatorgroup = 0;
            try
            {
                ioperatorgroup = Convert.ToInt32(getValue("og", 0));
            }
            catch { }
            int icompany = 0;
            try
            {
                icompany = Convert.ToInt32(getValue("cmp", 0));
            }
            catch { }
            int idepartment = 0;
            try
            {
                idepartment = Convert.ToInt32(getValue("dept", 0));
            }
            catch { }
            string strjobtitle = DecryptStr(Convert.ToString(getValue("jobt", "")));

            int iposition = 0;
            try
            {
                iposition = Convert.ToInt32(getValue("pos", 0));
            }
            catch { }
            int ishift = 0;
            try
            {
                ishift = Convert.ToInt32(getValue("s", 0));
            }
            catch { }
            int iworkcell = 0;
            try
            {
                iworkcell = Convert.ToInt32(getValue("wc", 0));
            }
            catch { }
            string strsupervisor = DecryptStr(Convert.ToString(getValue("sup", "")));
            int iisactive = 0;
            try
            {
                iisactive = Convert.ToInt32(getValue("ac", 0));
            }
            catch { }
            int itraininggroupid = 0;
            try
            {
                itraininggroupid = Convert.ToInt32(getValue("tg", 0));
            }
            catch { }
            int icoursegroupid = 0;
            try
            {
                icoursegroupid = Convert.ToInt32(getValue("cg", 0));
            }
            catch { }

            int icourseid = 0;
            try
            {
                icourseid = Convert.ToInt32(getValue("c", 0));
            }
            catch { }
            int iproductid = 0;
            try
            {
                iproductid = Convert.ToInt32(getValue("pro", 0));
            }
            catch { }
            DateTime daExpDateFrom = new DateTime(1900, 1, 1);
            try
            {
                daExpDateFrom = DateTime.ParseExact(Convert.ToString(getValue("exdatefrom", "")), "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daExpDateTo = new DateTime(1900, 1, 1);
            try
            {

                daExpDateTo = DateTime.ParseExact(Convert.ToString(getValue("exdateto", "")), "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daCerDateFrom = new DateTime(1900, 1, 1);
            try
            {
                daCerDateFrom = DateTime.ParseExact(Convert.ToString(getValue("cerdatefrom", "")), "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daCerDateTo = new DateTime(1900, 1, 1);
            try
            {
                daCerDateTo = DateTime.ParseExact(Convert.ToString(getValue("cerdateto", "")), "MM/dd/yyyy", null);
            }
            catch { }
            bool bislatestrecords = false;
            try
            {
                bislatestrecords = Convert.ToBoolean(Convert.ToString(getValue("lr", "")));
            }
            catch { }
            DataTable dtTrainingRecord = HRTR.Server.TrainingRecord.Search(stremployeeid, stremployeename, ioperatorgroup,
                icompany, idepartment, strjobtitle, iposition, ishift, iworkcell, strsupervisor, iisactive, itraininggroupid,
                icoursegroupid, icourseid, iproductid, daExpDateFrom, daExpDateTo, daCerDateFrom, daCerDateTo, bislatestrecords);
            return dtTrainingRecord;

        }
        catch
        {

        }
        return null;
    }
    private object getValue(string pstr_code, object podefault)
    {
        if (Request.QueryString[pstr_code] != null)
        {
            return Request.QueryString[pstr_code];
        }
        else
        {
            return podefault;
        }
    }
    private string DecryptStr(string pstrorg)
    {
        return pstrorg.Replace("?", "&").Replace("$", "=");
    }
    private string EncryptStr(string pstrorg)
    {
        return pstrorg.Replace("&", "?").Replace("=", "$");
    }
}
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
using System.Drawing;
using System.Web.UI.DataVisualization.Charting;
using HRTR.Server;
using System.Collections.Generic;
using SystemAuth;

namespace HRTR.GrapeChart
{
    public partial class GC_SummaryChart : HCM.BasePage.BasePage
    {
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {

                bool isAdmin = IsValidUserRole(new List<EPermissionRole>() { EPermissionRole.Admin, EPermissionRole.Trainer_Leader });
                #region Workcell
                DataTable dtGC_Customers = isAdmin ? GC_Customers.Search() : GC_Customers.SearchByUserProfileId(UserProfileID);
                ddlGC_CustomersS.DataSource = dtGC_Customers;
                ddlGC_CustomersS.DataBind();
                ddlGC_CustomersS.Items.Insert(0, new ListItem("[All]", "0"));
                #endregion

                #region Shift
                DataTable dtShift = CR_Shift.Search();

                ddlShiftS.DataSource = dtShift;
                ddlShiftS.DataBind();
                ddlShiftS.Items.Insert(0, new ListItem("[All]", "0"));

                #endregion

                #region TopN
                for (int i = 5; i <= 20; i += 5)
                {
                    ddlTopNS.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
                ddlTopNS.Items.Insert(0, new ListItem("[All]", "0"));
                ddlTopNS.SelectedValue = "10";
                #endregion

                #region Escaped Date
                txtEscapedDateFromS.Text = DateTime.Now.AddDays(-7).ToString("MM/dd/yyyy");
                txtEscapedDateToS.Text = DateTime.Now.ToString("MM/dd/yyyy");
                #endregion

                //#region Bind Data
                //BindData();
                //#endregion

            }

        }
        #endregion

        #region Search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //if (!cbShowParetoChart.Checked && !cbShowTrendChart.Checked)
            //{
            //    lblGC_SummaryChart.Text = "You have to select at least Show Pareto Chart or Show Trend Chart.";
            //    return;
            //}
            BindData();
        }
        protected void grvGC_ParetoChart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        }
        protected void grvGC_ParetoChart_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }
        protected void grvGC_TrendChart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        }
        protected void grvGC_TrendChart_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }
        private void BindData()
        {
            try
            {
                lblGC_SummaryChart.Text = "";

                #region Text Value
                string strworkcell = Convert.ToString(ddlGC_CustomersS.SelectedItem.Text);
                DateTime daFromDate = new DateTime(1900, 1, 1);
                try
                {
                    daFromDate = DateTime.ParseExact(txtEscapedDateFromS.Text, "MM/dd/yyyy", null);
                }
                catch
                {
                    throw new Exception("Invalid Escaped From.");
                }

                DateTime daToDate = new DateTime(1900, 1, 1);
                try
                {
                    daToDate = DateTime.ParseExact(txtEscapedDateToS.Text, "MM/dd/yyyy", null);
                }
                catch
                {
                    throw new Exception("Invalid Escaped To.");
                }

                if (daToDate < daFromDate)
                {
                    throw new Exception("Escaped To To must be greater than or equal to Escaped From.");
                }
                string strgrouptype = Convert.ToString(ddlGroupTypeS.SelectedItem.Text);
                string strgrapecharttype = Convert.ToString(ddlGrapeChartTypeS.SelectedItem.Text);
                #endregion

                DataSet dsGC_SummaryChart = rptGC_SummaryChart();

                #region Pareto Chart
                if (dsGC_SummaryChart.Tables.Count > 0)
                {

                    DataTable dtGC_ParetoChart = dsGC_SummaryChart.Tables[0];



                    BindParetoChartData(dtGC_ParetoChart, strworkcell, daFromDate, daToDate, strgrouptype, strgrapecharttype);
                    chartGC_ParetoChart.Visible = true;

                    grvGC_ParetoChart.DataSource = dtGC_ParetoChart;
                    grvGC_ParetoChart.DataBind();
                    grvGC_ParetoChart.Visible = true;
                }
                else
                {
                    chartGC_ParetoChart.Visible = false;
                    grvGC_ParetoChart.Visible = false;
                }
                #endregion

                #region Trend Chart
                if (dsGC_SummaryChart.Tables.Count > 1)
                {
                    DataTable dtGC_TrendChart = dsGC_SummaryChart.Tables[1];
                    BindTrendChartData(dtGC_TrendChart, strworkcell, daFromDate, daToDate, strgrouptype, strgrapecharttype);
                    chartGC_TrendChart.Visible = true;

                    grvGC_TrendChart.DataSource = dtGC_TrendChart;
                    grvGC_TrendChart.DataBind();
                    grvGC_TrendChart.Visible = true;
                }
                else
                {
                    chartGC_TrendChart.Visible = false;
                }
                #endregion

            }
            catch (Exception ex)
            {
                chartGC_ParetoChart.Visible = false;
                grvGC_ParetoChart.Visible = false;
                chartGC_TrendChart.Visible = false;
                grvGC_TrendChart.Visible = true;
                //lblGC_SummaryChart.Text = ex.Message;
                ShowError(lblGC_SummaryChart, ex.Message);
            }
        }
        private DataSet rptGC_SummaryChart()
        {

            int icustomer_id = Convert.ToInt32(ddlGC_CustomersS.SelectedValue);

            DateTime daFromDate = new DateTime(1900, 1, 1);
            try
            {
                daFromDate = DateTime.ParseExact(txtEscapedDateFromS.Text, "MM/dd/yyyy", null);
            }
            catch
            {
                throw new Exception("Invalid Escaped From.");
            }

            DateTime daToDate = new DateTime(1900, 1, 1);
            try
            {
                daToDate = DateTime.ParseExact(txtEscapedDateToS.Text, "MM/dd/yyyy", null);
            }
            catch
            {
                throw new Exception("Invalid Escaped To.");
            }

            if (daToDate < daFromDate)
            {
                throw new Exception("Escaped To must be greater than or equal to Escaped From.");
            }

            string stremployeeid = txtEmployeeIDS.Text.Trim();
            int itopn = Convert.ToInt32(ddlTopNS.SelectedValue.Trim());
            int ishiftid = Convert.ToInt32(ddlShiftS.Text.Trim());
            int igrapecharttypeid = Convert.ToInt32(ddlGrapeChartTypeS.SelectedValue);
            int igrouptypeid = Convert.ToInt32(ddlGroupTypeS.SelectedValue);
            int igroupby = Convert.ToInt32(ddlGroupByS.SelectedValue);
            return HRTR.Server.GC_Data.rptGC_SummaryChart(daFromDate
                , daToDate
                , icustomer_id
                , ishiftid
                , stremployeeid
                , itopn
                , igrapecharttypeid
                , igrouptypeid
                , igroupby);

        }
        #endregion

        #region Pareto Chart
        private void BindParetoChartData(DataTable dt, string pstrworkcell, DateTime pdafromdate, DateTime pdatodate, string pstrgrouptype, string pstrgrapecharttype)
        {
            //// Number of data points
            int numOfPoints = dt.Rows.Count;

            //// Generate rundom data
            //RandomData(chartTopRejectedByCRD.Series["Default"], numOfPoints);

            for (int i = 0; i < numOfPoints; i++)
            {
                chartGC_ParetoChart.Series["Total"].Points.AddXY(Convert.ToString(dt.Rows[i]["Name"]), Convert.ToInt32(dt.Rows[i]["Total"]));
            }

            // Make Pareto Chart
            MakeParetoChart(chartGC_ParetoChart, "Total", "Cum");

            // Set chart types for output data
            chartGC_ParetoChart.Series["Cum"].ChartType = SeriesChartType.Line;

            // set the markers for each point of the Pareto Line
            chartGC_ParetoChart.Series["Cum"].IsValueShownAsLabel = true;
            chartGC_ParetoChart.Series["Cum"].MarkerColor = Color.Red;
            chartGC_ParetoChart.Series["Cum"].MarkerBorderColor = Color.MidnightBlue;
            chartGC_ParetoChart.Series["Cum"].MarkerStyle = MarkerStyle.Circle;
            chartGC_ParetoChart.Series["Cum"].MarkerSize = 8;
            chartGC_ParetoChart.Series["Cum"].LabelFormat = "{0}%";  // format with one decimal and leading zero

            // Set Color of line Pareto chart
            chartGC_ParetoChart.Series["Cum"].Color = Color.FromArgb(252, 180, 65);

            //// Show as 2D or 3D
            //if (checkBoxShow3D.Checked)
            //{
            //    chartTopRejectedByCRD.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;

            //    // Set Color of line Pareto chart
            //    chartTopRejectedByCRD.Series["Pareto"].BorderWidth = 1;
            //    chartTopRejectedByCRD.Series["Pareto"]["ShowMarkerLines"] = "True";
            //}
            //else
            //{
            chartGC_ParetoChart.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = false;
            //}

            chartGC_ParetoChart.Titles[0].Text = "PARETO CHART - " + pstrgrouptype + " - " + pstrgrapecharttype;
            chartGC_ParetoChart.Titles[1].Text = "" + pstrworkcell + " - " + pdafromdate.ToString("MM/dd/yyyy") + " - " + pdatodate.ToString("MM/dd/yyyy");
            //chartTopRejectedByCRD.DataSource = dt;
            //chartTopRejectedByCRD.DataBind();
        }
        void MakeParetoChart(Chart chart, string srcSeriesName, string destSeriesName)
        {

            // get name of the ChartAre of the source series
            string strChartArea = chart.Series[srcSeriesName].ChartArea;

            // ensure the source series is a column chart type
            chart.Series[srcSeriesName].ChartType = SeriesChartType.Column;

            // sort the data in the series to be by values in descending order
            chart.DataManipulator.Sort(PointSortOrder.Descending, srcSeriesName);

            // find the total of all points in the source series
            double total = 0.0;
            double dbmax = 0.0;
            foreach (DataPoint pt in chart.Series[srcSeriesName].Points)
            {
                if (pt.YValues[0] > dbmax)
                    dbmax = pt.YValues[0];
                total += pt.YValues[0];
            }
            //dbmax = dbmax * 2;
            dbmax = Math.Ceiling(dbmax / 100) * 100;
            // set the max value on the primary axis to total
            chart.ChartAreas[strChartArea].AxisY.Maximum = dbmax;

            // create the destination series and add it to the chart
            Series destSeries = new Series(destSeriesName);
            chart.Series.Add(destSeries);

            // ensure the destination series is a Line or Spline chart type
            destSeries.ChartType = SeriesChartType.Line;

            destSeries.BorderWidth = 3;

            // assign the series to the same chart area as the column chart
            destSeries.ChartArea = chart.Series[srcSeriesName].ChartArea;

            // assign this series to use the secondary axis and set it maximum to be 100%
            destSeries.YAxisType = AxisType.Secondary;
            chart.ChartAreas[strChartArea].AxisY2.Maximum = 100;

            // locale specific percentage format with no decimals
            chart.ChartAreas[strChartArea].AxisY2.LabelStyle.Format = "{0}%";

            // turn off the end point values of the primary X axis
            chart.ChartAreas[strChartArea].AxisX.LabelStyle.IsEndLabelVisible = false;

            // for each point in the source series find % of total and assign to series
            double percentage = 0.0;

            foreach (DataPoint pt in chart.Series[srcSeriesName].Points)
            {
                percentage += (pt.YValues[0] / total * 100.0);
                destSeries.Points.Add(Math.Round(percentage, 2));
            }
        }
        #endregion

        #region Trend Chart
        private void BindTrendChartData(DataTable dt, string pstrworkcell, DateTime pdafromdate, DateTime pdatodate, string pstrgrouptype, string pstrgrapecharttype)
        {
            //chartGC_TrendChart.Palette = ChartColorPalette.
            //chartGC_TrendChart.PaletteCustomColors = new Color[] { Color.Red, Color.Blue, Color.Yellow };

            int iRowCount = dt.Rows.Count;
            for (int i = 0; i < iRowCount; i++)
            {
                string strGroupName = Convert.ToString(dt.Rows[i]["Name"]);
                if (strGroupName.Equals("Total", StringComparison.CurrentCultureIgnoreCase))
                {
                    continue;
                }
                Series chartSeries = new Series();
                chartSeries.Name = strGroupName;
                chartSeries.ChartType = SeriesChartType.Line;
                chartSeries.IsValueShownAsLabel = true;
                chartSeries.IsVisibleInLegend = true;
                chartSeries.LabelFormat = "{#}";
                chartSeries.MarkerBorderColor = Color.MidnightBlue;
                chartSeries.MarkerStyle = MarkerStyle.Circle;
                chartSeries.MarkerSize = 6;
                chartSeries.BorderWidth = 2;

                int iColumnCount = dt.Columns.Count;
                for (int j = 1; j < iColumnCount; j++)
                {
                    string strColumnName = dt.Columns[j].ColumnName;
                    if (strColumnName.Equals("No.", StringComparison.CurrentCultureIgnoreCase)
                        || strColumnName.Equals("GroupName", StringComparison.CurrentCultureIgnoreCase)
                        || strColumnName.Equals("Total", StringComparison.CurrentCultureIgnoreCase))
                    {
                        continue;
                    }

                    string str_X = strColumnName;
                    int i_Y = 0;
                    try
                    {
                        i_Y = Convert.ToInt32(dt.Rows[i][j]);
                    }
                    catch
                    {
                    }
                    chartSeries.Points.AddXY(str_X, i_Y);
                }
                chartGC_TrendChart.Series.Add(chartSeries);
            }

            chartGC_TrendChart.Titles[0].Text = "TREND CHART - " + pstrgrouptype + " - " + pstrgrapecharttype;
            chartGC_TrendChart.Titles[1].Text = "" + pstrworkcell + " - " + pdafromdate.ToString("MM/dd/yyyy") + " - " + pdatodate.ToString("MM/dd/yyyy");
            //chartGC_TrendChart.DataSource = dt;
            //chartGC_TrendChart.DataBind();

        }
        #endregion
    }
}
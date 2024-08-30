namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    ////

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("GC_Data")]
    public class GC_Data : OBase
    {

        #region Fields
        private int _GC_DataID;
        private int _Customer_ID;
        private System.DateTime _EscapedDate;
        private int _ShiftID;
        

        private int _Defect_ID;
        private string _DefectText;
        private string _CRD;
        private string _SerialNumber;
        private string _Description;

        private int _EscapedStationID;
        private string _EscapedByEmployeeID;
        private string _DetectedByEmployeeID;
        private int _DetectedStationID;

        #endregion

        #region Constructors
        public GC_Data()
        {
            this._DefectText = "";
            this._CRD = "";
            this._SerialNumber = "";
            this._Description = "";
            this._EscapedStationID = 0;
            this._EscapedByEmployeeID = "";
            this._DetectedStationID = 0;
            this._DetectedByEmployeeID = "";
        }
        #endregion
        #region Properties
        public int GC_DataID
        {
            get
            {
                return this._GC_DataID;
            }
            set
            {
                this._GC_DataID = value;
            }
        }
        public int Customer_ID
        {
            get
            {
                return this._Customer_ID;
            }
            set
            {
                this._Customer_ID = value;
            }
        }
        
        public System.DateTime EscapedDate
        {
            get
            {
                return this._EscapedDate;
            }
            set
            {
                this._EscapedDate = value;
            }
        }
        public int ShiftID
        {
            get
            {
                return this._ShiftID;
            }
            set
            {
                this._ShiftID = value;
            }
        }
        
        public int Defect_ID
        {
            get
            {
                return this._Defect_ID;
            }
            set
            {
                this._Defect_ID = value;
            }
        }
        public string DefectText
        {
            get
            {
                return this._DefectText;
            }
            set
            {
                this._DefectText = value;
            }
        }
        public string CRD
        {
            get
            {
                return this._CRD;
            }
            set
            {
                this._CRD = value;
            }
        }
        public string SerialNumber
        {
            get
            {
                return this._SerialNumber;
            }
            set
            {
                this._SerialNumber = value;
            }
        }
        public string Description
        {
            get
            {
                return this._Description;
            }
            set
            {
                this._Description = value;
            }
        }

        
        public int EscapedStationID
        {
            get
            {
                return this._EscapedStationID;
            }
            set
            {
                this._EscapedStationID = value;
            }
        }
        public string EscapedByEmployeeID
        {
            get
            {
                return this._EscapedByEmployeeID;
            }
            set
            {
                this._EscapedByEmployeeID = value;
            }
        }
        public string DetectedByEmployeeID
        {
            get
            {
                return this._DetectedByEmployeeID;
            }
            set
            {
                this._DetectedByEmployeeID = value;
            }
        }
        public int DetectedStationID
        {
            get
            {
                return this._DetectedStationID;
            }
            set
            {
                this._DetectedStationID = value;
            }
        }
        #endregion

        #region Methods

        public bool Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[14, 2]	{	{"@GC_DataID", this._GC_DataID},
                                                            {"@Customer_ID", this._Customer_ID},
                                                            {"@EscapedDate", this._EscapedDate},
                                                            {"@ShiftID", this._ShiftID},

                                                            {"@EscapedByEmployeeID", this._EscapedByEmployeeID},
                                                            {"@EscapedStationID", this._EscapedStationID},

                                                            {"@Defect_ID", this._Defect_ID},
                                                            {"@DefectText", this._DefectText},
                                                            {"@CRD", this._CRD},
                                                            {"@SerialNumber", this._SerialNumber},
                                                            {"@Description", this._Description},

                                                            {"@DetectedByEmployeeID", this._DetectedByEmployeeID},
                                                            {"@DetectedStationID", this._DetectedStationID},
                                                            {"@LastUpdatedBy", this.LastUpdatedBy}
														};
                    _con.ExecStore("GC_Data_Save", paramarr);
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int Delete()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]	{	{ "@GC_DataID", this._GC_DataID } ,
                                                        { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("GC_Data_Delete", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void Select()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@GC_DataID", this._GC_DataID } };
                    DataTable dt = _con.GetDataTableByStore("GC_Data_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable GC_Dashboards_Customer(int pi_customer_id
                               , int pi_grapecharttypeid
                               , int pi_gc_month
                               , int pi_gc_year
                               , int pi_employeeid_id
                               , int pi_topn)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[6, 2]	{	
                                                            {"@Customer_ID", pi_customer_id},
                                                            {"@GrapeChartTypeID", pi_grapecharttypeid},
                                                            {"@GC_Month", pi_gc_month},
                                                            {"@GC_Year", pi_gc_year},
                                                            {"@EmployeeID_ID", pi_employeeid_id},
                                                            {"@TopN", pi_topn}
														};
                    return _con.GetDataTableByStore("GC_Dashboards_Customer", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable EmployeeSkillTrackerByMonth(int pi_employeeid_id
                               , int pi_year
                               , int pi_month)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[3, 2]	{	
                                                            {"@EmployeeID_ID", pi_employeeid_id},
                                                            {"@Year", pi_year},
                                                            {"@Month", pi_month}
														};
                    return _con.GetDataTableByStore("GC_Data_EmployeeSkillTracker_By_Month", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable EmployeeSkillTracker(int pi_employeeid_id
                                                    , int pi_year)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]	{	
                                                            {"@EmployeeID_ID", pi_employeeid_id},
                                                            {"@Year", pi_year}
														};
                    return _con.GetDataTableByStore("GC_Data_EmployeeSkillTracker", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataSet WorkcellSkillTracker(int pi_workcellid
                                       , int pi_year)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]	{	
                                                            {"@WorkcellID", pi_workcellid},
                                                            {"@Year", pi_year}
														};
                    return _con.GetDataSetByStore("GC_Data_WorkcellSkillTracker", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable Search(DateTime pda_escapeddatefrom,
                                        DateTime pda_escapeddateto,
                                        int pi_customer_id,
                                        int pi_shiftid,
                                        int pi_detectedstationid,
                                        int pi_escapedstationid,
                                        int pi_defect_id,
                                        string pstr_crd,
                                        string pstr_serialnumber,
                                        string pstr_description,
                                        
                                        string pstr_detectedbyemployeeid,
                                        string pstr_escapedemployeeid,
                                        int pi_ismesautolinked
                                       )
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[13, 2]	{	
                                                            {"@EscapedDateFrom", pda_escapeddatefrom},
                                                            {"@EscapedDateTo", pda_escapeddateto},
                                                            {"@Customer_ID", pi_customer_id},
                                                            {"@ShiftID", pi_shiftid},
                                                            {"@DetectedStationID", pi_detectedstationid},
                                                            {"@EscapedStationID", pi_escapedstationid},
                                                            {"@Defect_ID", pi_defect_id},
                                                            {"@CRD", pstr_crd},
                                                            {"@SerialNumber", pstr_serialnumber},
                                                            {"@Description", pstr_description},
                                                            {"@EscapedByEmployeeID", pstr_escapedemployeeid},
                                                            {"@DetectedByEmployeeID", pstr_detectedbyemployeeid},
                                                            {"@IsMESAutoLinked", pi_ismesautolinked}
														};
                    return _con.GetDataTableByStore("GC_Data_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable rptGC_Summary(DateTime pda_escapeddatefrom,
                                        DateTime pda_escapeddateto,
                                        int pi_customer_id,
                                        int pi_shiftid,
                                        int pi_detectedstationid,
                                        int pi_escapedstationid,
                                        int pi_defect_id,
                                        string pstr_crd,
                                        string pstr_serialnumber,
                                        string pstr_description,
                                        string pstr_detectedbyemployeeid,
                                        string pstr_escapedemployeeid,
                                        int pi_ismesautolinked,
                                        int pi_grapecharttypeid
                                       )
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[14, 2]	{	
                                                            {"@EscapedDateFrom", pda_escapeddatefrom},
                                                            {"@EscapedDateTo", pda_escapeddateto},
                                                            {"@Customer_ID", pi_customer_id},
                                                            {"@ShiftID", pi_shiftid},
                                                            {"@DetectedStationID", pi_detectedstationid},
                                                            {"@EscapedStationID", pi_escapedstationid},
                                                            {"@Defect_ID", pi_defect_id},
                                                            {"@CRD", pstr_crd},
                                                            {"@SerialNumber", pstr_serialnumber},
                                                            {"@Description", pstr_description},
                                                            {"@EscapedByEmployeeID", pstr_escapedemployeeid},
                                                            {"@DetectedByEmployeeID", pstr_detectedbyemployeeid},
                                                            {"@IsMESAutoLinked", pi_ismesautolinked},
                                                            {"@GrapeChartTypeID", pi_grapecharttypeid}
														};
                    return _con.GetDataTableByStore("rptGC_Summary", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet rptGC_SummaryChart(DateTime pda_escapeddatefrom,
                                        DateTime pda_escapeddateto,
                                        int pi_customer_id,
                                        int pi_shiftid,
                                        string pstr_employeeid,
                                        int pi_topn,
                                        int pi_grapecharttypeid,
                                        int pi_grouptypeid,
                                        int pi_groupby
                                       )
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[9, 2]	{	
                                                            {"@EscapedDateFrom", pda_escapeddatefrom},
                                                            {"@EscapedDateTo", pda_escapeddateto},
                                                            {"@Customer_ID", pi_customer_id},
                                                            {"@ShiftID", pi_shiftid},
                                                            {"@EmployeeID", pstr_employeeid},
                                                            {"@TopN", pi_topn},
                                                            {"@GrapeChartTypeID", pi_grapecharttypeid},
                                                            {"@GroupTypeID", pi_grouptypeid},
                                                            {"@GroupBy", pi_groupby}
														};
                    return _con.GetDataSetByStore("rptGC_SummaryChart", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable EmployeeSkillTrackerToDate(int pi_employeeid_id
                               , DateTime SelectedDay)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]   {
                                                            {"@EmployeeID_ID", pi_employeeid_id},
                                                            {"@SelectedDay", SelectedDay}
                                                        };
                    return _con.GetDataTableByStore("GC_Data_EmployeeSkillTracker_To_Date", paramarr);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw;
            }
        }
        #endregion
    }
}


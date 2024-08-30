namespace HRTR.Server {

    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_Course")]
    public class CR_Course : OBase {
        private int _CourseID;
        private string _CourseName;
        private int _CourseGroupID;
        private int _TrainingGroupID;
        private int _ExpiredInMonths;
        private decimal _MinPoint;
        private decimal _MaxPoint;
        private int _NumberOfCriticalDays;
        private bool _HasVA;
        private bool _IsCritical;
        private bool _IsOrientation;

        private DateTime _EffectiveDate;
        private bool _IsActive;

        public CR_Course() {
            this._CourseName = "";
            //this._UserName = Environment.UserName;
        }

        public int CourseID {
            get {
                return this._CourseID;
            }
            set {
                this._CourseID = value;
            }
        }

        public string CourseName {
            get {
                return this._CourseName;
            }
            set {
                this._CourseName = value;
            }
        }

        public int CourseGroupID {
            get {
                return this._CourseGroupID;
            }
            set {
                this._CourseGroupID = value;
            }
        }

        public int TrainingGroupID {
            get {
                return this._TrainingGroupID;
            }
            set {
                this._TrainingGroupID = value;
            }
        }

        public int ExpiredInMonths {
            get {
                return this._ExpiredInMonths;
            }
            set {
                this._ExpiredInMonths = value;
            }
        }

        public decimal MinPoint {
            get {
                return this._MinPoint;
            }
            set {
                this._MinPoint = value;
            }
        }

        public decimal MaxPoint {
            get {
                return this._MaxPoint;
            }
            set {
                this._MaxPoint = value;
            }
        }

        public int NumberOfCriticalDays {
            get {
                return this._NumberOfCriticalDays;
            }
            set {
                this._NumberOfCriticalDays = value;
            }
        }

        public bool HasVA {
            get {
                return this._HasVA;
            }
            set {
                this._HasVA = value;
            }
        }

        public bool IsCritical {
            get {
                return this._IsCritical;
            }
            set {
                this._IsCritical = value;
            }
        }

        public bool IsOrientation {
            get {
                return this._IsOrientation;
            }
            set {
                this._IsOrientation = value;
            }
        }

        public bool IsCertifiedPerFamily { get; set; }

        public DateTime EffectiveDate {
            get {
                return this._EffectiveDate;
            }
            set {
                this._EffectiveDate = value;
            }
        }

        public bool IsActive {
            get {
                return this._IsActive;
            }
            set {
                this._IsActive = value;
            }
        }

        public bool Save() {
            try {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess()) {
                    object[,] paramarr = new object[,] {
                        { "@CourseID", this._CourseID },
                        { "@CourseName", this._CourseName},
                        { "@ExpiredInMonths", this._ExpiredInMonths},
                        { "@CourseGroupID", this._CourseGroupID },
                        { "@TrainingGroupID", this._TrainingGroupID },
                        { "@HasVA", this._HasVA },
                        { "@IsCritical", this._IsCritical },
                        { "@IsOrientation", this._IsOrientation },
                        { "@IsCertifiedPerFamily", this.IsCertifiedPerFamily },
                        { "@EffectiveDate", this._EffectiveDate },
                        { "@NumberOfCriticalDays", this._NumberOfCriticalDays},
                        { "@IsActive", this._IsActive },
                        { "@MinPoint", this._MinPoint },
                        { "@MaxPoint", this._MaxPoint },
                        { "@LastUpdatedBy", this.LastUpdatedBy }
                    };

                    DataTable dt = _con.ExecStoreRDataTable("CR_Course_Save", paramarr);

                    this.Fill(dt.Rows[0]);
                    return true;
                }
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        public int Delete() {
            //try
            //{
            //    ConnectionDatabase condb = new ConnectionDatabase();
            //    object[,] paramarr = new object[1, 2] { { "@CourseID", this._CourseID } };
            //    return condb.execStoreRI("Course_Delete", paramarr);
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}
            try {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess()) {
                    object[,] paramarr = new object[2, 2]   {    { "@CourseID", this._CourseID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
                                                        };
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_Course_Delete", paramarr));
                }
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        public void Select() {
            //try
            //{
            //    ConnectionDatabase condb = new ConnectionDatabase();
            //    object[,] paramarr = new object[1, 2] { { "@CourseID", this._CourseID } };
            //    DataTable dt = condb.execStoreRDT("Course_Select", paramarr);
            //    DataRow dr = dt.Rows[0];
            //    this.Fill(dr);
            //}
            //catch
            //{
            //}

            try {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess()) {
                    object[,] paramarr = new object[1, 2] { { "@CourseID", this._CourseID } };

                    DataTable dt = _con.GetDataTableByStore("CR_Course_Select", paramarr);
                    //DataRow dr = dt.Rows[0];
                    this.Fill(dt.Rows[0]);
                }
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        public static DataTable Search(string pstr_coursename = "",
                                        int pi_coursegroupid = 0,
                                        int pi_traininggroupid = 0,
                                        int pi_hasva = -1,
                                        int pi_iscritical = -1,
                                        int pi_isorientation = -1,
                                        int pi_isCertifiedPerFamily = -1,
                                        string pstr_coursegroupidlist = "",
                                        int pi_isactive = -1) {
            try {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess()) {
                    object[,] paramarr = new object[,] {
                        { "@CourseName",pstr_coursename},
                        { "@CourseGroupID", pi_coursegroupid},
                        { "@TrainingGroupID", pi_traininggroupid },
                        { "@HasVA", pi_hasva },
                        { "@IsCritical", pi_iscritical },
                        { "@IsOrientation", pi_isorientation },
                        { "@IsCertifiedPerFamily", pi_isCertifiedPerFamily },
                        { "@CourseGroupIDList", pstr_coursegroupidlist },
                        { "@IsActive", pi_isactive },
                    };

                    return _con.GetDataTableByStore("CR_Course_Search", paramarr);
                }
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        #region For CCS Project

        #endregion For CCS Project

        #region Import

        private static DataTable GetDataFromExcelFile(string pFromExcelFile) {
            //DataTable dt = new DataTable();
            try {
                Excel2SQL e2s = new Excel2SQL {
                    FromExcelFile = pFromExcelFile,
                    ExcelQuery = "SELECT * FROM [Course$]"
                };

                var dt = e2s.readExcel2DataTable();

                if (dt.Rows.Count > 0) {
                    return dt;
                }
                else {
                    throw new Exception("The import file contains records with blank or invalid data.");
                }
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        public static void Preview(string pFromExcelFile, int pLastUpdatedBy) {
            try {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess()) {
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pLastUpdatedBy } };

                    _con.ExecStore("CR_CourseTemp_Verify_Before_Loading", paramarr);
                }

                // Add LastUpdatedBy column to dt
                DataTable dt = GetDataFromExcelFile(pFromExcelFile);

                var lastUpdatedByCol = new DataColumn {
                    ColumnName = "LastUpdatedBy",
                    DataType = typeof(int),
                    DefaultValue = pLastUpdatedBy
                };
                dt.Columns.Add(lastUpdatedByCol);

                dt.AcceptChanges();

                // Create new DataTable2SQL obj
                DataTable2SQL dt2s = new DataTable2SQL {
                    FromDataTable = dt,
                    SQLConnectionString = HRTRConfig.ConnectionString,
                    ToSQLTable = "CR_CourseTemp"
                };

                dt2s.ToSQLTableColumns.Add("Training Group", "TrainingGroupName");
                dt2s.ToSQLTableColumns.Add("Course Group", "CourseGroupName");
                dt2s.ToSQLTableColumns.Add("Course", "CourseName");
                dt2s.ToSQLTableColumns.Add("Expired In Months", "ExpiredInMonths");
                dt2s.ToSQLTableColumns.Add("Min Point", "MinPoint");
                dt2s.ToSQLTableColumns.Add("Max Point", "MaxPoint");
                dt2s.ToSQLTableColumns.Add("VA", "HasVA");
                dt2s.ToSQLTableColumns.Add("Critical", "IsCritical");
                dt2s.ToSQLTableColumns.Add("Orientation", "IsOrientation");
                dt2s.ToSQLTableColumns.Add("Certified Per Family", "IsCertifiedPerFamily");
                dt2s.ToSQLTableColumns.Add("Effective Date", "EffectiveDate");
                dt2s.ToSQLTableColumns.Add("Number Of Log In Days", "NumberOfCriticalDays");
                dt2s.ToSQLTableColumns.Add("Active", "IsActive");
                dt2s.ToSQLTableColumns.Add("LastUpdatedBy", "LastUpdatedBy");

                if (dt2s.readDataTable2SQL()) {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess()) {
                        object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pLastUpdatedBy } };
                        _con.ExecStore("CR_CourseTemp_Verify_After_Loading", paramarr);
                    }
                }
                dt = null;
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        public static DataTable SearchTemp(int pi_lastupdatedby) {
            try {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess()) {
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_lastupdatedby } };
                    return _con.GetDataTableByStore("CR_CourseTemp_Search", paramarr);
                }
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        public static int Import(int pi_lastupdatedby) {
            try {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess()) {
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_lastupdatedby } };
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_Course_Import", paramarr));
                }
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        #endregion Import
    }
}
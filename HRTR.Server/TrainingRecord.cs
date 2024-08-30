namespace HRTR.Server
{

    using System;
    using System.Data;
    using System.Xml;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("TrainingRecord")]
    public class TrainingRecord : OBase
    {

        #region Fields

        private int _TrainingRecordID;
        private int _EmployeeID_ID;
        private int _ProductID;
        private string _Trainer;
        private int _CourseID;
        private int _TrainingGroupID;
        private int _CourseGroupID;
        private System.DateTime _CertDate;
        private System.DateTime _ExpDate;
        private decimal _Score;
        private int _CertifiedLevelID;
        private bool _OJT;
        private bool _IsActive;
        private string _Comments;
        private string _SiteName;

        #endregion Fields

        #region Constructors

        public TrainingRecord()
        {
            this._Trainer = "";
        }

        #endregion Constructors

        #region Properties

        public int TrainingRecordID
        {
            get
            {
                return this._TrainingRecordID;
            }
            set
            {
                this._TrainingRecordID = value;
            }
        }

        public int EmployeeID_ID
        {
            get
            {
                return this._EmployeeID_ID;
            }
            set
            {
                this._EmployeeID_ID = value;
            }
        }

        public int ProductID
        {
            get
            {
                return this._ProductID;
            }
            set
            {
                this._ProductID = value;
            }
        }

        public string Trainer
        {
            get
            {
                return this._Trainer;
            }
            set
            {
                this._Trainer = value;
            }
        }

        public int CourseID
        {
            get
            {
                return this._CourseID;
            }
            set
            {
                this._CourseID = value;
            }
        }

        public int TrainingGroupID
        {
            get
            {
                return this._TrainingGroupID;
            }
            set
            {
                this._TrainingGroupID = value;
            }
        }

        public int CourseGroupID
        {
            get
            {
                return this._CourseGroupID;
            }
            set
            {
                this._CourseGroupID = value;
            }
        }

        public System.DateTime CertDate
        {
            get
            {
                return this._CertDate;
            }
            set
            {
                this._CertDate = value;
            }
        }

        public System.DateTime ExpDate
        {
            get
            {
                return this._ExpDate;
            }
            set
            {
                this._ExpDate = value;
            }
        }

        public decimal Score
        {
            get
            {
                return this._Score;
            }
            set
            {
                this._Score = value;
            }
        }

        public int CertifiedLevelID
        {
            get { return this._CertifiedLevelID; }
            set { _CertifiedLevelID = value; }
        }

        public bool OJT
        {
            get { return this._OJT; }
            set { _OJT = value; }
        }

        public bool IsActive
        {
            get { return this._IsActive; }
            set { _IsActive = value; }
        }

        public string Comments
        {
            get
            {
                return this._Comments;
            }
            set
            {
                this._Comments = value;
            }
        }

        public string SiteName
        {
            get
            {
                return this._SiteName;
            }
            set
            {
                this._SiteName = value;
            }
        }

        #endregion Properties

        #region Methods

        public bool Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[12, 2] {
                        {"@TrainingRecordID", this._TrainingRecordID},
                        {"@EmployeeID_ID", this._EmployeeID_ID},
                        {"@ProductID", this._ProductID},
                        {"@Trainer", this._Trainer},
                        {"@CourseID", this._CourseID},
                        {"@CertDate", this._CertDate},
                        {"@ExpDate", this._ExpDate},
                        {"@Score", this._Score},
                        //{"@CertifiedLevelID", this._CertifiedLevelID},
                        {"@OJT", this._OJT},
                        {"@IsActive", this._IsActive},
                        {"@Comments", this._Comments},
                        {"@LastUpdatedBy", this.LastUpdatedBy}
                    };
                    _con.ExecStore("TrainingRecord_Save", paramarr);
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
                    object[,] paramarr = new object[2, 2]   {   { "@TrainingRecordID", this._TrainingRecordID } ,
                                                        { "@LastUpdatedBy", this.LastUpdatedBy}
                                                        };
                    return Convert.ToInt32(_con.ExecStoreRObject("TrainingRecord_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@TrainingRecordID", this._TrainingRecordID } };
                    DataTable dt = _con.GetDataTableByStore("TrainingRecord_Select", paramarr);
                    //DataRow dr = dt.Rows[0];
                    this.Fill(dt.Rows[0]);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //public static DataTable SearchBE( DateTime pda_cerdatefrom,
        //                              DateTime pda_cerdateto,
        //                              string pstr_employeeid,
        //                              string pstr_employeeidsap
        //                              )
        //{
        //    try
        //    {
        //        using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
        //        {
        //            object[,] paramarr = new object[4, 2]	{	{"@EmployeeID", pstr_employeeid},
        //                                                    {"@EmployeeIDSAP", pstr_employeeidsap},
        //                                                    {"@CerDateFrom", pda_cerdatefrom},
        //                                                    {"@CerDateTo", pda_cerdateto}
        //                                                };
        //            return _con.GetDataTableByStore("TrainingRecord_Search_BE", paramarr);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        public static DataTable Search(string pstr_employeeid,
                                       string pstr_employeeidsap,
                                       string pstr_employeename,
                                       int pi_operatorgroupid,
                                       int pi_companyid,
                                       int pi_departmentid,
                                       string pstr_jobtitle,
                                       int pi_positionid,
                                       int pi_workcellid,
                                       string pstr_supervisor,
                                       int pi_isactive_employee,
                                       int pi_traininggroupid,
                                       string pstr_traininggroupidlist,
                                       int pi_coursegroupid,
                                       string pstr_coursegroupidlist,
                                       string pstr_coursename,
                                       string pstr_coursenamelist,
                                       int pi_productid,
                                       DateTime pda_expdatefrom,
                                       DateTime pda_expdateto,
                                       DateTime pda_cerdatefrom,
                                       DateTime pda_cerdateto,
                                       bool pb_islatestrecords,
                                       int pi_isactive_trainingrecord,
                                       int pi_workingstatusid,
                                       string pstr_workingstatusidlist,
                                       int pi_certifiedlevelid,
                                       string pstr_certifiedlevelidlist,
                                       int pi_isworking = -1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[29, 2]  {   {"@EmployeeID", pstr_employeeid},
                                                            {"@EmployeeIDSAP", pstr_employeeidsap},
                                                            {"@EmployeeName", pstr_employeename},
                                                            {"@OperatorGroupID", pi_operatorgroupid},
                                                            {"@CompanyID", pi_companyid},
                                                            {"@DepartmentID", pi_departmentid},
                                                            {"@JobTitle", pstr_jobtitle},
                                                            {"@PositionID", pi_positionid},
                                                            {"@WorkcellID", pi_workcellid},
                                                            {"@Supervisor", pstr_supervisor},
                                                            {"@IsActive_Employee", pi_isactive_employee},
                                                            {"@TrainingGroupID", pi_traininggroupid},
                                                            {"@TrainingGroupIDList", pstr_traininggroupidlist},
                                                            {"@CourseGroupID", pi_coursegroupid},
                                                            {"@CourseGroupIDList", pstr_coursegroupidlist},
                                                            {"@CourseName", pstr_coursename},
                                                            {"@CourseNameList", pstr_coursenamelist},
                                                            {"@ProductID", pi_productid},
                                                            {"@ExpDateFrom", pda_expdatefrom},
                                                            {"@ExpDateTo", pda_expdateto},
                                                            {"@CerDateFrom", pda_cerdatefrom},
                                                            {"@CerDateTo", pda_cerdateto},
                                                            {"@IsLatestRecords", pb_islatestrecords},
                                                            {"@IsActive_TrainingRecord", pi_isactive_trainingrecord},
                                                            {"@WorkingStatusID", pi_workingstatusid},
                                                            {"@WorkingStatusIDList", pstr_workingstatusidlist},
                                                            {"@CertifiedLevelID", pi_certifiedlevelid},
                                                            {"@CertifiedLevelIDList", pstr_certifiedlevelidlist},
                                                            {"@IsWorking", pi_isworking}
                                                        };
                    return _con.GetDataTableByStore("TrainingRecord_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable SearchV2(
                                    int pi_workcellid,
                                    int pi_stationid,
                                    int pi_courseid,
                                    string docNumber,
                                    string docRev,
                                    DateTime pda_cerdatefrom,
                                    DateTime pda_cerdateto)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[7, 2]  {
                                                            {"@WorkcellID", pi_workcellid},
                                                            {"@StationID", pi_stationid},
                                                            {"@CourseID", pi_courseid},
                                                            {"@DocumentNumber", docNumber},
                                                            {"@Revision", docRev},
                                                            {"@CerDateFrom", pda_cerdatefrom},
                                                            {"@CerDateTo", pda_cerdateto}
                                                        };
                    return _con.GetDataTableByStore("TrainingRecord_Search_Map_Doc", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static string ConvertListToXml(int[] numbers)
        {
            XmlDocument doc = new XmlDocument();
            doc.XmlResolver = null;
            XmlElement root = doc.CreateElement("Root");

            doc.AppendChild(root);

            foreach (int number in numbers)
            {
                XmlElement element = doc.CreateElement("Value");
                element.InnerText = number.ToString();
                root.AppendChild(element);
            }

            return doc.OuterXml;
        }

        public static DataTable SaveDocumentMap(int[] trList, int stationID, int workcellID, int courseID, DateTime pda_cerdatefrom, DateTime pda_cerdateto, string docNumber, string docRev, int profileID)
        {
            string xml = ConvertListToXml(trList);
            using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
            {
                object[,] paramarr = new object[11, 2]  {
                                                            {"@TRXml", xml},
                                                            {"@StationID", stationID},
                                                            {"@WorkcellID", workcellID},
                                                            {"@CourseID", courseID},
                                                            {"@CerDateFrom", pda_cerdatefrom},
                                                            {"@CerDateTo", pda_cerdateto},
                                                            {"@DocumentNumber", docNumber},
                                                            {"@Revision", docRev},
                                                            {"@CreatedBy", profileID},
                                                            {"@Active", true},
                                                            {"@EmployeeDocID", 0}
                                                        };
                return _con.GetDataTableByStore("[CR_EmployeeDocument_Save]", paramarr);
            }
        }

        public static DataTable SaveAllDocumentMap(int stationID, int workcellID, int courseID, DateTime pda_cerdatefrom, DateTime pda_cerdateto, string docNumber, string docRev, int profileID)
        {
            using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
            {
                object[,] paramarr = new object[8, 2]  {
                                                            {"@StationID", stationID},
                                                            {"@WorkcellID", workcellID},
                                                            {"@CourseID", courseID},
                                                            {"@CerDateFrom", pda_cerdatefrom},
                                                            {"@CerDateTo", pda_cerdateto},
                                                            {"@DocumentNumber", docNumber},
                                                            {"@Revision", docRev},
                                                            {"@CreatedBy", profileID}
                                                        };
                return _con.GetDataTableByStore("[CR_EmployeeDocument_SaveAll]", paramarr);
            }
        }

        public static DataTable DeleteDocumentMap(int[] trList, int profileID)
        {
            string xml = ConvertListToXml(trList);
            using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
            {
                object[,] paramarr = new object[11, 2]  {
                                                            {"@TRXml", xml},
                                                            {"@StationID", 0},
                                                            {"@WorkcellID", 0},
                                                            {"@CourseID", 0},
                                                            {"@CerDateFrom", new DateTime(0, DateTimeKind.Local) },
                                                            {"@CerDateTo", new DateTime(0, DateTimeKind.Local)},
                                                            {"@DocumentNumber", ""},
                                                            {"@Revision", ""},
                                                            {"@CreatedBy", profileID},
                                                            {"@Active", false},
                                                            {"@EmployeeDocID", 0}
                                                        };
                return _con.GetDataTableByStore("[CR_EmployeeDocument_Save]", paramarr);
            }
        }

        public static DataTable UpdateSingDocumentMap(int employeeDocID, string docNumber, string docRevision, int profileID)
        {
            using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
            {
                object[,] paramarr = new object[11, 2]  {
                                                            {"@TRXml", ""},
                                                            {"@StationID", 0},
                                                            {"@WorkcellID", 0},
                                                            {"@CourseID", 0},
                                                            {"@CerDateFrom", new DateTime(0, DateTimeKind.Local) },
                                                            {"@CerDateTo", new DateTime(0, DateTimeKind.Local)},
                                                            {"@DocumentNumber", docNumber},
                                                            {"@Revision", docRevision},
                                                            {"@CreatedBy", profileID},
                                                            {"@Active", true},
                                                            {"@EmployeeDocID", employeeDocID}
                                                        };
                return _con.GetDataTableByStore("[CR_EmployeeDocument_Save]", paramarr);
            }
        }

        public static DataTable SelectDocumentMap(int empDocID)
        {
            using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
            {
                object[,] paramarr = new object[1, 2] { { "@EmployeeDocID", empDocID } };
                return _con.GetDataTableByStore("CR_EmployeeDocument_Select", paramarr);
            }
        }

        public static DataTable SearchDocumentMap(int stationID, int workcellID, int courseID, int tgID, int cgID, string docNumber, string docRev)
        {
            using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
            {
                object[,] paramarr = new object[7, 2]  {
                                                            {"@StationID", stationID},
                                                            {"@WorkcellID", workcellID},
                                                            {"@CourseID", courseID},
                                                            {"@TrainingGroupID", tgID},
                                                            {"@CourseGroupID", cgID},
                                                            {"@DocumentNumber", docNumber},
                                                            {"@Revision", docRev}
                                                        };
                return _con.GetDataTableByStore("[CR_EmployeeDocument_Search]", paramarr);
            }
        }

        public static DataTable DeleteAllDocumentMap(int stationID, int workcellID, int courseID, int tgID, int cgID, string docNumber, string docRev, int updatedBy)
        {
            using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
            {
                object[,] paramarr = new object[8, 2]  {
                                                            {"@StationID", stationID},
                                                            {"@WorkcellID", workcellID},
                                                            {"@CourseID", courseID},
                                                            {"@TrainingGroupID", tgID},
                                                            {"@CourseGroupID", cgID},
                                                            {"@DocumentNumber", docNumber},
                                                            {"@Revision", docRev},
                                                            {"@UpdatedBy", updatedBy}
                                                        };
                return _con.GetDataTableByStore("[CR_EmployeeDocument_DeleteAll]", paramarr);
            }
        }

        public static DataTable rptTrainingRecord_OrientationRecord(string pstr_employeeid,
                                       string pstr_employeeidsap,
                                       string pstr_employeename,
                                       int pi_operatorgroupid,
                                       int pi_companyid,
                                       int pi_departmentid,
                                       string pstr_jobtitle,
                                       int pi_positionid,
                                       int pi_workcellid,
                                       string pstr_supervisor,
                                       int pi_isactive,
                                       int pi_traininggroupid,
                                       string pstr_traininggroupidlist,
                                       int pi_coursegroupid,
                                       string pstr_coursegroupidlist,
                                       string pstr_coursename,
                                       string pstr_coursenamelist,
                                       int pi_productid,
                                       DateTime pda_expdatefrom,
                                       DateTime pda_expdateto,
                                       DateTime pda_cerdatefrom,
                                       DateTime pda_cerdateto,
                                       DateTime pda_joineddatefrom,
                                       DateTime pda_joineddateto,
                                       int pi_workingstatusid,
                                       string pstr_workingstatusidlist,
                                       int pi_expectedtocompletebefore_days,
                                       int pi_outputtypeid,
                                       int pstr_trainingstatusid,
                                       int pi_isworking = -1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[30, 2]  {   {"@EmployeeID", pstr_employeeid},
                                                            {"@EmployeeIDSAP", pstr_employeeidsap},
                                                            {"@EmployeeName", pstr_employeename},
                                                            {"@OperatorGroupID", pi_operatorgroupid},
                                                            {"@CompanyID", pi_companyid},
                                                            {"@DepartmentID", pi_departmentid},
                                                            {"@JobTitle", pstr_jobtitle},
                                                            {"@PositionID", pi_positionid},
                                                            {"@WorkcellID", pi_workcellid},
                                                            {"@Supervisor", pstr_supervisor},
                                                            {"@IsActive", pi_isactive},
                                                            {"@TrainingGroupID", pi_traininggroupid},
                                                            {"@TrainingGroupIDList", pstr_traininggroupidlist},
                                                            {"@CourseGroupID", pi_coursegroupid},
                                                            {"@CourseGroupIDList", pstr_coursegroupidlist},
                                                            {"@CourseName", pstr_coursename},
                                                            {"@CourseNameList", pstr_coursenamelist},
                                                            {"@ProductID", pi_productid},
                                                            {"@ExpDateFrom", pda_expdatefrom},
                                                            {"@ExpDateTo", pda_expdateto},
                                                            {"@CerDateFrom", pda_cerdatefrom},
                                                            {"@CerDateTo", pda_cerdateto},
                                                            {"@JoinedDateFrom", pda_joineddatefrom},
                                                            {"@JoinedDateTo", pda_joineddateto},
                                                            {"@WorkingStatusID", pi_workingstatusid},
                                                            {"@WorkingStatusIDList", pstr_workingstatusidlist},
                                                            {"@IsWorking", pi_isworking},
                                                            {"@ExpectedToCompleteBefore_Days", pi_expectedtocompletebefore_days},
                                                            {"@OutputTypeID", pi_outputtypeid},
                                                            {"@TrainingStatusID", pstr_trainingstatusid}
                                                        };
                    return _con.GetDataTableByStore("rptTrainingRecord_OrientationRecord", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable rptTrainingRecord_AwarenessRecord(string pstr_employeeid,
                                       string pstr_employeeidsap,
                                       string pstr_employeename,
                                       int pi_operatorgroupid,
                                       int pi_companyid,
                                       int pi_departmentid,
                                       string pstr_jobtitle,
                                       int pi_positionid,
                                       int pi_workcellid,
                                       string pstr_supervisor,
                                       int pi_isactive,
                                       int pi_traininggroupid,
                                       int pi_coursegroupid,
                                       int pi_courseid,
                                       int pi_productid,
                                       DateTime pda_expdatefrom,
                                       DateTime pda_expdateto,
                                       DateTime pda_cerdatefrom,
                                       DateTime pda_cerdateto,
                                       DateTime pda_joineddatefrom,
                                       DateTime pda_joineddateto,
                                       int pi_workingstatusid,
                                       string pstr_workingstatusidlist,
                                       int pi_expectedtocompletebefore_days,
                                       int pi_outputtypeid,
                                       int pstr_trainingstatusid,
                                       int pi_isworking = -1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[27, 2]  {   {"@EmployeeID", pstr_employeeid},
                                                            {"@EmployeeIDSAP", pstr_employeeidsap},
                                                            {"@EmployeeName", pstr_employeename},
                                                            {"@OperatorGroupID", pi_operatorgroupid},
                                                            {"@CompanyID", pi_companyid},
                                                            {"@DepartmentID", pi_departmentid},
                                                            {"@JobTitle", pstr_jobtitle},
                                                            {"@PositionID", pi_positionid},
                                                            {"@WorkcellID", pi_workcellid},
                                                            {"@Supervisor", pstr_supervisor},
                                                            {"@IsActive", pi_isactive},
                                                            {"@TrainingGroupID", pi_traininggroupid},
                                                            {"@CourseGroupID", pi_coursegroupid},
                                                            {"@CourseID", pi_courseid},
                                                            {"@ProductID", pi_productid},
                                                            {"@ExpDateFrom", pda_expdatefrom},
                                                            {"@ExpDateTo", pda_expdateto},
                                                            {"@CerDateFrom", pda_cerdatefrom},
                                                            {"@CerDateTo", pda_cerdateto},
                                                            {"@JoinedDateFrom", pda_joineddatefrom},
                                                            {"@JoinedDateTo", pda_joineddateto},
                                                            {"@WorkingStatusID", pi_workingstatusid},
                                                            {"@WorkingStatusIDList", pstr_workingstatusidlist},
                                                            {"@IsWorking", pi_isworking},
                                                            {"@ExpectedToCompleteBefore_Days", pi_expectedtocompletebefore_days},
                                                            {"@OutputTypeID", pi_outputtypeid},
                                                            {"@TrainingStatusID", pstr_trainingstatusid}
                                                        };
                    return _con.GetDataTableByStore("rptTrainingRecord_AwarenessRecord", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #region Import

        private static DataTable GetDataFromExcelFile(string pstr_fromexcelfile)
        {
            DataTable dt = new DataTable();
            try
            {
                Excel2SQL e2s = new Excel2SQL();
                e2s.FromExcelFile = pstr_fromexcelfile;

                e2s.ExcelQuery = @"SELECT * FROM [Training Record$]";

                dt = e2s.readExcel2DataTable();

                if (dt.Rows.Count > 0)
                {
                    //using (InputDataValidation idv = new InputDataValidation())
                    //{
                    //    idv.TableName = this._TempTableName;
                    //    idv.DT = dt;
                    //    idv.ColumnNameMap = this._ColumnNameMap;
                    //    idv.ValidateData();
                    //}
                    return dt;
                }
                else
                {
                    throw new Exception("The import file contains records with blank or invalid data.");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Import data from template Excel to TrainingRecordTemp table
        ///  and fill value to key columns (IDs).
        /// </summary>
        /// <param name="pExcelFilePath"></param>
        /// <param name="pLastUpdatedBy"></param>
        public static void Preview(string pExcelFilePath, int pLastUpdatedBy)
        {
            try
            {
                // Remove old data in TrainingRecordTemp table
                using (SystemAuthDBAccess conn = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] {
                        { "@LastUpdatedBy", pLastUpdatedBy }
                    };

                    conn.ExecStore("TrainingRecordTemp_Verify_Before_Loading", paramarr);
                }

                // Get data from Excel
                DataTable dt = GetDataFromExcelFile(pExcelFilePath);

                var lastUpdatedByCol = new DataColumn
                {
                    ColumnName = "LastUpdatedBy",
                    DataType = typeof(int),
                    DefaultValue = pLastUpdatedBy
                };

                dt.Columns.Add(lastUpdatedByCol);
                dt.AcceptChanges();
                
                // Prepare to import data to SQL
                DataTable2SQL dt2s = new DataTable2SQL();
                dt2s.FromDataTable = dt;
                dt2s.SQLConnectionString = HRTRConfig.ConnectionString;
                dt2s.ToSQLTable = "TrainingRecordTemp";

                dt2s.ToSQLTableColumns.Add("Employee ID", "EmployeeID");
                dt2s.ToSQLTableColumns.Add("Family", "ProductName");    //dt2s.ToSQLTableColumns.Add("Product", "ProductName");
                dt2s.ToSQLTableColumns.Add("Trainer", "Trainer");
                dt2s.ToSQLTableColumns.Add("Training Group", "TrainingGroupName");
                dt2s.ToSQLTableColumns.Add("Course", "CourseName");
                dt2s.ToSQLTableColumns.Add("Course Group", "CourseGroupName");
                dt2s.ToSQLTableColumns.Add("Cert Date", "CertDate");
                dt2s.ToSQLTableColumns.Add("Expired Date", "ExpDate");
                dt2s.ToSQLTableColumns.Add("Score", "Score");
                dt2s.ToSQLTableColumns.Add("OJT", "OJT");
                dt2s.ToSQLTableColumns.Add("Active", "IsActive");
                dt2s.ToSQLTableColumns.Add("Comments", "Comments");
                dt2s.ToSQLTableColumns.Add("LastUpdatedBy", "LastUpdatedBy");

                // Import data to SQL
                if (dt2s.readDataTable2SQL())
                {
                    using (SystemAuthDBAccess conn = new SystemAuthDBAccess())
                    {
                        var paramarr = new object[1, 2] {
                            { "@LastUpdatedBy", pLastUpdatedBy }
                        };

                        conn.ExecStore("TrainingRecordTemp_Verify_After_Loading", paramarr);
                    }
                }

                dt = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        
        public static void runsql(string query)
        {

            string connectionstring = System.Configuration.ConfigurationManager.AppSettings["SqlServer"];
            using (System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection(connectionstring))
            {

                System.Data.SqlClient.SqlCommand command = new System.Data.SqlClient.SqlCommand(query, connection);
                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        public static DataTable SearchTemp(int pLastupdatedby)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] {
                        { "@LastUpdatedBy", pLastupdatedby }
                    };

                    return _con.GetDataTableByStore("TrainingRecordTemp_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static int Import(int pi_lastupdatedby)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] {
                        { "@LastUpdatedBy", pi_lastupdatedby }
                    };

                    return Convert.ToInt32(_con.ExecStoreRObject("TrainingRecord_Import", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion Import

        #endregion Methods
    }
}
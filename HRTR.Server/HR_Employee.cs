namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("HR_Employee")]
    public class HR_Employee : OBase
    {
        #region Fields
        private int _EmployeeID_ID;
        private string _EmployeeID;
        private string _EmployeeIDSAP;
        private string _UserName;
        private string _EmployeeName;
        private int _OperatorGroupID;
        private int _CompanyID;
        private int _DepartmentID;
        private string _JobTitle;
        private int _PositionID;
        //private int _ShiftID;
        private int _WorkcellID;
        private string _Supervisor;
        private bool _IsActive;
        private bool _IsSupervisor;
        private System.DateTime _JoinedDate;
        private int _WorkingStatusID;
        #endregion

        #region Constructors
        public HR_Employee()
        {
            this._EmployeeID = "";
            this._EmployeeIDSAP = "";
            this._EmployeeName = "";
            this._JobTitle = "";
            this._Supervisor = "";
        }
        #endregion

        #region Properties
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
        public string EmployeeID
        {
            get
            {
                return this._EmployeeID;
            }
            set
            {
                this._EmployeeID = value;
            }
        }
        public string EmployeeIDSAP
        {
            get
            {
                return this._EmployeeIDSAP;
            }
            set
            {
                this._EmployeeIDSAP = value;
            }
        }
        public string UserName
        {
            get
            {
                return this._UserName;
            }
            set
            {
                this._UserName = value;
            }
        }
        public string EmployeeName
        {
            get
            {
                return this._EmployeeName;
            }
            set
            {
                this._EmployeeName = value;
            }
        }
        public int OperatorGroupID
        {
            get
            {
                return this._OperatorGroupID;
            }
            set
            {
                this._OperatorGroupID = value;
            }
        }
        public int CompanyID
        {
            get
            {
                return this._CompanyID;
            }
            set
            {
                this._CompanyID = value;
            }
        }
        public int DepartmentID
        {
            get
            {
                return this._DepartmentID;
            }
            set
            {
                this._DepartmentID = value;
            }
        }
        public string JobTitle
        {
            get
            {
                return this._JobTitle;
            }
            set
            {
                this._JobTitle = value;
            }
        }
        public int PositionID
        {
            get
            {
                return this._PositionID;
            }
            set
            {
                this._PositionID = value;
            }
        }
        //public int ShiftID
        //{
        //    get
        //    {
        //        return this._ShiftID;
        //    }
        //    set
        //    {
        //        this._ShiftID = value;
        //    }
        //}
        public int WorkcellID
        {
            get
            {
                return this._WorkcellID;
            }
            set
            {
                this._WorkcellID = value;
            }
        }
        public string Supervisor
        {
            get
            {
                return this._Supervisor;
            }
            set
            {
                this._Supervisor = value;
            }
        }
        public DateTime JoinedDate
        {
            get
            {
                return this._JoinedDate;
            }
            set
            {
                this._JoinedDate = value;
            }
        }
        public bool IsActive
        {
            get
            {
                return this._IsActive;
            }
            set
            {
                this._IsActive = value;
            }
        }
        public bool IsSupervisor
        {
            get
            {
                return this._IsSupervisor;
            }
            set
            {
                this._IsSupervisor = value;
            }
        }
        public int WorkingStatusID
        {
            get
            {
                return this._WorkingStatusID;
            }
            set
            {
                this._WorkingStatusID = value;
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
                    object[,] paramarr = new object[17, 2]  {   {"@EmployeeID_ID", this._EmployeeID_ID},
                                                            {"@EmployeeID", this._EmployeeID},
                                                            {"@EmployeeIDSAP", this._EmployeeIDSAP},
                                                            {"@UserName", this._UserName},
                                                            {"@EmployeeName", this._EmployeeName},
                                                            {"@OperatorGroupID", this._OperatorGroupID},
                                                            {"@CompanyID", this._CompanyID},
                                                            {"@DepartmentID", this._DepartmentID},
                                                            {"@JobTitle", this._JobTitle},
                                                            {"@PositionID", this._PositionID},
                                                            //{"@ShiftID", this._ShiftID},
                                                            {"@WorkcellID", this._WorkcellID},
                                                            {"@Supervisor", this._Supervisor},
                                                            {"@JoinedDate", this._JoinedDate},
                                                            {"@IsActive", this._IsActive},
                                                            {"@IsSupervisor", this._IsSupervisor},
                                                            {"@WorkingStatusID", this._WorkingStatusID},
                                                            {"@LastUpdatedBy", this.LastUpdatedBy }
                                                        };
                    DataTable dt = _con.ExecStoreRDataTable("HR_Employee_Save", paramarr);
                    //DataRow dr = dt.Rows[0];
                    this.Fill(dt.Rows[0]);
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
                    object[,] paramarr = new object[2, 2]   {    { "@EmployeeID_ID", this._EmployeeID_ID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
                                                        };
                    return Convert.ToInt32(_con.ExecStoreRObject("HR_Employee_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@EmployeeID_ID", this._EmployeeID_ID } };
                    DataTable dt = _con.GetDataTableByStore("HR_Employee_Select", paramarr);
                    //DataRow dr = dt.Rows[0];
                    this.Fill(dt.Rows[0]);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void SelectByEmployeeID()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@EmployeeID", this._EmployeeID } };
                    DataTable dt = _con.GetDataTableByStore("HR_Employee_Select_By_EmployeeID", paramarr);
                    //DataRow dr = dt.Rows[0];
                    this.Fill(dt.Rows[0]);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void SelectByUserName()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@UserName", this._UserName } };
                    DataTable dt = _con.GetDataTableByStore("HR_Employee_Select_By_UserName", paramarr);
                    if (dt.Rows.Count == 0)
                    {
                        throw new Exception("User Name [" + this._UserName + "] has not been setup in Employee profile.");
                    }
                    //DataRow dr = dt.Rows[0];
                    this.Fill(dt.Rows[0]);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataTable TrainingRecordByEmployeeID_ID( string strTrainingGroup, string strCourseGroup, string strCourse, int p_isactive_course = 1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[5, 2]   { {"@EmployeeID_ID", this._EmployeeID_ID},
                                                              {"@IsActive_Course", p_isactive_course},
                                                              {"@TrainingGroup", strTrainingGroup},
                                                              {"@CourseGroup", strCourseGroup},
                                                              {"@Course", strCourse}
                    };
                    return _con.GetDataTableByStore("TrainingRecord_Select_By_EmployeeID_ID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataTable TrainingRecordByCourseGroup(int pi_traininggroupid, int pi_coursegroupid, int pi_productid)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2]   {   {"@EmployeeID_ID", this._EmployeeID_ID},
                                                            {"@TraningGroupID",pi_traininggroupid},
                                                            {"@CourseGroupID",pi_coursegroupid},
                                                            {"@ProductID", pi_productid}
                                                        };
                    return _con.GetDataTableByStore("TrainingRecord_Select_By_ETCID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable SearchForGrapeChart()
        {
            return Search();
        }
        public static DataTable Search(string pstr_employeeid = "",
                                        string pstr_employeeidsap = "",
                                        string pstr_username = "",
                                        string pstr_employeename = "",
                                        int pi_operatorgroupid = 0,
                                        int pi_companyid = 0,
                                        int pi_departmentid = 0,
                                        string pstr_jobtitle = "",
                                        int pi_positionid = 0,
                                        int pi_workcellid = 0,
                                        string pstr_supervisor = "",
                                        int pi_isactive = 1,
                                        int pi_issupervisor = -1,
                                        DateTime? pda_joineddate = null,
                                        int pi_workingstatusid = 0,
                                        int pi_isworking = -1,
                                        string pstr_wdno = ""
                                        )
        {

            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[17, 2]  {   {"@EmployeeID", pstr_employeeid},
                                                            {"@EmployeeIDSAP", pstr_employeeidsap},
                                                            {"@UserName", pstr_username},
                                                            {"@EmployeeName", pstr_employeename},
                                                            {"@OperatorGroupID", pi_operatorgroupid},
                                                            {"@CompanyID", pi_companyid},
                                                            {"@DepartmentID", pi_departmentid},
                                                            {"@JobTitle", pstr_jobtitle},
                                                            {"@PositionID", pi_positionid},
                                                            {"@WorkcellID", pi_workcellid},
                                                            {"@Supervisor", pstr_supervisor},
                                                            {"@IsActive", pi_isactive},
                                                            {"@IsSupervisor", pi_issupervisor},
                                                            {"@JoinedDate", pda_joineddate},
                                                            {"@WorkingStatusID", pi_workingstatusid},
                                                            {"@IsWorking", pi_isworking},
                                                            {"@WDNo", pstr_wdno}
                                                        };
                    return _con.GetDataTableByStore("HR_Employee_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void PreviewEmployee(string pstr_fromexcelfile, int pi_lastupdatedby)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_lastupdatedby } };
                    _con.ExecStore("HR_Employee_Verify_Before_Loading", paramarr);
                }
                Excel2SQL e2s = new Excel2SQL();
                e2s.SQLConnectionString = HRTRConfig.ConnectionString;

                e2s.FromExcelFile = pstr_fromexcelfile;
                e2s.ExcelQuery = @"SELECT [EmployeeID],[UserName],[Full Name]
                                ,[Joined Date],[Operator Group],[Company]
                                ,[Department],[Job Title],[Position],[Shift],[Workcell]
                                ,[Line Leader],[Working Status], " + pi_lastupdatedby.ToString() + @" AS [LastUpdatedBy] FROM [Employee$]";
                e2s.ToSQLTable = "HR_EmployeeTemp";
                e2s.ToSQLTableColumns.Add("[EmployeeID]", "EmployeeID");
                e2s.ToSQLTableColumns.Add("[UserName]", "UserName");
                e2s.ToSQLTableColumns.Add("[Full Name]", "EmployeeName");
                e2s.ToSQLTableColumns.Add("[Joined Date]", "JoinedDate");
                e2s.ToSQLTableColumns.Add("[Operator Group]", "OperatorGroupName");
                e2s.ToSQLTableColumns.Add("[Company]", "CompanyName");
                e2s.ToSQLTableColumns.Add("[Department]", "DepartmentName");
                e2s.ToSQLTableColumns.Add("[Job Title]", "JobTitle");
                e2s.ToSQLTableColumns.Add("[Position]", "PositionName");
                e2s.ToSQLTableColumns.Add("[Shift]", "ShiftName");
                e2s.ToSQLTableColumns.Add("[Workcell]", "WorkcellName");
                e2s.ToSQLTableColumns.Add("[Line Leader]", "Supervisor");
                e2s.ToSQLTableColumns.Add("[Working Status]", "IsActive");
                e2s.ToSQLTableColumns.Add("[LastUpdatedBy]", "LastUpdatedBy");

                if (e2s.readExcel2SQL())
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_lastupdatedby } };
                        _con.ExecStore("HR_Employee_Verify_After_Loading", paramarr);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable SearchTemp(int pi_lastupdatedby)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_lastupdatedby } };
                    return _con.GetDataTableByStore("HR_EmployeeTemp_Search", paramarr);
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
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_lastupdatedby } };
                    return Convert.ToInt32(_con.ExecStoreRObject("HR_Employee_Import", paramarr));
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        public static bool TrainingRecord_EmployeeID_Verify(int pi_trainingGroupId, int pi_courseGroupId, int pi_courseId, int pi_employeeId)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2] { 
                        { "@EmployeeID_ID", pi_employeeId },
                        { "@TrainingGroupId", pi_trainingGroupId },
                        { "@CourseGroupId", pi_courseGroupId },
                        { "@CourseId", pi_courseId }
                     };
                    DataTable dt = _con.ExecStoreRDataTable("TrainingRecord_EmployeeID_Verify", paramarr);
                    if (dt != null && dt.Rows.Count > 0)
                        return true;
                    else
                        return false;   
                }
            }
            catch (Exception ex)
            {
                return false;
                
            }
        }

    }
}


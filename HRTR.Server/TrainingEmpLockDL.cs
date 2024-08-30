namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("TrainingEmpLockDL")]
    public class TrainingEmpLockDL : OBase
    {
        private int _LockID;
        private string _EmployeeID;
        private string _EmployeeIDSAP;
        private string _UserName;
        private string _EmployeeName;
        private string _TrainingCodeID;
        private string _Description;
        private System.DateTime _DueDate;
        private int _ExtendDay;
        private System.DateTime _ExtendFromDate;
        private System.DateTime _CompleteDate;
        private bool _IsActive;
        private int _IsDL;

        public TrainingEmpLockDL()
        {
            this._EmployeeID = "";
            this._EmployeeName = "";
            this._EmployeeIDSAP = "";
        }

        public int LockID
        {
            get
            {
                return this._LockID;
            }
            set
            {
                this._LockID = value;
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
        public string TrainingCodeID
        {
            get
            {
                return this._TrainingCodeID;
            }
            set
            {
                this._TrainingCodeID = value;
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
        public DateTime DueDate
        {
            get
            {
                return this._DueDate;
            }
            set
            {
                this._DueDate = value;
            }
        }
        public int ExtendDay
        {
            get
            {
                return this._ExtendDay;
            }
            set
            {
                this._ExtendDay = value;
            }
        }
        public DateTime ExtendFromDate
        {
            get
            {
                return this._ExtendFromDate;
            }
            set
            {
                this._ExtendFromDate = value;
            }
        }
        public DateTime CompleteDate
        {
            get
            {
                return this._CompleteDate;
            }
            set
            {
                this._CompleteDate = value;
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

        public int IsDL
        {
            get
            {
                return this._IsDL;
            }
            set
            {
                this._IsDL = value;
            }
        }

        public void Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[14, 2]	{	{"@LockID", this._LockID},
                                                            {"@EmployeeID", this._EmployeeID},
                                                            {"@EmployeeIDSAP", this._EmployeeIDSAP},
                                                            {"@UserName", this._UserName},
                                                            {"@EmployeeName", this._EmployeeName},
                                                            {"@TrainingCodeID", this._TrainingCodeID},
                                                            {"@Description", this._Description},
                                                            {"@DueDate", this._DueDate},
                                                            {"@ExtendDay", this._ExtendDay},
                                                            {"@ExtendFromDate", this.ExtendFromDate},
                                                            {"@CompleteDate", this._CompleteDate},
                                                            {"@IsActive", this._IsActive},
                                                            {"@LastUpdatedBy", this._LastUpdatedBy},
                                                            {"@IsDL", this._IsDL},
                                                        };
                    _con.ExecStore("AL_TrainingEmpLock_Save", paramarr);
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
                    object[,] paramarr = new object[1, 2]	{	 { "@LockID", this._LockID }                                                        
                                                        };
                    return Convert.ToInt32(_con.ExecStoreRObject("AL_TrainingEmpLock_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@LockID", this._LockID } };
                    DataTable dt = _con.GetDataTableByStore("AL_TrainingEmpLock_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable Search(string employeeId,
                                        string employeeIdsap,
                                        string userName,
                                        string employeeName,
                                        string trainingCodeId,
                                        DateTime dueDate,
                                        int extendDay,
                                        DateTime completeDate,
                                        int isActive,
                                        int isDL
                                        )
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[10, 2]	{	{"@EmployeeID", employeeId},
                                                            {"@EmployeeIDSAP", employeeIdsap},
                                                            {"@UserName", userName},
                                                            {"@EmployeeName", employeeName},
                                                            {"@TrainingCodeID", trainingCodeId},
                                                            {"@DueDate", dueDate},
                                                            {"@ExtendDay", extendDay},
                                                            {"@CompleteDate", completeDate},
                                                            {"@IsActive", isActive},   
                                                            {"@IsDL", isDL}, 
														};
                    return _con.GetDataTableByStore("AL_TrainingEmpLock_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void PreviewTrainingEmpLock(string pstr_fromexcelfile, int pi_lastupdatedby)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_lastupdatedby } };
                    _con.ExecStore("AL_TrainingEmpLockTemp_Delete", paramarr);
                }
                Excel2SQL e2s = new Excel2SQL();
                e2s.SQLConnectionString = HRTRConfig.ConnectionString;

                e2s.FromExcelFile = pstr_fromexcelfile;
                e2s.ExcelQuery = @"Select [EmployeeID]
                                    ,[EmployeeIDSAP]
                                    ,LTRIM(RTRIM([UserName])) AS [UserName]
                                    ,[EmployeeName]
                                    ,LTRIM(RTRIM([TrainingCodeID])) AS [TrainingCodeID]
                                    ,[Description]
                                    ,LTRIM(RTRIM([DueDate])) AS [DueDate]
                                    ,LTRIM(RTRIM([ExtendDay])) AS [ExtendDay]
                                    ,LTRIM(RTRIM([ExtendFromDate])) AS [ExtendFromDate]
                                    ,LTRIM(RTRIM([CompleteDate])) AS [CompleteDate]
                                    ,'" + DateTime.Now + @"' AS [LastUpdated]
                                    ," + pi_lastupdatedby.ToString() + @" AS [LastUpdatedBy]
                                    ," + 1 + @" AS [IsDL]
                                FROM [TrainingEmpLock$] ORDER BY [UserName], [TrainingCodeID]";
                e2s.ToSQLTable = "AL_TrainingAutoLockTemp";
                e2s.ToSQLTableColumns.Add("EmployeeID", "EmployeeID");
                e2s.ToSQLTableColumns.Add("EmployeeIDSAP", "EmployeeIDSAP");
                e2s.ToSQLTableColumns.Add("UserName", "UserName");
                e2s.ToSQLTableColumns.Add("EmployeeName", "EmployeeName");
                e2s.ToSQLTableColumns.Add("TrainingCodeID", "TrainingCodeID");
                e2s.ToSQLTableColumns.Add("Description", "Description");
                e2s.ToSQLTableColumns.Add("DueDate", "DueDate");
                e2s.ToSQLTableColumns.Add("ExtendDay", "ExtendDay");
                e2s.ToSQLTableColumns.Add("ExtendFromDate", "ExtendFromDate");
                e2s.ToSQLTableColumns.Add("CompleteDate", "CompleteDate");
                e2s.ToSQLTableColumns.Add("LastUpdated", "LastUpdated");
                e2s.ToSQLTableColumns.Add("LastUpdatedBy", "LastUpdatedBy");
                e2s.ToSQLTableColumns.Add("IsDL", "IsDL");
                if (e2s.readExcel2SQL())
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_lastupdatedby } };
                        _con.ExecStore("AL_TrainingEmpLockTemp_ImportValidate", paramarr);
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
                    return _con.GetDataTableByStore("AL_TrainingEmpLockTemp_Search", paramarr);
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
                    return Convert.ToInt32(_con.ExecStoreRObject("AL_TrainingEmpLock_Import", paramarr));
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}


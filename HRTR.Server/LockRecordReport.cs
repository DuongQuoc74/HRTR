namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("LockRecordReport")]
    public class LockRecordReport : OBase
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

        public LockRecordReport()
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

        public void Select()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@LockID", this._LockID } };
                    DataTable dt = _con.GetDataTableByStore("AL_TrainingEmpLock_Select", paramarr);
                    //DataRow dr = dt.Rows[0];
                    this.Fill(dt.Rows[0]);
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
                                        int isDL,
                                        int isComplete
                                        )
        {
            try
            {
                try
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        object[,] paramarr = new object[11, 2]	{	{"@EmployeeID", employeeId},
                                                            {"@EmployeeIDSAP", employeeIdsap},
                                                            {"@UserName", userName},
                                                            {"@EmployeeName", employeeName},
                                                            {"@TrainingCodeID", trainingCodeId},
                                                            {"@DueDate", dueDate},
                                                            {"@ExtendDay", extendDay},
                                                            {"@CompleteDate", completeDate},
                                                            {"@IsActive", isActive}, 
                                                            {"@IsDL", isDL},
                                                            {"@IsComplete", isComplete},
														};
                        return _con.GetDataTableByStore("AL_LockRecodReport_Search", paramarr);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }       
    }
}


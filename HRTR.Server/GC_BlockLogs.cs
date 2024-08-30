namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    ////

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("GC_BlockLogs")]
    public class GC_BlockLogs : OBase
    {
        #region Fields
        private int _GC_BlockLogsID;
        private int _Customer_ID;
        private int _EmployeeID_ID;
        private System.DateTime _CreatedDate;
        private System.DateTime _StartDate;
        private System.DateTime _EndDate;
        private int _TotalRedGrapes;
        private bool _IsBlocked;
        private bool _IsConfirmed;
        private string _Comments;
        #endregion

        #region Constructors
        public GC_BlockLogs()
        {
            this._Comments = "";
        }
        #endregion

        #region Properties
        public int GC_BlockLogsID
        {
            get
            {
                return this._GC_BlockLogsID;
            }
            set
            {
                this._GC_BlockLogsID = value;
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
        public System.DateTime CreatedDate
        {
            get
            {
                return this._CreatedDate;
            }
            set
            {
                this._CreatedDate = value;
            }
        }
        public System.DateTime StartDate
        {
            get
            {
                return this._StartDate;
            }
            set
            {
                this._StartDate = value;
            }
        }
        public System.DateTime EndDate
        {
            get
            {
                return this._EndDate;
            }
            set
            {
                this._EndDate = value;
            }
        }
        public int TotalRedGrapes
        {
            get
            {
                return this._TotalRedGrapes;
            }
            set
            {
                this._TotalRedGrapes = value;
            }
        }
        public bool IsBlocked
        {
            get
            {
                return this._IsBlocked;
            }
            set
            {
                this._IsBlocked = value;
            }
        }

        public bool IsConfirmed
        {
            get
            {
                return this._IsConfirmed;
            }
            set
            {
                this._IsConfirmed = value;
            }
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
        #endregion

        #region Methods
        public bool Confirm()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[3, 2]	{	{"@GC_BlockLogsID", this._GC_BlockLogsID},
                                                            {"@Comments", this._Comments},
                                                            {"@LastUpdatedBy", this.LastUpdatedBy}
														};
                    DataTable dt = _con.ExecStoreRDataTable("GC_BlockLogs_Confirm", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
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
                    object[,] paramarr = new object[2, 2]	{	{ "@GC_BlockLogsID", this._GC_BlockLogsID } ,
                                                        { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("GC_BlockLogs_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@GC_BlockLogsID", this._GC_BlockLogsID } };
                    DataTable dt = _con.GetDataTableByStore("GC_BlockLogs_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search(DateTime pda_createddatefrom,
                                        DateTime pda_createddateto,
                                        int pi_customer_id,
                                        string pstr_employeeid,
                                        int pi_isblocked,
                                        int pi_isconfirmed,
                                        int pi_isactive
                                       )
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[7, 2]	{	
                                                            {"@CreatedDateFrom", pda_createddatefrom},
                                                            {"@CreatedDateTo", pda_createddateto},
                                                            {"@Customer_ID", pi_customer_id},
                                                            {"@EmployeeID", pstr_employeeid},
                                                            {"@IsBlocked", pi_isblocked},
                                                            {"@IsConfirmed", pi_isconfirmed},
                                                            {"@IsActive", pi_isactive}
                                                        };
                    return _con.GetDataTableByStore("GC_BlockLogs_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion
    }
}


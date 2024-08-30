namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    ////

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("TR_BlockLogs")]
    public class TR_BlockLogs : OBase
    {
        #region Fields
        private int _TR_BlockLogsID;
        private int _EmployeeID_ID;
        private int _CourseID;
        private System.DateTime _LastLogonDate;
        private bool _IsConfirmed;
        private string _Comments;
        #endregion

        #region Constructors
        public TR_BlockLogs()
        {
            this._Comments = "";
        }
        #endregion

        #region Properties
        public int TR_BlockLogsID
        {
            get
            {
                return this._TR_BlockLogsID;
            }
            set
            {
                this._TR_BlockLogsID = value;
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
        public System.DateTime LastLogonDate
        {
            get
            {
                return this._LastLogonDate;
            }
            set
            {
                this._LastLogonDate = value;
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
                    object[,] paramarr = new object[3, 2]	{	{"@TR_BlockLogsID", this._TR_BlockLogsID},
                                                            {"@Comments", this._Comments},
                                                            {"@LastUpdatedBy", this.LastUpdatedBy}
														};
                    DataTable dt = _con.ExecStoreRDataTable("TR_BlockLogs_Confirm", paramarr);
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
                    object[,] paramarr = new object[2, 2]	{	{ "@TR_BlockLogsID", this._TR_BlockLogsID } ,
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
                    object[,] paramarr = new object[1, 2] { { "@TR_BlockLogsID", this._TR_BlockLogsID } };
                    DataTable dt = _con.GetDataTableByStore("TR_BlockLogs_Select", paramarr);
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
                                        string pstr_employeeid,
                                        int pi_isconfirmed
                                       )
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2]	{	
                                                            {"@CreatedDateFrom", pda_createddatefrom},
                                                            {"@CreatedDateTo", pda_createddateto},
                                                            {"@EmployeeID", pstr_employeeid},                                                  
                                                            {"@IsConfirmed", pi_isconfirmed}
														};
                    return _con.GetDataTableByStore("TR_BlockLogs_Search", paramarr);
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


namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    ////

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CCS_AuthenticationLog")]
    public class CCS_AuthenticationLog : OBase
    {

        #region Fields
        private int _CCS_AuthenticationLogID;
        #endregion

        #region Constructors
        public CCS_AuthenticationLog()
        {

        }
        #endregion

        #region Properties
        public int CCS_AuthenticationLogID
        {
            get
            {
                return this._CCS_AuthenticationLogID;
            }
            set
            {
                this._CCS_AuthenticationLogID = value;
            }
        }
        #endregion

        #region Methods
        public static DataTable Search(DateTime pda_logintimefrom,
                                        DateTime pda_logintimeto,
                                        string pstr_username,
                                        string pstr_employeeid
                                       )
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2]	{	
                                                            {"@LoginTimeFrom", pda_logintimefrom},
                                                            {"@LoginTimeTo", pda_logintimeto},
                                                            {"@UserName", pstr_username},
                                                            {"@EmployeeID", pstr_employeeid}
														};
                    return _con.GetDataTableByStore("CCS_AuthenticationLog_Search", paramarr);
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


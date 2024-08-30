namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_CertifiedLevel")]
    public class CR_CertifiedLevel : OBase
    {
        private int _CertifiedLevelID;
        private string _CertifiedLevelName;
        public CR_CertifiedLevel()
        {
            this._CertifiedLevelName = "";
        }
        public int CertifiedLevelID
        {
            get
            {
                return this._CertifiedLevelID;
            }
            set
            {
                this._CertifiedLevelID = value;
            }
        }
        public string CertifiedLevelName
        {
            get
            {
                return this._CertifiedLevelName;
            }
            set
            {
                this._CertifiedLevelName = value;
            }
        }

        public void Select()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@CertifiedLevelID", this._CertifiedLevelID } };
                    DataTable dt = _con.GetDataTableByStore("CR_CertifiedLevel_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    return _con.ExecStoreRDataTable("CR_CertifiedLevel_Search");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}


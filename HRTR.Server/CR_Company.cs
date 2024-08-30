namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_Company")]
    public class CR_Company : OBase
    {
        private int _CompanyID;
        private string _CompanyName;
        public CR_Company()
        {
            this._CompanyName = "";
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
        public string CompanyName
        {
            get
            {
                return this._CompanyName;
            }
            set
            {
                this._CompanyName = value;
            }
        }

        //public bool Save()
        //{
        //    try
        //    {
        //        ConnectionDatabase condb = new ConnectionDatabase();
        //        object[,] paramarr = new object[2, 2]	{	{ "@CompanyID", this._CompanyID },
        //                                                    { "@CompanyName", this._CompanyName}
        //                                                };
        //        DataTable dt = condb.execStoreRDT("Company_Save", paramarr);
        //        DataRow dr = dt.Rows[0];
        //        this.Fill(dr);
        //        return true;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        //public int Delete()
        //{
        //    try
        //    {
        //        ConnectionDatabase condb = new ConnectionDatabase();
        //        object[,] paramarr = new object[1, 2] { { "@CompanyID", this._CompanyID } };
        //        return condb.execStoreRI("Company_Delete", paramarr);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        public void Select()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@CompanyID", this._CompanyID } };
                    DataTable dt = _con.GetDataTableByStore("CR_Company_Select", paramarr);
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
                    return _con.ExecStoreRDataTable("CR_Company_Search");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}


namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;


    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("GC_Customers")]
    public class GC_Customers : OBase
    {
        private int _Customer_ID;
        private string _Customer;
        private int _MESCustomer_ID;
        public GC_Customers()
        {
            this._Customer = "";
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
        public string Customer
        {
            get
            {
                return this._Customer;
            }
            set
            {
                this._Customer = value;
            }
        }
        public int MESCustomer_ID
        {
            get
            {
                return this._MESCustomer_ID;
            }
            set
            {
                this._MESCustomer_ID = value;
            }
        }
        public bool Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2]   {{ "@Customer_ID", this._Customer_ID },
                                                            { "@MESCustomer_ID", this._MESCustomer_ID},
                                                            { "@Customer", this._Customer},
                                                            { "@LastUpdatedBy", this.LastUpdatedBy }
                                                        };
                    DataTable dt = _con.ExecStoreRDataTable("GC_Customers_Save", paramarr);
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
                    object[,] paramarr = new object[2, 2]   {    { "@Customer_ID", this._Customer_ID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
                                                        };
                    return Convert.ToInt32(_con.ExecStoreRObject("GC_Customers_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@Customer_ID", this._Customer_ID } };
                    DataTable dt = _con.GetDataTableByStore("GC_Customers_Select", paramarr);
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
                try
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        return _con.GetDataTableByStore("GC_Customers_Search");
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

        public static DataTable SearchByUserProfileId(int userProfileId)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@UserProfileID", userProfileId } };
                    return _con.GetDataTableByStore("GC_Customers_Search_By_ProfileId", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}


namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_Customers")]
    public class CR_Customers : OBase
    {
        private int _Customer_ID;
        private string _Customer;
        private int _MESCustomer_ID;
        private bool _IsActive;

        public CR_Customers()
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
        public void Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[5, 2]	{	{ "@Customer_ID", this._Customer_ID },
                                                            { "@Customer", this._Customer },
                                                            { "@MESCustomer_ID", this._MESCustomer_ID },
															{ "@IsActive", this._IsActive},
                                                            { "@LastUpdatedBy", this._LastUpdatedBy}
														};
                    DataTable dt = _con.ExecStoreRDataTable("CR_Customers_Save", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
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
                    object[,] paramarr = new object[2, 2] { { "@Customer_ID", this._Customer_ID },
                                                        { "@LastUpdatedBy", this._LastUpdatedBy }};
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_Customers_Delete", paramarr));
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
                    object[,] paramarr = new object[2, 2] { { "@Customer_ID", this._Customer_ID },
                                                        { "@MESCustomer_ID", this._MESCustomer_ID }};
                    DataTable dt = _con.GetDataTableByStore("CR_Customers_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search(string p_customer = "",
                                        int p_isactive = 1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                     object[,] paramarr = new object[2, 2]	{	
                                                            { "@Customer", p_customer },
															{ "@IsActive", p_isactive}
														};
                    return _con.GetDataTableByStore("CR_Customers_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}


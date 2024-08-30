namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SC_UserProfileCustomers")]
    public class SC_UserProfileCustomers : OBase
    {
        private int _UserProfileID;
        private int _Customer_ID;

        public SC_UserProfileCustomers()
        {
            
        }
        public int UserProfileID
        {
            get
            {
                return this._UserProfileID;
            }
            set
            {
                this._UserProfileID = value;
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

        public void Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[3, 2]	{	{ "@UserProfileID", this._UserProfileID },
															{ "@Customer_ID", this._Customer_ID},
                                                            { "@LastUpdatedBy", this._LastUpdatedBy}
														};
                    _con.ExecStoreRDataTable("SC_UserProfileCustomers_Save", paramarr);
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
                    object[,] paramarr = new object[3, 2]	{	{ "@UserProfileID", this._UserProfileID },
															{ "@Customer_ID", this._Customer_ID},
                                                            { "@LastUpdatedBy", this._LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("SC_UserProfileCustomers_Delete", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}


namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_Product")]
    public class CR_Product : OBase
    {
        private int _ProductID;
        private string _ProductName;
        private int _TrainingGroupID;
        
        public CR_Product()
        {
            this._ProductName = "";
        }
        public int ProductID
        {
            get
            {
                return this._ProductID;
            }
            set
            {
                this._ProductID = value;
            }
        }
        public string ProductName
        {
            get
            {
                return this._ProductName;
            }
            set
            {
                this._ProductName = value;
            }
        }
        public int TrainingGroupID
        {
            get
            {
                return this._TrainingGroupID;
            }
            set
            {
                this._TrainingGroupID = value;
            }
        }

        public bool Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2]	{	{ "@ProductID", this._ProductID },
															{ "@ProductName", this._ProductName},
                                                            { "@TrainingGroupID", this._TrainingGroupID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy }
														};
                    DataTable dt = _con.ExecStoreRDataTable("CR_Product_Save", paramarr);
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
                    object[,] paramarr = new object[2, 2]	{	 { "@ProductID", this._ProductID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_Product_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@ProductID", this._ProductID } };
                    DataTable dt = _con.GetDataTableByStore("CR_Product_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search(string pstr_productname = "",
                                       int pi_traininggroupid = 0,
                                       string pstr_traininggroupidlist = "")
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[3, 2]	{	
                                                            { "@ProductName", pstr_productname},
                                                            { "@TrainingGroupID", pi_traininggroupid },
                                                            { "@TrainingGroupIDList", pstr_traininggroupidlist }
                                                        };
                    return _con.GetDataTableByStore("CR_Product_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
    }
}


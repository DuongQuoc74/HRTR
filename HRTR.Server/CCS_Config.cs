namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CCS_Config")]
    public class CCS_Config : OBase
    {
        private int _ConfigID;
        private string _ConfigName;
        private string _ConfigValue;
        private string _Comments;
        public CCS_Config()
        {
            this._ConfigName = "";
        }
        public int ConfigID
        {
            get
            {
                return this._ConfigID;
            }
            set
            {
                this._ConfigID = value;
            }
        }
        public string ConfigName
        {
            get
            {
                return this._ConfigName;
            }
            set
            {
                this._ConfigName = value;
            }
        }
        public string ConfigValue
        {
            get
            {
                return this._ConfigValue;
            }
            set
            {
                this._ConfigValue = value;
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
        public void Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2]	{	 { "@ConfigName", this._ConfigName },
                                                            { "@ConfigValue", this._ConfigValue },
                                                            { "@Comments", this._Comments },
                                                            { "@LastUpdatedBy", this._LastUpdatedBy}
														};
                    DataTable dt = _con.ExecStoreRDataTable("CCS_Config_Save", paramarr);
                    this.Fill(dt.Rows[0]);
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
                    object[,] paramarr = new object[2, 2] { { "@ConfigID", this._ConfigID },
                                                        { "@LastUpdatedBy", this._LastUpdatedBy }};
                    return Convert.ToInt32(_con.ExecStoreRObject("CCS_Config_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@ConfigName", this._ConfigName }};
                    DataTable dt = _con.GetDataTableByStore("CCS_Config_Select_1", paramarr);
                    this.Fill(dt.Rows[0]);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}


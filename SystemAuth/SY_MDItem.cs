namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SY_MDItem")]
    public class SY_MDItem : OBase
    {
        private int _MDItemID;
        private int _MDTypeID;
        private string _MDItemCode;
        private string _Description;
        private bool _IsActive;

        public SY_MDItem()
        {
            this._MDItemCode = "";
            this._Description = "";
            //this._UserName = Environment.UserName;
        }
        public SY_MDItem(int i_mditemid)
        {
            this._MDItemID = i_mditemid;
            this._MDItemCode = "";
            this._Description = "";
        }
        public int MDItemID
        {
            get
            {
                return this._MDItemID;
            }
            set
            {
                this._MDItemID = value;
            }
        }
        public int MDTypeID
        {
            get
            {
                return this._MDTypeID;
            }
            set
            {
                this._MDTypeID = value;
            }
        }
        public string MDItemCode
        {
            get
            {
                return this._MDItemCode;
            }
            set
            {
                this._MDItemCode = value;
            }
        }
        public string Description
        {
            get
            {
                return this._Description;
            }
            set
            {
                this._Description = value;
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
                    object[,] paramarr = new object[6, 2]	{	{ "@MDItemID", this._MDItemID },
                                                            { "@MDTypeID", this._MDTypeID },
                                                            { "@MDItemCode", this._MDItemCode },
															{ "@Description", this._Description},
															{ "@IsActive", this._IsActive},
                                                            { "@LastUpdatedBy", this._LastUpdatedBy}
														};
                    DataTable dt = _con.ExecStoreRDataTable("SY_MDItem_Save", paramarr);
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
                    object[,] paramarr = new object[2, 2] { { "@MDItemID", this._MDItemID } ,
                                                            { "@LastUpdatedBy", this._LastUpdatedBy}};
                    return Convert.ToInt32(_con.ExecStoreRObject("SY_MDItem_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@MDItemID", this._MDItemID } };
                    DataTable dt = _con.GetDataTableByStore("SY_MDItem_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search(int p_mdtypeid, string p_mditemcode, string p_description, int p_isactive)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2]	{	{ "@MDTypeID", p_mdtypeid },
                                                            { "@MDItemCode", p_mditemcode },
															{ "@Description",p_description},
															{ "@IsActive", p_isactive}
														};
                    return _con.GetDataTableByStore("SY_MDItem_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable SelectAllActiveByMDType(int p_mdtypeid)
        {
            return Search(p_mdtypeid, string.Empty, string.Empty, 1);
        }
   
    }
}


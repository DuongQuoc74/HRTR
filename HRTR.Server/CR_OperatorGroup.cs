namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_OperatorGroup")]
    public class CR_OperatorGroup : OBase
    {
        private int _OperatorGroupID;
        private string _OperatorGroupName;
        
        public CR_OperatorGroup()
        {
            this._OperatorGroupName = "";
        }
        public int OperatorGroupID
        {
            get
            {
                return this._OperatorGroupID;
            }
            set
            {
                this._OperatorGroupID = value;
            }
        }
        public string OperatorGroupName
        {
            get
            {
                return this._OperatorGroupName;
            }
            set
            {
                this._OperatorGroupName = value;
            }
        }
       

        public bool Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[3, 2]	{	{ "@OperatorGroupID", this._OperatorGroupID },
															{ "@OperatorGroupName", this._OperatorGroupName},
                                                            { "@LastUpdatedBy", this.LastUpdatedBy }
														};
                    DataTable dt = _con.ExecStoreRDataTable("CR_OperatorGroup_Save", paramarr);
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
                    object[,] paramarr = new object[2, 2]	{	 { "@OperatorGroupID", this._OperatorGroupID } ,
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_OperatorGroup_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@OperatorGroupID", this._OperatorGroupID } };
                    DataTable dt = _con.GetDataTableByStore("CR_OperatorGroup_Select", paramarr);
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
                        return _con.GetDataTableByStore("CR_OperatorGroup_Search");
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


    }
}


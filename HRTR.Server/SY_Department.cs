namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SY_Department")]
    public class SY_Department : OBase
    { 
        private int _DepartmentID;
        private string _DepartmentCode;
        private string _DepartmentName;
        public SY_Department()
        {
            this._DepartmentCode = "";
            this._DepartmentName = "";
        }
        public int DepartmentID
        {
            get
            {
                return this._DepartmentID;
            }
            set
            {
                this._DepartmentID = value;
            }
        }
        public string DepartmentCode
        {
            get
            {
                return this._DepartmentCode;
            }
            set
            {
                this._DepartmentCode = value;
            }
        }
        public string DepartmentName
        {
            get
            {
                return this._DepartmentName;
            }
            set
            {
                this._DepartmentName = value;
            }
        }
       
        public bool Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2]	{	{ "@DepartmentID", this._DepartmentID },
                                                            { "@DepartmentCode", this._DepartmentCode },
															{ "@DepartmentName", this._DepartmentName},
                                                            { "@LastUpdatedBy", this.LastUpdatedBy }
														};
                    DataTable dt = _con.ExecStoreRDataTable("SY_Department_Save", paramarr);
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
                    object[,] paramarr = new object[2, 2]	{	 { "@DepartmentID", this._DepartmentID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("SY_Department_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@DepartmentID", this._DepartmentID } };
                    DataTable dt = _con.GetDataTableByStore("SY_Department_Select", paramarr);
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
                    return _con.GetDataTableByStore("SY_Department_Search");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}


namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_Shift")]
    public class CR_Shift : OBase
    {
        private int _ShiftID;
        private string _ShiftCode;
        private string _ShiftName;
        //private string _UserName;
        public CR_Shift()
        {
            this._ShiftCode = "";
            this._ShiftName = "";
            //this._UserName = Environment.UserName;
        }
        public int ShiftID
        {
            get
            {
                return this._ShiftID;
            }
            set
            {
                this._ShiftID = value;
            }
        }
        public string ShiftCode
        {
            get
            {
                return this._ShiftCode;
            }
            set
            {
                this._ShiftCode = value;
            }
        }
        public string ShiftName
        {
            get
            {
                return this._ShiftName;
            }
            set
            {
                this._ShiftName = value;
            }
        }
        //public string UserName
        //{
        //    get
        //    {
        //        return this._UserName;
        //    }
        //    set
        //    {
        //        this._UserName = value;
        //    }
        //}

        public bool Save()
        {
            //try
            //{
            //    ConnectionDatabase condb = new ConnectionDatabase();
            //    object[,] paramarr = new object[4, 2]	{	{ "@ShiftID", this._ShiftID },
            //                                                { "@ShiftCode", this._ShiftCode},
            //                                                { "@ShiftName", this._ShiftName},
            //                                                { "@UserName", this._UserName }
            //                                            };
            //    DataTable dt = condb.execStoreRDT("Shift_Save", paramarr);
            //    DataRow dr = dt.Rows[0];
            //    this.Fill(dr);
            //    return true;
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[4, 2]	{	{ "@ShiftID", this._ShiftID },
															{ "@ShiftCode", this._ShiftCode},
                                                            { "@ShiftName", this._ShiftName},
                                                            { "@LastUpdatedBy", this.LastUpdatedBy }
														};
                    DataTable dt = _con.ExecStoreRDataTable("CR_Shift_Save", paramarr);
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
            //try
            //{
            //    ConnectionDatabase condb = new ConnectionDatabase();
            //    object[,] paramarr = new object[1, 2] { { "@ShiftID", this._ShiftID } };
            //    return condb.execStoreRI("Shift_Delete", paramarr);
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}

            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]	{	 { "@ShiftID", this._ShiftID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_Shift_Delete", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void Select()
        {
            //try
            //{
            //    ConnectionDatabase condb = new ConnectionDatabase();
            //    object[,] paramarr = new object[1, 2] { { "@ShiftID", this._ShiftID } };
            //    DataTable dt = condb.execStoreRDT("Shift_Select", paramarr);
            //    DataRow dr = dt.Rows[0];
            //    this.Fill(dr);
            //}
            //catch
            //{
            //}

            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@ShiftID", this._ShiftID } };
                    DataTable dt = _con.GetDataTableByStore("CR_Shift_Select", paramarr);
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
            //try
            //{
            //    ConnectionDatabase condb = new ConnectionDatabase();
            //    return condb.execStoreRDT("Shift_SelectAll");
            //}
            //catch
            //{
            //    return null;
            //}
            try
            {
                try
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        return _con.GetDataTableByStore("CR_Shift_Search");
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


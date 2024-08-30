namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("GC_StepInsStation")]
    public class GC_StepInsStation : OBase
    {
        private int _GC_StepInsStationID;
        private int _MESCustomer_ID;
        private int _Customer_ID;
        private int _Step_ID;
        private string _StepIns;
        private int _GC_StationID;
        private bool _IsActive;

        public GC_StepInsStation()
        {
            this._StepIns = "";
        }

        public int GC_StepInsStationID
        {
            get
            {
                return this._GC_StepInsStationID;
            }
            set
            {
                this._GC_StepInsStationID = value;
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
        public int Step_ID
        {
            get
            {
                return this._Step_ID;
            }
            set
            {
                this._Step_ID = value;
            }
        }
        public string StepIns
        {
            get
            {
                return this._StepIns;
            }
            set
            {
                this._StepIns = value;
            }
        }
        public int GC_StationID
        {
            get
            {
                return this._GC_StationID;
            }
            set
            {
                this._GC_StationID = value;
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

        public bool Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[8, 2]	{	{ "@GC_StepInsStationID", this._GC_StepInsStationID },
                                                            { "@MESCustomer_ID", this._MESCustomer_ID },
                                                            { "@Customer_ID", this._Customer_ID },
                                                            { "@Step_ID", this._Step_ID },
                                                            { "@StepIns", this._StepIns },
                                                            { "@GC_StationID", this._GC_StationID },
                                                            { "@IsActive", this._IsActive },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy }
														};
                    DataTable dt = _con.ExecStoreRDataTable("GC_StepInsStation_Save", paramarr);
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
                    object[,] paramarr = new object[2, 2]	{	{ "@GC_StepInsStationID", this._GC_StepInsStationID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("GC_StepInsStation_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@GC_StepInsStationID", this._GC_StepInsStationID } };
                    DataTable dt = _con.GetDataTableByStore("GC_StepInsStation_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="pi_mescustomer_id"></param>
        /// <param name="pstr_stepins"></param>
        /// <param name="pstr_stationname"></param>
        /// <param name="pi_isactive">1: Active, 0: Inactive, -1: All</param>
        /// <returns></returns>
        public static DataTable Search(int pi_customer_id
            , string pstr_stepins
            , string pstr_stationname
            , int pi_isactive = -1)
        {
            try
            {
                try
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        object[,] paramarr = new object[4, 2]	{	
															{ "@Customer_ID", pi_customer_id},
                                                            { "@StepIns", pstr_stepins },
                                                            { "@StationName", pstr_stationname },
                                                            { "@IsActive", pi_isactive }
														};
                        return _con.GetDataTableByStore("GC_StepInsStation_Search", paramarr);
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


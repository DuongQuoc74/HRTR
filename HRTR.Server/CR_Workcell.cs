namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_Workcell")]
    public class CR_Workcell : OBase
    {
        private int _WorkcellID;
        private string _WorkcellCode;
        private string _WorkcellName;
        private int _MESCustomer_ID;
        public CR_Workcell()
        {
            this._WorkcellCode = "";
            this._WorkcellName = "";
        }
        public int WorkcellID
        {
            get
            {
                return this._WorkcellID;
            }
            set
            {
                this._WorkcellID = value;
            }
        }
        public string WorkcellCode
        {
            get
            {
                return this._WorkcellCode;
            }
            set
            {
                this._WorkcellCode = value;
            }
        }
        public string WorkcellName
        {
            get
            {
                return this._WorkcellName;
            }
            set
            {
                this._WorkcellName = value;
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
        public string JdocWorkcellCode { get; set; }
        public string ReturnMess { get; set ; }
        public string Save()
        {
            string result = "";
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[6, 2]	{{ "@WorkcellID", this._WorkcellID },
															{ "@WorkcellCode", this._WorkcellCode},
                                                            { "@JDocWorkcellCode", this.JdocWorkcellCode},
                                                            { "@WorkcellName", this._WorkcellName},
                                                            { "@LastUpdatedBy", this.LastUpdatedBy },
                                                            { "@ReturnMess", result }
                                                        };
                     _con.ExecStoreWithOutput("CR_Workcell_Save", paramarr);
                    this.Fill(paramarr);
                    return this.ReturnMess;
                }
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        public int Delete()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]	{	 { "@WorkcellID", this._WorkcellID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_Workcell_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@WorkcellID", this._WorkcellID } };
                    DataTable dt = _con.GetDataTableByStore("CR_Workcell_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void SelectByMESCustomer_ID()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@MESCustomer_ID", this._MESCustomer_ID } };
                    DataTable dt = _con.GetDataTableByStore("CR_Workcell_Select_By_MESCustomer_ID", paramarr);
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
        /// <param name="pi_mesworkcell">0: Not MES Workcell, 1: MES Workcell, -1: All</param>
        /// <returns></returns>
        public static DataTable Search(int pi_ismesworkcell = -1)
        {
            try
            {
                try
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        object[,] paramarr = new object[1, 2] { { "@IsMESWorkcell", pi_ismesworkcell } };
                        return _con.GetDataTableByStore("CR_Workcell_Search", paramarr);
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
        /// <summary>
        /// 
        /// </summary>
        /// <param name="pi_mesworkcell">0: Not MES Workcell, 1: MES Workcell, -1: All</param>
        /// <returns></returns>
        public static DataTable SearchByUserProfileId(int pi_userprofileid,int pi_ismesworkcell = -1)
        {
            try
            {
                try
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        object[,] paramarr = new object[2, 2] { { "@UserProfileID", pi_userprofileid }
                                                              , { "@IsMESWorkcell", pi_ismesworkcell } };
                        return _con.GetDataTableByStore("CR_Workcell_Search_By_User_ProfileId", paramarr);
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


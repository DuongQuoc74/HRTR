namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("GC_MESRules")]
    public class GC_MESRules : OBase
    {
        private int _GC_MESRulesID;
        private int _MESCustomer_ID;
        private string _DetectedStepIns;
        private int _Defect_ID;
        private string _EscapedStepIns;
        private string _CRD;
        private bool _IsActive;

        public GC_MESRules()
        {
            this._DetectedStepIns = "";
            this._CRD = "";
            this._EscapedStepIns = "";
        }

        public int GC_MESRulesID
        {
            get
            {
                return this._GC_MESRulesID;
            }
            set
            {
                this._GC_MESRulesID = value;
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
        public string DetectedStepIns
        {
            get
            {
                return this._DetectedStepIns;
            }
            set
            {
                this._DetectedStepIns = value;
            }
        }
        public int Defect_ID
        {
            get
            {
                return this._Defect_ID;
            }
            set
            {
                this._Defect_ID = value;
            }
        }
        public string CRD
        {
            get
            {
                return this._CRD;
            }
            set
            {
                this._CRD = value;
            }
        }
        public string EscapedStepIns
        {
            get
            {
                return this._EscapedStepIns;
            }
            set
            {
                this._EscapedStepIns = value;
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
                    object[,] paramarr = new object[8, 2]	{	{ "@GC_MESRulesID", this._GC_MESRulesID },
                                                            { "@MESCustomer_ID", this._MESCustomer_ID },
                                                            { "@DetectedStepIns", this._DetectedStepIns },
                                                            { "@Defect_ID", this._Defect_ID },
                                                            { "@CRD", this._CRD },
                                                            { "@EscapedStepIns", this._EscapedStepIns },
                                                            { "@IsActive", this._IsActive },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy }
														};
                    DataTable dt = _con.ExecStoreRDataTable("GC_MESRules_Save", paramarr);
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
                    object[,] paramarr = new object[2, 2]	{	{ "@GC_MESRulesID", this._GC_MESRulesID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("GC_MESRules_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@GC_MESRulesID", this._GC_MESRulesID } };
                    DataTable dt = _con.GetDataTableByStore("GC_MESRules_Select", paramarr);
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
        /// <param name="pstr_defecttext"></param>
        /// <param name="pi_isactive">1: Active, 0: Inactive, -1: All</param>
        /// <returns></returns>
        public static DataTable Search(int pi_mescustomer_id
            , string pstr_detectedstepins
            , string pstr_defecttext
            , string pstr_crd
            , string pstr_escapedstepins
            , int pi_isactive = -1)
        {
            try
            {
                try
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        object[,] paramarr = new object[6, 2]	{	
															{ "@MESCustomer_ID", pi_mescustomer_id},
                                                            { "@DetectedStepIns", pstr_detectedstepins },
                                                            { "@DefectText", pstr_defecttext },
                                                            { "@CRD", pstr_crd },
                                                            { "@EscapedStepIns", pstr_escapedstepins },
                                                            { "@IsActive", pi_isactive }
														};
                        return _con.GetDataTableByStore("GC_MESRules_Search", paramarr);
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


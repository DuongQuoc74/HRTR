namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_CourseGroup")]
    public class CR_CourseGroup : OBase
    {
        private int _CourseGroupID;
        private string _CourseGroupName;
        private int _ExpiredInMonths;
        private bool _IsActive;
        public CR_CourseGroup()
        {
            this._CourseGroupName = "";
        }
        public int CourseGroupID
        {
            get
            {
                return this._CourseGroupID;
            }
            set
            {
                this._CourseGroupID = value;
            }
        }
        public string CourseGroupName
        {
            get
            {
                return this._CourseGroupName;
            }
            set
            {
                this._CourseGroupName = value;
            }
        }
        public int ExpiredInMonths
        {
            get
            {
                return this._ExpiredInMonths;
            }
            set
            {
                this._ExpiredInMonths = value;
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
                    object[,] paramarr = new object[5, 2]	{	{ "@CourseGroupID", this._CourseGroupID },
															{ "@CourseGroupName", this._CourseGroupName},
                                                            { "@ExpiredInMonths", this._ExpiredInMonths},
                                                            { "@IsActive", this._IsActive},
                                                            { "@LastUpdatedBy", this.LastUpdatedBy }
														};
                    DataTable dt = _con.ExecStoreRDataTable("CR_CourseGroup_Save", paramarr);
                    //DataRow dr = dt.Rows[0];
                    this.Fill(dt.Rows[0]);
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
                    object[,] paramarr = new object[2, 2]	{	 { "@CourseGroupID", this._CourseGroupID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_CourseGroup_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@CourseGroupID", this._CourseGroupID } };
                    DataTable dt = _con.GetDataTableByStore("CR_CourseGroup_Select", paramarr);
                    //DataRow dr = dt.Rows[0];
                    this.Fill(dt.Rows[0]);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search(string p_coursegroupname = "",
                                       int pi_isactive = -1)
        {

            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]	{ { "@CourseGroupName", p_coursegroupname},
                                                              { "@IsActive", pi_isactive} };
                    return _con.GetDataTableByStore("CR_CourseGroup_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable SearchByTrainingGroupList(string p_traininggrouplist = "")
        {

            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2]   {
                                                            { "@TrainingGroupIDList", p_traininggrouplist}
                                                        };
                    return _con.GetDataTableByStore("CR_CourseGroup_Search_By_TrainingGroupIDList", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable SearchByTrainingGroupID(int p_traininggroupid = 0
            , int p_isactive = -1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]   {
                                                            { "@TrainingGroupID", p_traininggroupid}
                                                        , { "@IsActive", p_isactive}
                                                        };
                    return _con.GetDataTableByStore("CR_CourseGroup_Select_By_TrainingGroupID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //public static DataTable SearchByTrainingGroupID_Active(int p_traininggroupid = 0)
        //{
        //    try
        //    {
        //        using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
        //        {
        //            object[,] paramarr = new object[1, 2]   {
        //                                                    { "@TrainingGroupID", p_traininggroupid}
        //                                                };
        //            return _con.GetDataTableByStore("CR_CourseGroup_Select_By_TrainingGroupID_Active", paramarr);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
    }
}


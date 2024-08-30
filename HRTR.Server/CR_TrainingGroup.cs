namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_TrainingGroup")]
    public class CR_TrainingGroup : OBase
    {
        private int _TrainingGroupID;
        
        private string _TrainingGroupName;
        private bool _IsActive;
        //private string _UserName;
        public CR_TrainingGroup()
        {
            this._TrainingGroupName = "";
            //this._UserName = Environment.UserName;
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
      
        public string TrainingGroupName
        {
            get
            {
                return this._TrainingGroupName;
            }
            set
            {
                this._TrainingGroupName = value;
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
            //    object[,] paramarr = new object[3, 2]	{	{ "@TrainingGroupID", this._TrainingGroupID },
            //                                                { "@TrainingGroupName", this._TrainingGroupName},
            //                                                { "@UserName", this._UserName }
            //                                            };
            //    DataTable dt = condb.execStoreRDT("TrainingGroup_Save", paramarr);
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
                    object[,] paramarr = new object[4, 2]	{	{ "@TrainingGroupID", this._TrainingGroupID },
                                                            { "@TrainingGroupName", this._TrainingGroupName},
                                                            { "@IsActive", this._IsActive},
                                                            { "@LastUpdatedBy", this.LastUpdatedBy }
														};
                    DataTable dt = _con.ExecStoreRDataTable("CR_TrainingGroup_Save", paramarr);
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
            //    object[,] paramarr = new object[1, 2] { { "@TrainingGroupID", this._TrainingGroupID } };
            //    return condb.execStoreRI("TrainingGroup_Delete", paramarr);
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}

            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]	{	 { "@TrainingGroupID", this._TrainingGroupID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_TrainingGroup_Delete", paramarr));
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
            //    object[,] paramarr = new object[1, 2] { { "@TrainingGroupID", this._TrainingGroupID } };
            //    DataTable dt = condb.execStoreRDT("TrainingGroup_Select", paramarr);
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
                    object[,] paramarr = new object[1, 2] { { "@TrainingGroupID", this._TrainingGroupID } };
                    DataTable dt = _con.GetDataTableByStore("CR_TrainingGroup_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataTable GetCourseGroupByTrainingGroup()
        {
            //try
            //{
            //    ConnectionDatabase condb = new ConnectionDatabase();
            //    object[,] paramarr = new object[1, 2] { { "@TrainingGroupID", this._TrainingGroupID } };
            //    return condb.execStoreRDT("CourseGroup_Select_By_TrainingGroupID", paramarr);
            //}
            //catch
            //{
            //    return null;
            //}

            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@TrainingGroupID", this._TrainingGroupID } };
                    return _con.GetDataTableByStore("CR_CourseGroup_Select_By_TrainingGroupID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataTable GetProductByTrainingGroup()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@TrainingGroupID", this._TrainingGroupID } };
                    return _con.GetDataTableByStore("CR_Product_Select_By_TraningGroupID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search(int pi_isactive = -1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@IsActive", pi_isactive } };
                    return _con.GetDataTableByStore("CR_TrainingGroup_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}


namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_CourseStation")]
    public class CR_CourseStation : OBase
    {
        private int _CourseStationID;
        private int _CourseID;
        private int _StationID;
        //private bool _Active;

        public CR_CourseStation()
        {
        }

        public int CourseStationID
        {
            get
            {
                return this._CourseStationID;
            }
            set
            {
                this._CourseStationID = value;
            }
        }
        public int CourseID
        {
            get
            {
                return this._CourseID;
            }
            set
            {
                this._CourseID = value;
            }
        }
        public int StationID
        {
            get
            {
                return this._StationID;
            }
            set
            {
                this._StationID = value;
            }
        }
        public string ReturnMess { get; set; }

        public string Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[5, 2]	{	{ "@CourseStationID", this._CourseStationID },
                                                            { "@CourseID", this._CourseID },
                                                            { "@StationID", this._StationID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy },
                                                            { "@ReturnMess", this.ReturnMess }
                                                        };
                    _con.ExecStoreWithOutput ("CR_CourseStation_Save", paramarr);
                    this.Fill(paramarr);
                    return this.ReturnMess;
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
                    object[,] paramarr = new object[2, 2]	{	 { "@CourseStationID", this._CourseStationID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_CourseStation_Delete", paramarr));
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
                    object[,] paramarr = new object[1, 2] { { "@CourseStationID", this._CourseStationID } };
                    DataTable dt = _con.GetDataTableByStore("CR_CourseStation_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search(int pi_courseid = -1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2]	{	
															{ "@CourseID", pi_courseid}
														};
                    return _con.GetDataTableByStore("CR_CourseStation_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable SearchV2(int pi_courseid = -1, int pi_stationid = -1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]   {
                                                            { "@CourseID", pi_courseid},
                                                            { "@StationID", pi_stationid}
                                                        };
                    return _con.GetDataTableByStore("CR_CourseStation_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}


namespace HRTR.Server
{
	using System;
	using System.Data;
	using System.Xml.Serialization;
	using System.Collections.Generic;
    using SystemAuth;

	[System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("GC_Station")]
	public class GC_Station : OBase
	{
        private int _GC_StationID;
		private string _StationName;
		private int _Customer_ID;
        
		public GC_Station()
		{
			this._StationName = "";
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
		public string StationName
		{
			get
			{
				return this._StationName;
			}
			set
			{
				this._StationName = value;
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
        
        //public bool Save()
        //{
        //    try
        //    {
        //        using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
        //        {
        //            object[,] paramarr = new object[4, 2]	{	{ "@GC_StationID", this._GC_StationID},
        //                                                    { "@StationName", this._StationName},
        //                                                    { "@WorkcellID", this._WorkcellID},
        //                                                    { "@LastUpdatedBy", this.LastUpdatedBy}
        //                                                };
        //            DataTable dt = _con.ExecStoreRDataTable("GC_Station_Save", paramarr);
        //            DataRow dr = dt.Rows[0];
        //            this.Fill(dr);
        //            return true;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        //public int Delete()
        //{
        //    try
        //    {
        //        using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
        //        {
        //            object[,] paramarr = new object[2, 2]	{	{ "@StationID", this._StationID },
        //                                                    { "@LastUpdatedBy", this.LastUpdatedBy}
        //                                                };
        //            return Convert.ToInt32(_con.ExecStoreRObject("Station_Delete", paramarr));
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        //public void Select()
        //{
        //    try
        //    {
        //        using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
        //        {
        //            object[,] paramarr = new object[1, 2] { { "@StationID", this._StationID } };
        //            DataTable dt = _con.GetDataTableByStore("Station_Select", paramarr);
        //            DataRow dr = dt.Rows[0];
        //            this.Fill(dr);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public static DataTable Search(string p_stationname = "",
                                        int p_customer_id = 0,
                                        bool p_iswithunknown = false)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[3, 2]	{	
                                                            { "@StationName", p_stationname },
                                                            { "@Customer_ID", p_customer_id },
                                                            { "@IsWithUnknown", p_iswithunknown }
														};
                    return _con.GetDataTableByStore("GC_Station_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


	}
}


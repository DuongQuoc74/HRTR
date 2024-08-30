using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;
    using SystemAuth;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_WorkingStatus")]
    public class CR_WorkingStatus : OBase
    {
        private int _WorkingStatusID;
        private string _WorkingStatusCode;
        private string _WorkingStatusName;


        public CR_WorkingStatus()
        {
            this._WorkingStatusCode = "";
            this._WorkingStatusName = "";
        }

        public int WorkingStatusID
        {
            get
            {
                return this._WorkingStatusID;
            }
            set
            {
                this._WorkingStatusID = value;
            }
        }

        public string WorkingStatusCode
        {
            get
            {
                return this._WorkingStatusCode;
            }
            set
            {
                this._WorkingStatusCode = value;
            }
        }

        public string WorkingStatusName
        {
            get
            {
                return this._WorkingStatusName;
            }
            set
            {
                this._WorkingStatusName = value;
            }
        }

        public void Select()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@WorkingStatusID", this._WorkingStatusID } };
                    DataTable dt = _con.GetDataTableByStore("CR_WorkingStatus_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable Search(string p_workingstatuscode = ""
            , string p_workingstatusname = "")
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]   {
                                                            { "@WorkingStatusCode", p_workingstatuscode }
                                                            ,{ "@WorkingStatusName", p_workingstatusname }
                                                        };
                    return _con.GetDataTableByStore("CR_WorkingStatus_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}

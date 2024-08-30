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
    [System.Xml.Serialization.XmlRootAttribute("CR_TrainingStatus")]
    public class CR_TrainingStatus : OBase
    {
        private int _TrainingStatusID;
        private string _TrainingStatusName;


        public CR_TrainingStatus()
        {
            this._TrainingStatusName = "";
        }

        public int TrainingStatusID
        {
            get
            {
                return this._TrainingStatusID;
            }
            set
            {
                this._TrainingStatusID = value;
            }
        }

        public string TrainingStatusName
        {
            get
            {
                return this._TrainingStatusName;
            }
            set
            {
                this._TrainingStatusName = value;
            }
        }

        public static DataTable Search()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    return _con.ExecStoreRDataTable("CR_TrainingStatus_Search");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

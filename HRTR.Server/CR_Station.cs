namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;
    

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("CR_Station")]
    public class CR_Station : OBase
    {

        public CR_Station()
        {
            this.Name = "";
            this.WorkcellID = 0;
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public int WorkcellID { get; set; }
        public string ReturnMess { get; set; }


        public string Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[5, 2] { { "@Id", this.Id },
                                                            { "@Name", this.Name },
                                                            { "@WorkcellID", this.WorkcellID },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy } ,
                                                            { "@ReturnMess", this.ReturnMess }
                    };
                    _con.ExecStoreWithOutput("CR_Station_Save", paramarr);
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
                    object[,] paramarr = new object[2, 2] { { "@StationID", this.Id },
                                                            { "@LastUpdatedBy", this.LastUpdatedBy } };
                    return Convert.ToInt32(_con.ExecStoreRObject("CR_Station_Delete", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable Search(string p_familyname, int p_workcellid)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2] { { "@StationName", p_familyname },
                                                            { "@WorkcellID", p_workcellid } };
                    return _con.GetDataTableByStore("CR_Station_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}


namespace HRTR.Server
{
	using System;
	using System.Data;
    using SystemAuth;
	using System.Xml.Serialization;
	using System.Collections.Generic;

	[System.SerializableAttribute()]
	[System.Xml.Serialization.XmlRootAttribute("QM_Defects")]
	public class QM_Defects : OBase
	{
        private int Defect_ID;
           
		public QM_Defects()
		{
            
		}
		public int QM_DefectsID
		{
			get
			{
				return this.Defect_ID;
			}
			set
			{
				this.Defect_ID = value;
			}
		}

        /// <summary>
        /// 
        /// </summary>
        /// <param name="pi_isincludedall"></param>
        /// <returns></returns>
        public static DataTable Search(int pi_isincludedall = 0)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@IsIncludeAll", pi_isincludedall } };
                    return _con.GetDataTableByStore("QM_Defects_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


	}
}


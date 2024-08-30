namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SY_MDType")]
    public class SY_MDType : OBase
    {
        private int _MDTypeID;
        private string _MDTypeName;
        private int _DefaultMDItemID;
        public SY_MDType()
        {
            this._MDTypeName = "";
        }
        public int MDTypeID
        {
            get
            {
                return this._MDTypeID;
            }
            set
            {
                this._MDTypeID = value;
            }
        }
        public string MDTypeName
        {
            get
            {
                return this._MDTypeName;
            }
            set
            {
                this._MDTypeName = value;
            }
        }
        public int DefaultMDItemID
        {
            get
            {
                return this._DefaultMDItemID;
            }
            set
            {
                this._DefaultMDItemID = value;
            }
        }
        public void Select()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@MDTypeID", this._MDTypeID } };
                    DataTable dt = _con.GetDataTableByStore("SY_MDType_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search(int p_isactive = 1)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2]	{
															{ "@IsActive", p_isactive}
														};
                    return _con.GetDataTableByStore("SY_MDType_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
    public enum MDType : int
    {
        CR_Workcell = 1,
        CR_SRType = 2,
        CR_MaterialType = 3,
        CR_ShipMode = 4,
        CR_TransactionCode = 5,
        CR_Currency = 6,
        CR_ServiceMode = 7,
        CR_WeightUnit = 8,
        CR_IncoTerm = 9,
        CR_Country = 10,
        CR_Department = 11,
        CR_LengthUnit = 12,
        CR_ContainerType = 13,
        CR_UOM = 14,
        CR_Family = 15,
        CR_BOMStatus = 17,
        CR_Payment = 18,
        CR_ComponentType = 19,
        CR_ScanType = 20,
        CR_RADMaterialCategory = 21,
        CR_ReworkCategory = 22,
        CR_FPYKind = 23,
        CR_EmployeeGroup = 24,
        CR_PaymentTerm = 25,
        CR_ETA = 26,
        CR_RTVReason = 27,
        CR_KindOfSIBook = 28,
        CR_EducationType = 29,
        CR_FamilyRelationship = 30,
        CR_SIBookStatus = 31,
        CR_EmployeeLevel = 32
    };
}


namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using SystemAuth;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("GrapeChartChart")]
    public class GC_Chart : OBase
    {
        
        private int _EmployeeID_ID;
        private int _Year;
        private int _Month;
        private int _Day;
        private int _DayStatus;
        private int _TotalDefect;
        private string _DefectText;
        private string _CRD;
        private string _Description;

        public GC_Chart()
        {
            this._DefectText = "";
        }

        
        public int EmployeeID_ID
        {
            get
            {
                return this._EmployeeID_ID;
            }
            set
            {
                this._EmployeeID_ID = value;
            }
        }
        public int Year
        {
            get
            {
                return this._Year;
            }
            set
            {
                this._Year = value;
            }
        }
        public int Month
        {
            get
            {
                return this._Month;
            }
            set
            {
                this._Month = value;
            }
        }
        public int Day
        {
            get
            {
                return this._Day;
            }
            set
            {
                this._Day = value;
            }
        }
        public int TotalDefect
        {
            get
            {
                return this._TotalDefect;
            }
            set
            {
                this._TotalDefect = value;
            }
        }
        public int DayStatus
        {
            get
            {
                return this._DayStatus;
            }
            set
            {
                this._DayStatus = value;
            }
        }
        
        public string DefectText
        {
            get
            {
                return this._DefectText;
            }
            set
            {
                this._DefectText = value;
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
        public string Description
        {
            get
            {
                return this._Description;
            }
            set
            {
                this._Description = value;
            }
        }
       
    }
}


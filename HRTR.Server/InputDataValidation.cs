using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using eUtilities;
using SystemAuth;

namespace HRTR.Server
{
    public class InputDataValidation : IDisposable
    {
        #region Fields

        private string _TableName;
        private DataTable _DT = new DataTable();
        private Hashtable _ColumnNameMap = new Hashtable();

        #endregion

        #region Constructor

        public InputDataValidation()
        {
            this._TableName = "";
        }

        #endregion

        #region Dispose

        public virtual void Dispose()
        {
        }
        #endregion

        #region Properties

        public string TableName
        {
            get
            {
                return this._TableName;
            }
            set
            {
                this._TableName = value;
            }
        }
        public DataTable DT
        {
            get
            {
                return this._DT;
            }
            set
            {
                this._DT = value;
            }
        }
        public Hashtable ColumnNameMap
        {
            get
            {
                return this._ColumnNameMap;
            }
            set
            {
                this._ColumnNameMap = value;
            }
        }

        #endregion

        #region Methods

        public void ValidateData()
        {
            DataColumn dcIsValid = new DataColumn("IsValid", typeof(bool));
            dcIsValid.DefaultValue = true;
            this._DT.Columns.Add(dcIsValid);
            DataColumn dcErrorMessage = new DataColumn("ErrorMessage", typeof(string));
            dcErrorMessage.DefaultValue = "";
            this._DT.Columns.Add(dcErrorMessage);
            this._DT.AcceptChanges();

            ///Check column data length
            DataTable dtColumn = new DataTable();
            using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
            {
                object[,] paramarr = new object[1, 2]	{	{"@table_name", this._TableName}
														};
                dtColumn = _con.GetDataTableByStore("sp_columns_100", paramarr);
            }

            for (int i = 0; i < this._DT.Columns.Count; i++)
            {
                string strcolumnnameinfile = this._DT.Columns[i].ColumnName;
                if (string.IsNullOrEmpty(strcolumnnameinfile))
                {
                    continue;
                }
                string strcolumnname = strcolumnnameinfile;

                try
                {
                    strcolumnname = this._ColumnNameMap[strcolumnnameinfile].ToString();
                }
                catch
                {
                }
                string strfilter = "COLUMN_NAME = '" + strcolumnname + "'";
                DataRow[] selectedRows = dtColumn.Select(strfilter);
                if (selectedRows.Length > 0)
                {
                    DataRow selectedRow = selectedRows[0];
                    ///DataType from SQL Table
                    string strdatatype = selectedRow["TYPE_NAME"].ToString().ToLower();
                    ///DataType from Excel/ ... Files
                    string strdatatypeinfile = this._DT.Columns[strcolumnnameinfile].DataType.ToString().ToLower();
                    int imaxlength = Convert.ToInt32(selectedRow["PRECISION"]);
                    if (strdatatype.Equals("char")
                        || strdatatype.Equals("nchar")
                        || strdatatype.Equals("varchar")
                        || strdatatype.Equals("nvarchar"))
                    {
                        string strfilter2 = "LEN(Convert([" + strcolumnnameinfile + "],'System.String')) > " + imaxlength.ToString() + "";
                        DataRow[] arrdr = this._DT.Select(strfilter2);
                        foreach (DataRow dr in arrdr)
                        {
                            object objcolumnvalue = dr[strcolumnnameinfile];
                            dr[strcolumnnameinfile] = objcolumnvalue.ToString().Substring(0, imaxlength);
                            dr["IsValid"] = false;
                            dr["ErrorMessage"] = dr["ErrorMessage"]
                                                + strcolumnnameinfile + ": input data exceeds the maximum allowed size [" + imaxlength.ToString() + "]."
                                                + Environment.NewLine;
                        }
                    }
                    else if (strdatatype.Equals("datetime") && !strdatatypeinfile.Equals("system.datetime"))
                    {
                        //string strfilter2 = "[" + strcolumnnameinfile + "] IS NOT NULL AND [" + strcolumnnameinfile + "] <> ''";
                        string strfilter2 = "[" + strcolumnnameinfile + "] IS NOT NULL";
                        DataRow[] arrdr = this._DT.Select(strfilter2);
                        //throw new Exception("Column "  + strcolumnnameinfile + ": Invalid date time value.");
                        foreach (DataRow dr in arrdr)
                        {
                            object objcolumnvalue = dr[strcolumnnameinfile];
                            try
                            {
                                if (string.IsNullOrEmpty(objcolumnvalue.ToString().Trim()))
                                {
                                    dr[strcolumnnameinfile] = DBNull.Value;
                                    continue;
                                }
                                DateTime da;
                                if (DateTime.TryParse(objcolumnvalue.ToString(), out da))
                                {
                                    ///ok
                                }
                                else
                                {
                                    dr[strcolumnnameinfile] = DBNull.Value;
                                    dr["IsValid"] = false;
                                    dr["ErrorMessage"] = dr["ErrorMessage"]
                                                        + strcolumnnameinfile + ": Invalid date time value."
                                                        + Environment.NewLine;
                                }
                            }
                            catch
                            {
                                dr[strcolumnnameinfile] = DBNull.Value;
                                dr["IsValid"] = false;
                                dr["ErrorMessage"] = dr["ErrorMessage"]
                                                    + strcolumnnameinfile + ": Invalid date time value."
                                                    + Environment.NewLine;
                            }
                        }

                    }
                    //else  if (strdatatype.Equals("bit"))
                    //{
                    //    //dtColumn.Rows[strcolumnnameinfile] = objcolumnvalue.ToString().Substring(0, imaxlength);
                    //}
                }
            }
            this._DT.AcceptChanges();

        }

        #endregion

    }
}

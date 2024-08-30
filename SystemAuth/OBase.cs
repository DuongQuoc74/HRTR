using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Configuration;
using eUtilities;

namespace SystemAuth
{
    public class OBase : IDisposable
    {
        protected System.DateTime _LastUpdated;
        protected int _LastUpdatedBy;

        public System.DateTime LastUpdated
        {
            get
            {
                return this._LastUpdated;
            }
            set
            {
                this._LastUpdated = value;
            }
        }
        public int LastUpdatedBy
        {
            get
            {
                return this._LastUpdatedBy;
            }
            set
            {
                this._LastUpdatedBy = value;
            }
        }

        public OBase()
        {
            try
            {
                this._LastUpdatedBy = Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
            }
            catch
            {
                this._LastUpdatedBy = 0;
            }
        }

        ~OBase()
        {

        }

        public virtual void Dispose()
        {

        }

        public virtual void Fill(System.Data.DataRow dr)
        {
            System.ComponentModel.PropertyDescriptorCollection props = System.ComponentModel.TypeDescriptor.GetProperties(this);
            for (int i = 0; (i < props.Count); i = (i + 1))
            {
                System.ComponentModel.PropertyDescriptor prop = props[i];
                if ((prop.IsReadOnly != true))
                {
                    try
                    {
                        object strprop;
                        if (dr.RowState == DataRowState.Deleted)
                        {
                            strprop = dr[prop.Name, DataRowVersion.Original];
                        }
                        else
                        {
                            strprop = dr[prop.Name];
                        }

                        if ((strprop.Equals(System.DBNull.Value) != true))
                        {
                            if ((prop.PropertyType.Equals(strprop.GetType()) != true))
                            {
                                prop.SetValue(this, prop.Converter.ConvertFrom(strprop));
                            }
                            else
                            {
                                prop.SetValue(this, strprop);
                            }
                        }
                    }
                    catch (System.Exception)
                    {
                    }
                }
            }
        }

        public string ToXmlString()
        {
            System.Xml.Serialization.XmlSerializer oSerialize = new System.Xml.Serialization.XmlSerializer(this.GetType());
            System.IO.MemoryStream oBuffer = new System.IO.MemoryStream();
            oSerialize.Serialize(oBuffer, this);
            string returnVal = System.Text.ASCIIEncoding.ASCII.GetString(oBuffer.ToArray());
            return returnVal;
        }
    }
}

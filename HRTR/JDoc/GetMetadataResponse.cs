using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRTR.JDoc
{
    public class GetMetadataResponse
    {
        public int MetaDataId { get; set; }
        public string Name { get; set; }
        public List<MetadataValue> Values { get; set; }
        public List<object> SelectedValues { get; set; }
        public int Order { get; set; }
        public bool IsCustomField { get; set; }
    }

    public class MetadataValue
    {
        public string Name { get; set; }
        public string Value { get; set; }
    }
}
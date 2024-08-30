using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace HRTR.JDoc
{
    public class GetDocumentsRequestBody
    {
        public GetDocumentsRequestBody(string docNumber, string docRev, string stationName, GetMetadataResponse metaresp, List<string> docTypes)
        {
            IncludeCorporateSite = "false";
            Type = "";
            IsReleased = "true";
            AllSite = "false";
            SearchReleaseDate = "-1";
            FromPage = 0;
            PageSize = 1;
            SiteIds = new List<string>(ConfigurationManager.AppSettings["GetDocumentAPIRequestDocumentTypes"].Split(','));
            DocumentNumber = docNumber;
            DocumentRevision = docRev;
            DocumentTitle = "";
            DocumentTypeId = 0;
            DocumentTypes = docTypes;
            DocumentOwner = "";
            DocumentAuthor = "";
            PreviousNumber = "";
            MetadataList = new List<DocRequestMetadata> { new DocRequestMetadata(metaresp, stationName) };
        }

        public string IncludeCorporateSite { get; set; }
        public string Type { get; set; }
        public string IsReleased { get; set; }
        public string AllSite { get; set; }
        public string SearchReleaseDate { get; set; }
        public int FromPage { get; set; }
        public int PageSize { get; set; }
        public List<string> SiteIds { get; set; }
        public string DocumentNumber { get; set; }
        public string DocumentRevision { get; set; }
        public string DocumentTitle { get; set; }
        public int DocumentTypeId { get; set; }
        public List<string> DocumentTypes { get; set; }
        public string DocumentOwner { get; set; }
        public string DocumentAuthor { get; set; }
        public string PreviousNumber { get; set; }
        public List<DocRequestMetadata> MetadataList { get; set; }
    }

    public class DocRequestMetadata
    {
        public DocRequestMetadata(GetMetadataResponse metaresp, string stationName)
        {
            MetadataIndex = "";
            MetadataId = metaresp.MetaDataId;
            Metaoperator = 2;
            MetadataName = metaresp.Name;
            IsCustomField = metaresp.IsCustomField;
            Function = 3;
            Value = stationName;
            DateValue = "";
            DateFunction = 1;
            IsDateField = false;
        }

        public string MetadataIndex { get; set; }
        public int MetadataId { get; set; }
        [JsonProperty("operator")]
        public int Metaoperator { get; set; }
        public string MetadataName { get; set; }
        public bool IsCustomField { get; set; }
        public int Function { get; set; }
        public string Value { get; set; }
        public string DateValue { get; set; }
        public int DateFunction { get; set; }
        public bool IsDateField { get; set; }
    }
}
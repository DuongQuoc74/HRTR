using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRTR.JDoc
{
    public class Document
    {
        [JsonProperty("documentId")]
        public string DocumentId { get; set; }

        [JsonProperty("jDocNumber")]
        public string JDocNumber { get; set; }

        [JsonProperty("jDocRevision")]
        public string JDocRevision { get; set; }

        [JsonProperty("jDocVersion")]
        public string JDocVersion { get; set; }

        [JsonProperty("status")]
        public string Status { get; set; }

        [JsonProperty("statusDescription")]
        public string StatusDescription { get; set; }

        [JsonProperty("site")]
        public string Site { get; set; }

        [JsonProperty("siteId")]
        public string SiteId { get; set; }

        [JsonProperty("siteIdNumber")]
        public int SiteIdNumber { get; set; }

        [JsonProperty("isCorporateSite")]
        public bool IsCorporateSite { get; set; }

        [JsonProperty("siteDescription")]
        public string SiteDescription { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("typeDescription")]
        public string TypeDescription { get; set; }

        [JsonProperty("subtype")]
        public string Subtype { get; set; }

        [JsonProperty("department")]
        public string Department { get; set; }

        [JsonProperty("departmentDescription")]
        public string DepartmentDescription { get; set; }

        [JsonProperty("corpSiteFunction")]
        public string CorpSiteFunction { get; set; }

        [JsonProperty("corpSiteFunctionDescription")]
        public string CorpSiteFunctionDescription { get; set; }

        [JsonProperty("authorId")]
        public string AuthorId { get; set; }

        [JsonProperty("authorName")]
        public string AuthorName { get; set; }

        [JsonProperty("ownerId")]
        public string OwnerId { get; set; }

        [JsonProperty("ownerName")]
        public string OwnerName { get; set; }

        [JsonProperty("previousNumber")]
        public string PreviousNumber { get; set; }

        [JsonProperty("customer")]
        public string Customer { get; set; }

        [JsonProperty("customerDescription")]
        public object CustomerDescription { get; set; }

        [JsonProperty("confidential")]
        public bool Confidential { get; set; }

        [JsonProperty("workcell")]
        public string Workcell { get; set; }

        [JsonProperty("createdDate")]
        public DateTimeOffset CreatedDate { get; set; }

        [JsonProperty("nextReviewDate")]
        public object NextReviewDate { get; set; }

        [JsonProperty("releaseDate")]
        public DateTimeOffset ReleaseDate { get; set; }

        [JsonProperty("effectiveDate")]
        public DateTimeOffset EffectiveDate { get; set; }

        [JsonProperty("expirationDate")]
        public object ExpirationDate { get; set; }

        [JsonProperty("title")]
        public string Title { get; set; }

        [JsonProperty("titleDescription")]
        public string TitleDescription { get; set; }

        [JsonProperty("reasonForChange")]
        public string ReasonForChange { get; set; }

        [JsonProperty("notes")]
        public string Notes { get; set; }

        [JsonProperty("extDocNo")]
        public string ExtDocNo { get; set; }

        [JsonProperty("extDocRev")]
        public string ExtDocRev { get; set; }

        [JsonProperty("qmsFirstLevel")]
        public string QmsFirstLevel { get; set; }

        [JsonProperty("qmsSecondLevel")]
        public object QmsSecondLevel { get; set; }

        [JsonProperty("fileName")]
        public string FileName { get; set; }

        [JsonProperty("valid")]
        public bool Valid { get; set; }
    }

    public class GetDocumentsResponse
    {
        [JsonProperty(PropertyName = "documents")]
        public List<Document> Documents { get; set; }
        [JsonProperty(PropertyName = "totalDoc")]
        public int TotalDoc { get; set; }

        public bool HasDocument(string docNumber, string revision)
        {
            return Documents.Exists(d => d.JDocNumber == docNumber && d.JDocRevision == revision);
        }
    }

}
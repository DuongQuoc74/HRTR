using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace HRTR.JDoc
{
    public class JDocApi
    {
        private readonly HttpClient _client = new HttpClient();
        private readonly string _clientId;
        private readonly string _clientSecret;

        public JDocApi(string clientId, string clientSecret)
        {
            _clientId = clientId;
            _clientSecret = clientSecret;
        }

        public GetTokenResponse GetAccessToken(string userName)
        {
            System.Net.ServicePointManager.SecurityProtocol = (System.Net.SecurityProtocolType)(768 | 3072);
            // Step 1: Send POST request to get the access token from identity connect endpoint with client id and secret.
            var tokenEndpoint = ConfigurationManager.AppSettings["ApiUrl"] + "/auth/identity/connect/token";

            var tokenRequest = new HttpRequestMessage(HttpMethod.Post, tokenEndpoint);
            tokenRequest.Content = new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("client_id", _clientId),
                new KeyValuePair<string, string>("client_secret", _clientSecret),
                new KeyValuePair<string, string>("scope", "JDocViewerApi_Search"),
                new KeyValuePair<string, string>("grant_type", "external_custom")
            });

            string responseJson = "";
            try
            {
                var tokenResponse = _client.SendAsync(tokenRequest).Result;
                tokenResponse.EnsureSuccessStatusCode();

                responseJson = tokenResponse.Content.ReadAsStringAsync().Result;
            }
            catch (Exception ex)
            {
                HRTR.Server.CcsApiErrorLog.Save(tokenEndpoint, "POST", "", ex.Message, "", userName);
            }
            
            var response = JsonConvert.DeserializeObject<GetTokenResponse>(responseJson);
            response.ExpiresAt = DateTime.Now.AddSeconds(response.ExpiresIn);
            return response;
        }

        public GetMetadataResponse GetMetadataResponse(string accessToken, string userName)
        {
            System.Net.ServicePointManager.SecurityProtocol = (System.Net.SecurityProtocolType)(768 | 3072);

            var metaEndpoint = ConfigurationManager.AppSettings["ApiUrl"]
                + "/" + ConfigurationManager.AppSettings["ApiVersion"]
                + "/webapi/SecurityRole/GetMetaDataValue/" + ConfigurationManager.AppSettings["SiteId"];
            string metajson = "";
            _client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
            try
            {
                var metaResponse = _client.GetAsync(metaEndpoint).Result;
                metaResponse.EnsureSuccessStatusCode();
                metajson = metaResponse.Content.ReadAsStringAsync().Result;
            }
            catch (Exception ex)
            {
                HRTR.Server.CcsApiErrorLog.Save(metaEndpoint, "GET", "", ex.Message, "", userName);
            }

            var metadataList = JsonConvert.DeserializeObject<List<GetMetadataResponse>>(metajson);
            foreach (var md in metadataList)
            {
                if (md.Name.ToUpper() == "STATION")
                {
                    return md;
                }
            }
            return null;
        }

        // RestApi class
        public bool GetDocuments(string accessToken, GetMetadataResponse metadata, string documentNumber, string documentRevision, string stationName, string userName)
        {
            System.Net.ServicePointManager.SecurityProtocol = (System.Net.SecurityProtocolType)(768 | 3072);
            
            if (metadata == null)
            {
                return false;
            }
            _client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
            // Step 2: Send POST request to get document endpoint with bearer access token and request body in JSON format to get array of documents in JSON format.
            var documentEndpoint = ConfigurationManager.AppSettings["ApiUrl"]
                + "/" + ConfigurationManager.AppSettings["ApiVersion"]
                + "/webapi/DisplayDocument/GetDocuments";
            var docTypes = ConfigurationManager.AppSettings["GetDocumentAPIRequestDocumentTypes"];
            var responseJson = "";
            var requestBody = "";
            try
            {
                var requestBodyJson = JsonConvert.SerializeObject(new GetDocumentsRequestBody(documentNumber, documentRevision, stationName, metadata, docTypes.Split(',').ToList()));
                var requestBodyContent = new StringContent(requestBodyJson, Encoding.UTF8, "application/json");
                requestBody = requestBodyContent.ToString();
                var documentResponse = _client.PostAsync(documentEndpoint, requestBodyContent).Result;
                documentResponse.EnsureSuccessStatusCode();
                responseJson = documentResponse.Content.ReadAsStringAsync().Result;
            }
            catch (Exception ex)
            {
                HRTR.Server.CcsApiErrorLog.Save(documentEndpoint, "POST", requestBody, ex.Message, "", userName);
            }
            
            var response = JsonConvert.DeserializeObject<GetDocumentsResponse>(responseJson);
            return response.TotalDoc>0 && response.HasDocument(documentNumber, documentRevision);
        }
    }
}
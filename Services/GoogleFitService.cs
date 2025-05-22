using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.Identity;
using Newtonsoft.Json;
using ProjectFit.Models;

namespace ProjectFit.Services
{
    public class GoogleFitService
    {
        private readonly string _clientId;
        private readonly string _clientSecret;
        private readonly string _redirectUri;
        private readonly string[] scopes;

        public GoogleFitService()
        {
            // Obtém as variáveis de ambiente
            _clientId = Environment.GetEnvironmentVariable("GOOGLE_CLIENT_ID");
            _clientSecret = Environment.GetEnvironmentVariable("GOOGLE_CLIENT_SECRET");
            _redirectUri = Environment.GetEnvironmentVariable("GOOGLE_REDIRECT_URI");

            if (string.IsNullOrEmpty(_clientId) || string.IsNullOrEmpty(_clientSecret) || string.IsNullOrEmpty(_redirectUri))
            {
                throw new InvalidOperationException("As variáveis de ambiente GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET ou GOOGLE_REDIRECT_URI não estão configuradas.");
            }

            // Define os escopos necessários
            scopes = new[]
            {
                "https://www.googleapis.com/auth/fitness.activity.read ",
                "https://www.googleapis.com/auth/fitness.body.read ",
                "https://www.googleapis.com/auth/fitness.sleep.read ",
                "https://www.googleapis.com/auth/userinfo.profile ",
                "https://www.googleapis.com/auth/userinfo.email "
            };
        }

        /// <summary>
        /// Gera a URL de autorização para o Google Fit.
        /// </summary>
        public string GenerateAuthorizationUrl()
        {
            string scope = string.Join(" ", scopes);
            string authUrl = $"https://accounts.google.com/o/oauth2/v2/auth " +
                             $"?client_id={HttpUtility.UrlEncode(_clientId)}" +
                             $"&redirect_uri={HttpUtility.UrlEncode(_redirectUri)}" +
                             $"&response_type=code" +
                             $"&scope={HttpUtility.UrlEncode(scope)}" +
                             $"&access_type=offline" +
                             $"&prompt=consent";
            return authUrl;
        }

        /// <summary>
        /// Processa o código de autorização e obtém tokens do Google Fit.
        /// </summary>
        public async Task<GoogleTokenResponse> HandleCallbackAsync(string code)
        {
            var token = await ExchangeCodeForToken(code);
            if (token == null)
                return null;

            var userInfo = await GetUserInfo(token.AccessToken);
            if (userInfo == null)
                return null;

            return token;
        }

        /// <summary>
        /// Obtém dados de passos do Google Fit para um intervalo de datas.
        /// </summary>
        public async Task<StepResponse> GetStepsAsync(string accessToken, DateTime startDate, DateTime endDate)
        {
            var startTimeMillis = ToUnixTimeMilliseconds(startDate);
            var endTimeMillis = ToUnixTimeMilliseconds(endDate);

            var requestBody = new
            {
                aggregateBy = new[]
                {
                    new { dataTypeName = "com.google.step_count.delta" }
                },
                bucketByTime = new { durationMillis = (long)TimeSpan.FromDays(1).TotalMilliseconds },
                startTimeMillis = startTimeMillis,
                endTimeMillis = endTimeMillis
            };

            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
                var response = await client.PostAsJsonAsync(
                    "https://www.googleapis.com/fitness/v1/users/me/dataset :aggregate",
                    requestBody
                );

                if (!response.IsSuccessStatusCode)
                {
                    throw new Exception($"Erro ao buscar dados do Google Fit: {await response.Content.ReadAsStringAsync()}");
                }

                return JsonConvert.DeserializeObject<StepResponse>(await response.Content.ReadAsStringAsync());
            }
        }

        /// <summary>
        /// Obtém um token de acesso válido ou renova o token se necessário.
        /// </summary>
        public async Task<string> GetValidAccessTokenAsync(string userId)
        {
            using (var db = new ApplicationDbContext())
            {
                var user = db.Users.FirstOrDefault(u => u.Id == userId);
                if (user == null || string.IsNullOrEmpty(user.GoogleRefreshToken))
                    return null;

                var refreshToken = user.GoogleRefreshToken;

                var expiryTime = DateTimeOffset.FromUnixTimeMilliseconds(long.Parse(user.ExpiresIn)).UtcDateTime;
                if (DateTime.UtcNow < expiryTime)
                    return user.GoogleAccessToken;

                var newToken = await RefreshAccessToken(refreshToken);
                if (newToken == null)
                    return null;

                user.GoogleAccessToken = newToken.AccessToken;
                user.GoogleRefreshToken = newToken.RefreshToken;
                user.ExpiresIn = newToken.ExpiresIn.ToString();
                db.SaveChanges();

                return newToken.AccessToken;
            }
        }

        #region Métodos Auxiliares

        public async Task<GoogleTokenResponse> ExchangeCodeForToken(string code)
        {
            var tokenUrl = "https://oauth2.googleapis.com/token ";
            var tokenRequest = new Dictionary<string, string>
            {
                { "code", code },
                { "client_id", _clientId },
                { "client_secret", _clientSecret },
                { "redirect_uri", _redirectUri },
                { "grant_type", "authorization_code" }
            };

            using (var http = new HttpClient())
            {
                var content = new FormUrlEncodedContent(tokenRequest);
                var response = await http.PostAsync(tokenUrl, content);
                return JsonConvert.DeserializeObject<GoogleTokenResponse>(await response.Content.ReadAsStringAsync());
            }
        }

        public async Task<GoogleUserInfo> GetUserInfo(string accessToken)
        {
            using (var http = new HttpClient())
            {
                http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
                var response = await http.GetAsync("https://www.googleapis.com/oauth2/v2/userinfo ");
                return JsonConvert.DeserializeObject<GoogleUserInfo>(await response.Content.ReadAsStringAsync());
            }
        }

        private async Task<GoogleTokenResponse> RefreshAccessToken(string refreshToken)
        {
            var tokenUrl = "https://oauth2.googleapis.com/token ";
            var tokenRequest = new Dictionary<string, string>
            {
                { "client_id", _clientId },
                { "client_secret", _clientSecret },
                { "refresh_token", refreshToken },
                { "grant_type", "refresh_token" }
            };

            using (var http = new HttpClient())
            {
                var content = new FormUrlEncodedContent(tokenRequest);
                var response = await http.PostAsync(tokenUrl, content);
                return JsonConvert.DeserializeObject<GoogleTokenResponse>(await response.Content.ReadAsStringAsync());
            }
        }

        private long ToUnixTimeMilliseconds(DateTime date)
        {
            return (long)(date.ToUniversalTime() - new DateTime(1970, 1, 1)).TotalMilliseconds;
        }

        #endregion

        #region Modelos Auxiliares

        public class GoogleTokenResponse
        {
            [JsonProperty("access_token")]
            public string AccessToken { get; set; }
            [JsonProperty("expires_in")]
            public int ExpiresIn { get; set; }
            [JsonProperty("refresh_token")]
            public string RefreshToken { get; set; }
            [JsonProperty("scope")]
            public string Scope { get; set; }
            [JsonProperty("token_type")]
            public string TokenType { get; set; }
            [JsonProperty("id_token")]
            public string IdToken { get; set; }
        }

        public class GoogleUserInfo
        {
            [JsonProperty("email")]
            public string Email { get; set; }
            [JsonProperty("name")]
            public string Name { get; set; }
            [JsonProperty("picture")]
            public string PictureUrl { get; set; }
        }

        public class StepResponse
        {
            [JsonProperty("bucket")]
            public List<Bucket> Buckets { get; set; }
        }

        public class Bucket
        {
            [JsonProperty("startTimeMillis")]
            public string StartTime { get; set; }
            [JsonProperty("endTimeMillis")]
            public string EndTime { get; set; }
            [JsonProperty("dataset")]
            public List<DataSet> DataSets { get; set; }
        }

        public class DataSet
        {
            [JsonProperty("dataSourceId")]
            public string DataSourceId { get; set; }
            [JsonProperty("point")]
            public List<Point> Points { get; set; }
        }

        public class Point
        {
            [JsonProperty("startTimeNanos")]
            public string StartTime { get; set; }
            [JsonProperty("endTimeNanos")]
            public string EndTime { get; set; }
            [JsonProperty("value")]
            public List<Value> Values { get; set; }
        }

        public class Value
        {
            [JsonProperty("intVal")]
            public int IntValue { get; set; }
            [JsonProperty("fpVal")]
            public double FloatValue { get; set; }
        }

        #endregion
    }
}
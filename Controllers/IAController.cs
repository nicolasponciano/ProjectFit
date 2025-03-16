using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Web.Http;

namespace ProjectFit.Controllers
{
    [Route("api/[controller]")]
    public class IAController : ApiController
    {
        private static readonly HttpClient _httpClient = new HttpClient();
        private readonly string _apiKey = "AIzaSyBd__GcL1-5dgPGipLefMZeCCeKj7nYJ7s";

        public async Task<string> GetAIBasedResultAsync(string searchText, string context)
        {
            string instructionText;

            if (context == "dieta")
            {
                instructionText = "Você é um nutricionista virtual. Gere um plano de dieta personalizado baseado nos dados fornecidos.";
            }
            else if (context == "treino")
            {
                instructionText = "Você é um personal trainer virtual. Gere um plano de treino curto (máx. 100 caracteres) baseado nos dados fornecidos.";
            }
            else
            {
                throw new ArgumentException("Contexto inválido. Use 'dieta' ou 'treino'.");
            }

            var requestData = new
            {
                model = "gemini-1.5-pro",
                system_instruction = new
                {
                    parts = new[] { new { text = instructionText } }
                },
                generation_config = new
                {
                    temperature = 0.7
                },
                contents = new[]
                {
                    new
                    {
                        role = "user",
                        parts = new[] { new { text = searchText } }
                    }
                }
            };

            var requestContent = new StringContent(JsonConvert.SerializeObject(requestData), Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync($"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key={_apiKey}", requestContent);

            if (!response.IsSuccessStatusCode)
            {
                var errorContent = await response.Content.ReadAsStringAsync();
                throw new Exception($"Erro na API Gemini: {errorContent}");
            }

            return await response.Content.ReadAsStringAsync();
        }
    }
}

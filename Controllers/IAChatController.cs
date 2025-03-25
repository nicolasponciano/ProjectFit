using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;
using Newtonsoft.Json;

namespace ProjectFit.Controllers
{
    [RoutePrefix("api/IAChat")]
    public class IAChatController : ApiController
    {
        private static readonly HttpClient _httpClient = new HttpClient();
        private readonly string _apiKey = "AIzaSyBd__GcL1-5dgPGipLefMZeCCeKj7nYJ7s";

        /// <summary>
        /// Processa uma mensagem de chat e retorna uma resposta.
        /// </summary>
        [HttpPost]
        [Route("GetChatResponse")] // Define a rota específica para este método
        public async Task<IHttpActionResult> GetChatResponse([FromBody] ChatRequest request)
        {
            if (string.IsNullOrWhiteSpace(request.Message))
            {
                return BadRequest("Mensagem inválida.");
            }

            try
            {
                // Constrói o prompt para a IA
                string instructionText = $@"
                Você é um assistente virtual especializado em dietas, treinos e preparos alimentares.
                Responda à seguinte pergunta de forma clara e objetiva:
                Pergunta: {request.Message}

                Se necessário, sugira links ou referências confiáveis.
                ";

                // Estrutura da solicitação para a API da IA
                var requestData = new
                {
                    model = "gemini-1.5-pro",
                    system_instruction = new
                    {
                        parts = new[] { new { text = instructionText } }
                    },
                    generation_config = new
                    {
                        temperature = 0.7,
                        max_output_tokens = 512
                    },
                    contents = new[]
                    {
                        new
                        {
                            role = "user",
                            parts = new[] { new { text = request.Message } }
                        }
                    }
                };

                // Envia a solicitação para a API da IA
                var response = await _httpClient.PostAsync(
                    $"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key={_apiKey}",
                    new StringContent(JsonConvert.SerializeObject(requestData), Encoding.UTF8, "application/json")
                );

                if (!response.IsSuccessStatusCode)
                {
                    var errorContent = await response.Content.ReadAsStringAsync();
                    throw new Exception($"Erro na API Gemini: {errorContent}");
                }

                var jsonResponse = await response.Content.ReadAsStringAsync();
                var responseObj = JsonConvert.DeserializeObject<ApiResponse>(jsonResponse);

                if (responseObj?.Candidates?.Length > 0)
                {
                    string botReply = responseObj.Candidates[0].Content.Parts[0].Text;
                    return Ok(new { reply = botReply });
                }
                else
                {
                    return Ok(new { reply = "Desculpe, não consegui entender sua pergunta." });
                }
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        // Classes auxiliares
        public class ChatRequest
        {
            public string Message { get; set; }
        }

        public class ApiResponse
        {
            public Candidate[] Candidates { get; set; }
        }

        public class Candidate
        {
            public Content Content { get; set; }
        }

        public class Content
        {
            public Part[] Parts { get; set; }
        }

        public class Part
        {
            public string Text { get; set; }
        }
    }
}
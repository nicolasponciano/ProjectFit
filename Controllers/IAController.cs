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
                instructionText = @"
                Você é um nutricionista especializado em planejamento dietético. 
                Gere um plano de dieta detalhado com as seguintes informações para cada refeição:
                - Dados físicos do usuário (idade, peso, altura)
                - Gênero e objetivo físico
                - Nome da refeição (ex: Café da Manhã)
                - Horário sugerido (ex: 07:00)
                - Lista de alimentos (itens separados por vírgula)
                - Calorias aproximadas (formato: XXXX kcal)
                - Dicas de preparo (curtas e objetivas)

                Formato obrigatório para cada linha:
                [Nome da Refeição] | [Horário] | [Alimentos] | [Calorias] | [Dicas de Preparo]

                Exemplo:
                Café da Manhã | 07:00 | Ovos mexidos, pão integral, suco de laranja | 350 kcal | Preparar os ovos com pouco óleo, usar pão integral

                Regras:
                1. Use o separador '|' para dividir as colunas
                2. Mantenha cada refeição em uma linha única
                3. Priorize alimentos comuns da região do usuário
                4. Inclua pelo menos 5 refeições diárias
                5. Destaque alimentos importantes em negrito usando **
                6. Não use markdown ou formatação complexa";
            }
            else if (context == "preparo")
            {
                instructionText = "Você é um chef nutricional. Gere dicas de preparo saudáveis em formato de acordo com os alimentos ou ordens especificadas<li>";
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

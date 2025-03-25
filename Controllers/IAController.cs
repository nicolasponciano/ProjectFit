using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;
using Newtonsoft.Json;
using ProjectFit.Models;

namespace ProjectFit.Controllers
{
    [Route("api/[controller]")]
    public class IAController : ApiController
    {
        private static readonly HttpClient _httpClient = new HttpClient();
        private readonly string _apiKey = "AIzaSyBd__GcL1-5dgPGipLefMZeCCeKj7nYJ7s";

        /// <summary>
        /// Gera um resultado personalizado com base no contexto (dieta, treino ou preparo).
        /// </summary>
        /// <param name="searchText">Respostas das perguntas da tela.</param>
        /// <param name="context">Contexto: "dieta", "treino" ou "preparo".</param>
        /// <param name="aluno">Dados do aluno para personalização.</param>
        /// <returns>Resposta formatada da IA.</returns>
        public async Task<string> GetAIBasedResultAsync(string searchText, string context, Aluno aluno)
        {
            if (string.IsNullOrWhiteSpace(context) || (context != "dieta" && context != "treino" && context != "preparo"))
            {
                throw new ArgumentException("Contexto inválido. Use 'dieta', 'treino' ou 'preparo'.");
            }

            // Constrói o prompt com base no contexto e nos dados do aluno
            string instructionText = ConstruirPrompt(context, aluno, searchText);

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
                    temperature = 0.7, // Controla a criatividade da resposta
                    max_output_tokens = 1024 // Limite de tokens na resposta
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

            // Envia a solicitação para a API da IA
            var requestContent = new StringContent(JsonConvert.SerializeObject(requestData), Encoding.UTF8, "application/json");
            var response = await _httpClient.PostAsync($"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key={_apiKey}", requestContent);

            if (!response.IsSuccessStatusCode)
            {
                var errorContent = await response.Content.ReadAsStringAsync();
                throw new Exception($"Erro na API Gemini: {errorContent}");
            }

            // Lê e processa a resposta da API
            var jsonResponse = await response.Content.ReadAsStringAsync();
            Console.WriteLine($"Resposta da API: {jsonResponse}"); // Log para depuração

            try
            {
                var responseObj = JsonConvert.DeserializeObject<ApiResponse>(jsonResponse);

                if (responseObj?.Candidates?.Length > 0)
                {
                    string resultadoGerado = responseObj.Candidates[0].Content.Parts[0].Text;

                    // Retorna o resultado com base no contexto
                    return resultadoGerado;
                }
                else
                {
                    throw new Exception("A IA não retornou nenhuma resposta válida.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Erro ao desserializar a resposta: {ex.Message}. Resposta recebida: {jsonResponse}");
            }
        }

        /// <summary>
        /// Constrói o prompt personalizado com base no contexto e nos dados do aluno.
        /// </summary>
        /// <param name="context">Contexto: "dieta", "treino" ou "preparo".</param>
        /// <param name="aluno">Dados do aluno.</param>
        /// <param name="searchText">Respostas das perguntas da tela.</param>
        /// <returns>Prompt formatado para a IA.</returns>
        private string ConstruirPrompt(string context, Aluno aluno, string searchText)
        {
            string prompt;

            if (context == "dieta")
            {
                prompt = $@"
                    Você é um nutricionista especializado em planejamento dietético.
                    Gere um plano de dieta detalhado com base nos seguintes dados do usuário:
                    - Nome: {aluno.Nome}
                    - Idade: {CalcularIdade(aluno.DataGravacao)} anos
                    - Peso: {aluno.Peso} kg
                    - Altura: {aluno.Altura} m
                    - IMC: {aluno.IMC}
                    - Objetivo: {aluno.Meta}
                    - Respostas do formulário: {searchText}
    
                    Para cada refeição, inclua as seguintes informações:
                    - Nome da refeição (ex: Café da Manhã)
                    - Horário sugerido (ex: 07:00)
                    - Lista de alimentos (itens separados por vírgula)
                    - Calorias aproximadas (formato: XXXX kcal)
                    - Dicas de preparo (curtas e objetivas)
                    - Links referenciais sobre os alimentos para consulta adicional. Utilize os seguintes sites confiáveis:
                      - https://alimentacaosaudavel.org.br
                      - https://www.tbca.net.br
                      - https://nutritionsource.hsph.harvard.edu
                      - https://www.bvsms.saude.gov.br
                      - https://www.sns24.gov.pt
                      - https://www.paho.org
                      - https://www.gov.br/saude
                      - https://www.tuasaude.com
    
                    Formato obrigatório para cada linha:
                    [Nome da Refeição] | [Horário] | [Alimentos] | [Calorias] | [Dicas de Preparo] | [Links Referenciais]
    
                    Regras:
                    1. Use o separador '|' para dividir as colunas.
                    2. Mantenha cada refeição em uma linha única.
                    3. Priorize alimentos comuns da região do usuário.
                    4. Inclua a quantidade de refeições que o usuário inserir.
                    5. Não use markdown ou formatação complexa.
                    ";
            }
            else if (context == "treino")
            {
                prompt = $@"
                Você é um personal trainer virtual.
                Gere um plano de treino detalhado com base nos seguintes dados do usuário:
                - Nome: {aluno.Nome}
                - Idade: {CalcularIdade(aluno.DataGravacao)} anos
                - Peso: {aluno.Peso} kg
                - Altura: {aluno.Altura} m
                - IMC: {aluno.IMC}
                - Objetivo: {aluno.Meta}
                - Respostas do formulário: {searchText}

                Inclua as seguintes informações para cada dia de treino:
                - Dia da semana (ex: Segunda-feira)
                - Exercício (ex: Supino Reto)
                - Séries x Repetições (ex: 3x10)
                - Tempo de descanso (ex: 60 segundos)
                - Equipamento necessário (ex: Halteres)
                - Grupo muscular trabalhado (ex: Peito)
                - Dicas de execução (curtas e objetivas)
                - Links referenciais sobre o exercício ou equipamento (formato: https://example.com/treinos/nome-do-exercicio)

                Exemplos de links confiáveis:
                - Supino Reto: https://www.musculacao.net/como-fazer-supino-reto/
                - Agachamento: https://www.dicasdetreino.com.br/agachamento-completo/
                - Flexão de Braço: https://www.treinomestre.com.br/como-fazer-flexao-de-bracos/
                - Halteres: https://www.todamateria.com.br/halteres/
                - Equipamentos: https://www.educacaofisica.com.br/musculacao-e-equipamentos/
                - Guia de Exercícios: https://www.treinomestre.com.br/guia-de-exercicios/

                Formato obrigatório para cada linha:
                [Dia da Semana] | [Exercício] | [Séries x Repetições] | [Descanso] | [Equipamento] | [Grupo Muscular] | [Dicas] | [Links Referenciais]

                Regras:
                1. Use o separador '|' para dividir as colunas
                2. Mantenha cada exercício em uma linha única
                3. Priorize exercícios adequados ao nível de experiência do usuário
                4. Inclua quantos treinos o usuário inserir
                5. Não use markdown ou formatação complexa
                ";
            }
            else if (context == "preparo")
            {
                prompt = $@"
                    Você é um chef especializado em nutrição saudável.
                    Gere dicas práticas de preparo para os alimentos especificados abaixo, priorizando métodos saudáveis e que preservem os nutrientes:
                    - Ingredientes: {searchText}

                    Para cada alimento, inclua as seguintes informações:
                    - Nome do alimento
                    - Método de preparo recomendado (ex: Cozinhe no vapor por 5 minutos para preservar os nutrientes)
                    - Benefícios nutricionais (ex: Rico em proteínas, fonte de fibras, antioxidantes naturais)
                    - Sugestão de combinação com outros alimentos (ex: Combine com azeite de oliva para melhor absorção de nutrientes)
                    - Links referenciais sobre o alimento e seus benefícios (formato: https://example.com/alimentos/nome-do-alimento)

                    Exemplos de links confiáveis:
                    - Ovos: https://pt.wikipedia.org/wiki/Ovo_(alimento)
                    - Tomate: https://pt.wikipedia.org/wiki/Tomate
                    - Café: https://pt.wikipedia.org/wiki/Caf%C3%A9
                    - Leite sem lactose: https://www.todamateria.com.br/leite-sem-lactose/
                    - Guia de alimentos: https://www.brasildefato.com.br/2022/09/27/guia-de-alimentos-naturais
                    - Métodos de preparo: https://www.treinomestre.com.br/metodos-saudaveis-de-preparo/

                    Formato obrigatório para cada linha:
                    [Nome do Alimento] | [Método de Preparo] | [Benefícios Nutricionais] | [Sugestão de Combinação] | [Links Referenciais]

                    Regras:
                    1. Use o separador '|' para dividir as colunas
                    2. Mantenha cada alimento em uma linha única
                    3. Priorize métodos que realcem o sabor e mantenham o valor nutricional
                    4. Não use markdown ou formatação complexa
                    ";
            }
            else
            {
                throw new ArgumentException("Contexto inválido. Use 'dieta', 'treino' ou 'preparo'.");
            }

            return prompt;
        }

        /// <summary>
        /// Calcula a idade do aluno com base na data de nascimento.
        /// </summary>
        /// <param name="dataNascimento">Data de nascimento do aluno.</param>
        /// <returns>Idade calculada.</returns>
        private int CalcularIdade(DateTime dataNascimento)
        {
            var hoje = DateTime.Today;
            var idade = hoje.Year - dataNascimento.Year;
            if (dataNascimento.Date > hoje.AddYears(-idade)) idade--;
            return idade;
        }


    }
}
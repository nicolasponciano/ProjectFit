using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Newtonsoft.Json;

namespace ProjectFit
{
    public partial class Treino : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Código para carregamento da página, se necessário
            if (Request.QueryString["treino"] != null)
            {
                // Recebe o treino enviado pela página anterior e exibe
                var treinoGerado = Request.QueryString["treino"];
                lblTreino.Text = treinoGerado; // Aqui, lblTreino é um Label que exibirá o treino gerado.
            }
        }

        // Método assíncrono, mas com retorno void
        protected async void btnSubmit_Click(object sender, EventArgs e)
        {
            // Criando o objeto com os dados do formulário
            var formData = new
            {
                trainingExperience = txtTrainingExperience.Text,
                trainingDays = txtTrainingDays.Text,
                trainingTime = txtTrainingTime.Text,
                trainingLevel = txtTrainingLevel.Text,
                injuries = txtInjuries.Text,
                limitations = txtLimitations.Text,
                healthConditions = txtHealthConditions.Text,
                activityLevel = txtActivityLevel.Text
            };

            // Convertendo para JSON
            var jsonData = JsonConvert.SerializeObject(formData);

            // Escapando as aspas duplas dentro do JSON para não quebrar
            var escapedJsonData = jsonData.Replace("\"", "\\\"");

            // Enviar para a API
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://localhost:7080/api/IA");//trocar api por controller 

                // Agora o conteúdo que será enviado é o JSON escapado
                var content = new StringContent($"\"{escapedJsonData}\"", Encoding.UTF8, "application/json");

                // Enviar a requisição POST
                var response = await client.PostAsync("", content);

                if (response.IsSuccessStatusCode)
                {
                    // Se a requisição for bem-sucedida
                    string responseData = await response.Content.ReadAsStringAsync();

                    // Extraindo o conteúdo do treino da resposta JSON
                    var apiResponse = JsonConvert.DeserializeObject<ApiResponse>(responseData);
                    var treinoGerado = apiResponse.Candidates[0].Content.Parts[0].Text;

                    // Exibe o treino diretamente na página
                    lblTreino.Text = treinoGerado;
                }
                else
                {
                    // Caso haja erro ao enviar
                    string errorResponse = await response.Content.ReadAsStringAsync();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Erro ao gerar treino: {errorResponse}');", true);
                }
            }
        }

    }

    // Classe para mapear a resposta da API
    public class ApiResponse
    {
        [JsonProperty("candidates")]
        public Candidate[] Candidates { get; set; }
    }

    public class Candidate
    {
        [JsonProperty("content")]
        public Content Content { get; set; }
    }

    public class Content
    {
        [JsonProperty("parts")]
        public Part[] Parts { get; set; }
    }

    public class Part
    {
        [JsonProperty("text")]
        public string Text { get; set; }
    }
}
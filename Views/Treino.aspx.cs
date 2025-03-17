using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using ProjectFit.Controllers;

namespace ProjectFit
{
    public partial class Treino : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["treino"] != null)
            {
                lblTreino.Text = Request.QueryString["treino"];
            }
        }

        protected async void btnSubmit_Click(object sender, EventArgs e)
        {
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

            string formattedText = $"Experiência: {formData.trainingExperience}, Dias: {formData.trainingDays}, Tempo: {formData.trainingTime}, " +
                                   $"Nível: {formData.trainingLevel}, Lesões: {formData.injuries}, Limitações: {formData.limitations}, " +
                                   $"Condições: {formData.healthConditions}, Atividade: {formData.activityLevel}.";

            var iaController = new IAController();
            try
            {
                var jsonResponse = await iaController.GetAIBasedResultAsync(formattedText, "treino");

                var responseObj = JsonConvert.DeserializeObject<ApiResponse>(jsonResponse);
                if (responseObj?.Candidates?.Length > 0)
                {
                    string treinoGerado = responseObj.Candidates[0].Content.Parts[0].Text;
                    lblTreino.Text = treinoGerado;
                }
                else
                {
                    lblTreino.Text = "Erro ao gerar o treino. Tente novamente.";
                }
            }
            catch (Exception ex)
            {
                lblTreino.Text = "Erro ao gerar o treino: " + ex.Message;
            }
        }

    }

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

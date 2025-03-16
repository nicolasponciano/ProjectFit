using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Ajax.Utilities;
using Newtonsoft.Json;
using ProjectFit.Controllers;

namespace ProjectFit
{
    public partial class Dieta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["dieta"] != null)
            {
                lblDieta.Text = Request.QueryString["dieta"]; // Exibir dieta gerada
            }
        }

        protected async void btnSubmit_Click(object sender, EventArgs e)
        {
            var formData = new
            {
                objetivo = ddlObjetivo.SelectedValue,
                refeicoes = txtRefeicoes.Text,
                restricoes = txtRestricoes.Text,
                agua = txtAgua.Text,
                fastFood = ddlFastFood.SelectedValue,
                preferencias = ddlPreferencias.SelectedValue,
                rotina = txtRotina.Text,
                alimentosEvitados = txtAlimentosEvitados.Text
            };

            string formattedText = $"Objetivo: {formData.objetivo}, Refeições: {formData.refeicoes}, " +
                                   $"Restrições: {formData.restricoes}, Água: {formData.agua}, " +
                                   $"FastFood: {formData.fastFood}, Preferências: {formData.preferencias}, " +
                                   $"Rotina: {formData.rotina}, Alimentos evitados: {formData.alimentosEvitados}.";

            var iaController = new IAController();
            try
            {
                var result = await iaController.GetAIBasedResultAsync(formattedText, "dieta");

                var responseObj = JsonConvert.DeserializeObject<ApiResponse>(result);
                if (responseObj?.Candidates?.Length > 0)
                {
                    string dietaGerado = responseObj.Candidates[0].Content.Parts[0].Text;
                    lblDieta.Text = dietaGerado;
                }
                else
                {
                    lblDieta.Text = "Erro ao gerar o treino. Tente novamente.";
                }

            }
            catch (Exception ex)
            {
                lblDieta.Text = "Erro ao gerar a dieta: " + ex.Message;
            }
        }

    }
}

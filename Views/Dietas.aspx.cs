using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web.UI;
using Newtonsoft.Json;
using ProjectFit.Controllers;
using ProjectFit.Models;

namespace ProjectFit
{
    public partial class Dietas : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Mantém a página sempre com o UpdatePanel ativo
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
                    string dietaGerada = responseObj.Candidates[0].Content.Parts[0].Text;
                    var refeicoes = ProcessarRespostaDieta(dietaGerada);

                    using (var db = new ApplicationDbContext())
                    {
                        var aluno = db.Alunos.FirstOrDefault(a => a.ApplicationUser.Id == CurrentUserId);

                        if (aluno == null)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Complete seu perfil primeiro!');", true);
                            return;
                        }

                        foreach (var refeicao in refeicoes)
                        {
                            var dieta = new Dieta
                            {
                                AlunoId = aluno.Id_Aluno,
                                Refeicao = refeicao.Refeicao,
                                Horario = refeicao.Horario,
                                Alimentos = refeicao.Alimentos,
                                Calorias = refeicao.Calorias,
                                Observacoes = refeicao.Observacoes
                            };

                            db.Dietas.Add(dieta);
                        }

                        await db.SaveChangesAsync();
                        ClientScript.RegisterStartupScript(this.GetType(), "success", "alert('Dieta salva com sucesso!');", true);
                    }

                    gridDieta.DataSource = refeicoes;
                    gridDieta.DataBind();
                }
                else
                {
                    gridDieta.DataSource = new List<RefeicaoDieta> { new RefeicaoDieta {
                        Refeicao = "Erro",
                        Alimentos = "Não foi possível gerar a dieta",
                        Observacoes = "Tente novamente"
                    }};
                    gridDieta.DataBind();
                }
            }
            catch (Exception ex)
            {
                gridDieta.DataSource = new List<RefeicaoDieta> { new RefeicaoDieta {
                    Refeicao = "Erro",
                    Alimentos = ex.Message,
                    Observacoes = "Contate o suporte"
                }};
                gridDieta.DataBind();
            }
        }

        private List<RefeicaoDieta> ProcessarRespostaDieta(string resposta)
        {
            var refeicoes = new List<RefeicaoDieta>();
            var linhas = resposta.Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var linha in linhas)
            {
                var partes = linha.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries);

                if (partes.Length >= 5)
                {
                    refeicoes.Add(new RefeicaoDieta
                    {
                        Refeicao = partes[0].Trim(),
                        Horario = partes[1].Trim(),
                        Alimentos = partes[2].Trim().Replace("**", ""),
                        Calorias = partes[3].Trim(),
                        Observacoes = partes[4].Trim()
                    });
                }
            }
            return refeicoes;
        }

        private async Task<string> GerarObservacoesAutomaticas(RefeicaoDieta refeicao)
        {
            var iaController = new IAController();
            string prompt = $"Gere 2 dicas práticas de preparo para: {refeicao.Refeicao}.\n" +
                           $"Ingredientes: {refeicao.Alimentos.Replace("<strong>", "").Replace("</strong>", "")}\n" +
                           "Regras:\n" +
                           "- Máximo 40 palavras\n" +
                           "- Formato: <li>[dica]</li>\n" +
                           "Exemplo:\n" +
                           "<li>Cozinhe os ovos em fogo médio</li>";

            try
            {
                var result = await iaController.GetAIBasedResultAsync(prompt, "preparo");
                var responseObj = JsonConvert.DeserializeObject<ApiResponse>(result);

                if (responseObj?.Candidates?.Length > 0)
                {
                    var dicas = responseObj.Candidates[0].Content.Parts[0].Text
                        .Replace("*", "")
                        .Replace("<li>", "")
                        .Replace("</li>", "")
                        .Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);

                    return string.Join("", dicas.Select(d => $"<li>{d.Trim()}</li>"));
                }
            }
            catch
            {
                return GerarDicasFallback(refeicao.Refeicao);
            }
            return GerarDicasFallback(refeicao.Refeicao);
        }

        private string GerarDicasFallback(string refeicao)
        {
            var refLower = refeicao.ToLower();

            if (refLower.Contains("café") || refLower.Contains("cafe"))
            {
                return "<ul class='dicas-lista'><li>Utilize métodos de cocção com pouca gordura</li><li>Prefira alimentos integrais</li></ul>";
            }
            else if (refLower.Contains("almoço") || refLower.Contains("almoco"))
            {
                return "<ul class='dicas-lista'><li>Cozinhe os vegetais no vapor</li><li>Controle o tempo de cocção</li></ul>";
            }
            else if (refLower.Contains("jantar"))
            {
                return "<ul class='dicas-lista'><li>Reduza o uso de sal</li><li>Utilize ervas para temperar</li></ul>";
            }
            else
            {
                return "<ul class='dicas-lista'><li>Mantenha porções equilibradas</li><li>Higienize bem os alimentos</li></ul>";
            }
        }

        public class RefeicaoDieta
        {
            public string Refeicao { get; set; }
            public string Horario { get; set; }
            public string Alimentos { get; set; }
            public string Calorias { get; set; }
            public string Observacoes { get; set; }
        }

        public class ApiResponse
        {
            public Candidate[] Candidates { get; set; }

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
}
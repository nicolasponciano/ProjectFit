using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text.RegularExpressions;
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
            if (IsPostBack)
            {
                // Registra o script para ocultar a tela de carregamento após o postback
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideLoading", "hideGlobalLoading();", true);
            }
        }

        private bool ValidarCampos()
        {
            if (string.IsNullOrWhiteSpace(ddlObjetivo.SelectedValue))
            {
                ExibirMensagem("O campo 'Objetivo' é obrigatório.", "error");
                return false;
            }

            if (!int.TryParse(txtRefeicoes.Text, out int refeicoes) || refeicoes <= 0 || refeicoes > 10)
            {
                ExibirMensagem("O campo 'Refeições por dia' deve ser um número entre 1 e 10.", "error");
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtRestricoes.Text))
            {
                ExibirMensagem("O campo 'Restrições Alimentares' é obrigatório.", "error");
                return false;
            }

            if (!double.TryParse(txtAgua.Text, out double agua) || agua <= 0)
            {
                ExibirMensagem("O campo 'Ingestão de Água' deve ser um valor positivo.", "error");
                return false;
            }

            return true;
        }

        protected async void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!ValidarCampos())
            {
                return;
            }

            var aluno = ObterAlunoLogado();
            if (aluno == null)
            {
                ExibirMensagem("Complete seu perfil primeiro!", "error");
                return;
            }

            var formData = new
            {
                objetivo = ddlObjetivo.SelectedValue,
                refeicoesPorDia = txtRefeicoes.Text,
                restricoes = txtRestricoes.Text,
                agua = txtAgua.Text,
                fastFood = ddlFastFood.SelectedValue,
                preferencias = ddlPreferencias.SelectedValue,
                rotina = txtRotina.Text,
                alimentosEvitados = txtAlimentosEvitados.Text
            };

            string formattedText = $"Objetivo: {formData.objetivo}, Refeições: {formData.refeicoesPorDia}, " +
                                   $"Restrições: {formData.restricoes}, Água: {formData.agua}, " +
                                   $"FastFood: {formData.fastFood}, Preferências: {formData.preferencias}, " +
                                   $"Rotina: {formData.rotina}, Alimentos evitados: {formData.alimentosEvitados}.";

            var iaController = new IAController();
            try
            {
                var jsonResponse = await iaController.GetAIBasedResultAsync(formattedText, "dieta", aluno);
                var responseObj = JsonConvert.DeserializeObject<ApiResponse>(jsonResponse);

                if (responseObj?.Candidates?.Length > 0)
                {
                    string dietaGerada = responseObj.Candidates[0].Content.Parts[0].Text;
                    var refeicoes = ProcessarRespostaDieta(dietaGerada);

                    using (var db = new ApplicationDbContext())
                    {
                        foreach (var refeicao in refeicoes)
                        {
                            var dieta = new Dieta
                            {
                                AlunoIdDieta = aluno.Id_Aluno,
                                Refeicao = refeicao.Refeicao,
                                Horario = refeicao.Horario,
                                Alimentos = refeicao.Alimentos,
                                Calorias = refeicao.Calorias,
                                Observacoes = refeicao.Observacoes,
                                LinksReferenciaisDieta = refeicao.LinksReferenciais,
                                DataRegistro = DateTime.Now
                            };

                            db.Dietas.Add(dieta);
                        }

                        await db.SaveChangesAsync();
                        ExibirMensagem("Dieta salva com sucesso!", "success");
                    }

                    gridDieta.DataSource = refeicoes;
                    gridDieta.DataBind();
                }
                else
                {
                    ExibirMensagem("Erro ao gerar a dieta. Tente novamente.", "error");
                }
            }
            catch (Exception ex)
            {
                ExibirMensagem($"Erro ao gerar a dieta: {ex.Message}", "error");
            }
        }

        private Aluno ObterAlunoLogado()
        {
            using (var db = new ApplicationDbContext())
            {
                return db.Alunos.FirstOrDefault(a => a.UserId == CurrentUserId);
            }
        }

        private List<RefeicaoDieta> ProcessarRespostaDieta(string resposta)
        {
            var refeicoesList = new List<RefeicaoDieta>();
            var linhas = resposta.Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var linha in linhas)
            {
                var partes = linha.Split('|');
                if (partes.Length == 6) // Formato esperado: [Refeição]| [Horário]| [Alimentos]| [Calorias]| [Dicas]| [Links]
                {
                    string linksRaw = partes[5].Trim();
                    var linksValidos = ExtrairLinksValidos(linksRaw);

                    refeicoesList.Add(new RefeicaoDieta
                    {
                        Refeicao = partes[0].Trim(),
                        Horario = partes[1].Trim(),
                        Alimentos = partes[2].Trim(),
                        Calorias = partes[3].Trim(),
                        Observacoes = partes[4].Trim(),
                        LinksReferenciais = string.Join(", ", linksValidos) // Salva os links válidos
                    });
                }
            }

            return refeicoesList;
        }

        // Método para extrair e validar links
        private List<string> ExtrairLinksValidos(string input)
        {
            var links = new List<string>();
            var regex = new Regex(@"https?:\/\/[^\s]+");

            var matches = regex.Matches(input);
            foreach (Match match in matches)
            {
                var link = match.Value.TrimEnd(',', '.', ';', ')'); // Remove caracteres indesejados no final
                if (Uri.IsWellFormedUriString(link, UriKind.Absolute))
                {
                    links.Add(link);
                }
            }

            return links;
        }

        protected string FormatLinks(string links)
        {
            if (string.IsNullOrEmpty(links))
            {
                return "Nenhum link disponível";
            }

            var linkArray = links.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            var formattedLinks = new List<string>();

            foreach (var link in linkArray)
            {
                var trimmedLink = link.Trim();
                if (Uri.IsWellFormedUriString(trimmedLink, UriKind.Absolute))
                {
                    formattedLinks.Add($"<a href='{trimmedLink}' target='_blank'>'{trimmedLink}'</a>");
                }
            }

            return string.Join(", ", formattedLinks);
        }

    }

    public class RefeicaoDieta
    {
        public string Refeicao { get; set; }
        public string Horario { get; set; }
        public string Alimentos { get; set; }
        public string Calorias { get; set; }
        public string Observacoes { get; set; }
        public string LinksReferenciais { get; set; }
    }
}
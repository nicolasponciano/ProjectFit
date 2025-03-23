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
    public partial class Treinos : BasePage
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
            if (string.IsNullOrWhiteSpace(txtTrainingExperience.Text))
            {
                ExibirMensagem("O campo 'Experiência de Treino' é obrigatório.", "error");
                return false;
            }

            if (!int.TryParse(txtTrainingDays.Text, out int trainingDays) || trainingDays <= 0 || trainingDays > 7)
            {
                ExibirMensagem("O campo 'Dias de Treino' deve ser um número entre 1 e 7.", "error");
                return false;
            }

            if (!TimeSpan.TryParse(txtTrainingTime.Text, out _))
            {
                ExibirMensagem("O campo 'Tempo de Treino' deve estar no formato HH:mm.", "error");
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtTrainingLevel.SelectedValue))
            {
                ExibirMensagem("O campo 'Nível de Treino' é obrigatório.", "error");
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
                trainingExperience = txtTrainingExperience.Text,
                trainingDays = txtTrainingDays.Text,
                trainingTime = txtTrainingTime.Text,
                trainingLevel = txtTrainingLevel.SelectedValue,
                injuries = txtInjuries.Text,
                limitations = txtLimitations.Text,
                healthConditions = txtHealthConditions.Text,
                activityLevel = txtActivityLevel.SelectedValue
            };

            string formattedText = $"Experiência: {formData.trainingExperience}, Dias: {formData.trainingDays}, Tempo: {formData.trainingTime}, " +
                                   $"Nível: {formData.trainingLevel}, Lesões: {formData.injuries}, Limitações: {formData.limitations}, " +
                                   $"Condições: {formData.healthConditions}, Atividade: {formData.activityLevel}.";

            var iaController = new IAController();
            try
            {
                var jsonResponse = await iaController.GetAIBasedResultAsync(formattedText, "treino", aluno);
                var responseObj = JsonConvert.DeserializeObject<ApiResponse>(jsonResponse);

                if (responseObj?.Candidates?.Length > 0)
                {
                    string treinoGerado = responseObj.Candidates[0].Content.Parts[0].Text;
                    var treinoList = ProcessarRespostaTreino(treinoGerado, aluno.Id_Aluno);

                    using (var db = new ApplicationDbContext())
                    {
                        foreach (var itemTreino in treinoList)
                        {
                            var treinoDb = new Treino
                            {
                                AlunoIdTreino = itemTreino.AlunoIdTreino,
                                DiaTreino = itemTreino.DiaTreino,
                                Exercicio = itemTreino.Exercicio,
                                SeriesRepeticoes = itemTreino.SeriesRepeticoes,
                                Descanso = itemTreino.Descanso,
                                Equipamento = itemTreino.Equipamento,
                                GrupoMuscular = itemTreino.GrupoMuscular,
                                Dicas = itemTreino.Dicas,
                                LinksReferenciaisTreino = itemTreino.LinksReferenciaisTreino,
                                DataCriacao = itemTreino.DataCriacao
                            };
                            db.Treinos.Add(treinoDb);
                        }
                        await db.SaveChangesAsync();
                    }

                    ExibirMensagem("Treino salvo com sucesso!", "success");
                    gridTreino.DataSource = treinoList;
                    gridTreino.DataBind();
                }
                else
                {
                    ExibirMensagem("Erro ao gerar o treino. Tente novamente.", "error");
                }
            }
            catch (Exception ex)
            {
                ExibirMensagem($"Erro ao gerar o treino: {ex.Message}", "error");
            }
        }

        private Aluno ObterAlunoLogado()
        {
            using (var db = new ApplicationDbContext())
            {
                return db.Alunos.FirstOrDefault(a => a.UserId == CurrentUserId);
            }
        }

        private List<ItemTreino> ProcessarRespostaTreino(string resposta, int alunoId)
        {
            var treinoList = new List<ItemTreino>();
            var linhas = resposta.Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var linha in linhas)
            {
                var partes = linha.Split('|');
                if (partes.Length == 8) // Formato esperado: [DiaTreino]| [Exercicio]| [SeriesRepeticoes]| [Descanso]| [Equipamento]| [GrupoMuscular]| [Dicas]| [LinksReferenciais]
                {
                    var linksValidos = ExtrairLinksValidos(partes[7].Trim());

                    treinoList.Add(new ItemTreino
                    {
                        AlunoIdTreino = alunoId,
                        DiaTreino = partes[0].Trim(),
                        Exercicio = partes[1].Trim(),
                        SeriesRepeticoes = partes[2].Trim(),
                        Descanso = partes[3].Trim(),
                        Equipamento = partes[4].Trim(),
                        GrupoMuscular = partes[5].Trim(),
                        Dicas = partes[6].Trim(),
                        LinksReferenciaisTreino = string.Join(", ", linksValidos), // Salva os links válidos
                        DataCriacao = DateTime.Now
                    });
                }
            }

            return treinoList;
        }

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

    public class ItemTreino
    {
        public int Id { get; set; }
        public int AlunoIdTreino { get; set; }
        public string DiaTreino { get; set; }
        public string Exercicio { get; set; }
        public string SeriesRepeticoes { get; set; }
        public string Descanso { get; set; }
        public string Equipamento { get; set; }
        public string GrupoMuscular { get; set; }
        public string Dicas { get; set; }
        public string LinksReferenciaisTreino { get; set; }
        
        public DateTime DataCriacao { get; set; }
    }
}
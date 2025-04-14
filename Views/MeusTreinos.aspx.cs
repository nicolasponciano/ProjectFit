using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProjectFit.Models;

namespace ProjectFit.Views
{
    public partial class MeusTreinos : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CarregarTreinos();
            }
        }

        protected void btnAnterior_Click(object sender, EventArgs e)
        {
            int paginaAtual = (int)ViewState["PaginaAtual"];
            if (paginaAtual > 1)
            {
                CarregarTreinos(paginaAtual - 1);
            }
        }

        protected void btnProximo_Click(object sender, EventArgs e)
        {
            int paginaAtual = (int)ViewState["PaginaAtual"];
            int totalPaginas = (int)ViewState["TotalPaginas"];
            if (paginaAtual < totalPaginas)
            {
                CarregarTreinos(paginaAtual + 1);
            }
        }

        protected void RptTreinos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var gridTreinos = (GridView)e.Item.FindControl("gridMeusTreinos");
                var treinoViewModel = e.Item.DataItem as TreinoViewModel;
                if (treinoViewModel == null) return;

                var exercicios = treinoViewModel.Exercicios;
                gridTreinos.DataSource = exercicios;
                gridTreinos.DataBind();
            }
        }

        private void CarregarTreinos(int pagina = 1, int itensPorPagina = 3)
        {
            var alunoLogado = ObterAlunoLogado();
            if (alunoLogado == null)
            {
                ExibirMensagem("Erro ao carregar o perfil do aluno.", "error");
                return;
            }

            using (var db = new ApplicationDbContext())
            {
                var treinosAgrupados = db.Treinos
                    .Where(t => t.AlunoIdTreino == alunoLogado.Id_Aluno)
                    .GroupBy(t => t.NumeroTreino)
                    .Select(g => new TreinoViewModel
                    {
                        NumeroTreino = g.Key,
                        Exercicios = g.Select(t => new ExercicioViewModel
                        {
                            Id_Treino = t.TreinoId,
                            DiaTreino = t.DiaTreino,
                            Exercicio = t.Exercicio,
                            SeriesRepeticoes = t.SeriesRepeticoes,
                            Descanso = t.Descanso,
                            Equipamento = t.Equipamento,
                            GrupoMuscular = t.GrupoMuscular,
                            Dicas = t.Dicas,
                            LinksReferenciaisTreino = t.LinksReferenciaisTreino,
                            DataRegistro = t.DataCriacao
                        }).ToList()
                    })
                    .OrderByDescending(g => g.NumeroTreino)
                    .Skip((pagina - 1) * itensPorPagina)
                    .Take(itensPorPagina)
                    .ToList();

                int totalTreinos = db.Treinos
                    .Where(t => t.AlunoIdTreino == alunoLogado.Id_Aluno)
                    .Select(t => t.NumeroTreino)
                    .Distinct()
                    .Count();
                int totalPaginas = (int)Math.Ceiling(totalTreinos / (double)itensPorPagina);

                ViewState["TotalPaginas"] = totalPaginas;
                ViewState["PaginaAtual"] = pagina;

                RptTreinos.DataSource = treinosAgrupados;
                RptTreinos.DataBind();
            }
        }

        protected void btnExcluir_Click(object sender, EventArgs e)
        {
            var btnExcluir = (Button)sender;
            var treinoId = Convert.ToInt32(btnExcluir.CommandArgument);

            using (var db = new ApplicationDbContext())
            {
                var treino = db.Treinos.FirstOrDefault(t => t.TreinoId == treinoId);
                if (treino != null)
                {
                    db.Treinos.Remove(treino);
                    db.SaveChanges();
                    CarregarTreinos();
                    ExibirMensagem("Treino excluído com sucesso!", "success");
                }
                else
                {
                    ExibirMensagem("Erro ao excluir o treino.", "error");
                }
            }
        }
        protected void btnEditar_Click(object sender, EventArgs e)
        {
            EditarTreinoControl.Visible = true;

            var btnEditar = (Button)sender;
            var treinoId = Convert.ToInt32(btnEditar.CommandArgument);

            // Configura o ID do treino no controle de edição
            EditarTreinoControl.TreinoId = treinoId;
            EditarTreinoControl.Visible = true;

            // Força o carregamento dos dados
            EditarTreinoControl.CarregarDados();

            // Abre o modal via JavaScript
            ScriptManager.RegisterStartupScript(this, GetType(), "openModal", @"
            setTimeout(function() {
          $('#modalEditar').modal('show');
            }, 100); // Atraso de 100ms para garantir que os dados sejam carregados
            ", true);
        }
        protected void btnExcluirGrid_Click(object sender, EventArgs e)
        {
            var btnExcluirGrid = (Button)sender;
            var NumeroTreino = Convert.ToInt32(btnExcluirGrid.CommandArgument);

            using (var db = new ApplicationDbContext())
            {

                var treinos = db.Treinos.Where(d => d.NumeroTreino == NumeroTreino).ToList();

                if (treinos.Any())
                {
                    // Remove todas as dietas encontradas
                    db.Treinos.RemoveRange(treinos);
                    db.SaveChanges();
                    CarregarTreinos(); // Recarrega os dados após a exclusão
                    ExibirMensagem("Todas os treinos foram excluídas com sucesso!", "success");
                }
                else
                {
                    ExibirMensagem("Nenhum treino encontrada para exclusão.", "error");
                }
            }
        }
        protected void btnExportarPdf_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            string numeroTreino = btn.CommandArgument; // Obtém o número do treino
            var aluno = ObterAlunoLogado();

            if (aluno == null)
            {
                ExibirMensagem("Erro ao carregar perfil do usuário.", "error");
                return;
            }

            // Gera o HTML do treino
            string htmlContent = GerarHtmlDoTreino(numeroTreino, aluno.Id_Aluno);
            string nomeArquivo = $"Treino_{numeroTreino}.pdf";

            // Configura o conversor de HTML para PDF
            var converter = new SelectPdf.HtmlToPdf();
            converter.Options.PdfPageSize = SelectPdf.PdfPageSize.A4;
            converter.Options.MarginTop = 20;
            converter.Options.MarginBottom = 20;
            converter.Options.MarginLeft = 20;
            converter.Options.MarginRight = 20;

            // Converte o HTML em PDF
            var pdfDocument = converter.ConvertHtmlString(htmlContent);

            // Retorna o PDF ao navegador
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", $"attachment;filename={nomeArquivo}");
            pdfDocument.Save(Response.OutputStream);
            Response.End();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideLoading",
        "if (window.parent.hideGlobalLoading) window.parent.hideGlobalLoading();", true);
        }

        private string GerarHtmlDoTreino(string numeroTreino, int alunoId)
        {
            // Busca TODOS os exercícios do treino pelo número e ID do aluno
            int numero = Convert.ToInt32(numeroTreino);
            if (numero <= 0)
                return "<h3>Nenhum exercício encontrado para este treino.</h3>";

            using (var db = new ApplicationDbContext())
            {
                var treinos = db.Treinos
                    .Where(t => t.NumeroTreino == numero && t.AlunoIdTreino == alunoId)
                    .ToList();

                if (!treinos.Any())
                    return "<h3>Nenhum exercício encontrado para este treino.</h3>";

                // Monta o HTML
                StringBuilder html = new StringBuilder();
                html.Append("<html><head>");
                html.Append("<style>");
                html.Append("body { font-family: 'Arial'; margin: 20px; }");
                html.Append("h2 { color: #2C3E50; }");
                html.Append("table { width: 100%; border-collapse: collapse; margin-top: 20px; }");
                html.Append("th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }");
                html.Append("th { background-color: #2C3E50; color: white; }");
                html.Append("</style></head><body>");

                html.Append($"<h2>Treino #{numeroTreino}</h2>");
                html.Append("<table>");
                html.Append("<tr>");
                html.Append("<th>Dia do Treino</th>");
                html.Append("<th>Exercício</th>");
                html.Append("<th>Séries x Repetições</th>");
                html.Append("<th>Descanso</th>");
                html.Append("<th>Equipamento</th>");
                html.Append("<th>Grupo Muscular</th>");
                html.Append("<th>Dicas</th>");
                html.Append("</tr>");

                foreach (var treino in treinos)
                {
                    html.Append("<tr>");
                    html.Append($"<td>{treino.DiaTreino}</td>");
                    html.Append($"<td>{treino.Exercicio}</td>");
                    html.Append($"<td>{treino.SeriesRepeticoes}</td>");
                    html.Append($"<td>{treino.Descanso}</td>");
                    html.Append($"<td>{treino.Equipamento}</td>");
                    html.Append($"<td>{treino.GrupoMuscular}</td>");
                    html.Append($"<td>{treino.Dicas}</td>");
                    html.Append("</tr>");
                }

                html.Append("</table></body></html>");
                return html.ToString();
            }
        }

        public class TreinoViewModel
        {
            public int NumeroTreino { get; set; }
            public List<ExercicioViewModel> Exercicios { get; set; } = new List<ExercicioViewModel>();
        }

        public class ExercicioViewModel
        {
            public int Id_Treino { get; set; }
            public string DiaTreino { get; set; }
            public string Exercicio { get; set; }
            public string SeriesRepeticoes { get; set; }
            public string Descanso { get; set; }
            public string Equipamento { get; set; }
            public string GrupoMuscular { get; set; }
            public string Dicas { get; set; }
            public string LinksReferenciaisTreino { get; set; }
            public DateTime DataRegistro { get; set; }
        }

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProjectFit.Models;
using SelectPdf;

namespace ProjectFit.Views
{
    public partial class MinhasDietas : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CarregarDietas();
            }
        }

        protected void btnAnterior_Click(object sender, EventArgs e)
        {
            int paginaAtual = (int)ViewState["PaginaAtual"];
            if (paginaAtual > 1)
            {
                CarregarDietas(paginaAtual - 1);
            }
        }

        protected void btnProximo_Click(object sender, EventArgs e)
        {
            int paginaAtual = (int)ViewState["PaginaAtual"];
            int totalPaginas = (int)ViewState["TotalPaginas"];
            if (paginaAtual < totalPaginas)
            {
                CarregarDietas(paginaAtual + 1);
            }
        }

        protected void RptDietas_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var gridDietas = (GridView)e.Item.FindControl("gridMinhasDietas");

                // Recupera os dados do grupo atual
                var dataItem = e.Item.DataItem;
                Console.WriteLine($"Tipo de DataItem: {dataItem?.GetType().FullName}");

                var dietaViewModel = dataItem as DietaViewModel;
                if (dietaViewModel == null)
                {
                    Console.WriteLine("Erro ao converter DataItem para DietaViewModel.");
                    return;
                }

                var dietas = dietaViewModel.Dietas;
                Console.WriteLine($"Número da Dieta: {dietaViewModel.NumeroDieta}");
                Console.WriteLine($"Quantidade de refeições na dieta: {dietas?.Count ?? 0}");

                // Verifica se há refeições para exibir
                if (dietas == null || !dietas.Any())
                {
                    Console.WriteLine("Erro: Nenhuma refeição encontrada para esta dieta.");
                }
                else
                {
                    Console.WriteLine($"Refeições encontradas: {string.Join(", ", dietas.Select(d => d.Refeicao))}");
                }

                // Vincula os dados ao GridView
                gridDietas.DataSource = dietas;
                gridDietas.DataBind();
            }
        }

        private void CarregarDietas(int pagina = 1, int itensPorPagina = 3)
        {
            var alunoLogado = ObterAlunoLogado();
            if (alunoLogado == null)
            {
                ExibirMensagem("Erro ao carregar o perfil do aluno.", "error");
                return;
            }

            using (var db = new ApplicationDbContext())
            {
                // Agrupa as dietas pelo número da dieta
                var dietasAgrupadas = db.Dietas
                    .Where(d => d.AlunoIdDieta == alunoLogado.Id_Aluno)
                    .GroupBy(d => d.NumeroDieta)
                    .Select(g => new DietaViewModel
                    {
                        NumeroDieta = g.Key,
                        Dietas = g.Select(d => new RefeicaoViewModel
                        {
                            Id_Dieta = d.DietaId,
                            Refeicao = d.Refeicao,
                            Horario = d.Horario,
                            Alimentos = d.Alimentos,
                            Calorias = d.Calorias,
                            Observacoes = d.Observacoes,
                            LinksReferenciais = d.LinksReferenciaisDieta,
                            DataRegistro = d.DataRegistro
                        }).ToList()
                    })
                    .OrderByDescending(g => g.NumeroDieta) // Ordena por número de dieta descendente
                    .Skip((pagina - 1) * itensPorPagina) // Pula as páginas anteriores
                    .Take(itensPorPagina) // Limita a quantidade de grids por página
                    .ToList(); // Materializa a consulta

                // Calcula o total de páginas
                int totalDietas = db.Dietas
                    .Where(d => d.AlunoIdDieta == alunoLogado.Id_Aluno)
                    .Select(d => d.NumeroDieta)
                    .Distinct()
                    .Count();
                int totalPaginas = (int)Math.Ceiling(totalDietas / (double)itensPorPagina);

                // Armazena os dados em ViewState para uso posterior
                ViewState["TotalPaginas"] = totalPaginas;
                ViewState["PaginaAtual"] = pagina;

                // Vincula os dados ao Repeater
                RptDietas.DataSource = dietasAgrupadas;
                RptDietas.DataBind();

                foreach (var dieta in dietasAgrupadas)
                {
                    Console.WriteLine($"Número da Dieta: {dieta.NumeroDieta}");
                    foreach (var refeicao in dieta.Dietas)
                    {
                        Console.WriteLine($"- Refeição: {refeicao.Refeicao}, Alimentos: {refeicao.Alimentos}");
                    }
                }

            }
        }

        protected void btnExcluir_Click(object sender, EventArgs e)
        {
            var btnExcluir = (Button)sender;
            var dietaId = Convert.ToInt32(btnExcluir.CommandArgument);

            using (var db = new ApplicationDbContext())
            {
                var dieta = db.Dietas.FirstOrDefault(d => d.DietaId == dietaId);
                if (dieta != null)
                {
                    db.Dietas.Remove(dieta);
                    db.SaveChanges();
                    CarregarDietas(); // Recarrega os dados após a exclusão
                    ExibirMensagem("Dieta excluída com sucesso!", "success");
                }
                else
                {
                    ExibirMensagem("Erro ao excluir a dieta.", "error");
                }
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            EditarDietaControl.Visible = true;

            var btnEditar = (Button)sender;
            var dietaId = Convert.ToInt32(btnEditar.CommandArgument);

            // Configura o ID da dieta no controle de edição
            EditarDietaControl.DietaId = dietaId;
            EditarDietaControl.Visible = true;

            // Força o carregamento dos dados
            EditarDietaControl.CarregarDados();

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
            var numeroDieta = Convert.ToInt32(btnExcluirGrid.CommandArgument);

            using (var db = new ApplicationDbContext())
            {
                // Encontra todas as dietas com o mesmo NumeroDieta
                var dietas = db.Dietas.Where(d => d.NumeroDieta == numeroDieta).ToList();

                if (dietas.Any())
                {
                    // Remove todas as dietas encontradas
                    db.Dietas.RemoveRange(dietas);
                    db.SaveChanges();
                    CarregarDietas(); // Recarrega os dados após a exclusão
                    ExibirMensagem("Todas as refeições desta dieta foram excluídas com sucesso!", "success");
                }
                else
                {
                    ExibirMensagem("Nenhuma dieta encontrada para exclusão.", "error");
                }
            }
        }


        protected void btnExportarPdf_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            string numeroDieta = btn.CommandArgument;
            var aluno = ObterAlunoLogado();

            if (aluno == null)
            {
                ExibirMensagem("Erro ao carregar perfil do aluno.", "error");
                return;
            }

            // Gera o HTML da dieta
            string htmlContent = GerarHtmlDaDieta(numeroDieta, aluno.Id_Aluno);
            string nomeArquivo = $"Dieta_{numeroDieta}.pdf";

            // Configura o conversor de HTML para PDF
            var converter = new HtmlToPdf();
            converter.Options.PdfPageSize = PdfPageSize.A4;
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

        private string GerarHtmlDaDieta(string numeroDieta, int alunoId)
        {
            // Busca TODAS as refeições da dieta pelo número e ID do aluno
            int numero = Convert.ToInt32(numeroDieta);
            if (numero <= 0)
                return "<h3>Nenhuma refeição encontrada para esta dieta.</h3>";

            using (var db = new ApplicationDbContext())
            {
                var refeicoes = db.Dietas
                    .Where(d => d.NumeroDieta == numero && d.AlunoIdDieta == alunoId)
                    .OrderBy(d => d.Horario) // Ordena por horário
                    .ToList();

                if (!refeicoes.Any())
                    return "<h3>Nenhuma refeição encontrada para esta dieta.</h3>";

                // Monta o HTML
                StringBuilder html = new StringBuilder();
                html.Append("<html><head>");
                html.Append("<style>");
                html.Append("body { font-family: 'Arial'; margin: 20px; }");
                html.Append("h2 { color: #2C3E50; text-align: center; margin-bottom: 30px; }");
                html.Append("h3 { color: #3498db; margin-top: 25px; }");
                html.Append("table { width: 100%; border-collapse: collapse; margin-top: 10px; }");
                html.Append("th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }");
                html.Append("th { background-color: #2C3E50; color: white; }");
                html.Append("tr:nth-child(even) { background-color: #f2f2f2; }");
                html.Append(".total { font-weight: bold; margin-top: 20px; }");
                html.Append(".observacoes { margin-top: 15px; padding: 10px; background-color: #f9f9f9; border-left: 4px solid #3498db; }");
                html.Append("</style></head><body>");

                html.Append($"<h2>Dieta #{numeroDieta}</h2>");

                // Agrupa por refeição
                var refeicoesAgrupadas = refeicoes.GroupBy(r => r.Refeicao);

                foreach (var grupo in refeicoesAgrupadas)
                {
                    html.Append($"<h3>{grupo.Key}</h3>");
                    html.Append("<table>");
                    html.Append("<tr>");
                    html.Append("<th>Horário</th>");
                    html.Append("<th>Alimentos</th>");
                    html.Append("<th>Calorias</th>");
                    html.Append("</tr>");

                    foreach (var refeicao in grupo)
                    {
                        html.Append("<tr>");
                        html.Append($"<td>{refeicao.Horario}</td>");
                        html.Append($"<td>{refeicao.Alimentos}</td>");
                        html.Append($"<td>{refeicao.Calorias}</td>");
                        html.Append("</tr>");
                    }

                    html.Append("</table>");

                    // Adiciona observações se houver
                    var observacoes = grupo.FirstOrDefault(r => !string.IsNullOrEmpty(r.Observacoes))?.Observacoes;
                    if (!string.IsNullOrEmpty(observacoes))
                    {
                        html.Append($"<div class='observacoes'><strong>Observações:</strong> {observacoes}</div>");
                    }
                }

                // Cálculo do total de calorias
                var totalCalorias = refeicoes.Sum(r =>
                    string.IsNullOrEmpty(r.Calorias) ? 0 :
                    int.TryParse(r.Calorias.Replace("kcal", "").Trim(), out int cal) ? cal : 0);

                html.Append($"<div class='total'>Total de calorias diárias: {totalCalorias} kcal</div>");

                // Links referenciais se houver
                var links = refeicoes.FirstOrDefault(r => !string.IsNullOrEmpty(r.LinksReferenciaisDieta))?.LinksReferenciaisDieta;
                if (!string.IsNullOrEmpty(links))
                {
                    html.Append("<div class='observacoes' style='margin-top: 20px;'>");
                    html.Append("<strong>Links de referência:</strong><br>");
                    html.Append(links.Replace(",", "<br>"));
                    html.Append("</div>");
                }

                html.Append("</body></html>");
                return html.ToString();
            }
        }



        public class DietaViewModel
        {
            public int NumeroDieta { get; set; }
            public List<RefeicaoViewModel> Dietas { get; set; } = new List<RefeicaoViewModel>();
        }

        public class RefeicaoViewModel
        {
            public int Id_Dieta { get; set; }
            public string Refeicao { get; set; }
            public string Horario { get; set; }
            public string Alimentos { get; set; }
            public string Calorias { get; set; }
            public string Observacoes { get; set; }
            public string LinksReferenciais { get; set; }
            public DateTime DataRegistro { get; set; }
        }
    }
}
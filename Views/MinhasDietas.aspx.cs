using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProjectFit.Models;

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
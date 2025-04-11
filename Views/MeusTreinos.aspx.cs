using System;
using System.Collections.Generic;
using System.Linq;
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

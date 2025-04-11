using System;
using System.Linq;
using System.Web.UI;
using ProjectFit.Models;

namespace ProjectFit.Views
{
    public partial class EditarTreino : System.Web.UI.UserControl
    {
        public int TreinoId
        {
            get { return Convert.ToInt32(hdnTreinoId.Value); }
            set { hdnTreinoId.Value = value.ToString(); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Console.WriteLine($"TreinoId recebido no controle: {TreinoId}");
                CarregarDados();
            }
        }

        public void CarregarDados()
        {
            using (var db = new ApplicationDbContext())
            {
                var treino = db.Treinos.FirstOrDefault(t => t.TreinoId == TreinoId);
                if (treino != null)
                {
                    txtDiaTreino.Text = treino.DiaTreino;
                    txtExercicio.Text = treino.Exercicio;
                    txtSeriesRepeticoes.Text = treino.SeriesRepeticoes;
                    txtDescanso.Text = treino.Descanso;
                    txtEquipamento.Text = treino.Equipamento;
                    txtGrupoMuscular.Text = treino.GrupoMuscular;
                    txtDicas.Text = treino.Dicas;
                    txtLinks.Text = treino.LinksReferenciaisTreino;
                }
            }
        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {
                using (var db = new ApplicationDbContext())
                {
                    var treino = db.Treinos.FirstOrDefault(t => t.TreinoId == TreinoId);

                    Console.WriteLine($"Treino encontrado no banco de dados: {treino != null}");

                    if (treino != null)
                    {
                        treino.DiaTreino = txtDiaTreino.Text;
                        treino.Exercicio = txtExercicio.Text;
                        treino.SeriesRepeticoes = txtSeriesRepeticoes.Text;
                        treino.DiaTreino = txtDescanso.Text;
                        treino.Equipamento = txtEquipamento.Text;
                        treino.GrupoMuscular = txtGrupoMuscular.Text;
                        treino.Dicas = txtDicas.Text;
                        treino.LinksReferenciaisTreino = txtLinks.Text;
                        db.SaveChanges();
                        ExibirMensagem("Treino atualizado com sucesso!", "success");
                        Response.Redirect(Request.UrlReferrer.ToString()); // Redireciona para a página anterior
                    }
                    else
                    {
                        ExibirMensagem("Treino não encontrado no banco de dados.", "error");
                    }
                }
            }
            catch (Exception ex)
            {
                ExibirMensagem($"Erro ao atualizar o treino: {ex.Message}", "error");
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.UrlReferrer.ToString()); // Retorna para a página anterior
        }

        private void ExibirMensagem(string mensagem, string tipo)
        {
            // Implemente sua lógica de exibição de mensagens (ex.: SweetAlert, Toastr, etc.)
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", $"alert('{mensagem}');", true);
        }
    }
}
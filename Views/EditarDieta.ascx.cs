using System;
using System.Linq;
using System.Web.UI;
using ProjectFit.Models;

namespace ProjectFit.Views
{
    public partial class EditarDieta : System.Web.UI.UserControl
    {
        public int DietaId
        {
            get { return Convert.ToInt32(hdnDietaId.Value); }
            set { hdnDietaId.Value = value.ToString(); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Console.WriteLine($"DietaId recebido no controle: {DietaId}");
                CarregarDados();
            }
        }

        public void CarregarDados()
        {
            using (var db = new ApplicationDbContext())
            {
                var dieta = db.Dietas.FirstOrDefault(d => d.DietaId == DietaId);
                if (dieta != null)
                {
                    txtRefeicao.Text = dieta.Refeicao;
                    txtHorario.Text = dieta.Horario;
                    txtAlimentos.Text = dieta.Alimentos;
                    txtCalorias.Text = dieta.Calorias;
                    txtObservacoes.Text = dieta.Observacoes;
                    txtLinks.Text = dieta.LinksReferenciaisDieta;
                }
            }
        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {
                using (var db = new ApplicationDbContext())
                {
                    var dieta = db.Dietas.FirstOrDefault(d => d.DietaId == DietaId);

                    Console.WriteLine($"Dieta encontrada no banco de dados: {dieta != null}");

                    if (dieta != null)
                    {
                        dieta.Refeicao = txtRefeicao.Text;
                        dieta.Horario = txtHorario.Text;
                        dieta.Alimentos = txtAlimentos.Text;
                        dieta.Calorias = txtCalorias.Text;
                        dieta.Observacoes = txtObservacoes.Text;
                        dieta.LinksReferenciaisDieta = txtLinks.Text;
                        db.SaveChanges();
                        ExibirMensagem("Dieta atualizada com sucesso!", "success");
                        Response.Redirect(Request.UrlReferrer.ToString()); // Redireciona para a página anterior
                    }
                    else
                    {
                        ExibirMensagem("Dieta não encontrada no banco de dados.", "error");
                    }
                }
            }
            catch (Exception ex)
            {
                ExibirMensagem($"Erro ao atualizar a dieta: {ex.Message}", "error");
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
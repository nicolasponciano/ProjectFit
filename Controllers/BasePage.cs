using System;
using System.Data.Entity;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using ProjectFit.Models;

public class BasePage : Page
{
    // Renomeado para evitar conflito com possíveis controles
    protected bool UserIsAdmin { get; private set; }
    protected string CurrentUserId { get; private set; }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        if (!Context.User.Identity.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        CurrentUserId = Context.User.Identity.GetUserId();

        using (var db = new ApplicationDbContext())
        {
            var user = db.Users
                .Include(u => u.Alunos)
                .Include(u => u.Alunos.Select(a => a.Dietas)) // Carrega dietas
                .Include(u => u.Alunos.Select(a => a.Treinos)) // Carrega treinos
                .FirstOrDefault(u => u.Id == CurrentUserId);
            if (user != null)
            {
                UserIsAdmin = user.IsAdmin;
                System.Diagnostics.Debug.WriteLine("UserIsAdmin na BasePage (OnInit): " + UserIsAdmin);
            }
            else
            {
                Response.Redirect("~/Account/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
        }
    }

    public void ExibirMensagem(string mensagem, string tipoAlerta)
    {
        // Remove caracteres especiais ou substitui por entidades HTML
        mensagem = mensagem.Replace("'", "\\'").Replace("\n", "\\n");

        // Registra o script para fechar o carregamento e exibir o alerta
        string script = $"fecharCarregamentoEExibirAlerta('{mensagem}', '{tipoAlerta}');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetalert", script, true);
    }
}

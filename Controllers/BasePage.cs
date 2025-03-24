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

    //public Aluno ObterAlunoLogado()
    //{
    //    // Verifica se o usuário está autenticado
    //    if (!Context.User.Identity.IsAuthenticated)
    //    {
    //        return null; // Retorna null se o usuário não estiver logado
    //    }

    //    // Obtém o ID do usuário logado
    //    var userId = Context.User.Identity.GetUserId();

    //    // Busca o aluno no banco de dados pelo UserId
    //    using (var db = new ApplicationDbContext())
    //    {
    //        var aluno = db.Alunos.FirstOrDefault(a => a.UserId == userId);
    //        return aluno;
    //    }
    //}

    public Aluno ObterAlunoLogado()
    {
        using (var db = new ApplicationDbContext())
        {
            return db.Alunos.FirstOrDefault(a => a.UserId == CurrentUserId);
        }
    }

}

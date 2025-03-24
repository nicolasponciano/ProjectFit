using System;
using System.Web;
using System.Web.Security;
using Microsoft.AspNet.Identity;

namespace ProjectFit.Account
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.User.Identity.IsAuthenticated)
            {
                // Remove autenticação do Identity
                HttpContext.Current.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);

                // Limpa a sessão
                Session.Clear();
                Session.Abandon();

                // Redireciona para a tela de Login
                Response.Redirect("~/Account/Login.aspx");
            }
            else
            {
                // Se não estiver autenticado, apenas redireciona
                Response.Redirect("~/Account/Login.aspx");
            }
        }
    }
}

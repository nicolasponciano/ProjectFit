using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using ProjectFit.Models;

namespace ProjectFit
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;


        public bool ShowNavbar
        {
            get { return pnlNavbar.Visible; }
            set { pnlNavbar.Visible = value; }
        }



        protected void Page_Init(object sender, EventArgs e)
        {
            // O código abaixo ajuda a proteger contra ataques XSRF
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use o token Anti-XSRF do cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Gerar um novo token Anti-XSRF e salvar no cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Configurar o token Anti-XSRF
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validar o token Anti-XSRF
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Falha na validação do token Anti-XSRF.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            UserGoogleFitPictureUrl();


            if (!IsPostBack)
            {
                // Verifica se o usuário está autenticado
                if (Context.User.Identity.IsAuthenticated)
                {
                    // Recupera o nome do usuário logado (ou mude para outra forma de identificação, se necessário)
                    var userName = Context.User.Identity.Name;

                    using (var db = new ApplicationDbContext())
                    {
                        // Busca o usuário no banco pelo nome (ou ID, se preferir)
                        var user = db.Users.FirstOrDefault(u => u.UserName == userName);

                        if (user != null)
                        {
                            // Exibe o item apenas para administradores
                            liCadastro.Visible = user.IsAdmin;
                        }
                        else
                        {
                            liCadastro.Visible = false;
                        }
                    }
                }
                else
                {
                    liCadastro.Visible = false;
                }
            }
        }


        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
        }


        // Método para obter a URL da foto do Google do usuário vinculado
        public string UserGoogleFitPictureUrl()
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                var userId = HttpContext.Current.User.Identity.GetUserId();
                using (var db = new ApplicationDbContext())
                {
                    // Busca o registro mais recente na tabela UserGoogleFits para o usuário
                    var userGoogleFit = db.UsersGoogleFits
                        .Where(ugf => ugf.FitUserId == userId && !string.IsNullOrEmpty(ugf.UrlFotoPerfil))
                        .OrderByDescending(ugf => ugf.DataColeta) // Pega o registro mais recente
                        .FirstOrDefault();

                    if (userGoogleFit != null)
                    {
                        return userGoogleFit.UrlFotoPerfil; // Retorna a URL da foto do Google Fit
                    }
                }
            }
            return null;
        }

        // Método para obter o nome do usuário logado
        public string GetUserDisplayName()
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                var userId = HttpContext.Current.User.Identity.GetUserId();
                using (var db = new ApplicationDbContext())
                {
                    // Busca o aluno associado ao usuário autenticado
                    var aluno = db.Alunos.FirstOrDefault(a => a.UserId == userId);
                    if (aluno != null)
                    {
                        return aluno.Nome; // Retorna o nome do aluno, se existir
                    }

                    // Se não houver aluno, retorna o nome do usuário padrão
                    var user = db.Users.FirstOrDefault(u => u.Id == userId);
                    if (user != null)
                    {
                        return user.UserName; // Fallback para o nome de usuário
                    }
                }
            }
            return "Perfil";
        }
    }

}
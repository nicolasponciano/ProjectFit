using System;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using ProjectFit.Models;
using System.Collections.Generic;
using System.Data.Entity;

namespace ProjectFit.Models
{
    // É possível adicionar Dados de usuário para o usuário ao incluir mais propriedades na sua Classe de usuário, visite https://go.microsoft.com/fwlink/?LinkID=317594 para obter mais informações.
    public class ApplicationUser : IdentityUser
    {
        public bool IsAdmin { get; set; } // Adicione esta propriedade
        public virtual ICollection<Aluno> Alunos { get; set; }


        // Relacionamento com UserGoogleFit (opcional)
        //public virtual ICollection<UserGoogleFit> UserGoogleFitData { get; set; }

        // Adicione esta propriedade para armazenar o refresh token do Google
        public string GoogleRefreshToken { get; set; }
        public string GoogleAccessToken { get; internal set; }
        public string ExpiresIn { get; internal set; }


        // Método para gerar a identidade do usuário com Claims
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);

            // Adiciona o Claim IsAdmin
            userIdentity.AddClaim(new Claim("IsAdmin", IsAdmin.ToString()));

            return userIdentity;
        }


        // Contexto unificado que gerencia tanto os usuários do Identity quanto as entidades da aplicação
        public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
        {
            public DbSet<Aluno> Alunos { get; set; }

            // Construtor que utiliza a string de conexão definida no Web.config
            public ApplicationDbContext()
                : base("ProjectFitDbContext", throwIfV1Schema: false)
            {
            }

            // Configuração das entidades (se necessário)
            protected override void OnModelCreating(DbModelBuilder modelBuilder)
            {
                base.OnModelCreating(modelBuilder); // Configurações do Identity

                // Configuração da relação entre Aluno e ApplicationUser (se necessário)
                modelBuilder.Entity<Aluno>()
                    .HasRequired(a => a.ApplicationUser) // Relacionamento com o usuário
                    .WithMany(u => u.Alunos) // Cada ApplicationUser pode ter muitos Alunos
                    .HasForeignKey(a => a.UserId); // A chave estrangeira é UserId

                modelBuilder.Entity<Aluno>().ToTable("T_ALUNOS"); // Tabela personalizada, se necessário
            }

            // Método para criar a instância do contexto
            public static ApplicationDbContext Create()
            {
                return new ApplicationDbContext();
            }
        }
    }
}

#region Auxiliadores
namespace ProjectFit
{
    public static class IdentityHelper
    {
        // Usado para XSRF ao vincular logons externos
        public const string XsrfKey = "XsrfId";

        public const string ProviderNameKey = "providerName";
        public static string GetProviderNameFromRequest(HttpRequest request)
        {
            return request.QueryString[ProviderNameKey];
        }

        public const string CodeKey = "code";
        public static string GetCodeFromRequest(HttpRequest request)
        {
            return request.QueryString[CodeKey];
        }

        public const string UserIdKey = "userId";
        public static string GetUserIdFromRequest(HttpRequest request)
        {
            return HttpUtility.UrlDecode(request.QueryString[UserIdKey]);
        }

        public static string GetResetPasswordRedirectUrl(string code, HttpRequest request)
        {
            var absoluteUri = "/Account/ResetPassword?" + CodeKey + "=" + HttpUtility.UrlEncode(code);
            return new Uri(request.Url, absoluteUri).AbsoluteUri.ToString();
        }

        public static string GetUserConfirmationRedirectUrl(string code, string userId, HttpRequest request)
        {
            var absoluteUri = "/Account/Confirm?" + CodeKey + "=" + HttpUtility.UrlEncode(code) + "&" + UserIdKey + "=" + HttpUtility.UrlEncode(userId);
            return new Uri(request.Url, absoluteUri).AbsoluteUri.ToString();
        }

        private static bool IsLocalUrl(string url)
        {
            return !string.IsNullOrEmpty(url) && ((url[0] == '/' && (url.Length == 1 || (url[1] != '/' && url[1] != '\\'))) || (url.Length > 1 && url[0] == '~' && url[1] == '/'));
        }

        public static void RedirectToReturnUrl(string returnUrl, HttpResponse response)
        {
            if (!String.IsNullOrEmpty(returnUrl) && IsLocalUrl(returnUrl))
            {
                response.Redirect(returnUrl);
            }
            else
            {
                response.Redirect("~/");
            }
        }
    }
}
#endregion

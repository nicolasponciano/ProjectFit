using Microsoft.AspNet.FriendlyUrls;
using System.Web.Mvc;
using System.Web.Routing;

namespace ProjectFit
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            // --- Rotas para WebForms (.aspx) ---
            routes.MapPageRoute(
                "LoginRoute",           // Nome da rota
                "Account/Login",        // URL amigável
                "~/Account/Login.aspx"  // Caminho físico
            );

            // Adicione outras páginas aqui (ex: Home, Registro)
            routes.MapPageRoute(
                "DefaultRoute",
                "",
                "~/Default.aspx"
            );

            // --- Rota padrão do MVC (para futuros controllers) ---
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
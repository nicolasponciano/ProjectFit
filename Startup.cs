using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ProjectFit.Startup))]
namespace ProjectFit
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

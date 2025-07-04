using Hangfire;
using Microsoft.Owin;
using Owin;
//using ProjectFit.Services;

[assembly: OwinStartupAttribute(typeof(ProjectFit.Startup))]
namespace ProjectFit
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) 
        {
            ConfigureAuth(app);

        }

    }


}

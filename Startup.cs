using Hangfire;
using Microsoft.Owin;
using Owin;
using ProjectFit.Services;

[assembly: OwinStartupAttribute(typeof(ProjectFit.Startup))]
namespace ProjectFit
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) 
        {
            ConfigureAuth(app);

            // Configura o Hangfire para usar a mesma connection string do Entity Framework
            GlobalConfiguration.Configuration.UseSqlServerStorage("ProjectFitDbContext");

            // Habilita o dashboard do Hangfire
            app.UseHangfireDashboard();

            // Inicia o servidor do Hangfire
            app.UseHangfireServer();

            // Agendamento da tarefa diária
            RecurringJob.AddOrUpdate(
                "sync-google-fit-data", // Nome único para o job
                () => GoogleFitSyncService.SyncUserData(),
                Cron.Daily); // Executa uma vez por dia
        }

    }


}

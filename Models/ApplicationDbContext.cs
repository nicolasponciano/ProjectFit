using System.Data.Entity;
using Microsoft.AspNet.Identity.EntityFramework;
using ProjectFit.Models;

namespace ProjectFit.Models
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        // Inclua todas as entidades do domínio, por exemplo, a tabela de alunos
        public DbSet<Aluno> Alunos { get; set; }
        public DbSet<Dieta> Dietas { get; set; }
        public DbSet<Treino> Treinos { get; set; }


        // Construtor que utiliza a string de conexão definida no Web.config
        public ApplicationDbContext()
            : base("ProjectFitDbContext", throwIfV1Schema: false)
        {
        }

        // Configuração do modelo – importante chamar o base.OnModelCreating para o Identity
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configuração específica para a entidade Aluno:
            modelBuilder.Entity<Aluno>()
                .HasRequired(a => a.ApplicationUser)
                .WithMany(u => u.Alunos)
                .HasForeignKey(a => a.UserId);

            modelBuilder.Entity<Dieta>()
                .HasRequired(d => d.Aluno)
                .WithMany(a => a.Dietas)
                .HasForeignKey(d => d.AlunoIdDieta);

            modelBuilder.Entity<Treino>()
                .HasRequired(t => t.Aluno)
                .WithMany(a => a.Treinos)
                .HasForeignKey(t => t.AlunoIdTreino);

            // Mapeia a entidade para a tabela customizada, se desejado
            modelBuilder.Entity<Aluno>().ToTable("T_ALUNOS");
        }

        // Método para criar a instância do contexto
        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }
    }
}

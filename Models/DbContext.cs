using System.Data.Entity;

namespace ProjectFit.Models
{
    public class AppDbContext : DbContext
    {
        public AppDbContext() : base("name=ProjectFitDbContext")
        {
        }

        public DbSet<Aluno> Alunos { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Aluno>().ToTable("T_ALUNOS");
        }
    }
}
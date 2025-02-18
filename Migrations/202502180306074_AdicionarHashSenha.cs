namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AdicionarHashSenha : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.T_ALUNOS", "ALN_HASH_SENHA", c => c.String(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.T_ALUNOS", "ALN_HASH_SENHA");
        }
    }
}

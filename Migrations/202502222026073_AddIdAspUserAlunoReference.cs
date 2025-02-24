namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddIdAspUserAlunoReference : DbMigration
    {
        public override void Up()
        {
            //DropColumn("dbo.T_ALUNOS", "ALN_IN_ADMIN");
        }
        
        public override void Down()
        {
            AddColumn("dbo.T_ALUNOS", "ALN_IN_ADMIN", c => c.Boolean(nullable: false));
        }
    }
}

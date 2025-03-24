namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class numeroTreino : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.T_TREINO", "TRE_NR_TREINO", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.T_TREINO", "TRE_NR_TREINO");
        }
    }
}

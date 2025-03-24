namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class numeroDieta : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.T_DIETA", "DIE_NR_DIETA", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.T_DIETA", "DIE_NR_DIETA");
        }
    }
}

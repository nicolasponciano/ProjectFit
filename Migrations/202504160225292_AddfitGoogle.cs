namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddfitGoogle : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.UserGoogleFits", "FitUserId", "dbo.AspNetUsers");
            AddColumn("dbo.UserGoogleFits", "ApplicationUser_Id", c => c.String(maxLength: 128));
            CreateIndex("dbo.UserGoogleFits", "ApplicationUser_Id");
            AddForeignKey("dbo.UserGoogleFits", "ApplicationUser_Id", "dbo.AspNetUsers", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.UserGoogleFits", "ApplicationUser_Id", "dbo.AspNetUsers");
            DropIndex("dbo.UserGoogleFits", new[] { "ApplicationUser_Id" });
            DropColumn("dbo.UserGoogleFits", "ApplicationUser_Id");
            AddForeignKey("dbo.UserGoogleFits", "FitUserId", "dbo.AspNetUsers", "Id", cascadeDelete: true);
        }
    }
}

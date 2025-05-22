namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddHangfire : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.AspNetUsers", "GoogleAccessToken", c => c.String());
            AddColumn("dbo.AspNetUsers", "ExpiresIn", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.AspNetUsers", "ExpiresIn");
            DropColumn("dbo.AspNetUsers", "GoogleAccessToken");
        }
    }
}

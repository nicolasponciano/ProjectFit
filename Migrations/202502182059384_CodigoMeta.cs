namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CodigoMeta : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.T_ALUNOS", "ALN_CD_META", c => c.Int());
            AlterColumn("dbo.T_ALUNOS", "ALN_CD_PLANO_TREINO", c => c.Int());
        }
        
        public override void Down()
        {
            AlterColumn("dbo.T_ALUNOS", "ALN_CD_PLANO_TREINO", c => c.Int(nullable: false));
            AlterColumn("dbo.T_ALUNOS", "ALN_CD_META", c => c.String());
        }
    }
}

namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AtualizacaoTabelaAlunos : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.T_ALUNOS", "ALN_CD_PLANO_TREINO", c => c.Int(nullable: false));
            AlterColumn("dbo.T_ALUNOS", "ALN_CD_USER_CREATE", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.T_ALUNOS", "ALN_CD_USER_CREATE", c => c.Int());
            AlterColumn("dbo.T_ALUNOS", "ALN_CD_PLANO_TREINO", c => c.Int());
        }
    }
}

namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class TabelaDieta : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.T_DIETA",
                c => new
                    {
                        DIE_ID_DIETA = c.Int(nullable: false, identity: true),
                        DIE_ID_ALUNO = c.Int(nullable: false),
                        DIE_NM_REFEICAO = c.String(nullable: false, maxLength: 100),
                        DIE_HR_REFEICAO = c.String(nullable: false, maxLength: 5),
                        DIE_DS_ALIMENTOS = c.String(nullable: false),
                        DIE_VL_CALORIAS = c.String(nullable: false, maxLength: 20),
                        DIE_DS_OBSERVACOES = c.String(nullable: false),
                        DIE_DT_REGISTRO = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.DIE_ID_DIETA)
                .ForeignKey("dbo.T_ALUNOS", t => t.DIE_ID_ALUNO, cascadeDelete: true)
                .Index(t => t.DIE_ID_ALUNO);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.T_DIETA", "DIE_ID_ALUNO", "dbo.T_ALUNOS");
            DropIndex("dbo.T_DIETA", new[] { "DIE_ID_ALUNO" });
            DropTable("dbo.T_DIETA");
        }
    }
}

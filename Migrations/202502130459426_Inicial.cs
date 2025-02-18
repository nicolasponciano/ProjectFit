namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Inicial : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.T_ALUNOS",
                c => new
                    {
                        ALN_ID_ALUNO = c.Int(nullable: false, identity: true),
                        ALN_NM_ALUNO = c.String(nullable: false, maxLength: 100),
                        ALN_CD_CPF = c.String(nullable: false, maxLength: 11),
                        ALN_CD_CEP = c.String(maxLength: 11),
                        ALN_NR_TELEFONE = c.String(),
                        ALN_DS_EMAIL = c.String(nullable: false),
                        ALN_VL_PESO = c.Double(nullable: false),
                        ALN_VL_ALTURA = c.Double(nullable: false),
                        ALN_VL_IMC = c.Double(nullable: false),
                        ALN_NM_META = c.String(),
                        ALN_CD_PLANO_TREINO = c.Int(),
                        ALN_NM_PLANO_TREINO = c.String(),
                        ALN_CD_USER_CREATE = c.Int(),
                        ALN_DT_GRAVACAO = c.DateTime(nullable: false),
                        ALN_CD_USER_ALTER = c.Int(),
                        ALN_DT_ALTERACAO = c.DateTime(),
                    })
                .PrimaryKey(t => t.ALN_ID_ALUNO);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.T_ALUNOS");
        }
    }
}

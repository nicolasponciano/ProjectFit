namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.T_ALUNOS",
                c => new
                    {
                        ALN_ID_ALUNO = c.Int(nullable: false, identity: true),
                        UserId = c.String(nullable: false, maxLength: 128),
                        ALN_IN_ADMIN = c.Boolean(nullable: false),
                        ALN_NM_ALUNO = c.String(nullable: false, maxLength: 100),
                        ALN_CD_CPF = c.String(nullable: false, maxLength: 11),
                        ALN_CD_CEP = c.String(maxLength: 11),
                        ALN_NR_TELEFONE = c.String(),
                        ALN_DS_EMAIL = c.String(nullable: false),
                        ALN_VL_PESO = c.Double(nullable: false),
                        ALN_VL_ALTURA = c.Double(nullable: false),
                        ALN_VL_IMC = c.Double(nullable: false),
                        ALN_CD_META = c.Int(),
                        ALN_NM_META = c.String(),
                        ALN_CD_PLANO_TREINO = c.Int(),
                        ALN_NM_PLANO_TREINO = c.String(),
                        ALN_CD_USER_CREATE = c.Int(nullable: false),
                        ALN_DT_GRAVACAO = c.DateTime(nullable: false),
                        ALN_CD_USER_ALTER = c.Int(),
                        ALN_DT_ALTERACAO = c.DateTime(),
                        ALN_HASH_SENHA = c.String(nullable: false),
                    })
                .PrimaryKey(t => t.ALN_ID_ALUNO)
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.AspNetUsers",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        IsAdmin = c.Boolean(nullable: false),
                        Email = c.String(maxLength: 256),
                        EmailConfirmed = c.Boolean(nullable: false),
                        PasswordHash = c.String(),
                        SecurityStamp = c.String(),
                        PhoneNumber = c.String(),
                        PhoneNumberConfirmed = c.Boolean(nullable: false),
                        TwoFactorEnabled = c.Boolean(nullable: false),
                        LockoutEndDateUtc = c.DateTime(),
                        LockoutEnabled = c.Boolean(nullable: false),
                        AccessFailedCount = c.Int(nullable: false),
                        UserName = c.String(nullable: false, maxLength: 256),
                    })
                .PrimaryKey(t => t.Id)
                .Index(t => t.UserName, unique: true, name: "UserNameIndex");
            
            CreateTable(
                "dbo.AspNetUserClaims",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        UserId = c.String(nullable: false, maxLength: 128),
                        ClaimType = c.String(),
                        ClaimValue = c.String(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.AspNetUserLogins",
                c => new
                    {
                        LoginProvider = c.String(nullable: false, maxLength: 128),
                        ProviderKey = c.String(nullable: false, maxLength: 128),
                        UserId = c.String(nullable: false, maxLength: 128),
                    })
                .PrimaryKey(t => new { t.LoginProvider, t.ProviderKey, t.UserId })
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.AspNetUserRoles",
                c => new
                    {
                        UserId = c.String(nullable: false, maxLength: 128),
                        RoleId = c.String(nullable: false, maxLength: 128),
                    })
                .PrimaryKey(t => new { t.UserId, t.RoleId })
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .ForeignKey("dbo.AspNetRoles", t => t.RoleId, cascadeDelete: true)
                .Index(t => t.UserId)
                .Index(t => t.RoleId);
            
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
                        DIE_DS_LINKS_REFERENCIAIS = c.String(maxLength: 500),
                    })
                .PrimaryKey(t => t.DIE_ID_DIETA)
                .ForeignKey("dbo.T_ALUNOS", t => t.DIE_ID_ALUNO, cascadeDelete: true)
                .Index(t => t.DIE_ID_ALUNO);
            
            CreateTable(
                "dbo.T_TREINO",
                c => new
                    {
                        TRE_ID_TREINO = c.Int(nullable: false, identity: true),
                        TRE_ID_ALUNO = c.Int(nullable: false),
                        TRE_DS_DIA = c.String(nullable: false, maxLength: 50),
                        TRE_DS_EXERCICIO = c.String(nullable: false, maxLength: 100),
                        TRE_DS_SERIE_REPETICOES = c.String(nullable: false, maxLength: 50),
                        TRE_DS_DESCANSO = c.String(nullable: false, maxLength: 20),
                        TRE_DS_EQUIPAMENTO = c.String(nullable: false, maxLength: 100),
                        TRE_DS_GRUPO_MUSCULAR = c.String(nullable: false, maxLength: 100),
                        TRE_DS_DICAS = c.String(nullable: false),
                        TRE_DS_LINKS_REFERENCIAIS = c.String(maxLength: 500),
                        TRE_DT_REGISTRO = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.TRE_ID_TREINO)
                .ForeignKey("dbo.T_ALUNOS", t => t.TRE_ID_ALUNO, cascadeDelete: true)
                .Index(t => t.TRE_ID_ALUNO);
            
            CreateTable(
                "dbo.AspNetRoles",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(nullable: false, maxLength: 256),
                    })
                .PrimaryKey(t => t.Id)
                .Index(t => t.Name, unique: true, name: "RoleNameIndex");
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.AspNetUserRoles", "RoleId", "dbo.AspNetRoles");
            DropForeignKey("dbo.T_TREINO", "TRE_ID_ALUNO", "dbo.T_ALUNOS");
            DropForeignKey("dbo.T_DIETA", "DIE_ID_ALUNO", "dbo.T_ALUNOS");
            DropForeignKey("dbo.T_ALUNOS", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserRoles", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserLogins", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserClaims", "UserId", "dbo.AspNetUsers");
            DropIndex("dbo.AspNetRoles", "RoleNameIndex");
            DropIndex("dbo.T_TREINO", new[] { "TRE_ID_ALUNO" });
            DropIndex("dbo.T_DIETA", new[] { "DIE_ID_ALUNO" });
            DropIndex("dbo.AspNetUserRoles", new[] { "RoleId" });
            DropIndex("dbo.AspNetUserRoles", new[] { "UserId" });
            DropIndex("dbo.AspNetUserLogins", new[] { "UserId" });
            DropIndex("dbo.AspNetUserClaims", new[] { "UserId" });
            DropIndex("dbo.AspNetUsers", "UserNameIndex");
            DropIndex("dbo.T_ALUNOS", new[] { "UserId" });
            DropTable("dbo.AspNetRoles");
            DropTable("dbo.T_TREINO");
            DropTable("dbo.T_DIETA");
            DropTable("dbo.AspNetUserRoles");
            DropTable("dbo.AspNetUserLogins");
            DropTable("dbo.AspNetUserClaims");
            DropTable("dbo.AspNetUsers");
            DropTable("dbo.T_ALUNOS");
        }
    }
}

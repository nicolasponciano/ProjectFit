namespace ProjectFit.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddGoogleRefreshTokenToUser : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.UserGoogleFits",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        FitUserId = c.String(nullable: false, maxLength: 128),
                        GoogleId = c.String(),
                        NomeCompleto = c.String(maxLength: 255),
                        Email = c.String(maxLength: 255),
                        UrlFotoPerfil = c.String(maxLength: 500),
                        DataColeta = c.DateTime(nullable: false),
                        Passos = c.Int(nullable: false),
                        DistanciaMetros = c.Double(nullable: false),
                        CaloriasGastas = c.Double(nullable: false),
                        TempoAtivo = c.Time(nullable: false, precision: 7),
                        TipoAtividade = c.String(),
                        TempoTotalSono = c.Time(nullable: false, precision: 7),
                        SonoProfundo = c.Time(nullable: false, precision: 7),
                        SonoLeve = c.Time(nullable: false, precision: 7),
                        FaseRem = c.Time(nullable: false, precision: 7),
                        FrequenciaCardiacaMin = c.Double(nullable: false),
                        FrequenciaCardiacaMax = c.Double(nullable: false),
                        FrequenciaCardiacaMedia = c.Double(nullable: false),
                        PesoKg = c.Double(nullable: false),
                        AlturaMetros = c.Double(nullable: false),
                        PercentualGorduraCorporal = c.Double(nullable: false),
                        HidratacaoMl = c.Double(nullable: false),
                        SaturacaoOxigenio = c.Double(nullable: false),
                        PressaoArterialSistolica = c.Double(nullable: false),
                        PressaoArterialDiastolica = c.Double(nullable: false),
                        Glicemia = c.Double(nullable: false),
                        TemperaturaCorporal = c.Double(nullable: false),
                        DataCriacao = c.DateTime(nullable: false),
                        FonteDados = c.String(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.AspNetUsers", t => t.FitUserId, cascadeDelete: true)
                .Index(t => t.FitUserId);
            
            AddColumn("dbo.AspNetUsers", "GoogleRefreshToken", c => c.String());
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.UserGoogleFits", "FitUserId", "dbo.AspNetUsers");
            DropIndex("dbo.UserGoogleFits", new[] { "FitUserId" });
            DropColumn("dbo.AspNetUsers", "GoogleRefreshToken");
            DropTable("dbo.UserGoogleFits");
        }
    }
}

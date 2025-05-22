using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectFit.Models
{
    public class UserGoogleFit
    {
        [Key]
        public int Id { get; set; }

        // Dados de autenticação do usuário
        [Required]
        [ForeignKey("ApplicationUser")] // Aponta para a propriedade de navegação abaixo
        public string FitUserId { get; set; } // FK para AspNetUsers

        // Propriedade de navegação (relacionamento com ApplicationUser)
        public virtual ApplicationUser ApplicationUser { get; set; }
        public string GoogleId { get; set; } // ID único do Google

        // Dados do perfil
        [StringLength(255)]
        public string NomeCompleto { get; set; }

        [EmailAddress]
        [StringLength(255)]
        public string Email { get; set; }

        [StringLength(500)]
        public string UrlFotoPerfil { get; set; }

        // Dados de saúde/atividade física
        [DataType(DataType.DateTime)]
        public DateTime DataColeta { get; set; }

        // Atividade física
        public int Passos { get; set; }
        public double DistanciaMetros { get; set; }
        public double CaloriasGastas { get; set; }
        public TimeSpan TempoAtivo { get; set; }
        public string TipoAtividade { get; set; }

        // Sono
        public TimeSpan TempoTotalSono { get; set; }
        public TimeSpan SonoProfundo { get; set; }
        public TimeSpan SonoLeve { get; set; }
        public TimeSpan FaseRem { get; set; }

        // Frequência cardíaca
        public double FrequenciaCardiacaMin { get; set; }
        public double FrequenciaCardiacaMax { get; set; }
        public double FrequenciaCardiacaMedia { get; set; }

        // Dados corporais
        public double PesoKg { get; set; }
        public double AlturaMetros { get; set; }
        public double PercentualGorduraCorporal { get; set; }
        public double HidratacaoMl { get; set; }
        public double SaturacaoOxigenio { get; set; }

        // Dados de saúde avançados
        public double PressaoArterialSistolica { get; set; }
        public double PressaoArterialDiastolica { get; set; }
        public double Glicemia { get; set; }
        public double TemperaturaCorporal { get; set; }

        // Metadados
        [DataType(DataType.DateTime)]
        public DateTime DataCriacao { get; set; } = DateTime.UtcNow;
        public string FonteDados { get; set; }
    }
}
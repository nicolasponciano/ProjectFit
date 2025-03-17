using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectFit.Models
{
    [Table("T_DIETA")] // Nome da tabela no banco
    public class Dieta
    {
        [Key]
        [Column("DIE_ID_DIETA")] // Chave primária
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int DietaId { get; set; }

        [ForeignKey("Aluno")]
        [Column("DIE_ID_ALUNO")] // Chave estrangeira para Aluno (ALN_ID_ALUNO)
        public int AlunoId { get; set; }

        [Required]
        [Column("DIE_NM_REFEICAO")] // Nome da refeição
        [StringLength(100, ErrorMessage = "Máximo de 100 caracteres")]
        public string Refeicao { get; set; }

        [Required]
        [Column("DIE_HR_REFEICAO")] // Horário no formato HH:mm
        [StringLength(5, ErrorMessage = "Formato inválido (HH:mm)")]
        public string Horario { get; set; }

        [Required]
        [Column("DIE_DS_ALIMENTOS")] // Descrição dos alimentos
        public string Alimentos { get; set; }

        [Required]
        [Column("DIE_VL_CALORIAS")] // Valor calórico aproximado
        [StringLength(20, ErrorMessage = "Formato inválido")]
        public string Calorias { get; set; }

        [Required]
        [Column("DIE_DS_OBSERVACOES")] // Dicas de preparo
        public string Observacoes { get; set; }

        [Required]
        [Column("DIE_DT_REGISTRO")] // Data de registro automática
        public DateTime DataRegistro { get; set; } = DateTime.Now;

        // Relacionamento
        public virtual Aluno Aluno { get; set; }
    }
}
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectFit.Models
{
    [Table("T_TREINO")] // Nome da tabela no banco
    public class Treino
    {
        [Key]
        [Column("TRE_ID_TREINO")] // Chave primária
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int TreinoId { get; set; }

        [ForeignKey("Aluno")]
        [Column("TRE_ID_ALUNO")] // Chave estrangeira para Aluno (ALN_ID_ALUNO)
        public int AlunoIdTreino { get; set; }

        [Required]
        [Column("TRE_DS_DIA")] // Dia do treino
        [StringLength(50, ErrorMessage = "Máximo de 50 caracteres")]
        public string DiaTreino { get; set; }

        [Required]
        [Column("TRE_DS_EXERCICIO")] // Nome do exercício
        [StringLength(100, ErrorMessage = "Máximo de 100 caracteres")]
        public string Exercicio { get; set; }

        [Required]
        [Column("TRE_DS_SERIE_REPETICOES")] // Séries e repetições
        [StringLength(50, ErrorMessage = "Máximo de 50 caracteres")]
        public string SeriesRepeticoes { get; set; }

        [Required]
        [Column("TRE_DS_DESCANSO")] // Tempo de descanso
        [StringLength(20, ErrorMessage = "Máximo de 20 caracteres")]
        public string Descanso { get; set; }

        [Required]
        [Column("TRE_DS_EQUIPAMENTO")] // Equipamento utilizado
        [StringLength(100, ErrorMessage = "Máximo de 100 caracteres")]
        public string Equipamento { get; set; }

        [Required]
        [Column("TRE_DS_GRUPO_MUSCULAR")] // Grupo muscular trabalhado
        [StringLength(100, ErrorMessage = "Máximo de 100 caracteres")]
        public string GrupoMuscular { get; set; }

        [Required]
        [Column("TRE_DS_DICAS")] // Dicas e observações
        public string Dicas { get; set; }

        [Column("TRE_DS_LINKS_REFERENCIAIS")] // Links referenciais
        [StringLength(500, ErrorMessage = "Máximo de 500 caracteres")] // Ajuste o tamanho conforme necessário
        public string LinksReferenciaisTreino { get; set; }

        [Required]
        [Column("TRE_DT_REGISTRO")] // Data de registro automática
        public DateTime DataCriacao { get; set; } = DateTime.Now;

        [Column("TRE_NR_TREINO")] // Chave estrangeira para Aluno (ALN_ID_ALUNO)
        public int NumeroTreino { get; set; }

        // Relacionamento
        public virtual Aluno Aluno { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectFit.Models
{
    [Table("T_ALUNOS")] // Mapeia a classe para a tabela T_ALUNOS
    public class Aluno
    {
        [Key]
        [Column("ALN_ID_ALUNO")] // Mapeia a propriedade para a coluna ALN_ID_ALUNO
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)] // Define que o valor é gerado automaticamente pelo banco de dados
        public int Id_Aluno { get; set; }


        [ForeignKey("ApplicationUser")]
        [Column("UserId")] // Garante que o nome da coluna no banco seja "UserId"
        public string UserId { get; set; } // Relaciona com ASP.NET Users

        public virtual ApplicationUser ApplicationUser { get; set; }

        [Column("ALN_IN_ADMIN")]
        public bool IsAdmin { get; set; }  // Indica se o usuário é administrador

        [Required(ErrorMessage = "O nome é obrigatório.")]
        [StringLength(100, ErrorMessage = "O nome deve ter no máximo 100 caracteres.")]
        [Column("ALN_NM_ALUNO")] // Mapeia a propriedade para a coluna ALN_NM_ALUNO
        public string Nome { get; set; }

        [Required(ErrorMessage = "O CPF é obrigatório.")]
        [StringLength(11, ErrorMessage = "O CPF deve ter no máximo 11 Dígitos.")]
        [Column("ALN_CD_CPF")] // Mapeia a propriedade para a coluna ALN_CD_CPF
        public string Cpf { get; set; }

        [StringLength(11, ErrorMessage = "O CEP deve ter no máximo 11 Dígitos.")]
        [Column("ALN_CD_CEP")] // Mapeia a propriedade para a coluna ALN_CD_CEP
        public string Cep { get; set; }

        [Phone(ErrorMessage = "Telefone inválido.")]
        [Column("ALN_NR_TELEFONE")] // Mapeia a propriedade para a coluna ALN_NR_TELEFONE
        public string Telefone { get; set; }

        [Required(ErrorMessage = "O e-mail é obrigatório.")]
        [EmailAddress(ErrorMessage = "E-mail inválido.")]
        [Column("ALN_DS_EMAIL")] // Mapeia a propriedade para a coluna ALN_DS_EMAIL
        public string Email { get; set; }

        [Required(ErrorMessage = "O Peso é obrigatório.")]
        [Column("ALN_VL_PESO")] // Mapeia a propriedade para a coluna ALN_VL_PESO
        public double Peso { get; set; }

        [Required(ErrorMessage = "A Altura é obrigatório.")]
        [Column("ALN_VL_ALTURA")] // Mapeia a propriedade para a coluna ALN_VL_ALTURA
        public double Altura { get; set; }

        [Column("ALN_VL_IMC")] // Mapeia a propriedade para a coluna ALN_VL_IMC
        public double IMC { get; set; }

        [Column("ALN_CD_META")] // Mapeia a propriedade para a coluna ALN_CD_META
        public int? CodigoMeta { get; set; }

        [Column("ALN_NM_META")] // Mapeia a propriedade para a coluna ALN_NM_META
        public string Meta { get; set; }

        [Column("ALN_CD_PLANO_TREINO")] // Mapeia a propriedade para a coluna ALN_CD_PLANO_TREINO
        public int? CodigoPlanoTreino { get; set; }

        [Column("ALN_NM_PLANO_TREINO")] // Mapeia a propriedade para a coluna ALN_NM_PLANO_TREINO
        public string PlanoTreino { get; set; }

        [Column("ALN_CD_USER_CREATE")] // Mapeia a propriedade para a coluna ALN_CD_USER_CREATE
        public int CodigoUsuarioCriacao { get; set; }

        [Column("ALN_DT_GRAVACAO")] // Mapeia a propriedade para a coluna ALN_DT_GRAVACAO
        public DateTime DataGravacao { get; set; } = DateTime.Now; // Valor padrão é a data/hora atual

        [Column("ALN_CD_USER_ALTER")] // Mapeia a propriedade para a coluna ALN_CD_USER_ALTER
        public int? CodigoUsuarioAlteracao { get; set; }

        [Column("ALN_DT_ALTERACAO")] // Mapeia a propriedade para a coluna ALN_DT_ALTERACAO
        public DateTime? DataAlteracao { get; set; }

        [Required(ErrorMessage = "A senha é obrigatória.")]
        [Column("ALN_HASH_SENHA")] // Mapeia para a coluna ALN_HASH_SENHA
        public string HashSenha { get; set; }

        [Column("ALN_NM_DIETA")]
        public virtual ICollection<Dieta> Dietas { get; set; }

        // Método para calcular o IMC
        public double CalcularIMC()
        {
            if (Altura <= 0)
            {
                IMC = 0;
                return IMC;
            }
            IMC = Peso / (Altura * Altura);
            return IMC;
        }

        public void DefinirSenha(string senha)
        {
            HashSenha = BCrypt.Net.BCrypt.HashPassword(senha);
        }

        public bool VerificarSenha(string senha)
        {
            return BCrypt.Net.BCrypt.Verify(senha, HashSenha);
        }


    }
}
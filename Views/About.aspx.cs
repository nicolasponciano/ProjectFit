using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProjectFit.Models;


namespace ProjectFit
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //// Testa a conexão com o banco de dados
            //if (TestarConexao.TestarBanco())
            //{
            //    // Exibe uma mensagem de sucesso
            //    string script = "alert('Conexão com o banco de dados realizada com sucesso!');";
            //    ClientScript.RegisterStartupScript(this.GetType(), "SucessoConexao", script, true);
            //}
            //else
            //{
            //    // Exibe uma mensagem de erro
            //    string script = "alert('Erro ao conectar ao banco de dados. Verifique as configurações.');";
            //    ClientScript.RegisterStartupScript(this.GetType(), "ErroConexao", script, true);
            //}

            try
            {
                using (var context = new AppDbContext())
                {
                    // Cria um novo aluno com dados de exemplo
                    var aluno = new Aluno
                    {
                        Nome = "Maria Oliveira",
                        Cpf = "98765432109",
                        Cep = "22450000",
                        Telefone = "(21) 9999-8888",
                        Email = "maria@email.com",
                        Peso = 65.5,
                        Altura = 1.68,
                        Meta = "Ganhar massa muscular",
                        CodigoPlanoTreino = 2,
                        CodigoUsuarioCriacao = 1
                    };

                    // Calcula o IMC
                    aluno.CalcularIMC();

                    // Adiciona e salva
                    context.Alunos.Add(aluno);
                    context.SaveChanges();

                    // Mensagem de sucesso
                    string script = "alert('Aluno cadastrado com sucesso! ID: " + aluno.Id_Aluno + "');";
                    ClientScript.RegisterStartupScript(this.GetType(), "SucessoCadastro", script, true);
                }
            }
            catch (Exception ex)
            {
                // Mensagem de erro
                string script = "alert('Erro ao cadastrar: " + ex.Message.Replace("'", "") + "');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErroCadastro", script, true);
            }


        }
    }
}
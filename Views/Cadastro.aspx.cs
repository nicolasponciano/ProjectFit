using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProjectFit.Models;

namespace ProjectFit
{
    public partial class Cadastro : System.Web.UI.Page
    {
        private readonly AppDbContext db = new AppDbContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    CarregarGrid();
                }
            }
            catch (Exception ex)
            {
                ExibirMensagem($"Erro ao carregar a página: {ex.Message}", "error");
            }
        }

        // Botão Cadastrar / Atualizar
        protected void btnCadastrar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && ValidarDados())
            {
                // Verifica se o CPF já existe
                var alunoExistente = db.Alunos.FirstOrDefault(a => a.Cpf == txtCpf.Text);



                if (alunoExistente == null)
                {
                    // Novo cadastro
                    var aluno = new Aluno
                    {
                        Cpf = txtCpf.Text,
                        Nome = txtNome.Text,
                        Email = txtEmail.Text,
                        Cep = txtCep.Text,
                        Telefone = txtTelefone.Text,
                        Peso = Convert.ToDouble(txtPeso.Text),
                        Altura = Convert.ToDouble(txtAltura.Text),
                        IMC = CalcularIMC(Convert.ToDouble(txtPeso.Text), Convert.ToDouble(txtAltura.Text)),
                        Meta = txtMeta.Text,
                        DataGravacao = DateTime.Now,
                        HashSenha = txtSenha.Text
                    };

                    db.Alunos.Add(aluno);
                    db.SaveChanges();
                    ExibirMensagem("Cadastro realizado com sucesso!", "success");
                }
                else
                {
                    // Atualização do cadastro
                    alunoExistente.Nome = txtNome.Text;
                    alunoExistente.Email = txtEmail.Text;
                    alunoExistente.Cep = txtCep.Text;
                    alunoExistente.Telefone = txtTelefone.Text;
                    alunoExistente.Peso = Convert.ToDouble(txtPeso.Text);
                    alunoExistente.Altura = Convert.ToDouble(txtAltura.Text);
                    alunoExistente.IMC = CalcularIMC(Convert.ToDouble(txtPeso.Text), Convert.ToDouble(txtAltura.Text));
                    alunoExistente.Meta = txtMeta.Text;
                    alunoExistente.DataAlteracao = DateTime.Now;

                    db.SaveChanges();
                    ExibirMensagem("Cadastro atualizado com sucesso!", "success");
                }

                LimparCampos();
                CarregarGrid();
            }
        }

        // Botão Buscar
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var aluno = db.Alunos.FirstOrDefault(a => a.Cpf == txtCpf.Text);

            if (aluno != null)
            {
                txtNome.Text = aluno.Nome;
                txtEmail.Text = aluno.Email;
                txtCep.Text = aluno.Cep;
                txtTelefone.Text = aluno.Telefone;
                txtPeso.Text = aluno.Peso.ToString();
                txtAltura.Text = aluno.Altura.ToString();
                txtIMC.Text = aluno.IMC.ToString("F2");
                txtMeta.Text = aluno.Meta;
            }
            else
            {
                ExibirMensagem("Aluno não encontrado.", "warning");
                LimparCampos();
            }
        }

        // Botão Excluir
        protected void btnExcluir_Click(object sender, EventArgs e)
        {
            var aluno = db.Alunos.FirstOrDefault(a => a.Cpf == txtCpf.Text);

            if (aluno != null)
            {
                db.Alunos.Remove(aluno);
                db.SaveChanges();
                ExibirMensagem("Cadastro excluído com sucesso!", "success");

                LimparCampos();
                CarregarGrid();
            }
            else
            {
                ExibirMensagem("Aluno não encontrado.", "warning");
            }
        }

        // Carregar GridView
        private void CarregarGrid()
        {
            gvAlunos.DataSource = db.Alunos.OrderBy(a => a.Nome).ToList();
            gvAlunos.DataBind();
        }

        // Limpar Campos
        private void LimparCampos()
        {
            txtCpf.Text = string.Empty;
            txtNome.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtCep.Text = string.Empty;
            txtTelefone.Text = string.Empty;
            txtPeso.Text = string.Empty;
            txtAltura.Text = string.Empty;
            txtIMC.Text = string.Empty;
            txtMeta.Text = string.Empty;
        }

        // Calcular IMC
        private double CalcularIMC(double peso, double altura)
        {
            if (altura > 0)
            {
                return peso / (altura * altura);
            }
            return 0;
        }

        // Exibir mensagens
        private void ExibirMensagem(string mensagem, string tipoAlerta)
        {
            // Definindo o tipo de alerta com base no parâmetro passado
            string script = $"Swal.fire({{ title: 'Mensagem', text: '{mensagem}', icon: '{tipoAlerta}', confirmButtonText: 'OK' }});";
            ClientScript.RegisterStartupScript(this.GetType(), "sweetalert", script, true);
        }

        // Paginação no GridView
        protected void gvAlunos_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            gvAlunos.PageIndex = e.NewPageIndex;
            CarregarGrid();
        }

        protected void btnLimpar_Click(object sender, EventArgs e)
        {
            LimparCampos();
        }


        // Função para validar os dados do formulário
        private bool ValidarDados()
        {
            // Verificar se os campos obrigatórios estão preenchidos
            if (string.IsNullOrEmpty(txtCpf.Text) ||
                string.IsNullOrEmpty(txtNome.Text) ||
                string.IsNullOrEmpty(txtEmail.Text) ||
                string.IsNullOrEmpty(txtCep.Text) ||
                string.IsNullOrEmpty(txtTelefone.Text) ||
                string.IsNullOrEmpty(txtPeso.Text) ||
                string.IsNullOrEmpty(txtAltura.Text) ||
                string.IsNullOrEmpty(txtMeta.Text))
            {
                ExibirMensagem("Todos os campos são obrigatórios!", "error");
                return false;
            }

            // Validar CPF (Formato simples de exemplo - pode ser melhorado)
            if (!ValidarCpf(txtCpf.Text))
            {
                ExibirMensagem("CPF inválido!", "error");
                return false;
            }

            // Validar Email
            if (!ValidarEmail(txtEmail.Text))
            {
                ExibirMensagem("E-mail inválido!", "error");
                return false;
            }

            // Validar Peso e Altura (deve ser um número)
            if (!double.TryParse(txtPeso.Text, out double peso) || peso <= 0)
            {
                ExibirMensagem("Peso inválido!", "error");
                return false;
            }

            if (!double.TryParse(txtAltura.Text, out double altura) || altura <= 0)
            {
                ExibirMensagem("Altura inválida!", "error");
                return false;
            }

            // Verifica se a senha foi preenchida
            if (string.IsNullOrEmpty(txtSenha.Text))
            {
                ExibirMensagem("A senha é obrigatória!", "error");
                return false;
            }

            // Verifica se a senha tem o tamanho mínimo de 6 caracteres
            if (txtSenha.Text.Length < 6)
            {
                ExibirMensagem("A senha deve ter no mínimo 6 caracteres!", "error");
                return false;
            }

            return true;
        }

        // Função para validar CPF
        private bool ValidarCpf(string cpf)
        {
            // Aqui você pode usar uma expressão regular para validar o formato do CPF ou implementar uma função de validação
            return cpf.Length == 11 && cpf.All(char.IsDigit);
        }

        // Função para validar Email
        private bool ValidarEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
    }
}

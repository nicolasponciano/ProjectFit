using System;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using ProjectFit.Models;
using System.Data.Entity.Validation;
using System.Web;

namespace ProjectFit.Account
{
    public partial class Register : Page
    {
        private readonly ApplicationDbContext db = new ApplicationDbContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (this.Master is SiteMaster master)
                {
                    master.ShowNavbar = false;
                }
            }
        }

        protected void CreateUser_Click(object sender, EventArgs e)
        {
            if (!ValidarDados())
            {
                return;
            }

            try
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();

                // Remove as máscaras do CPF, telefone e CEP
                string cpf = RemoverMascaras(txtCpf.Text);
                string telefone = RemoverMascaras(txtTelefone.Text);
                string cep = RemoverMascaras(txtCep.Text);
                string email = txtEmail.Text.Trim();

                // Verifica se o CPF já existe na tabela de alunos
                if (db.Alunos.Any(a => a.Cpf == cpf))
                {
                    ExibirMensagem("CPF já cadastrado!", "error");
                    return;
                }

                // Criação do usuário (já insere o registro na tabela AspNetUsers)
                var user = new ApplicationUser() { UserName = email, Email = email };
                IdentityResult result = manager.Create(user, Password.Text);
                if (!result.Succeeded)
                {
                    ErrorMessage.Text = result.Errors.FirstOrDefault();
                    return;
                }

                // Criação do aluno, vinculando pelo UserId gerado
                double peso = Convert.ToDouble(txtPeso.Text);
                double altura = Convert.ToDouble(txtAltura.Text);
                double imc = CalcularIMC(peso, altura);

                var aluno = new Aluno
                {
                    Cpf = cpf,
                    Nome = txtNome.Text.Trim(),
                    Email = email,
                    Cep = txtCep.Text.Trim(),
                    Telefone = telefone,
                    Peso = peso,
                    Altura = altura,
                    IMC = imc,
                    CodigoMeta = Convert.ToInt32(cboMeta.SelectedValue),
                    Meta = cboMeta.SelectedItem.Text,
                    DataGravacao = DateTime.Now,
                    // Atenção: Armazenar a senha em texto puro não é recomendado.
                    // Considere armazenar apenas o hash ou remover esse campo.
                    HashSenha = Password.Text,
                    UserId = user.Id
                };

                // Tenta salvar o aluno
                try
                {
                    db.Alunos.Add(aluno);
                    db.SaveChanges();
                }
                catch (Exception exAluno)
                {
                    // Se falhar, remove o usuário criado para evitar inconsistência
                    manager.Delete(user);
                    ExibirMensagem($"Erro ao salvar aluno: {exAluno.Message}", "error");
                    return;
                }

                // Se tudo ocorrer bem, exibe a mensagem de sucesso e realiza o login
                ExibirMensagem("Cadastro realizado com sucesso!", "success");
                LimparCampos();

                signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            catch (DbEntityValidationException ex)
            {
                // Extrai as mensagens de validação
                string errors = string.Join("; ",
                    ex.EntityValidationErrors.SelectMany(ev => ev.ValidationErrors)
                                               .Select(es => es.PropertyName + ": " + es.ErrorMessage));
                ExibirMensagem("Erro de validação: " + errors, "error");
            }
            catch (Exception ex)
            {
                ExibirMensagem($"Erro ao processar o cadastro: {ex.Message}", "error");
            }
        }


        private double CalcularIMC(double peso, double altura)
        {
            return altura > 0 ? peso / (altura * altura) : 0;
        }

        private void ExibirMensagem(string mensagem, string tipoAlerta)
        {
            string script = $"Swal.fire({{ title: 'Mensagem', text: '{mensagem}', icon: '{tipoAlerta}', confirmButtonText: 'OK' }});";
            ClientScript.RegisterStartupScript(this.GetType(), "sweetalert", script, true);
        }

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
            cboMeta.SelectedValue = "0";
        }

        private bool ValidarDados()
        {
            if (string.IsNullOrWhiteSpace(txtCpf.Text) ||
                string.IsNullOrWhiteSpace(txtNome.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtCep.Text) ||
                string.IsNullOrWhiteSpace(txtTelefone.Text) ||
                string.IsNullOrWhiteSpace(txtPeso.Text) ||
                string.IsNullOrWhiteSpace(txtAltura.Text) ||
                string.IsNullOrWhiteSpace(cboMeta.SelectedValue))
            {
                ExibirMensagem("Todos os campos são obrigatórios!", "error");
                return false;
            }

            string cpfLimpo = RemoverMascaras(txtCpf.Text);

            if (!ValidarCpf(cpfLimpo))
            {
                ExibirMensagem("CPF inválido!", "error");
                return false;
            }

            if (db.Alunos.Any(a => a.Cpf == cpfLimpo))
            {
                ExibirMensagem("CPF já cadastrado!", "error");
                return false;
            }

            if (!ValidarEmail(txtEmail.Text))
            {
                ExibirMensagem("E-mail inválido!", "error");
                return false;
            }

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

            if (string.IsNullOrWhiteSpace(Password.Text))
            {
                ExibirMensagem("A senha é obrigatória!", "error");
                return false;
            }

            if (Password.Text.Length < 6)
            {
                ExibirMensagem("A senha deve ter no mínimo 6 caracteres!", "error");
                return false;
            }

            return true;
        }

        private bool ValidarCpf(string cpf)
        {
            if (cpf.Length != 11 || !cpf.All(char.IsDigit))
                return false;

            if (new string(cpf[0], 11) == cpf)
                return false;

            int soma = 0;
            for (int i = 0; i < 9; i++)
                soma += (cpf[i] - '0') * (10 - i);
            int primeiroDigito = (soma % 11) < 2 ? 0 : 11 - (soma % 11);
            if (primeiroDigito != (cpf[9] - '0'))
                return false;

            soma = 0;
            for (int i = 0; i < 10; i++)
                soma += (cpf[i] - '0') * (11 - i);
            int segundoDigito = (soma % 11) < 2 ? 0 : 11 - (soma % 11);
            if (segundoDigito != (cpf[10] - '0'))
                return false;

            return true;
        }

        private bool ValidarEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email.Trim());
                return addr.Address == email.Trim();
            }
            catch
            {
                return false;
            }
        }

        // Função para remover qualquer máscara (como CPF, telefone, etc.)
        private string RemoverMascaras(string valor)
        {
            return new string(valor.Where(char.IsDigit).ToArray());
        }
    }
}

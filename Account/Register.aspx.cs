using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using ProjectFit.Models;



namespace ProjectFit.Account
{
    public partial class Register : Page
    {
        private readonly AppDbContext db = new AppDbContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Acessar a MasterPage e esconder a navbar
                var master = this.Master as SiteMaster;
                if (master != null)
                {
                    master.ShowNavbar = false;
                }
            }
        }

        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var user = new ApplicationUser() { UserName = txtEmail.Text, Email = txtEmail.Text };

            IdentityResult result = manager.Create(user, Password.Text);

            // Para obter mais informações sobre como habilitar a confirmação da conta e redefinição de senha, visite https://go.microsoft.com/fwlink/?LinkID=320771
            //string code = manager.GenerateEmailConfirmationToken(user.Id);
            //string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
            //manager.SendEmail(user.Id, "Confirme sua conta", "Confirme sua conta clicando <a href=\"" + callbackUrl + "\">aqui</a>.");



            if (result.Succeeded)
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
                            CodigoMeta = Convert.ToInt32(cboMeta.SelectedValue ?? "0"),
                            Meta = cboMeta.SelectedItem.Text, // Use SelectedItem.Text para obter o texto correto
                            DataGravacao = DateTime.Now,
                            HashSenha = Password.Text
                        };

                        // Adiciona e salva no banco de dados
                        db.Alunos.Add(aluno);
                        db.SaveChanges();

                        ExibirMensagem("Cadastro realizado com sucesso!", "success");
                        LimparCampos();

                        // Autentica o usuário
                        signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                    }
                    else
                    {
                        ExibirMensagem("CPF já cadastrado!", "error");
                    }
                }
            }
            else
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }




        private double CalcularIMC(double peso, double altura)
        {
            if (altura > 0)
            {
                return peso / (altura * altura);
            }
            return 0;
        }


        private void ExibirMensagem(string mensagem, string tipoAlerta)
        {
            // Definindo o tipo de alerta com base no parâmetro passado
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
            // Verificar se os campos obrigatórios estão preenchidos
            if (string.IsNullOrEmpty(txtCpf.Text) ||
                string.IsNullOrEmpty(txtNome.Text) ||
                string.IsNullOrEmpty(txtEmail.Text) ||
                string.IsNullOrEmpty(txtCep.Text) ||
                string.IsNullOrEmpty(txtTelefone.Text) ||
                string.IsNullOrEmpty(txtPeso.Text) ||
                string.IsNullOrEmpty(txtAltura.Text) ||
                string.IsNullOrEmpty(cboMeta.SelectedValue))
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
            if (string.IsNullOrEmpty(Password.Text))
            {
                ExibirMensagem("A senha é obrigatória!", "error");
                return false;
            }

            // Verifica se a senha tem o tamanho mínimo de 6 caracteres
            if (Password.Text.Length < 6)
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
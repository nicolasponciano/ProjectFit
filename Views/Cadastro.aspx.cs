using System;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using ProjectFit.Models;

namespace ProjectFit
{
    public partial class Cadastro : BasePage
    {
        private readonly ApplicationDbContext _appDb = new ApplicationDbContext();
        private readonly UserManager<ApplicationUser> _userManager;

        public Cadastro()
        {
            // UserManager configurado para ApplicationUser
            _userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(_appDb));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //verificar se o usuário é admin
                if (!UserIsAdmin)
                {

                    if (User != null && User.Identity.IsAuthenticated)
                    {
                        string nomeUsuario = User.Identity.Name;
                        Response.Redirect("~/Default.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                        
                    }
                    else
                    {
                        // Usuário não está logado
                        // Redirecione para a tela de login, se necessário
                        Response.Redirect("~/Account/Login.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                    }

                }

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

        protected async void btnCadastrar_Click(object sender, EventArgs e)
        {
            string cpf = RemoverMascaras(txtCpf.Text);
            string telefone = RemoverMascaras(txtTelefone.Text);
            string cep = RemoverMascaras(txtCep.Text);
            string email = txtEmail.Text.Trim();

            if (Page.IsValid && ValidarDados())
            {
                // Verifica se existe Aluno com esse CPF
                var alunoExistente = _appDb.Alunos.FirstOrDefault(a => a.Cpf == cpf);

                // Inicia uma transação EF
                using (var transaction = _appDb.Database.BeginTransaction())
                {
                    try
                    {

                        if (alunoExistente == null)
                        {

                            // ============== CRIAÇÃO DE NOVO ALUNO + USUÁRIO ==============

                            // 1) Criar o usuário no Identity
                            var newUser = new ApplicationUser
                            {
                                UserName = email,
                                Email = email,
                                IsAdmin = chkAdmin.Checked
                            };

                            var createUserResult = await _userManager.CreateAsync(newUser, txtSenha.Text);
                            if (!createUserResult.Succeeded)
                            {
                                transaction.Rollback();
                                ExibirMensagem($"Erro ao criar usuário: {string.Join(", ", createUserResult.Errors)}", "error");
                                return;
                            }

                            // 2) Criar o Aluno no banco, associando o UserId
                            var aluno = new Aluno
                            {
                                Cpf = cpf,
                                Nome = txtNome.Text,
                                Email = txtEmail.Text,
                                Cep = cep,
                                Telefone = telefone,
                                Peso = Convert.ToDouble(txtPeso.Text),
                                Altura = Convert.ToDouble(txtAltura.Text),
                                IMC = CalcularIMC(Convert.ToDouble(txtPeso.Text), Convert.ToDouble(txtAltura.Text)),
                                CodigoMeta = Convert.ToInt32(cboMeta.SelectedValue),
                                Meta = cboMeta.SelectedItem.Text,
                                DataGravacao = DateTime.Now,
                                // Guarda a senha em HashSenha apenas se for necessário, 
                                // mas lembre que a senha REAL está no AspNetUsers
                                HashSenha = txtSenha.Text,
                                IsAdmin = chkAdmin.Checked,

                                // Vinculando ao usuário recém-criado
                                UserId = newUser.Id
                            };

                            _appDb.Alunos.Add(aluno);
                            _appDb.SaveChanges();

                            // Tudo certo, commit
                            transaction.Commit();
                            ExibirMensagem("Cadastro realizado com sucesso!", "success");
                        }
                        else
                        {
                            // ============== ATUALIZAÇÃO DE ALUNO + USUÁRIO ==============

                            // 1) Atualiza dados do Aluno
                            alunoExistente.Nome = txtNome.Text;
                            alunoExistente.Email = email;
                            alunoExistente.Cep = cep;
                            alunoExistente.Telefone = txtTelefone.Text;
                            alunoExistente.Peso = Convert.ToDouble(txtPeso.Text);
                            alunoExistente.Altura = Convert.ToDouble(txtAltura.Text);
                            alunoExistente.IMC = CalcularIMC(Convert.ToDouble(txtPeso.Text), Convert.ToDouble(txtAltura.Text));
                            alunoExistente.CodigoMeta = Convert.ToInt32(cboMeta.SelectedValue);
                            alunoExistente.Meta = cboMeta.SelectedItem.Text;
                            alunoExistente.DataAlteracao = DateTime.Now;
                            alunoExistente.IsAdmin = chkAdmin.Checked;

                            // Se você quiser armazenar a senha no campo HashSenha
                            alunoExistente.HashSenha = txtSenha.Text;

                            _appDb.SaveChanges();

                            // 2) Atualiza dados do Usuário no Identity
                            // Primeiro, garante que temos o UserId do aluno
                            if (string.IsNullOrEmpty(alunoExistente.UserId))
                            {
                                // Se não tiver UserId, não há como atualizar AspNetUsers
                                // Você pode tratar esse caso criando o usuário, se necessário.
                                transaction.Rollback();
                                ExibirMensagem("Não foi possível atualizar: Aluno não possui UserId associado.", "error");
                                return;
                            }

                            // Localiza o usuário pelo Id (forma mais segura do que por e-mail)
                            var user = await _userManager.FindByIdAsync(alunoExistente.UserId);
                            if (user == null)
                            {
                                transaction.Rollback();
                                ExibirMensagem("Usuário não encontrado no sistema.", "error");
                                return;
                            }

                            // Atualiza campos do Identity
                            user.UserName = txtEmail.Text;
                            user.Email = txtEmail.Text;
                            user.IsAdmin = chkAdmin.Checked;

                            // Se a senha mudou, atualize também no Identity (opcional)
                            // Neste exemplo, removemos e adicionamos a nova senha:
                            if (!string.IsNullOrEmpty(txtSenha.Text))
                            {
                                // Remove a senha antiga
                                await _userManager.RemovePasswordAsync(user.Id);
                                // Adiciona a nova senha
                                var addPassResult = await _userManager.AddPasswordAsync(user.Id, txtSenha.Text);
                                if (!addPassResult.Succeeded)
                                {
                                    transaction.Rollback();
                                    ExibirMensagem($"Erro ao atualizar a senha: {string.Join(", ", addPassResult.Errors)}", "error");
                                    return;
                                }
                            }

                            // Persiste alterações no usuário
                            var updateUserResult = await _userManager.UpdateAsync(user);
                            if (!updateUserResult.Succeeded)
                            {
                                transaction.Rollback();
                                ExibirMensagem($"Erro ao atualizar usuário: {string.Join(", ", updateUserResult.Errors)}", "error");
                                return;
                            }

                            // Tudo certo, commit
                            transaction.Commit();
                            ExibirMensagem("Cadastro atualizado com sucesso!", "success");
                        }

                        LimparCampos();
                        CarregarGrid();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        ExibirMensagem($"Erro ao realizar a operação: {ex.Message}", "error");
                    }
                }
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

            string cpf = RemoverMascaras(txtCpf.Text);
            var aluno = _appDb.Alunos.FirstOrDefault(a => a.Cpf == cpf);

            if (aluno != null)
            {
                txtNome.Text = aluno.Nome;
                txtEmail.Text = aluno.Email;
                txtCep.Text = aluno.Cep;
                txtTelefone.Text = aluno.Telefone;
                txtPeso.Text = aluno.Peso.ToString();
                txtAltura.Text = aluno.Altura.ToString();
                txtIMC.Text = aluno.IMC.ToString("F2");
                cboMeta.SelectedValue = aluno.CodigoMeta.ToString();
                cboMeta.Text = aluno.Meta;
                chkAdmin.Checked = aluno.IsAdmin;
            }
            else
            {
                ExibirMensagem("Aluno não encontrado.", "warning");
                LimparCampos();
            }
        }

        protected void btnExcluir_Click(object sender, EventArgs e)
        {
            var aluno = _appDb.Alunos.FirstOrDefault(a => a.Cpf == txtCpf.Text);

            if (aluno != null)
            {
                using (var transaction = _appDb.Database.BeginTransaction())
                {
                    try
                    {
                        // Remove o aluno
                        _appDb.Alunos.Remove(aluno);
                        _appDb.SaveChanges();

                        // Remove o usuário do AspNetUsers
                        // Mas primeiro precisamos ter certeza de que existe um UserId
                        if (!string.IsNullOrEmpty(aluno.UserId))
                        {
                            var user = _appDb.Users.FirstOrDefault(u => u.Id == aluno.UserId);
                            if (user != null)
                            {
                                var result = _userManager.DeleteAsync(user).Result;
                                if (!result.Succeeded)
                                {
                                    transaction.Rollback();
                                    ExibirMensagem("Erro ao excluir usuário: " + string.Join(", ", result.Errors), "error");
                                    return;
                                }
                            }
                        }

                        transaction.Commit();
                        ExibirMensagem("Cadastro excluído com sucesso!", "success");
                        LimparCampos();
                        CarregarGrid();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        ExibirMensagem($"Erro ao excluir o cadastro: {ex.Message}", "error");
                    }
                }
            }
            else
            {
                ExibirMensagem("Aluno não encontrado.", "warning");
            }
        }

        private void CarregarGrid()
        {
            gvAlunos.DataSource = _appDb.Alunos.OrderBy(a => a.Nome).ToList();
            gvAlunos.DataBind();
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
            cboMeta.Text = string.Empty;
            txtSenha.Text = string.Empty;
            chkAdmin.Checked = false;
        }

        private double CalcularIMC(double peso, double altura)
        {
            return altura > 0 ? peso / (altura * altura) : 0;
        }

        protected void gvAlunos_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            gvAlunos.PageIndex = e.NewPageIndex;
            CarregarGrid();
        }

        protected void btnLimpar_Click(object sender, EventArgs e)
        {
            LimparCampos();
        }

        private bool ValidarDados()
        {
            if (string.IsNullOrEmpty(txtCpf.Text) ||
                string.IsNullOrEmpty(txtNome.Text) ||
                string.IsNullOrEmpty(txtEmail.Text) ||
                string.IsNullOrEmpty(txtCep.Text) ||
                string.IsNullOrEmpty(txtTelefone.Text) ||
                string.IsNullOrEmpty(txtPeso.Text) ||
                string.IsNullOrEmpty(txtAltura.Text) ||
                string.IsNullOrEmpty(cboMeta.Text))
            {
                ExibirMensagem("Todos os campos são obrigatórios!", "error");
                return false;
            }

            if (!ValidarCpf(txtCpf.Text))
            {
                ExibirMensagem("CPF inválido!", "error");
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

            if (string.IsNullOrEmpty(txtSenha.Text) || txtSenha.Text.Length < 6)
            {
                ExibirMensagem("A senha deve ter no mínimo 6 caracteres!", "error");
                return false;
            }

            return true;
        }

        private bool ValidarCpf(string cpf)
        {
            // Remove possíveis caracteres não numéricos (como pontos e traços)
            cpf = cpf.Replace(".", "").Replace("-", "");

            // Verifica se o CPF tem 11 caracteres numéricos
            if (cpf.Length != 11 || !cpf.All(char.IsDigit))
                return false;

            // Verifica se o CPF é de um número repetido (exemplo: 111.111.111-11, 222.222.222-22, etc.)
            if (new string(cpf[0], 11) == cpf)
                return false;

            // Validação do primeiro dígito verificador
            int soma = 0;
            for (int i = 0; i < 9; i++)
                soma += (cpf[i] - '0') * (10 - i);

            int primeiroDigito = (soma % 11) < 2 ? 0 : 11 - (soma % 11);
            if (primeiroDigito != (cpf[9] - '0'))
                return false;

            // Validação do segundo dígito verificador
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
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private string RemoverMascaras(string valor)
        {
            return new string(valor.Where(char.IsDigit).ToArray());
        }

    }
}

<%@ Page Title="Registre-se" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ProjectFit.Account.Register" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <!-- Inclusão de CSS de ícones e SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>

    <!-- Importação de Fonte Moderna -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">

    <!-- Estilo Customizado -->
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #2C3E50, #FF4136); /* Gradiente inicial */
            transition: background 0.3s ease; /* Transição suave para o fundo */
            color: #fff;
        }
        body:hover {
            background: linear-gradient(135deg, #FF4136, #2C3E50); /* Gradiente ao passar o mouse */
        }
        .min-vh-100 {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative; /* Permite posicionar a logo absolutamente */
        }
        .card {
            border-radius: 20px;
            border: none;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            padding: 1.5rem; /* Padding padrão */
            background: #ffffff;
            width: 100%;
            max-width: 800px; /* Largura fixa */
            min-height: auto; /* Altura automática */
            position: relative; /* Referência para posicionar a logo */
        }
        .logo-container {
            position: absolute; /* Remove a logo do fluxo normal */
            top: 15px; /* Posiciona a logo acima do card */
            left: 50%; /* Centraliza horizontalmente */
            transform: translateX(-50%); /* Ajusta o centro */
            width: 150px; /* Largura fixa para o contêiner da logo */
            height: 150px; /* Altura fixa para o contêiner da logo */
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden; /* Garante que a logo não ultrapasse o contêiner */
        }
        .logo-container img {
            max-width: 150px; /* Limita o tamanho máximo da logo */
            max-height: 150px; /* Limita a altura máxima da logo */
            width: 150px;
            height: 150px;
            object-fit: contain; /* Garante que a logo fique proporcional */
            transition: transform 0.3s ease, filter 0.3s ease;
        }
        h2.card-title {
            font-family: 'Poppins', sans-serif; /* Fonte moderna */
            font-size: 1.8rem; /* Tamanho maior */
            font-weight: 600; /* Negrito */
            color: #FF4136; /* Cor vermelha vibrante */
            margin-bottom: 1.5rem;
            text-transform: uppercase; /* Letras maiúsculas */
            letter-spacing: 1px; /* Espaçamento entre letras */
        }
        .form-control {
            border-radius: 10px;
            border: 1px solid #ccc;
            transition: all 0.3s ease;
            background-color: #eef1f8;
            color: #333; /* Cor do texto dentro dos campos */
        }
        .form-control:focus {
            border-color: #FF4136;
            box-shadow: 0 0 0 0.15rem rgba(255, 65, 54, 0.25);
        }
        .btn-primary {
            background: #FF4136;
            border: none;
            color: #fff;
            padding: 0.75rem;
            font-weight: 600;
            border-radius: 10px;
            transition: background 0.3s ease;
        }
        .btn-primary:hover {
            background: #E74C3C;
        }
        /* Estilos específicos para os links */
        a.fw-bold {
            color: #2C3E50 !important; /* Cor principal */
            text-decoration: none; /* Remove sublinhado */
            font-weight: bold; /* Texto em negrito */
            transition: color 0.3s ease; /* Transição suave */
        }
        a.fw-bold:hover {
            color: #FF4136 !important; /* Cor ao passar o mouse */
            text-decoration: underline; /* Sublinhado ao passar o mouse */
        }
        .invalid-feedback {
            display: block;
            font-size: 0.8rem;
            color: #dc3545;
        }
    </style>

    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <!-- Contêiner da Logo (Fora do Fluxo Normal) -->
        <div class="logo-container" id="logoAnimation">
            <asp:Image 
                ID="imgLogo" 
                runat="server" 
                ImageUrl="~/Images/logo-transparent.png" 
                AlternateText="ProjectFit" 
                CssClass="navbar-logo me-2" />
        </div>
        <div class="card shadow-lg">
            <div class="card-body p-4"> <!-- Reduzido padding -->
                <h2 class="card-title text-center mb-3">Registre-se</h2>
                <p class="text-center text-muted mb-3">Crie sua conta para começar</p>
                
                <!-- Mensagens de Erro -->
                <asp:ValidationSummary runat="server" CssClass="alert alert-danger mb-3" />
                <div class="text-danger mb-3">
                    <asp:Literal runat="server" ID="ErrorMessage" />
                </div>
                
                <!-- Formulário -->
                <form id="registerForm">
                    <div class="row g-3">
                        <!-- Coluna 1 -->
                        <div class="col-12 col-md-6">
                            <!-- Email -->
                            <div class="mb-3">
                                <label for="txtEmail" class="form-label fw-bold">E-mail</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-envelope"></i>
                                    </span>
                                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control form-control-lg"
                                        placeholder="nome@exemplo.com" />
                                </div>
                                <div class="invalid-feedback" id="emailFeedback"></div>
                            </div>
                            <!-- Nome Completo -->
                            <div class="mb-3">
                                <label for="txtNome" class="form-label fw-bold">Nome Completo</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-person"></i>
                                    </span>
                                    <asp:TextBox ID="txtNome" CssClass="form-control form-control-lg" runat="server" />
                                </div>
                            </div>
                            <!-- CPF -->
                            <div class="mb-3">
                                <label for="txtCpf" class="form-label fw-bold">CPF</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-card-text"></i>
                                    </span>
                                    <asp:TextBox ID="txtCpf" CssClass="form-control form-control-lg cpf-mask" runat="server" placeholder="000.000.000-00" />
                                </div>
                            </div>
                            <!-- Telefone -->
                            <div class="mb-3">
                                <label for="txtTelefone" class="form-label fw-bold">Telefone</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-telephone"></i>
                                    </span>
                                    <asp:TextBox ID="txtTelefone" CssClass="form-control form-control-lg phone-mask" runat="server" placeholder="(00) 00000-0000" />
                                </div>
                            </div>
                        </div>
                        <!-- Coluna 2 -->
                        <div class="col-12 col-md-6">
                            <!-- Senha -->
                            <div class="mb-3">
                                <label for="Password" class="form-label fw-bold">Senha</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock"></i>
                                    </span>
                                    <asp:TextBox runat="server" ID="Password" TextMode="Password"
                                        CssClass="form-control form-control-lg"
                                        placeholder="Mínimo 8 caracteres" />
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="bi bi-eye-slash"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback" id="passwordFeedback"></div>
                            </div>
                            <!-- Confirmar Senha com opção de visualizar -->
                            <div class="mb-3">
                                <label for="ConfirmPassword" class="form-label fw-bold">Confirmar Senha</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock"></i>
                                    </span>
                                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password"
                                        CssClass="form-control form-control-lg"
                                        placeholder="Confirme sua senha" />
                                    <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                                        <i class="bi bi-eye-slash"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback" id="confirmPasswordFeedback"></div>
                            </div>
                            <!-- Dados Físicos -->
                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <label for="txtPeso" class="form-label fw-bold">Peso (kg)</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-speedometer2"></i>
                                        </span>
                                        <asp:TextBox ID="txtPeso" CssClass="form-control form-control-lg weight-mask" runat="server" placeholder="Ex: 75" />
                                    </div>
                                </div>
                                <div class="col-6">
                                    <label for="txtAltura" class="form-label fw-bold">Altura (m)</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-arrow-up"></i>
                                        </span>
                                        <asp:TextBox ID="txtAltura" CssClass="form-control form-control-lg height-mask" runat="server" placeholder="Ex: 1.75" />
                                    </div>
                                </div>
                            </div>
                            <!-- Campo IMC oculto -->
                            <div style="display: none;">
                                <asp:TextBox ID="txtIMC" CssClass="form-control form-control-lg bg-light" runat="server" ReadOnly="True" />
                            </div>
                            <!-- CEP e Meta lado a lado -->
                            <div class="row g-2">
                                <div class="col-6">
                                    <label for="txtCep" class="form-label fw-bold">CEP</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-geo-alt"></i>
                                        </span>
                                        <asp:TextBox ID="txtCep" CssClass="form-control form-control-lg cep-mask" runat="server" placeholder="00000-000" />
                                    </div>
                                </div>
                                <div class="col-6">
                                    <label for="cboMeta" class="form-label fw-bold">Meta</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-bullseye"></i>
                                        </span>
                                        <asp:DropDownList ID="cboMeta" CssClass="form-control form-control-lg" runat="server">
                                            <asp:ListItem Text="Selecione a Meta..." Value="0" Selected="True" />
                                            <asp:ListItem Text="Definição" Value="1" />
                                            <asp:ListItem Text="Ganho de Massa" Value="2" />
                                            <asp:ListItem Text="Perda de Peso" Value="3" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Botão de Registro -->
                    <div class="d-grid mt-4">
                        <asp:Button runat="server" OnClick="CreateUser_Click"
                            Text="Criar Conta"
                            CssClass="btn btn-primary btn-lg w-100 mb-3 hover-scale" />
                    </div>
                </form>
                <!-- Link de Login -->
                <div class="text-center mt-3">
                    <p class="text-muted mb-0">
                        Já tem uma conta?
                        <asp:HyperLink runat="server" NavigateUrl="~/Account/Login" CssClass="fw-bold">Entrar</asp:HyperLink>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Efeito sofisticado na Logo
        const logo = document.getElementById('logoAnimation');
        logo.addEventListener('mouseover', () => {
            logo.querySelector('img').style.transform = 'rotate(-5deg) scale(1.05)';
            logo.querySelector('img').style.filter = 'brightness(1.2)'; // Brilho aumentado
        });
        logo.addEventListener('mouseout', () => {
            logo.querySelector('img').style.transform = 'rotate(0deg) scale(1)';
            logo.querySelector('img').style.filter = 'brightness(1)'; // Voltar ao brilho normal
        });

        // Toggle Password
        const togglePassword = document.getElementById('togglePassword');
        const passwordField = document.getElementById('<%= Password.ClientID %>');
        togglePassword.addEventListener('click', () => {
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
            togglePassword.querySelector('i').classList.toggle('bi-eye');
            togglePassword.querySelector('i').classList.toggle('bi-eye-slash');
        });

        // Toggle Confirm Password
        const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
        const confirmPasswordField = document.getElementById('<%= ConfirmPassword.ClientID %>');
        toggleConfirmPassword.addEventListener('click', () => {
            const type = confirmPasswordField.getAttribute('type') === 'password' ? 'text' : 'password';
            confirmPasswordField.setAttribute('type', type);
            toggleConfirmPassword.querySelector('i').classList.toggle('bi-eye');
            toggleConfirmPassword.querySelector('i').classList.toggle('bi-eye-slash');
        });

        // Máscaras nos campos
        $(document).ready(function () {
            $('.cpf-mask').mask('000.000.000-00', { reverse: true });
            $('.phone-mask').mask('(00) 00000-0000');
            $('.cep-mask').mask('00000-000');
            $('.weight-mask').mask('000', { reverse: true }); // Apenas números para peso
            $('.height-mask').mask('0.00', { reverse: true }); // Altura em metros
        });

        // Validação em Tempo Real
        document.getElementById('<%= txtEmail.ClientID %>').addEventListener('input', function () {
            this.classList.remove('is-invalid');
            if (!this.value.match(/^\S+@\S+\.\S+$/)) {
                this.classList.add('is-invalid');
                document.getElementById('emailFeedback').textContent = 'Por favor, insira um e-mail válido';
            } else {
                document.getElementById('emailFeedback').textContent = '';
            }
        });
        document.getElementById('<%= Password.ClientID %>').addEventListener('input', function () {
            this.classList.remove('is-invalid');
            if (this.value.length < 8) {
                this.classList.add('is-invalid');
                document.getElementById('passwordFeedback').textContent = 'A senha deve ter pelo menos 8 caracteres';
            } else {
                document.getElementById('passwordFeedback').textContent = '';
            }
        });
        document.getElementById('<%= ConfirmPassword.ClientID %>').addEventListener('input', function () {
            this.classList.remove('is-invalid');
            if (this.value !== document.getElementById('<%= Password.ClientID %>').value) {
                this.classList.add('is-invalid');
                document.getElementById('confirmPasswordFeedback').textContent = 'As senhas não coincidem';
            } else {
                document.getElementById('confirmPasswordFeedback').textContent = '';
            }
        });
    </script>
</asp:Content>
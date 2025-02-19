<%@ Page Title="Registre-se" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ProjectFit.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow-lg" style="width: 100%; max-width: 800px;">
            <div class="card-body p-5">
                <!-- Logo Animado -->
                <div class="text-center mb-4">
                    <div class="logo-container mb-4" id="logoAnimation">
                        <div class="d-flex justify-content-center align-items-center">
                            <div class="dumbbell-icon">
                                <i class="bi bi-heart-pulse-fill text-primary fs-1"></i>
                            </div>
                            <h1 class="logo-text ms-3 fw-bold">Project<span class="text-primary">Fit</span></h1>
                        </div>
                    </div>
                </div>

                <h2 class="card-title text-center mb-4">Registre-se</h2>
                <p class="text-center text-muted mb-4">Crie sua conta para começar</p>

                <!-- Mensagens de Erro -->
                <asp:ValidationSummary runat="server" CssClass="alert alert-danger mb-4" />
                <div class="text-danger mb-4">
                    <asp:Literal runat="server" ID="ErrorMessage" />
                </div>

                <!-- Formulário -->
                <form id="registerForm">
                    <div class="row g-4">
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
                                    <asp:TextBox ID="txtCpf" CssClass="form-control form-control-lg" runat="server" placeholder="000.000.000-00" />
                                </div>
                            </div>

                            <!-- Telefone -->
                            <div class="mb-3">
                                <label for="txtTelefone" class="form-label fw-bold">Telefone</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-telephone"></i>
                                    </span>
                                    <asp:TextBox ID="txtTelefone" CssClass="form-control form-control-lg" runat="server" placeholder="(00) 00000-0000" />
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

                            <!-- Confirmar Senha -->
                            <div class="mb-3">
                                <label for="ConfirmPassword" class="form-label fw-bold">Confirmar Senha</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock"></i>
                                    </span>
                                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password"
                                        CssClass="form-control form-control-lg"
                                        placeholder="Confirme sua senha" />
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
                                        <asp:TextBox ID="txtPeso" CssClass="form-control form-control-lg" runat="server" placeholder="Ex: 75" />
                                    </div>
                                </div>
                                <div class="col-6">
                                    <label for="txtAltura" class="form-label fw-bold">Altura (m)</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-arrow-up"></i>
                                        </span>
                                        <asp:TextBox ID="txtAltura" CssClass="form-control form-control-lg" runat="server" placeholder="Ex: 1.75" />
                                    </div>
                                </div>
                            </div>

                            <!-- IMC -->
                            <div class="mb-3">
                                <label for="txtIMC" class="form-label fw-bold">IMC</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-calculator"></i>
                                    </span>
                                    <asp:TextBox ID="txtIMC" CssClass="form-control form-control-lg bg-light" runat="server" ReadOnly="True" />
                                </div>
                            </div>

                            <!-- CEP e Meta lado a lado -->
                            <div class="row g-2">
                                <div class="col-6">
                                    <label for="txtCep" class="form-label fw-bold">CEP</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-geo-alt"></i>
                                        </span>
                                        <asp:TextBox ID="txtCep" CssClass="form-control form-control-lg" runat="server" placeholder="00000-000" />
                                    </div>
                                </div>
                                <div class="col-6">
                                    <label for="cboMeta" class="form-label fw-bold">Meta</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-bullseye"></i>
                                        </span>
                                        <asp:DropDownList ID="cboMeta" CssClass="form-control form-control-lg" runat="server">
                                            <asp:ListItem Text="Selecione..." Value="0" Selected="True" />
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
                <div class="text-center mt-4">
                    <p class="text-muted mb-0">
                        Já tem uma conta?
                        <asp:HyperLink runat="server" NavigateUrl="~/Account/Login" CssClass="fw-bold">Entrar</asp:HyperLink>
                </div>
            </div>
        </div>
    </div>

    <style>
        .min-vh-100 {
            min-height: 100vh;
            background: #ffffff;
        }

        .card {
            border-radius: 20px;
            border: none;
            transition: transform 0.3s ease;
        }


        .logo-container {
            transition: transform 0.3s ease;
        }

        .logo-container:hover {
            transform: scale(1.05);
        }

        .logo-text {
            font-family: 'Arial Rounded MT Bold', sans-serif;
            letter-spacing: 1px;
        }

        .input-group-text {
            background: #fff;
            border-right: none;
        }

        .form-control {
            border-left: none;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #dee2e6;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            position: relative;
            overflow: hidden;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0056b3 0%, #003d80 100%);
        }

        .hover-scale {
            transition: transform 0.2s ease;
        }

        .hover-scale:hover {
            transform: scale(1.02);
        }

        .invalid-feedback {
            display: none;
        }

        .was-validated .invalid-feedback {
            display: block;
        }
    </style>

    <script>
        // Animação do Logo
        const logo = document.getElementById('logoAnimation');
        logo.addEventListener('mouseover', () => {
            logo.style.transform = 'rotate(-5deg)';
        });
        logo.addEventListener('mouseout', () => {
            logo.style.transform = 'rotate(0deg)';
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

        // Validação em Tempo Real
        document.getElementById('<%= txtEmail.ClientID %>').addEventListener('input', function () {
            this.classList.remove('is-invalid');
            if (!this.value.match(/^\S+@\S+\.\S+$/)) {
                this.classList.add('is-invalid');
                document.getElementById('emailFeedback').textContent = 'Por favor, insira um e-mail válido';
            }
        });

        document.getElementById('<%= Password.ClientID %>').addEventListener('input', function () {
            this.classList.remove('is-invalid');
            if (this.value.length < 8) {
                this.classList.add('is-invalid');
                document.getElementById('passwordFeedback').textContent = 'A senha deve ter pelo menos 8 caracteres';
            }
        });

        document.getElementById('<%= ConfirmPassword.ClientID %>').addEventListener('input', function () {
            this.classList.remove('is-invalid');
            if (this.value !== document.getElementById('<%= Password.ClientID %>').value) {
                this.classList.add('is-invalid');
                document.getElementById('confirmPasswordFeedback').textContent = 'As senhas não coincidem';
            }
        });
    </script>
</asp:Content>
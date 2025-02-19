<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProjectFit.Account.Login" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow-lg" style="width: 100%; max-width: 500px;">
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

                <h2 class="card-title text-center mb-4">Bem-vindo de Volta</h2>
                
                <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                    <div class="alert alert-danger" role="alert">
                        <asp:Literal runat="server" ID="FailureText" />
                    </div>
                </asp:PlaceHolder>

                <form id="loginForm">
                    <!-- Email Input -->
                    <div class="mb-3">
                        <label for="Email" class="form-label">E-mail</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-envelope"></i>
                            </span>
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control form-control-lg" 
                                TextMode="Email" placeholder="nome@exemplo.com" />
                        </div>
                        <div class="invalid-feedback" id="emailFeedback"></div>
                    </div>

                    <!-- Password Input -->
                    <div class="mb-4">
                        <label for="Password" class="form-label">Senha</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-lock"></i>
                            </span>
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" 
                                CssClass="form-control form-control-lg" placeholder="••••••••" />
                            <button class="btn btn-outline-secondary" type="button" 
                                id="togglePassword">
                                <i class="bi bi-eye-slash"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback" id="passwordFeedback"></div>
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <asp:CheckBox runat="server" ID="RememberMe" CssClass="" />
                            <label class="form-check-label" for="RememberMe">Lembrar-me</label>
                        </div>
                        <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" 
                            CssClass="text-decoration-none" ViewStateMode="Disabled">
                            Esqueceu a senha?
                        </asp:HyperLink>
                    </div>

                    <!-- Submit Button -->
                    <asp:Button runat="server" OnClick="LogIn" Text="Entrar" 
                        CssClass="btn btn-primary btn-lg w-100 mb-3 hover-scale" />

                    <!-- Register Link -->
                    <div class="text-center">
                        <span class="text-muted">Não tem uma conta? </span>
                        <asp:HyperLink runat="server" ID="RegisterHyperLink" 
                            CssClass="text-decoration-none fw-bold hover-scale" ViewStateMode="Disabled">
                            Cadastre-se
                        </asp:HyperLink>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <style>
        .min-vh-100 {
            min-height: 100vh;
            background: #ffffff; /* Fundo branco */
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

        /* Estilo personalizado para o checkbox */
        .form-check-input {
            width: 1.2em;
            height: 1.2em;
            margin-top: 0.2em;
            border: 2px solid #007bff;
        }

        .form-check-input:checked {
            background-color: #007bff;
            border-color: #007bff;
        }

        .form-check-label {
            margin-left: 0.5em;
            color: #555;
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
        document.getElementById('<%= Email.ClientID %>').addEventListener('input', function() {
            this.classList.remove('is-invalid');
            if (!this.value.match(/^\S+@\S+\.\S+$/)) {
                this.classList.add('is-invalid');
                document.getElementById('emailFeedback').textContent = 'Por favor, insira um e-mail válido';
            }
        });

        document.getElementById('<%= Password.ClientID %>').addEventListener('input', function () {
            this.classList.remove('is-invalid');
            if (this.value.length < 6) {
                this.classList.add('is-invalid');
                document.getElementById('passwordFeedback').textContent = 'A senha deve ter pelo menos 6 caracteres';
            }
        });
    </script>
</asp:Content>
<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProjectFit.Account.Login" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <!-- Adicionar CDN do Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow-lg" style="width: 100%; max-width: 500px;">
            <div class="card-body p-5">
                <!-- Logo da Academia -->
                <div class="text-center mb-4">
                    <img src="https://via.placeholder.com/100x100.png?text=GYM+Logo" 
                         alt="Logo Academia" 
                         class="img-fluid rounded-circle mb-3" 
                         style="width: 100px; height: 100px; object-fit: cover;">
                </div>
                
                <h2 class="card-title text-center mb-4">Bem-vindo de Volta</h2>
                
                <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                    <div class="alert alert-danger" role="alert">
                        <asp:Literal runat="server" ID="FailureText" />
                    </div>
                </asp:PlaceHolder>

                <form>
                    <!-- Email Input -->
                    <div class="mb-3">
                        <label for="Email" class="form-label">E-mail</label>
                        <asp:TextBox runat="server" ID="Email" CssClass="form-control form-control-lg" 
                            TextMode="Email" placeholder="nome@exemplo.com" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                            CssClass="text-danger small" ErrorMessage="O campo e-mail é obrigatório." 
                            Display="Dynamic" />
                    </div>

                    <!-- Password Input com Botão de Visualização -->
                    <div class="mb-4">
                        <label for="Password" class="form-label">Senha</label>
                        <div class="input-group">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" 
                                CssClass="form-control form-control-lg" placeholder="••••••••" />
                            <button class="btn btn-outline-secondary" type="button" 
                                id="togglePassword" 
                                onclick="togglePasswordVisibility()">
                                <i class="bi bi-eye-slash"></i>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" 
                            CssClass="text-danger small" ErrorMessage="O campo senha é obrigatório." 
                            Display="Dynamic" />
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <asp:CheckBox runat="server" ID="RememberMe" CssClass="form-check-input" />
                            <label class="form-check-label" for="RememberMe">Lembrar-me</label>
                        </div>
                        <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" 
                            CssClass="text-decoration-none" ViewStateMode="Disabled">
                            Esqueceu a senha?
                        </asp:HyperLink>
                    </div>

                    <!-- Submit Button -->
                    <asp:Button runat="server" OnClick="LogIn" Text="Entrar" 
                        CssClass="btn btn-primary btn-lg w-100 mb-3" />

                    <!-- Register Link -->
                    <div class="text-center">
                        <span class="text-muted">Não tem uma conta? </span>
                        <asp:HyperLink runat="server" ID="RegisterHyperLink" 
                            CssClass="text-decoration-none fw-bold" ViewStateMode="Disabled">
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
        }
        
        .card {
            border-radius: 15px;
            border: none;
        }
        
        .form-control {
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
        }
        
        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 12px;
            transition: background-color 0.3s ease;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
        }
        
        .form-check-input:checked {
            background-color: #007bff;
            border-color: #007bff;
        }
        
        /* Estilo personalizado para o botão de visualização de senha */
        #togglePassword {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
            border-left: none;
        }
    </style>

    <script>
        // Função para alternar visibilidade da senha
        function togglePasswordVisibility() {
            const passwordField = document.getElementById('<%= Password.ClientID %>');
            const toggleButton = document.getElementById('togglePassword');

            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleButton.innerHTML = '<i class="bi bi-eye"></i>';
            } else {
                passwordField.type = "password";
                toggleButton.innerHTML = '<i class="bi bi-eye-slash"></i>';
            }
        }

        // Adiciona feedback visual ao interagir com os campos
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function () {
                this.parentElement.classList.add('input-focused');
            });

            input.addEventListener('blur', function () {
                this.parentElement.classList.remove('input-focused');
            });
        });
    </script>
</asp:Content>
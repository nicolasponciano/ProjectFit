<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProjectFit.Account.Login" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
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
            padding: 2rem; /* Padding padrão */
            background: #ffffff;
            width: 100%;
            max-width: 420px; /* Largura fixa */
            min-height: 500px; /* Altura mínima para tornar o card mais quadrado */
            position: relative; /* Referência para posicionar a logo */
        }

        .logo-container {
            position: absolute; /* Remove a logo do fluxo normal */
            top: -100px; /* Posiciona a logo acima do card */
            left: 50%; /* Centraliza horizontalmente */
            transform: translateX(-50%); /* Ajusta o centro */
            width: 200px; /* Largura fixa para o contêiner da logo */
            height: 200px; /* Altura fixa para o contêiner da logo */
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden; /* Garante que a logo não ultrapasse o contêiner */
        }

        .logo-container img {
            max-width: 100%; /* Limita o tamanho máximo da logo */
            max-height: 100%; /* Limita a altura máxima da logo */
            width: auto;
            height: auto;
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
        #ForgotPasswordHyperLink,
        #RegisterHyperLink {
            color: #2C3E50 !important; /* Cor principal */
            text-decoration: none; /* Remove sublinhado */
            font-weight: bold; /* Texto em negrito */
            transition: color 0.3s ease; /* Transição suave */
        }

        #ForgotPasswordHyperLink:hover,
        #RegisterHyperLink:hover {
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
        <div class="card shadow-lg">
            <!-- Contêiner da Logo (Fora do Fluxo Normal) -->
            <div class="logo-container" id="logoAnimation">
                <asp:Image 
                    ID="imgLogo" 
                    runat="server" 
                    ImageUrl="~/Images/logo-transparent.png" 
                    AlternateText="ProjectFit" 
                    CssClass="navbar-logo me-2" />
            </div>

            <div class="card-body">
                <h2 class="card-title text-center mb-4">Seja Bem-Vindo ao ProjectFit!</h2>

                <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                    <div class="alert alert-danger" role="alert">
                        <asp:Literal runat="server" ID="FailureText" />
                    </div>
                </asp:PlaceHolder>

                <form id="loginForm">
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

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <asp:CheckBox runat="server" ID="RememberMe" CssClass="" />
                            <label class="form-check-label" for="RememberMe">Lembrar-me</label>
                        </div>
                        <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink"
                            ViewStateMode="Disabled">
                            Esqueceu a senha?
                        </asp:HyperLink>
                    </div>

                    <asp:Button runat="server" OnClick="LogIn" Text="Entrar"
                        CssClass="btn btn-primary btn-lg w-100 mb-3 hover-scale" />

                    <div class="text-center">
                        <span class="text-muted">Não tem uma conta? </span>
                        <asp:HyperLink runat="server" ID="RegisterHyperLink"
                            ViewStateMode="Disabled">
                            Cadastre-se
                        </asp:HyperLink>
                    </div>
                </form>
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

        // Validação em Tempo Real
        document.getElementById('<%= Email.ClientID %>').addEventListener('input', function () {
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
            if (this.value.length < 6) {
                this.classList.add('is-invalid');
                document.getElementById('passwordFeedback').textContent = 'A senha deve ter pelo menos 6 caracteres';
            } else {
                document.getElementById('passwordFeedback').textContent = '';
            }
        });
    </script>
</asp:Content>
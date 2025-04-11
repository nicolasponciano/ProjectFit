<%@ Page Title="Sobre" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="ProjectFit.About" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="pageTitle" class="container mt-5">
        <!-- Seção Hero -->
        <section class="hero-section text-center text-white d-flex align-items-center justify-content-center position-relative overflow-hidden">
            <div id="particles-js" class="position-absolute w-100 h-100 top-0 start-0"></div>
            <div class="hero-overlay p-5 z-1">
               <asp:Image ID="imgLogo" runat="server"
    ImageUrl="~/Images/logo-transparent.png"
    AlternateText="Logo Project Fit"
    CssClass="logo mb-4"
    Style="max-height: 250px; width:250px" />
                <h1 class="display-3 font-weight-bold">Sobre o Project Fit</h1>
                <p class="lead">Transforme sua vida com treinos e dietas personalizados usando Inteligência Artificial.</p>
            </div>
        </section>
        <!-- Sobre o Projeto -->
        <section class="about-section py-5">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="mb-4">Nossa Missão</h2>
                    <p class="text-muted">
                        No Project Fit, nossa missão é proporcionar soluções personalizadas para ajudar você a alcançar seus objetivos de saúde e fitness. Usamos tecnologia de ponta e Inteligência Artificial para criar planos de dieta e treino adaptados às suas necessidades.
                    </p>
                    <p class="text-muted">
                        Acreditamos que cada pessoa é única, e por isso oferecemos uma abordagem individualizada para garantir resultados eficazes e sustentáveis.
                    </p>
                </div>
            </div>
        </section>
        <!-- Valores e Visão -->
        <section class="values-section bg-light py-5">
            <div class="row">
                <div class="col-md-4 text-center">
                    <i class="fas fa-heart fa-3x text mb-3"></i>
                    <h4>Nossa Visão</h4>
                    <p class="text-muted">Ser a plataforma líder em saúde e fitness, transformando vidas através da tecnologia.</p>
                </div>
                <div class="col-md-4 text-center">
                    <i class="fas fa-bolt fa-3x text mb-3"></i>
                    <h4>Valores</h4>
                    <p class="text-muted">Inovação, compromisso, transparência e bem-estar são nossos pilares.</p>
                </div>
                <div class="col-md-4 text-center">
                    <i class="fas fa-users fa-3x text mb-3"></i>
                    <h4>Comunidade</h4>
                    <p class="text-muted">Conectamos pessoas que compartilham o mesmo objetivo de uma vida mais saudável.</p>
                </div>
            </div>
        </section>
        <!-- Depoimentos -->
        <section class="testimonials-section py-5">
            <h2 class="text-center mb-5">O Que Nossos Usuários Dizem</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="card shadow-sm p-4">
                        <p class="text-muted">"O Project Fit mudou minha rotina de exercícios e dieta. Estou mais motivado do que nunca!"</p>
                        <p class="font-weight-bold">- João Silva</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card shadow-sm p-4">
                        <p class="text-muted">"Os planos personalizados são incríveis. Consegui perder peso de forma saudável e consistente."</p>
                        <p class="font-weight-bold">- Maria Clara</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card shadow-sm p-4">
                        <p class="text-muted">"Adoro a interface amigável e as sugestões inteligentes. Nunca foi tão fácil cuidar da minha saúde!"</p>
                        <p class="font-weight-bold">- Pedro Almeida</p>
                    </div>
                </div>
            </div>
        </section>
        <!-- Equipe -->
        <section class="team-section py-5">
            <h2 class="text-center mb-5">Nossa Equipe</h2>
            <div class="row">
                <div class="col-md-3 text-center">
                    <img src="/Images/team-member-1.jpg" alt="Membro da equipe" class="img-fluid rounded-circle mb-3" style="width: 150px; height: 150px;">
                    <h5>João Vitor Matos Vassão</h5>
                    <p class="text-muted">CEO & Fundador</p>
                </div>
                <div class="col-md-3 text-center">
                    <img src="/Images/team-member-2.jpg" alt="Membro da equipe" class="img-fluid rounded-circle mb-3" style="width: 150px; height: 150px;">
                    <h5>Nicolas Leonardo Ponciano</h5>
                    <p class="text-muted">Engenheiro de Software e IA</p>
                </div>
                <div class="col-md-3 text-center">
                    <img src="/Images/team-member-3.jpg" alt="Membro da equipe" class="img-fluid rounded-circle mb-3" style="width: 150px; height: 150px;">
                    <h5>Marcelo Vieira Lima</h5>
                    <p class="text-muted">Nutricionista Chefe</p>
                </div>
                <div class="col-md-3 text-center">
                    <img src="/Images/team-member-4.jpg" alt="Membro da equipe" class="img-fluid rounded-circle mb-3" style="width: 150px; height: 150px;">
                    <h5>Arthur Oliviera da Silva</h5>
                    <p class="text-muted">Designer Front-end</p>
                </div>
                <div class="col-md-3 text-center">
                    <img src="/Images/team-member-5.jpg" alt="Membro da equipe" class="img-fluid rounded-circle mb-3" style="width: 150px; height: 150px;">
                    <h5>Guilherme Soares do Vale Quaresma</h5>
                    <p class="text-muted">Designer UX/UI</p>
                </div>
                <div class="col-md-3 text-center">
                    <img src="/Images/team-member-6.jpg" alt="Membro da equipe" class="img-fluid rounded-circle mb-3" style="width: 150px; height: 150px;">
                    <h5>Kelwin Negreiros Normandia</h5>
                    <p class="text-muted">Chefe do atendimento ao cliente</p>
                </div>
                <div class="col-md-3 text-center">
                    <img src="/Images/team-member-7.jpg" alt="Membro da equipe" class="img-fluid rounded-circle mb-3" style="width: 150px; height: 150px;">
                    <h5>Vinicius Boaventura Siqueira</h5>
                    <p class="text-muted">Especialista em treinos</p>
                </div>
            </div>
        </section>
        <!-- Chamada para Ação -->
        <section class="cta-section text-center text-white py-5">
            <h2 class="mb-3">Pronto para começar sua jornada?</h2>
            <a href="Cadastro.aspx" class="btn btn-danger btn-lg">Cadastre-se Agora!</a>
        </section>
    </main>
    <!-- Estilos Personalizados -->
    <style>
        /* Logo */
        .logo {
            max-height: 100px;
            width: auto;
            margin-bottom: 20px;
        }

        /* Seção Hero */
        .hero-section {
            background: url('/Images/hero-bg.jpg') no-repeat center center;
            background-size: cover;
            height: 60vh;
            position: relative;
            animation: fadeIn 1.5s ease-in-out;
        }

        .hero-overlay {
            background: rgba(0, 0, 0, 0.8);
            border-radius: 15px;
            padding: 50px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        /* Valores e Visão */
        .values-section {
            background: #f8f9fa;
        }

        /* Ícones */
        .values-section i {
            color: var(--secondary-color); /* Vermelho (#E74C3C) */
        }

        /* Depoimentos */
        .testimonials-section .card {
            transition: transform 0.3s ease-in-out;
        }

        .testimonials-section .card:hover {
            transform: translateY(-10px);
        }

        /* Equipe */
        .team-section img {
            object-fit: cover;
            border: 2px solid #ffffff;
        }

        /* Chamada para Ação */
        .cta-section {
            background: linear-gradient(135deg, #dc3545, #b52b3a);
            animation: pulse 2s infinite;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        /* Removendo o botão de subir para cima */
        #btnTop {
            display: none !important;
        }
    </style>
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    <script>
        // Inicializar Partículas
        particlesJS.load('particles-js', '/Scripts/particles-config.json', function () {
            console.log('Partículas carregadas!');
        });
    </script>
</asp:Content>
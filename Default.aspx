<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProjectFit._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="video-background">
            <video autoplay muted loop id="heroVideo">
                <source src="~/Videos/hero-video.mp4" type="video/mp4">
            </video>
        </div>
        <div class="container overlay-content">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="hero-title">Transforme Seu Estilo de Vida</h1>
                    <p class="hero-subtitle">
                        Com ProjectFit, você terá acesso a planos personalizados de dieta e treino, além de um chatbot exclusivo para tirar suas dúvidas.
                    </p>
                    <div class="cta-buttons">
                        <a href="~/Views/Dietas" runat="server" class="btn btn-primary btn-lg hover-scale">Gerar Dieta Personalizada</a>
                        <a href="~/Views/Treinos" runat="server" class="btn btn-outline-light btn-lg hover-scale ms-3">Gerar Treino Personalizado</a>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <img src="~/Images/hero-image.png" alt="Fitness Lifestyle" class="hero-image img-fluid animate__animated animate__fadeInRight" />
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section bg-light py-5">
        <div class="container">
            <h2 class="text-center mb-5">Por Que Escolher ProjectFit?</h2>
            <div class="row gy-4">
                <div class="col-md-4">
                    <div class="feature-card text-center p-4 rounded shadow-sm hover-scale">
                        <i class="bi bi-heart-pulse-fill fa-3x text-primary mb-3"></i>
                        <h4>Planos Personalizados</h4>
                        <p>
                            Receba dietas e treinos adaptados às suas necessidades e objetivos específicos.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card text-center p-4 rounded shadow-sm hover-scale">
                        <i class="bi bi-chat-dots-fill fa-3x text-primary mb-3"></i>
                        <h4>Suporte 24/7</h4>
                        <p>
                            Tire suas dúvidas sobre dieta e treino com nosso assistente virtual inteligente.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card text-center p-4 rounded shadow-sm hover-scale">
                        <i class="bi bi-bar-chart-line-fill fa-3x text-primary mb-3"></i>
                        <h4>Acompanhamento de Progresso</h4>
                        <p>
                            Monitore seu progresso com gráficos e relatórios detalhados.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials-section py-5">
        <div class="container">
            <h2 class="text-center mb-5">O Que Nossos Usuários Dizem</h2>
            <div class="row gy-4">
                <div class="col-md-4">
                    <div class="testimonial-card p-4 rounded shadow-sm text-center">
                        <img src="~/Images/user1.jpg" alt="User 1" class="testimonial-avatar rounded-circle mb-3" />
                        <p class="testimonial-text">
                            "ProjectFit mudou minha vida! Com as dietas personalizadas, perdi 10kg em 3 meses."
                        </p>
                        <p class="testimonial-author">- Maria Silva</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card p-4 rounded shadow-sm text-center">
                        <img src="~/Images/user2.jpg" alt="User 2" class="testimonial-avatar rounded-circle mb-3" />
                        <p class="testimonial-text">
                            "Os treinos são incríveis! Ganhei massa muscular e estou mais saudável."
                        </p>
                        <p class="testimonial-author">- João Almeida</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card p-4 rounded shadow-sm text-center">
                        <img src="~/Images/user3.jpg" alt="User 3" class="testimonial-avatar rounded-circle mb-3" />
                        <p class="testimonial-text">
                            "O chatbot é sensacional! Sempre tiro minhas dúvidas rapidamente."
                        </p>
                        <p class="testimonial-author">- Ana Costa</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action Section -->
    <section class="cta-section py-5 text-center">
        <div class="container">
            <h2 class="cta-title">Pronto para começar sua transformação?</h2>
            <p class="cta-subtitle">
                Registre-se agora e tenha acesso a todas as funcionalidades do ProjectFit.
            </p>
            <a href="~/Account/Register" runat="server" class="btn btn-primary btn-lg hover-scale">Cadastre-se Gratuitamente</a>
        </div>
    </section>


    <!-- Styles -->
    <style>
        /* Hero Section */
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('/Images/hero-bg.jpg') no-repeat center center;
            background-size: cover;
            color: white;
            padding: 100px 0;
            border-radius: 0 0 20px 20px;
        }

        .video-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        #heroVideo {
            min-width: 100%;
            min-height: 100%;
            object-fit: cover;
        }

        .overlay-content {
            position: relative;
            z-index: 1;
            color: white;
        }

        .hero-title {
            font-size: 3rem;
            font-weight: bold;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            margin-bottom: 30px;
        }

        .hero-image {
            max-width: 100%;
            height: auto;
            border-radius: 15px;
        }

        /* Features Section */
        .feature-card {
            transition: transform 0.3s ease-in-out;
        }

        .feature-card:hover {
            transform: scale(1.05);
        }

        /* Testimonials Section */
        .testimonial-card {
            background-color: #fff;
            transition: transform 0.3s ease-in-out;
        }

        .testimonial-card:hover {
            transform: translateY(-10px);
        }

        .testimonial-avatar {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }

        /* CTA Section */
        .cta-section {
            background-color: #f8f9fa;
        }

        .cta-title {
            font-size: 2rem;
            font-weight: bold;
        }

        /* Hover Effects */
        .hover-scale {
            transition: transform 0.3s ease-in-out;
        }

        .hover-scale:hover {
            transform: scale(1.05);
        }

        /* Footer */
        .footer-section {
            background-color: #343a40;
            color: white;
        }
    </style>

    <!-- Scripts -->
    <script>
        // Animações ao rolar a página
        document.addEventListener("DOMContentLoaded", function () {
            const observer = new IntersectionObserver((entries) => {
                entries.forEach((entry) => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add("animate__animated", "animate__fadeInUp");
                    }
                });
            });

            document.querySelectorAll(".animate-on-scroll").forEach((el) => observer.observe(el));
        });

        // Função para exibir a tela de carregamento global
        function showGlobalLoading() {
            var loadingElement = document.getElementById('globalLoading');
            if (loadingElement) {
                loadingElement.style.display = 'flex';
            } else {
                console.error("Elemento 'globalLoading' não encontrado.");
            }
        }

        // Função para ocultar a tela de carregamento global
        function hideGlobalLoading() {
            var loadingElement = document.getElementById('globalLoading');
            if (loadingElement) {
                loadingElement.style.display = 'none';
            } else {
                console.error("Elemento 'globalLoading' não encontrado.");
            }
        }
    </script>
</asp:Content>
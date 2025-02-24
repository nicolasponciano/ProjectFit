<%@ Page Title="Sobre" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="ProjectFit.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="pageTitle" class="container mt-5">
        <!-- Bootstrap Carousel -->
        <div id="appCarousel" class="carousel slide mb-5" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#appCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#appCarousel" data-slide-to="1"></li>
                <li data-target="#appCarousel" data-slide-to="2"></li>
            </ol>

            <div class="carousel-inner rounded-lg">
                <!-- Slide 1 -->
                <div class="carousel-item active">
                    <img src="/Images/diet-plan.png" class="d-block w-100" alt="Plano Nutricional">
                    <div class="carousel-caption d-none d-md-block bg-dark-overlay">
                        <h3>Nutrição Personalizada</h3>
                        <p>Planos alimentares adaptados ao seu biotipo e objetivos</p>
                    </div>
                </div>

                <!-- Slide 2 -->
                <div class="carousel-item">
                    <video class="d-block w-100 video-fit" autoplay muted loop>
                        <source src="/Images/videoFit2.mp4" type="video/mp4">
                        Seu navegador não suporta a tag de vídeo.
   
                    </video>
                    <div class="carousel-caption d-none d-md-block bg-dark-overlay">
                        <h3>Treinos Integrados</h3>
                        <p>Sincronização perfeita entre dieta e programa de exercícios</p>
                    </div>
                </div>


                <!-- Slide 3 -->
                <div class="carousel-item">
                    <img src="/Images/progress-tracker.png" class="d-block w-100" alt="Monitoramento Contínuo">
                    <div class="carousel-caption d-none d-md-block bg-dark-overlay">
                        <h3>Monitoramento Contínuo</h3>
                        <p>Ajustes automáticos baseados em seu progresso</p>
                    </div>
                </div>
            </div>

            <!-- Controles de Navegação -->
            <a class="carousel-control-prev" href="#appCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Anterior</span>
            </a>
            <a class="carousel-control-next" href="#appCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Próximo</span>
            </a>
        </div>

        <!-- Seção de Funcionalidades -->
        <section class="feature-section mb-5">
            <div class="row text-center">
                <div class="col-12">
                    <h2 id="pageTitle" class="display-4 mb-4">Como Funciona</h2>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-item p-4">
                        <i class="fas fa-user-circle fa-3x text-primary mb-3"></i>
                        <h4>Perfil Completo</h4>
                        <p>Análise de dados biométricos, hábitos e objetivos</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-item p-4">
                        <i class="fas fa-dumbbell fa-3x text-primary mb-3"></i>
                        <h4>Plano de Treino</h4>
                        <p>Programa de exercícios adaptado à sua rotina</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-item p-4">
                        <i class="fas fa-utensils fa-3x text-primary mb-3"></i>
                        <h4>Dieta Personalizada</h4>
                        <p>Cardápios gerados com base em suas métricas</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Seção de Tecnologia -->
        <section class="tech-section bg-light py-5">
            <div class="container">
                <h3 class="text-center mb-4">Tecnologia Avançada</h3>
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title">IA Nutricional</h5>
                                <p class="card-text">Nosso algoritmo analisa mais de 50 parâmetros para criar a dieta perfeita:</p>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">Metabolismo basal</li>
                                    <li class="list-group-item">Nível de atividade física</li>
                                    <li class="list-group-item">Preferências alimentares</li>
                                    <li class="list-group-item">Objetivos específicos</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title">Integração Completa</h5>
                                <p class="card-text">Conecte seus dispositivos e aplicativos favoritos:</p>
                                <div class="integration-icons">
                                    <i class="fab fa-apple fa-2x m-2"></i>
                                    <i class="fab fa-google fa-2x m-2"></i>
                                    <i class="fab fa-strava fa-2x m-2"></i>
                                    <i class="fas fa-heartbeat fa-2x m-2"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Estilos Customizados -->
    <style>
        .bg-dark-overlay {
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 15px;
            padding: 15px;
        }

        /* Ajustes do Carousel */
        .carousel-item {
            height: 50vh;
            max-height: 500px;
            overflow: hidden;
            position: relative;
            min-height: 400px; /* Garante uma altura mínima adequada */
        }

            .carousel-item img,
            .carousel-item video {
                width: 100%;
                height: 100%;
                object-fit: contain; /* Exibe a imagem inteira, sem cortar */
            }

        @media (max-width: 768px) {
            .carousel-item {
                height: 40vh;
                max-height: 300px;
            }
        }

        /*.carousel-item video {
            width: 100%;
            height: auto;*/ /* Mantém a proporção do vídeo */
            /*max-height: 60vh;*/ /* Limita a altura do vídeo para 60% da altura da tela */
            /*object-fit: cover;*/ /* Garante que o vídeo preencha o contêiner sem distorção */
            /*border-radius: 10px;*/ /* Arredonda as bordas do vídeo */
        /*}*/

        /* Botões de navegação personalizados */
        .carousel-control-prev,
        .carousel-control-next {
            position: absolute;
            top: 50%; /* Ajuste esse valor conforme necessário */
            transform: translateY(-50%);
            width: 50px;
            height: 50px;
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: background-color 0.3s ease, transform 0.3s ease;
            cursor: pointer;
        }

            .carousel-control-prev:hover,
            .carousel-control-next:hover {
                background-color: rgba(0, 0, 0, 0.8);
                transform: translateY(-50%) scale(1.1);
            }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            display: inline-block;
            width: 10px;
            height: 10px;
            border-top: 3px solid #fff;
            border-right: 3px solid #fff;
        }

        .carousel-control-prev-icon {
            transform: rotate(-135deg);
        }

        .carousel-control-next-icon {
            transform: rotate(45deg);
        }

        /* Itens de Funcionalidades */
        .feature-item {
            background-color: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

            .feature-item:hover {
                transform: translateY(-10px);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            }

        /* Ícones de Integração */
        .integration-icons {
            opacity: 0.8;
            transition: opacity 0.3s;
        }

            .integration-icons:hover {
                opacity: 1;
            }

            .integration-icons i {
                transition: transform 0.3s;
            }

                .integration-icons i:hover {
                    transform: scale(1.1);
                }
    </style>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#appCarousel').carousel({
                interval: 3000
            });
        });
    </script>
</asp:Content>

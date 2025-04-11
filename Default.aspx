<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProjectFit._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container py-5">
        <!-- Cabeçalho da Página -->
        <header class="text-center mb-5">
            <h1 class="display-4 fw-bold text-primary">Bem-vindo ao Project Fit</h1>
            <p class="lead text-muted">Seu portal de saúde e fitness personalizado.</p>
        </header>

        <!-- Seção de Funcionalidades Principais -->
        <section class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body text-center">
                        <i class="fas fa-dumbbell fa-3x text-primary mb-3"></i>
                        <h5 class="card-title fw-bold">Treinos Personalizados</h5>
                        <p class="card-text text-muted">Crie planos de treino adaptados às suas metas e necessidades.</p>
                        <a href="~/Views/Treinos" class="btn btn-outline-primary">Gerar Treino</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body text-center">
                        <i class="fas fa-utensils fa-3x text-success mb-3"></i>
                        <h5 class="card-title fw-bold">Dietas Inteligentes</h5>
                        <p class="card-text text-muted">Planeje refeições saudáveis com base no seu perfil.</p>
                        <a href="~/Views/Dietas" class="btn btn-outline-success">Gerar Dieta</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body text-center">
                        <i class="fas fa-heartbeat fa-3x text-danger mb-3"></i>
                        <h5 class="card-title fw-bold">Saúde e Bem-Estar</h5>
                        <p class="card-text text-muted">Dicas diárias para melhorar sua qualidade de vida.</p>
                        <button onclick="loadRandomTip()" class="btn btn-outline-danger">Ver Dica</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Carrossel de Destaques -->
        <section class="carousel-section py-5">
            <div class="container position-relative">
                <h2 class="text-center mb-5 text-primary">Descubra Mais Sobre Nossa Jornada</h2>
                <div id="highlightCarousel" class="carousel slide" data-bs-ride="carousel">
                    <!-- Indicadores -->
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#highlightCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#highlightCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#highlightCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    </div>
                    <!-- Itens do Carrossel -->
                    <div class="carousel-inner" style="height: 400px; overflow: hidden;">
                        <!-- Slide 1: Plano Nutricional -->
                        <div class="carousel-item active">
                            <img src="/Images/diet-plan.png" class="d-block w-100 h-100 object-fit-cover" alt="Plano Nutricional">
                            <div class="carousel-caption d-none d-md-block">
                                <h5>Plano Nutricional Personalizado</h5>
                                <p>Alcance seus objetivos com dietas adaptadas às suas necessidades.</p>
                            </div>
                        </div>
                        <!-- Slide 2: Vídeo Fitness -->
                        <div class="carousel-item">
                            <video class="d-block w-100 h-100 object-fit-cover" autoplay muted loop>
                                <source src="/Images/videoFit2.mp4" type="video/mp4">
                                Seu navegador não suporta vídeos.
                            </video>
                            <div class="carousel-caption d-none d-md-block">
                                <h5>Treino Dinâmico</h5>
                                <p>Aprimore sua rotina com treinos personalizados e interativos.</p>
                            </div>
                        </div>
                        <!-- Slide 3: Monitoramento Contínuo -->
                        <div class="carousel-item">
                            <img src="/Images/progress-tracker.png" class="d-block w-100 h-100 object-fit-cover" alt="Monitoramento Contínuo">
                            <div class="carousel-caption d-none d-md-block">
                                <h5>Monitoramento Contínuo</h5>
                                <p>Acompanhe seu progresso e ajuste suas metas em tempo real.</p>
                            </div>
                        </div>
                    </div>
                    <!-- Controles -->
                    <button class="carousel-control-prev" type="button" data-bs-target="#highlightCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Anterior</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#highlightCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Próximo</span>
                    </button>
                </div>
            </div>
        </section>

        <!-- Calculadora de IMC -->
        <section class="mb-5">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title text-center fw-bold">Calcule Seu IMC</h5>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <input type="number" id="weight" class="form-control" placeholder="Peso (kg)">
                        </div>
                        <div class="col-md-6">
                            <input type="number" id="height" class="form-control" placeholder="Altura (cm)">
                        </div>
                        <div class="col-12 text-center">
                            <button onclick="calculateBMI()" class="btn btn-primary btn-lg">Calcular</button>
                        </div>
                        <div class="col-12 mt-3 text-center">
                            <div id="bmi-result" class="alert alert-info fade show" role="alert" style="display: none;">
                                <strong>Seu IMC:</strong> <span id="bmi-value"></span>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Dica de Saúde Aleatória -->
        <section>
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title fw-bold">Dica de Saúde e Fitness</h5>
                    <p id="health-tip" class="lead text-muted">Carregando...</p>
                    <button onclick="loadRandomTip()" class="btn btn-outline-secondary">Nova Dica</button>
                </div>
            </div>
        </section>
    </main>

    <!-- Estilos Customizados -->
    <style>
        /* Paleta de Cores */
        :root {
            --primary-color: #2C3E50;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --text-color: #FFFFFF;
            --background-color: #f9f9f9;
        }
        /* Estilo Geral */
        body {
            background-color: var(--background-color);
            font-family: 'Poppins', sans-serif;
        }

        .card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            }

        .btn-lg {
            padding: 10px 20px;
            font-size: 16px;
        }

        .alert-info {
            background-color: #e9ecef;
            color: #2C3E50;
        }

        /* Estilo do Carrossel */
        .carousel-section {
            position: relative;
            height: auto;
            background-color: #f9f9f9;
        }

        .carousel-inner {
            height: 400px; /* Altura fixa */
            overflow: hidden;
        }

        .carousel-item img,
        .carousel-item video {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Garante que as imagens e vídeos preencham o espaço sem distorção */
        }

        .carousel-caption {
            background: rgba(0, 0, 0, 0.6);
            padding: 15px;
            border-radius: 8px;
        }

        .carousel-control-prev,
        .carousel-control-next {
            width: 5%; /* Ajusta o tamanho dos botões de navegação */
            filter: brightness(1.5); /* Torna os ícones mais visíveis */
        }

        .carousel-indicators [data-bs-target] {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #007bff;
            opacity: 0.7;
            transition: opacity 0.3s ease;
        }

            .carousel-indicators [data-bs-target]:hover,
            .carousel-indicators .active {
                opacity: 1;
            }
    </style>

    <!-- Bibliotecas Necessárias -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>

    <!-- Scripts Personalizados -->
    <script>


        // Calculadora de IMC
        function calculateBMI() {
            const weight = parseFloat($('#weight').val());
            const height = parseFloat($('#height').val()) / 100;
            if (isNaN(weight) || isNaN(height)) {
                Swal.fire('Atenção', 'Preencha todos os campos!', 'warning');
                return;
            }
            const bmi = (weight / (height * height)).toFixed(1);
            $('#bmi-value').text(bmi);
            $('#bmi-result').show();
            Swal.fire({
                title: 'Seu IMC',
                html: `
                    <div class="text-start">
                        <p>IMC: ${bmi}</p>
                        <p>${getBMIStatus(bmi)}</p>
                    </div>
                `,
                icon: 'info',
                confirmButtonText: 'Entendi'
            });
        }

        function getBMIStatus(bmi) {
            if (bmi < 18.5) return 'Abaixo do peso';
            if (bmi < 25) return 'Peso normal';
            if (bmi < 30) return 'Sobrepeso';
            return 'Obesidade';
        }

        // Dica de Saúde Aleatória (Advice Slip API)
        async function loadRandomTip() {
            try {
                const { data } = await axios.get('https://api.adviceslip.com/advice');
                const tip = data.slip.advice;
                $('#health-tip').text(tip);
            } catch (error) {
                Swal.fire({
                    icon: 'error',
                    title: 'Erro ao carregar dica',
                    text: 'Não foi possível carregar a dica. Verifique sua conexão ou tente novamente mais tarde.'
                });
            }
        }

        // Inicializar Página
        document.addEventListener('DOMContentLoaded', () => {
            loadRandomTip();
        });
    </script>
</asp:Content>

<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="ProjectFit.Contact" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <div class="contact-container">
            <h2 id="title">Contato</h2>
            <p>Entre em contato conosco para suporte, dúvidas ou sugestões.</p>
            <!-- Informações de Contato -->
            <div class="contact-info">
                <div class="info-card animate__animated animate__fadeIn">
                    <i class="fas fa-map-marker-alt info-icon"></i>
                    <h4>Endereço</h4>
                    <p>
                        R. Oswaldo Cruz, 277 - Boqueirão<br />
                        Santos - SP, 11045-907
                    </p>
                </div>
                <div class="info-card animate__animated animate__fadeIn">
                    <i class="fas fa-phone info-icon"></i>
                    <h4>Telefone</h4>
                    <p>(13) 3223-4567</p>
                </div>
                <div class="info-card animate__animated animate__fadeIn">
                    <i class="fas fa-envelope info-icon"></i>
                    <h4>E-mail</h4>
                    <p>
                        <strong>Suporte:</strong> <a href="mailto:suporte@projectfit.com">suporte@projectfit.com</a><br />
                        <strong>Marketing:</strong> <a href="mailto:marketing@projectfit.com">marketing@projectfit.com</a>
                    </p>
                </div>
            </div>
            <!-- Mapa de Localização -->
            <div class="map-container">
                <h3>Nossa Localização</h3>
                <div id="map" style="height: 400px; border-radius: 8px; margin-bottom: 20px;"></div>
            </div>
            <!-- Formulário de Contato -->
            <div class="contact-form">
                <h3>Fale Conosco</h3>
                <div class="form-group">
                    <label for="txtName">Nome</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Digite seu nome"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtEmail">E-mail</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Digite seu e-mail"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Avaliação</label>
                    <div class="rating-stars">
                        <input type="radio" id="star5" name="rating" value="5" runat="server" clientidmode="Static" />
                        <label for="star5" title="Excelente">★</label>
                        <input type="radio" id="star4" name="rating" value="4" runat="server" clientidmode="Static" />
                        <label for="star4" title="Muito bom">★</label>
                        <input type="radio" id="star3" name="rating" value="3" runat="server" clientidmode="Static" />
                        <label for="star3" title="Bom">★</label>
                        <input type="radio" id="star2" name="rating" value="2" runat="server" clientidmode="Static" />
                        <label for="star2" title="Regular">★</label>
                        <input type="radio" id="star1" name="rating" value="1" runat="server" clientidmode="Static" />
                        <label for="star1" title="Ruim">★</label>
                    </div>
                    <asp:HiddenField ID="hdnRating" runat="server" />
                </div>
                <div class="form-group">
                    <label for="txtMessage">Mensagem</label>
                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Digite sua mensagem"></asp:TextBox>
                </div>
                <asp:Button ID="btnSubmit" runat="server" Text="Enviar Mensagem"
                    CssClass="btn-submit" OnClick="btnSubmit_Click"
                    CausesValidation="false" />
            </div>
        </div>
        <style>
            /* Paleta de Cores */
            :root {
                --primary-color: #2C3E50; /* Azul escuro */
                --secondary-color: #E74C3C; /* Vermelho */
                --text-color: #FFFFFF; /* Branco */
                --background-color: #f9f9f9; /* Fundo claro */
                --shadow-color: rgba(0, 0, 0, 0.1); /* Sombra suave */
            }
            /* Estilos Gerais */
            .contact-container {
                background: var(--background-color);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 10px var(--shadow-color);
                max-width: 1200px;
                margin: 0 auto;
            }
            h2 {
                text-align: center;
                color: var(--primary-color);
                margin-bottom: 20px;
            }
            p {
                text-align: center;
                color: #6c757d;
                font-size: 16px;
                margin-bottom: 30px;
            }
            /* Informações de Contato */
            .contact-info {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
                margin-bottom: 30px;
            }
            .info-card {
                background: var(--text-color);
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 6px var(--shadow-color);
                text-align: center;
                width: 30%;
                min-width: 250px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .info-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 12px var(--shadow-color);
            }
            .info-icon {
                font-size: 36px;
                color: var(--secondary-color);
                margin-bottom: 10px;
                display: block;
            }
            .info-card h4 {
                font-size: 18px;
                margin-bottom: 10px;
                color: var(--primary-color);
            }
            .info-card p {
                font-size: 14px;
                color: #6c757d;
                text-align: center;
            }
            /* Mapa */
            .map-container {
                background: var(--text-color);
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px var(--shadow-color);
                margin-bottom: 20px;
            }
            .map-container h3 {
                text-align: center;
                color: var(--primary-color);
                margin-bottom: 15px;
            }
            /* Formulário de Contato */
            .contact-form {
                background: var(--text-color);
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px var(--shadow-color);
            }
            .contact-form h3 {
                text-align: center;
                color: var(--primary-color);
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                color: var(--primary-color);
            }
            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }
            .btn-submit {
                width: 100%;
                max-width: 300px;
                background-color: var(--secondary-color);
                color: var(--text-color);
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin: 0 auto;
                display: block;
                font-size: 16px;
            }
            .btn-submit:hover {
                background-color: var(--primary-color);
            }
            /* Avaliações */
            .rating-stars {
                display: flex;
                flex-direction: row-reverse;
                justify-content: flex-end;
                margin: 10px 0;
            }
            .rating-stars input {
                display: none;
            }
            .rating-stars label {
                font-size: 30px;
                color: #ccc;
                cursor: pointer;
                transition: color 0.2s;
                margin-right: 5px;
            }
            .rating-stars input:checked ~ label,
            .rating-stars input:hover ~ label,
            .rating-stars label:hover,
            .rating-stars label:hover ~ label {
                color: var(--secondary-color);
            }
            .rating-stars input:checked + label {
                color: var(--secondary-color);
            }
            /* Responsividade */
            @media screen and (max-width: 768px) {
                .contact-info {
                    flex-direction: column;
                    align-items: center;
                }
                .info-card {
                    width: 100%;
                    margin-bottom: 20px;
                }
            }
            .has-error .form-control {
                border-color: #dc3545;
            }
            .error-message {
                display: block;
                margin-top: 5px;
                font-size: 14px;
                color: #dc3545;
            }
        </style>
        <!-- Scripts para animações e mapa -->
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.js"></script>
        <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
        <script>
            $(document).ready(function () {
                // Inicialização do mapa
                var map = L.map('map').setView([-23.9618, -46.3322], 16);
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                }).addTo(map);
                // Adicionando marcador com popup
                var marker = L.marker([-23.9618, -46.3322]).addTo(map)
                    .bindPopup('<b>ProjectFit</b><br>R. Oswaldo Cruz, 277 - Boqueirão, Santos')
                    .openPopup();
                // Validação do formulário
                $('#<%= btnSubmit.ClientID %>').click(function (e) {
                    e.preventDefault();
                    let isValid = true;
                    const name = $('#<%= txtName.ClientID %>').val().trim();
                    const email = $('#<%= txtEmail.ClientID %>').val().trim();
                    const message = $('#<%= txtMessage.ClientID %>').val().trim();
                    const rating = $('#<%= hdnRating.ClientID %>').val();
                    $('.form-group').removeClass('has-error');
                    $('.error-message').remove();
                    if (name === '') {
                        $('#<%= txtName.ClientID %>').parent().addClass('has-error');
                        $('#<%= txtName.ClientID %>').after('<span class="error-message">Por favor, insira seu nome</span>');
                        isValid = false;
                    }
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (email === '' || !emailRegex.test(email)) {
                        $('#<%= txtEmail.ClientID %>').parent().addClass('has-error');
                        $('#<%= txtEmail.ClientID %>').after('<span class="error-message">Por favor, insira um e-mail válido</span>');
                        isValid = false;
                    }
                    if (message === '') {
                        $('#<%= txtMessage.ClientID %>').parent().addClass('has-error');
                        $('#<%= txtMessage.ClientID %>').after('<span class="error-message">Por favor, insira sua mensagem</span>');
                        isValid = false;
                    }
                    if (!rating) {
                        $('.rating-stars').parent().addClass('has-error');
                        $('.rating-stars').after('<span class="error-message">Por favor, avalie com 1 a 5 estrelas</span>');
                        isValid = false;
                    }
                    if (isValid) {
                        __doPostBack('<%= btnSubmit.UniqueID %>', '');
                    }
                });
                // Manipulação das estrelas de avaliação
                $('.rating-stars input').change(function () {
                    $('#<%= hdnRating.ClientID %>').val($(this).val());
                });
            });
        </script>
    </main>
</asp:Content>
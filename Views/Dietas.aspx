<%@ Page Title="Dieta Personalizada" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dietas.aspx.cs" Inherits="ProjectFit.Dietas" Async="true" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <div class="container">
            <h2 id="title">Dieta Personalizada</h2>
            <h3>Responda as perguntas abaixo para gerar sua dieta personalizada</h3>
            <asp:UpdatePanel runat="server" ID="updatePanelDieta">
                <ContentTemplate>
                    <div class="question-form">
                        <asp:Panel ID="pnlQuestions" runat="server" CssClass="question-panel">
                            <div class="question-grid">
                                <!-- Objetivo -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-bullseye question-icon"></i>
                                    <label for="ddlObjetivo">Qual é o seu objetivo principal?</label>
                                    <asp:DropDownList ID="ddlObjetivo" runat="server" CssClass="dropdown">
                                        <asp:ListItem Text="Perda de peso" Value="Perda de peso" />
                                        <asp:ListItem Text="Ganho de massa" Value="Ganho de massa" />
                                        <asp:ListItem Text="Manutenção" Value="Manutenção" />
                                    </asp:DropDownList>
                                </div>
                                <!-- Refeições -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-utensils question-icon"></i>
                                    <label for="txtRefeicoes">Quantas refeições faz por dia?</label>
                                    <asp:TextBox ID="txtRefeicoes" runat="server" CssClass="textbox numeric-mask" placeholder="Ex: 5" MaxLength="2"></asp:TextBox>
                                    <small class="hint">Insira apenas números (1-10).</small>
                                </div>
                                <!-- Restrições Alimentares -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-exclamation-triangle question-icon"></i>
                                    <label for="txtRestricoes">Tem alguma restrição alimentar ou alergia?</label>
                                    <asp:TextBox ID="txtRestricoes" runat="server" CssClass="textbox" placeholder="Ex: Intolerância à lactose"></asp:TextBox>
                                    <small class="hint">Exemplo: Alergia a frutos do mar.</small>
                                </div>
                                <!-- Ingestão de Água -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-tint question-icon"></i>
                                    <label for="txtAgua">Como é sua ingestão de água diária?</label>
                                    <asp:TextBox ID="txtAgua" runat="server" CssClass="textbox numeric-mask" placeholder="Ex: 2.5" MaxLength="4"></asp:TextBox>
                                    <small class="hint">Litros por dia (ex.: 2.5).</small>
                                </div>
                                <!-- Consumo de Fast Food -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-hamburger question-icon"></i>
                                    <label for="ddlFastFood">Costuma consumir fast food ou alimentos processados?</label>
                                    <asp:DropDownList ID="ddlFastFood" runat="server" CssClass="dropdown">
                                        <asp:ListItem Text="Não" Value="Não" />
                                        <asp:ListItem Text="1 vez por semana" Value="1 vez por semana" />
                                        <asp:ListItem Text="2 ou mais vezes por semana" Value="2 ou mais vezes por semana" />
                                    </asp:DropDownList>
                                </div>
                                <!-- Preferências Alimentares -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-carrot question-icon"></i>
                                    <label for="ddlPreferencias">Tem alguma preferência alimentar?</label>
                                    <asp:DropDownList ID="ddlPreferencias" runat="server" CssClass="dropdown">
                                        <asp:ListItem Text="Carnívoro" Value="Carnívoro" />
                                        <asp:ListItem Text="Vegetariano" Value="Vegetariano" />
                                        <asp:ListItem Text="Vegano" Value="Vegano" />
                                    </asp:DropDownList>
                                </div>
                                <!-- Rotina Alimentar -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-clock question-icon"></i>
                                    <label for="txtRotina">Qual é sua rotina alimentar atual?</label>
                                    <asp:TextBox ID="txtRotina" runat="server" CssClass="textbox" placeholder="Ex: Como de 3 em 3 horas"></asp:TextBox>
                                    <small class="hint">Exemplo: Faço 3 refeições principais e 2 lanches.</small>
                                </div>
                                <!-- Alimentos Evitados -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-times-circle question-icon"></i>
                                    <label for="txtAlimentosEvitados">Há algum alimento que você não gosta ou evita?</label>
                                    <asp:TextBox ID="txtAlimentosEvitados" runat="server" CssClass="textbox" placeholder="Ex: Não gosto de peixe"></asp:TextBox>
                                    <small class="hint">Exemplo: Evito carboidratos refinados.</small>
                                </div>
                            </div>
                            <div class="submit-button">
                                <asp:Button ID="btnSubmit" runat="server" Text="Gerar Dieta" CssClass="btn-submit" OnClick="btnSubmit_Click" />
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="result-section">
                        <asp:GridView ID="gridDieta" runat="server" CssClass="dieta-grid" AutoGenerateColumns="false"
                            ShowHeaderWhenEmpty="true" EmptyDataText="Nenhuma dieta gerada ainda">
                            <Columns>
                                <asp:BoundField DataField="Refeicao" HeaderText="Refeição" />
                                <asp:BoundField DataField="Horario" HeaderText="Horário Sugerido" />
                                <asp:BoundField DataField="Alimentos" HeaderText="Alimentos" />
                                <asp:BoundField DataField="Calorias" HeaderText="Calorias Aproximadas" />
                                <asp:BoundField DataField="Observacoes" HeaderText="Dicas de Preparo" />
                                <asp:TemplateField HeaderText="Links Referenciais" ItemStyle-Width="200px">
                                    <ItemTemplate>
                                        <%# FormatLinks(Eval("LinksReferenciais").ToString()) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </main>
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
        .question-form {
            background: var(--background-color);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px var(--shadow-color);
        }
        h2 {
            text-align: center;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        h3 {
            text-align: center;
            color: #6c757d;
            font-size: 16px;
            margin-bottom: 30px;
        }
        .question-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 15px;
        }
        .question-card {
            background: var(--text-color);
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 6px var(--shadow-color);
            text-align: left;
            position: relative;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .question-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px var(--shadow-color);
        }
        .question-icon {
            font-size: 24px;
            color: var(--secondary-color);
            margin-bottom: 10px;
            display: block;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: var(--primary-color);
        }
        .textbox, .dropdown {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .hint {
            display: block;
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
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
            margin-top: 10px;
            font-size: 16px;
        }
        .btn-submit:hover {
            background-color: var(--primary-color);
        }
        .result-section {
            margin-top: 20px;
        }
        .dieta-grid {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 14px;
        }
        .dieta-grid th, .dieta-grid td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .dieta-grid th {
            background-color: var(--primary-color);
            color: var(--text-color);
            text-align: center;
            font-weight: bold;
        }
        .dieta-grid tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .dieta-grid tr:hover {
            background-color: #f1f1f1;
        }
        @media screen and (max-width: 768px) {
            .dieta-grid {
                font-size: 12px;
            }
            .dieta-grid th, .dieta-grid td {
                padding: 6px;
            }
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
    <script>
        $(document).ready(function () {
            // Máscara para campo numérico (refeições)
            $('.numeric-mask').mask('00');
        });
    </script>
</asp:Content>
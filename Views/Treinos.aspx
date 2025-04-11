<%@ Page Title="Treino Personalizado" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Treinos.aspx.cs" Inherits="ProjectFit.Treinos" Async="true" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <div class="container">
            <h2 id="title">Treino Personalizado</h2>
            <h3>Responda as perguntas abaixo para gerar seu treino personalizado</h3>
            <asp:UpdatePanel runat="server" ID="updatePanelTreino">
                <ContentTemplate>
                    <div class="question-form">
                        <asp:Panel ID="pnlQuestions" runat="server" CssClass="question-panel">
                            <div class="question-grid">
                                <!-- Experiência de Treino -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-dumbbell question-icon"></i>
                                    <label for="txtTrainingExperience">Você já treina? Se sim, há quanto tempo?</label>
                                    <asp:TextBox ID="txtTrainingExperience" runat="server" CssClass="textbox" placeholder="Ex: Sim, treino há 1 ano"></asp:TextBox>
                                    <small class="hint">Exemplo: Sim, treino há 6 meses.</small>
                                </div>
                                <!-- Dias de Treino -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-calendar-week question-icon"></i>
                                    <label for="txtTrainingDays">Quantos dias por semana você consegue treinar?</label>
                                    <asp:TextBox ID="txtTrainingDays" runat="server" CssClass="textbox numeric-mask" placeholder="Ex: 3" MaxLength="1"></asp:TextBox>
                                    <small class="hint">Insira apenas números (1-7).</small>
                                </div>
                                <!-- Tempo de Treino -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-clock question-icon"></i>
                                    <label for="txtTrainingTime">Quanto tempo você tem disponível por treino?</label>
                                    <asp:TextBox ID="txtTrainingTime" runat="server" CssClass="textbox time-mask" placeholder="Ex: 01:30"></asp:TextBox>
                                    <small class="hint">Formato: HH:mm (horas:minutos).</small>
                                </div>
                                <!-- Nível de Treino -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-chart-bar question-icon"></i>
                                    <label for="txtTrainingLevel">Como é/foi seu nível de treino anterior?</label>
                                    <asp:DropDownList ID="txtTrainingLevel" runat="server" CssClass="dropdown">
                                        <asp:ListItem Text="Iniciante" Value="Iniciante" />
                                        <asp:ListItem Text="Intermediário" Value="Intermediário" />
                                        <asp:ListItem Text="Avançado" Value="Avançado" />
                                    </asp:DropDownList>
                                </div>
                                <!-- Lesões -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-heart-broken question-icon"></i>
                                    <label for="txtInjuries">Tem alguma lesão ou dor frequente?</label>
                                    <asp:TextBox ID="txtInjuries" runat="server" CssClass="textbox" placeholder="Ex: Dor no joelho"></asp:TextBox>
                                    <small class="hint">Exemplo: Dor lombar após exercícios.</small>
                                </div>
                                <!-- Limitações -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-exclamation-circle question-icon"></i>
                                    <label for="txtLimitations">Possui alguma limitação de movimento?</label>
                                    <asp:TextBox ID="txtLimitations" runat="server" CssClass="textbox" placeholder="Ex: Cirurgia no ombro"></asp:TextBox>
                                    <small class="hint">Exemplo: Dificuldade para levantar braços.</small>
                                </div>
                                <!-- Condições de Saúde -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-medkit question-icon"></i>
                                    <label for="txtHealthConditions">Tem alguma condição de saúde?</label>
                                    <asp:TextBox ID="txtHealthConditions" runat="server" CssClass="textbox" placeholder="Ex: Hipertensão"></asp:TextBox>
                                    <small class="hint">Exemplo: Diabetes tipo 2.</small>
                                </div>
                                <!-- Nível de Atividade Física -->
                                <div class="question-card animate__animated animate__fadeIn">
                                    <i class="fas fa-running question-icon"></i>
                                    <label for="txtActivityLevel">Como é seu nível de atividade física fora da academia?</label>
                                    <asp:DropDownList ID="txtActivityLevel" runat="server" CssClass="dropdown">
                                        <asp:ListItem Text="Sedentário" Value="Sedentário" />
                                        <asp:ListItem Text="Leve" Value="Leve" />
                                        <asp:ListItem Text="Moderado" Value="Moderado" />
                                        <asp:ListItem Text="Ativo" Value="Ativo" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="submit-button">
                                <asp:Button ID="btnSubmit" runat="server" Text="Gerar Treino" CssClass="btn-submit" OnClick="btnSubmit_Click" />
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="result-section">
                        <asp:GridView ID="gridTreino" runat="server" CssClass="treino-grid" AutoGenerateColumns="false"
                            ShowHeaderWhenEmpty="true" EmptyDataText="Nenhum treino gerado ainda">
                            <Columns>
                                <asp:BoundField DataField="DiaTreino" HeaderText="Dia do Treino" />
                                <asp:BoundField DataField="Exercicio" HeaderText="Exercício" />
                                <asp:BoundField DataField="SeriesRepeticoes" HeaderText="Séries x Repetições" />
                                <asp:BoundField DataField="Descanso" HeaderText="Descanso" />
                                <asp:BoundField DataField="Equipamento" HeaderText="Equipamento" />
                                <asp:BoundField DataField="GrupoMuscular" HeaderText="Grupo Muscular" />
                                <asp:BoundField DataField="Dicas" HeaderText="Dicas" />
                                <asp:TemplateField HeaderText="Links Referenciais" ItemStyle-Width="200px">
                                    <ItemTemplate>
                                        <%# FormatLinks(Eval("LinksReferenciaisTreino").ToString()) %>
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
        .treino-grid {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 14px;
        }
        .treino-grid th, .treino-grid td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .treino-grid th {
            background-color: var(--primary-color);
            color: var(--text-color);
            text-align: center;
            font-weight: bold;
        }
        .treino-grid tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .treino-grid tr:hover {
            background-color: #f1f1f1;
        }
        @media screen and (max-width: 768px) {
            .treino-grid {
                font-size: 12px;
            }
            .treino-grid th, .treino-grid td {
                padding: 6px;
            }
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
    <script>
        $(document).ready(function () {
            // Máscara para campo numérico (dias de treino)
            $('.numeric-mask').mask('0');
            // Máscara para campo de tempo (HH:mm)
            $('.time-mask').mask('00:00');
        });
    </script>
</asp:Content>
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
                                <div class="question-item">
                                    <label for="txtTrainingExperience">Você já treina? Se sim, há quanto tempo?</label>
                                    <asp:TextBox ID="txtTrainingExperience" runat="server" CssClass="textbox" placeholder="Ex: Sim, treino há 1 ano"></asp:TextBox>
                                </div>

                                <!-- Dias de Treino -->
                                <div class="question-item">
                                    <label for="txtTrainingDays">Quantos dias por semana você consegue treinar?</label>
                                    <asp:TextBox ID="txtTrainingDays" runat="server" CssClass="textbox numeric-mask" placeholder="Ex: 3" MaxLength="1"></asp:TextBox>
                                </div>

                                <!-- Tempo de Treino -->
                                <div class="question-item">
                                    <label for="txtTrainingTime">Quanto tempo você tem disponível por treino?</label>
                                    <asp:TextBox ID="txtTrainingTime" runat="server" CssClass="textbox time-mask" placeholder="Ex: 01:30"></asp:TextBox>
                                </div>

                                <!-- Nível de Treino -->
                                <div class="question-item">
                                    <label for="txtTrainingLevel">Como é/foi seu nível de treino anterior?</label>
                                    <asp:DropDownList ID="txtTrainingLevel" runat="server" CssClass="dropdown">
                                        <asp:ListItem Text="Iniciante" Value="Iniciante" />
                                        <asp:ListItem Text="Intermediário" Value="Intermediário" />
                                        <asp:ListItem Text="Avançado" Value="Avançado" />
                                    </asp:DropDownList>
                                </div>

                                <!-- Lesões -->
                                <div class="question-item">
                                    <label for="txtInjuries">Tem alguma lesão ou dor frequente?</label>
                                    <asp:TextBox ID="txtInjuries" runat="server" CssClass="textbox" placeholder="Ex: Dor no joelho"></asp:TextBox>
                                </div>

                                <!-- Limitações -->
                                <div class="question-item">
                                    <label for="txtLimitations">Possui alguma limitação de movimento?</label>
                                    <asp:TextBox ID="txtLimitations" runat="server" CssClass="textbox" placeholder="Ex: Cirurgia no ombro"></asp:TextBox>
                                </div>

                                <!-- Condições de Saúde -->
                                <div class="question-item">
                                    <label for="txtHealthConditions">Tem alguma condição de saúde?</label>
                                    <asp:TextBox ID="txtHealthConditions" runat="server" CssClass="textbox" placeholder="Ex: Hipertensão"></asp:TextBox>
                                </div>

                                <!-- Nível de Atividade Física -->
                                <div class="question-item">
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
        .question-form {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .question-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 15px;
        }

        .question-item {
            text-align: left;
        }

            .question-item label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }

        .textbox, .dropdown {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .btn-submit {
            width: 100%;
            max-width: 300px;
            background-color: #0070e8;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 16px;
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
                background-color: #0070e8;
                color: #ffffff;
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

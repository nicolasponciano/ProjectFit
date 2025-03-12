<%@ Page Title="Treino Personalizado" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Treino.aspx.cs" Inherits="ProjectFit.Treino" Async="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <main aria-labelledby="title">
        <div class="question-container">
            <h2 id="title"><%= Title %></h2>
            <h3>Responda as perguntas para gerar seu treino personalizado</h3>
            
            <div class="question-form">
                <!-- Pergunta 1 -->
                <div class="question-item">
                    <label for="txtTrainingExperience">Você já treina? Se sim, há quanto tempo?</label>
                    <asp:TextBox ID="txtTrainingExperience" runat="server" CssClass="textbox" placeholder="Ex: Sim, treino há 1 ano"></asp:TextBox>
                </div>

                <!-- Pergunta 2 -->
                <div class="question-item">
                    <label for="txtTrainingDays">Quantos dias por semana você consegue treinar?</label>
                    <asp:TextBox ID="txtTrainingDays" runat="server" CssClass="textbox" placeholder="Ex: 3 dias"></asp:TextBox>
                </div>

                <!-- Pergunta 3 -->
                <div class="question-item">
                    <label for="txtTrainingTime">Quanto tempo você tem disponível por treino? (Exemplo: 45 min, 1h, 1h30)</label>
                    <asp:TextBox ID="txtTrainingTime" runat="server" CssClass="textbox" placeholder="Ex: 1 hora"></asp:TextBox>
                </div>

                <!-- Pergunta 4 -->
                <div class="question-item">
                    <label for="txtTrainingLevel">Como é/foi seu nível de treino anterior? (A quanto tempo treina)</label>
                    <asp:TextBox ID="txtTrainingLevel" runat="server" CssClass="textbox" placeholder="Ex: Intermediário, treino há 2 anos"></asp:TextBox>
                </div>

                <!-- Pergunta 5 -->
                <div class="question-item">
                    <label for="txtInjuries">Tem alguma lesão ou dor frequente? (Joelho, ombro, coluna, etc.)</label>
                    <asp:TextBox ID="txtInjuries" runat="server" CssClass="textbox" placeholder="Ex: Dor no joelho"></asp:TextBox>
                </div>

                <!-- Pergunta 6 -->
                <div class="question-item">
                    <label for="txtLimitations">Possui alguma limitação de movimento ou cirurgia prévia?</label>
                    <asp:TextBox ID="txtLimitations" runat="server" CssClass="textbox" placeholder="Ex: Cirurgia no ombro"></asp:TextBox>
                </div>

                <!-- Pergunta 7 -->
                <div class="question-item">
                    <label for="txtHealthConditions">Tem alguma condição de saúde que deve ser considerada? (Hipertensão, diabetes, problemas cardíacos)</label>
                    <asp:TextBox ID="txtHealthConditions" runat="server" CssClass="textbox" placeholder="Ex: Hipertensão"></asp:TextBox>
                </div>

                <!-- Pergunta 8 -->
                <div class="question-item">
                    <label for="txtActivityLevel">Como é seu nível de atividade física fora da academia? (Trabalho ativo ou sedentário?)</label>
                    <asp:TextBox ID="txtActivityLevel" runat="server" CssClass="textbox" placeholder="Ex: Trabalho sedentário"></asp:TextBox>
                </div>

                <!-- Botão de Envio -->
                <asp:Button ID="btnSubmit" runat="server" Text="Gerar Treino" CssClass="btn-submit" OnClick="btnSubmit_Click" />

               
                <h2>Treino Gerado</h2>
                <asp:Label ID="lblTreino" runat="server" Text="Aqui aparecerá o treino." CssClass="treino-content" />

            </div>
        </div>
    </main>

    <style>
        /* Estilos da página (já estão presentes no seu código) */
        .question-container {
            padding: 20px;
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
        }

        .question-container h3 {
            font-size: 1.8em;
            margin-bottom: 20px;
            color: #0070e8; /* Azul padrão do site */
        }

        .question-form {
            text-align: left;
        }

        .question-item {
            margin-bottom: 20px;
        }

        .question-item label {
            font-size: 1.1em;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .textbox {
            width: 100%;
            padding: 10px;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .textbox:focus {
            border-color: #0070e8;
            box-shadow: 0 4px 8px rgba(0, 112, 232, 0.2);
            outline: none;
        }

        .btn-submit {
            background-color: #0070e8;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #005bb5;
        }
    </style>
</asp:Content>
<%@ Page Title="Treino Personalizado" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Treino.aspx.cs" Inherits="ProjectFit.Treino" Async="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <div class="container">
            <h2 id="title"><%= Title %></h2>
            <h3>Responda as perguntas para gerar seu treino</h3>

            <div class="question-form">
                <asp:Panel ID="pnlQuestions" runat="server" CssClass="question-panel">
                    <div class="question-item">
                        <label for="txtTrainingExperience">Você já treina? Se sim, há quanto tempo?</label>
                        <asp:TextBox ID="txtTrainingExperience" runat="server" CssClass="textbox" placeholder="Ex: Sim, treino há 1 ano"></asp:TextBox>
                    </div>

                    <div class="question-item">
                        <label for="txtTrainingDays">Quantos dias por semana você consegue treinar?</label>
                        <asp:TextBox ID="txtTrainingDays" runat="server" CssClass="textbox" placeholder="Ex: 3 dias"></asp:TextBox>
                    </div>

                    <div class="question-item">
                        <label for="txtTrainingTime">Quanto tempo você tem disponível por treino?</label>
                        <asp:TextBox ID="txtTrainingTime" runat="server" CssClass="textbox" placeholder="Ex: 1 hora"></asp:TextBox>
                    </div>

                    <div class="question-item">
                        <label for="txtTrainingLevel">Como é/foi seu nível de treino anterior?</label>
                        <asp:TextBox ID="txtTrainingLevel" runat="server" CssClass="textbox" placeholder="Ex: Intermediário, treino há 2 anos"></asp:TextBox>
                    </div>

                    <div class="question-item">
                        <label for="txtInjuries">Tem alguma lesão ou dor frequente?</label>
                        <asp:TextBox ID="txtInjuries" runat="server" CssClass="textbox" placeholder="Ex: Dor no joelho"></asp:TextBox>
                    </div>

                    <div class="question-item">
                        <label for="txtLimitations">Possui alguma limitação de movimento?</label>
                        <asp:TextBox ID="txtLimitations" runat="server" CssClass="textbox" placeholder="Ex: Cirurgia no ombro"></asp:TextBox>
                    </div>

                    <div class="question-item">
                        <label for="txtHealthConditions">Tem alguma condição de saúde?</label>
                        <asp:TextBox ID="txtHealthConditions" runat="server" CssClass="textbox" placeholder="Ex: Hipertensão"></asp:TextBox>
                    </div>

                    <div class="question-item">
                        <label for="txtActivityLevel">Como é seu nível de atividade física fora da academia?</label>
                        <asp:TextBox ID="txtActivityLevel" runat="server" CssClass="textbox" placeholder="Ex: Trabalho sedentário"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnSubmit" runat="server" Text="Gerar Treino" CssClass="btn-submit" OnClick="btnSubmit_Click" />
                </asp:Panel>

                <div class="treino-container">
                    <h2>Treino Gerado</h2>
                    <asp:Label ID="lblTreino" runat="server" CssClass="dieta-content" />
                </div>
            </div>
        </div>
    </main>

    <style>
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            text-align: center;
        }

        .question-form {
            text-align: center;
            background: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
        }

        .question-item {
            margin-bottom: 15px;
        }

        .question-item label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .textbox {
            width: 300px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
        }

        .btn-submit {
            width: 300px;
            background-color: #0070e8;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background-color: #005bb5;
        }

        .treino-container {
            margin-top: 20px;
            padding: 15px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        }

        .dieta-content {
            font-size: 1.2em;
            font-weight: bold;
            color: #0070e8;
        }
    </style>
</asp:Content>
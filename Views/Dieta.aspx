<%@ Page Title="Dieta Personalizada" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dieta.aspx.cs" Inherits="ProjectFit.Dieta" Async="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <div class="container">
            <h2 id="title"><%= Title %></h2>
            <h3>Responda as perguntas para gerar sua dieta personalizada</h3>

            <div class="question-form">
                <div class="question-item">
                    <label for="txtObjetivo">Qual é o seu objetivo principal?</label>
                    <asp:DropDownList ID="ddlObjetivo" runat="server" CssClass="dropdown">
                        <asp:ListItem Text="Perda de peso" Value="Perda de peso" />
                        <asp:ListItem Text="Ganho de massa" Value="Ganho de massa" />
                        <asp:ListItem Text="Manutenção" Value="Manutenção" />
                    </asp:DropDownList>
                </div>

                <div class="question-item">
                    <label for="txtRefeicoes">Quantas refeições faz por dia?</label>
                    <asp:TextBox ID="txtRefeicoes" runat="server" CssClass="textbox" placeholder="Ex: 5 refeições"></asp:TextBox>
                </div>

                <div class="question-item">
                    <label for="txtRestricoes">Tem alguma restrição alimentar ou alergia?</label>
                    <asp:TextBox ID="txtRestricoes" runat="server" CssClass="textbox" placeholder="Ex: Intolerância à lactose"></asp:TextBox>
                </div>

                <div class="question-item">
                    <label for="txtAgua">Como é sua ingestão de água diária?</label>
                    <asp:TextBox ID="txtAgua" runat="server" CssClass="textbox" placeholder="Ex: 2 litros por dia"></asp:TextBox>
                </div>

                <div class="question-item">
                    <label for="txtFastFood">Costuma consumir fast food ou alimentos processados?</label>
                    <asp:DropDownList ID="ddlFastFood" runat="server" CssClass="dropdown">
                        <asp:ListItem Text="Não" Value="Não" />
                        <asp:ListItem Text="1 vez por semana" Value="1 vez por semana" />
                        <asp:ListItem Text="2 ou mais vezes por semana" Value="2 ou mais vezes por semana" />
                    </asp:DropDownList>
                </div>

                <div class="question-item">
                    <label for="txtPreferencias">Tem alguma preferência alimentar?</label>
                    <asp:DropDownList ID="ddlPreferencias" runat="server" CssClass="dropdown">
                        <asp:ListItem Text="Carnívoro" Value="Carnívoro" />
                        <asp:ListItem Text="Vegetariano" Value="Vegetariano" />
                        <asp:ListItem Text="Vegano" Value="Vegano" />
                    </asp:DropDownList>
                </div>

                <div class="question-item">
                    <label for="txtRotina">Qual é sua rotina alimentar atual?</label>
                    <asp:TextBox ID="txtRotina" runat="server" CssClass="textbox" placeholder="Ex: Como de 3 em 3 horas"></asp:TextBox>
                </div>

                <div class="question-item">
                    <label for="txtAlimentosEvitados">Há algum alimento que você não gosta ou evita?</label>
                    <asp:TextBox ID="txtAlimentosEvitados" runat="server" CssClass="textbox" placeholder="Ex: Não gosto de peixe"></asp:TextBox>
                </div>

                <asp:Button ID="btnSubmit" runat="server" Text="Gerar Dieta" CssClass="btn-submit" OnClick="btnSubmit_Click" />

                <div class="dieta-container">
                    <h2>Dieta Gerada</h2>
                    <asp:Label ID="lblDieta" runat="server" CssClass="dieta-content" />
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

    .textbox, .dropdown {
        width: 100%;
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

    .dieta-container {
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

    .dropdown, .textbox {
        width: 300px;
    }
</style>

</asp:Content>

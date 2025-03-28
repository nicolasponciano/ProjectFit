﻿<%@ Page Title="Dieta Personalizada" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dietas.aspx.cs" Inherits="ProjectFit.Dietas" Async="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Como o MasterPage já possui o ScriptManager, não adicionamos outro aqui -->

    <div class="container">
        <h2>Dieta Personalizada</h2>
        <h3>Responda as perguntas para gerar sua dieta personalizada</h3>

        <!-- UpdatePanel para postback assíncrono -->
        <asp:UpdatePanel runat="server" ID="updatePanel">
            <ContentTemplate>
                <div class="question-form">
                    <!-- Objetivo -->
                    <div class="question-item">
                        <label for="ddlObjetivo">Qual é o seu objetivo principal?</label>
                        <asp:DropDownList ID="ddlObjetivo" runat="server" CssClass="dropdown">
                            <asp:ListItem Text="Perda de peso" Value="Perda de peso" />
                            <asp:ListItem Text="Ganho de massa" Value="Ganho de massa" />
                            <asp:ListItem Text="Manutenção" Value="Manutenção" />
                        </asp:DropDownList>
                    </div>

                    <!-- Refeições -->
                    <div class="question-item">
                        <label for="txtRefeicoes">Quantas refeições faz por dia?</label>
                        <asp:TextBox ID="txtRefeicoes" runat="server" CssClass="textbox numeric-input"
                            placeholder="Ex: 5" type="number" min="1" max="10"></asp:TextBox>
                    </div>

                    <!-- Restrições Alimentares -->
                    <div class="question-item">
                        <label for="txtRestricoes">Tem alguma restrição alimentar ou alergia?</label>
                        <asp:TextBox ID="txtRestricoes" runat="server" CssClass="textbox"
                            placeholder="Ex: Intolerância à lactose"></asp:TextBox>
                    </div>

                    <!-- Ingestão de Água -->
                    <div class="question-item">
                        <label for="txtAgua">Como é sua ingestão de água diária?</label>
                        <asp:TextBox ID="txtAgua" runat="server" CssClass="textbox numeric-input"
                            placeholder="Ex: 2.5" type="number" step="0.1" min="0"></asp:TextBox>
                        <span class="input-hint">Litros por dia</span>
                    </div>

                    <!-- Consumo de Fast Food -->
                    <div class="question-item">
                        <label for="ddlFastFood">Costuma consumir fast food ou alimentos processados?</label>
                        <asp:DropDownList ID="ddlFastFood" runat="server" CssClass="dropdown">
                            <asp:ListItem Text="Não" Value="Não" />
                            <asp:ListItem Text="1 vez por semana" Value="1 vez por semana" />
                            <asp:ListItem Text="2 ou mais vezes por semana" Value="2 ou mais vezes por semana" />
                        </asp:DropDownList>
                    </div>

                    <!-- Preferências Alimentares -->
                    <div class="question-item">
                        <label for="ddlPreferencias">Tem alguma preferência alimentar?</label>
                        <asp:DropDownList ID="ddlPreferencias" runat="server" CssClass="dropdown">
                            <asp:ListItem Text="Carnívoro" Value="Carnívoro" />
                            <asp:ListItem Text="Vegetariano" Value="Vegetariano" />
                            <asp:ListItem Text="Vegano" Value="Vegano" />
                        </asp:DropDownList>
                    </div>

                    <!-- Rotina Alimentar -->
                    <div class="question-item">
                        <label for="txtRotina">Qual é sua rotina alimentar atual?</label>
                        <asp:TextBox ID="txtRotina" runat="server" CssClass="textbox"
                            placeholder="Ex: Como de 3 em 3 horas"></asp:TextBox>
                    </div>

                    <!-- Alimentos Evitados -->
                    <div class="question-item">
                        <label for="txtAlimentosEvitados">Há algum alimento que você não gosta ou evita?</label>
                        <asp:TextBox ID="txtAlimentosEvitados" runat="server" CssClass="textbox"
                            placeholder="Ex: Não gosto de peixe"></asp:TextBox>
                    </div>

                    <!-- Botão de Envio -->
                    <asp:Button ID="btnSubmit" runat="server" Text="Gerar Dieta" CssClass="btn-submit"
                        OnClick="btnSubmit_Click" />
                </div>

                <!-- Seção para exibir a resposta em Grid -->
                <div class="result-section">
                    <asp:GridView ID="gridDieta" runat="server" CssClass="dieta-grid" AutoGenerateColumns="false"
                        ShowHeaderWhenEmpty="true" EmptyDataText="Nenhuma dieta gerada ainda">
                        <Columns>
                            <asp:TemplateField HeaderText="Refeição" ItemStyle-Width="120px" HeaderStyle-CssClass="header-center">
                                <ItemTemplate>
                                    <asp:Literal ID="litRefeicao" runat="server" Text='<%# Eval("Refeicao") %>'></asp:Literal>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Horario" HeaderText="Horário Sugerido" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />

                            <asp:TemplateField HeaderText="Alimentos" ItemStyle-Width="300px" ItemStyle-CssClass="alimentos-column">
                                <ItemTemplate>
                                    <asp:Literal ID="litAlimentos" runat="server" Text='<%# Eval("Alimentos") %>'></asp:Literal>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Calorias" HeaderText="Calorias Aproximadas"
                                ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="caloria-cell" />

                            <asp:TemplateField HeaderText="Dicas de Preparo" ItemStyle-Width="250px">
                                <ItemTemplate>
                                    <asp:Literal ID="litObservacoes" runat="server" Text='<%# Bind("Observacoes") %>'></asp:Literal>
                                </ItemTemplate>
                            </asp:TemplateField>

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


    <style>
        .question-form {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .question-item {
            margin-bottom: 15px;
            text-align: left;
        }

            .question-item label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }

        .textbox, .dropdown {
            width: 100%;
            max-width: 300px;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
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
        }

        .result-section {
            margin-top: 20px;
        }

        /* Estilos aprimorados para o GridView */

        .meal-type-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 15px;
            font-size: 0.8em;
        }

        .breakfast-badge {
            background-color: #fff3cd;
            color: #856404;
        }

        .lunch-badge {
            background-color: #d4edda;
            color: #155724;
        }

        .dicas-lista {
            list-style: none;
            padding-left: 0;
            margin: 0;
        }

            .dicas-lista li {
                position: relative;
                padding-left: 20px;
                margin-bottom: 8px;
            }

                .dicas-lista li:before {
                    content: "•";
                    color: #0070e8;
                    position: absolute;
                    left: 0;
                    font-weight: bold;
                }

        .dieta-grid {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 16px;
            font-family: Arial, sans-serif;
        }

            .dieta-grid th, .dieta-grid td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: left;
            }

            .dieta-grid th {
                background-color: #0070e8;
                color: #ffffff;
                text-align: center;
                font-weight: bold;
            }

            .dieta-grid tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .dieta-grid tr:hover {
                background-color: #f1f1f1;
            }

        .links-column a {
            color: #0070e8;
            text-decoration: none;
        }

            .links-column a:hover {
                text-decoration: underline;
            }
    </style>

</asp:Content>

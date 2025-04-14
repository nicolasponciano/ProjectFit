<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MeusTreinos.aspx.cs" Inherits="ProjectFit.Views.MeusTreinos" %>

<%@ Register TagPrefix="uc" TagName="EditarTreino" Src="~/Views/EditarTreino.ascx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2 class="text-center mb-4">Meus Treinos</h2>

        <!-- Repeater para exibir os grids -->
        <asp:Repeater ID="RptTreinos" runat="server" OnItemDataBound="RptTreinos_ItemDataBound">
            <ItemTemplate>
                <div class="card mb-4 shadow-sm">
                    <div class="card-header d-flex justify-content-between align-items-center text-white">
                        <span>Treino <strong><%# ((ProjectFit.Views.MeusTreinos.TreinoViewModel)Container.DataItem).NumeroTreino %></strong></span>
                        <div class="btn-group">
                            <asp:Button ID="btnExportarPdf" runat="server" Text="Exportar PDF"
                                CssClass="btn btn-success btn-sm"
                                CommandArgument='<%# Eval("NumeroTreino") %>'
                                OnClick="btnExportarPdf_Click" />

                            <asp:Button ID="btnExcluirGrid" runat="server" Text="Excluir Treino"
                                CssClass="btn btn-danger btn-sm"
                                CommandArgument='<%# Eval("NumeroTreino") %>'
                                OnClick="btnExcluirGrid_Click" />
                        </div>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gridMeusTreinos" runat="server" CssClass="table table-bordered table-hover"
                            AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="Nenhum treino cadastrado"
                            DataKeyNames="Id_Treino">
                            <Columns>
                                <asp:BoundField DataField="DiaTreino" HeaderText="Dia do Treino" ItemStyle-CssClass="text-capitalize fw-bold" />

                                <asp:BoundField DataField="Exercicio" HeaderText="Exercício" />

                                <asp:BoundField DataField="SeriesRepeticoes" HeaderText="Séries x Repetições" />

                                <asp:BoundField DataField="Descanso" HeaderText="Descanso" />

                                <asp:BoundField DataField="Equipamento" HeaderText="Equipamento" />

                                <asp:BoundField DataField="GrupoMuscular" HeaderText="Grupo Muscular" />

                                <asp:BoundField DataField="Dicas" HeaderText="Dicas" />

                                <asp:TemplateField HeaderText="Links">
                                    <ItemTemplate>
                                        <a href='<%# Eval("LinksReferenciaisTreino") %>' target="_blank" class="btn btn-link p-0 text-decoration-none text-primary">Abrir Link
                                        </a>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="DataRegistro" HeaderText="Data de Registro" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-CssClass="text-center" />

                                <asp:TemplateField HeaderText="Ações" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <div class="btn-group" role="group">
                                            <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn btn-outline-primary btn-sm"
                                                CommandArgument='<%# Eval("Id_Treino") %>' OnClick="btnEditar_Click" />
                                            <asp:Button ID="btnExcluir" runat="server" Text="Excluir" CssClass="btn btn-outline-danger btn-sm"
                                                CommandArgument='<%# Eval("Id_Treino") %>' OnClick="btnExcluir_Click" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Modal para Edição de Treino -->
        <div id="modalEditar" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Editar Treino</h5>
                        <i class="fas fa-edit fa-lg"></i>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <uc:EditarTreino ID="EditarTreinoControl" runat="server" Visible="false" />
                    </div>
                </div>
            </div>
        </div>

    </div>

    <style>
        /* Paleta de Cores */
        :root {
            --primary-color: #2C3E50; /* Azul escuro */
            --secondary-color: #E74C3C; /* Vermelho */
            --success-color: #28a745; /* Verde */
            --text-color: #FFFFFF; /* Branco */
            --background-color: #f9f9f9; /* Fundo claro */
            --shadow-color: rgba(0, 0, 0, 0.1); /* Sombra suave */
        }

        /* Estilos Gerais */
        h2 {
            color: var(--primary-color);
            font-weight: bold;
        }

        .card {
            background: var(--background-color);
            border: none;
            box-shadow: 0 2px 10px var(--shadow-color);
        }

        .card-header {
            background: #536061;
            color: var(--text-color);
            font-size: 18px;
        }

        .modal-header {
            background: var(--primary-color);
            color: var(--text-color);
        }

        .card-header .btn-danger {
            background: var(--secondary-color);
            border: none;
        }

            .card-header .btn-danger:hover {
                background: var(--primary-color);
            }

        .table {
            background: var(--text-color);
            color: #333;
        }

            .table th {
                background: var(--primary-color);
                color: var(--text-color);
                font-weight: bold;
                text-align: center;
            }

            .table td {
                vertical-align: middle;
            }

        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }

        .btn-group {
            display: flex;
            gap: 5px;
        }

        .btn-outline-primary {
            border-color: var(--primary-color);
            color: var(--primary-color);
        }

            .btn-outline-primary:hover {
                background: var(--primary-color);
                color: var(--text-color);
            }

        .btn-outline-danger {
            border-color: var(--secondary-color);
            color: var(--secondary-color);
        }

            .btn-outline-danger:hover {
                background: var(--secondary-color);
                color: var(--text-color);
            }

        .btn-link {
            color: var(--primary-color);
        }

            .btn-link:hover {
                color: var(--primary-color);
            }
    </style>

    <!-- Script para Manipulação do Modal -->
    <script>
        // Função para abrir o modal ao clicar em "Editar"
        function abrirModalEdicao() {
            $('#modalEditar').modal('show');
        }

        // Função para tornar os links clicáveis
        $(document).ready(function () {
            $('.btn-link').on('click', function (e) {
                e.stopPropagation(); // Evita conflitos com outros eventos
            });
        });
    </script>
</asp:Content>

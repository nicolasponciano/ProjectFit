<%@ Page Title="Minhas Dietas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MinhasDietas.aspx.cs" Inherits="ProjectFit.Views.MinhasDietas" Async="true" %>

<%@ Register Src="~/Views/EditarDieta.ascx" TagName="EditarDieta" TagPrefix="uc" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2 class="text-center mb-4">Minhas Dietas</h2>

        <!-- Controles de paginação -->
        <div class="d-flex justify-content-center mb-3">
            <asp:Button ID="btnAnterior" runat="server" Text="Anterior" CssClass="btn btn-outline-primary me-2" OnClick="btnAnterior_Click" />
            <asp:Button ID="btnProximo" runat="server" Text="Próximo" CssClass="btn btn-outline-primary" OnClick="btnProximo_Click" />
        </div>

        <!-- Repeater para exibir os grids -->
        <asp:Repeater ID="RptDietas" runat="server" OnItemDataBound="RptDietas_ItemDataBound">
            <ItemTemplate>
                <div class="card mb-4 shadow-sm">
                    <div class="card-header d-flex justify-content-between align-items-center text-white">
                        <span>Dieta <strong><%# ((ProjectFit.Views.MinhasDietas.DietaViewModel)Container.DataItem).NumeroDieta %></strong></span>
                        
                        <div class="btn-group">
                            <asp:Button ID="btnExportarPdf" runat="server" Text="Exportar PDF" CssClass="btn btn-success btn-sm"
                                CommandArgument='<%# Eval("NumeroDieta") %>' OnClick="btnExportarPdf_Click" />
                            <asp:Button ID="btnExcluirGrid" runat="server" Text="Excluir Dieta" CssClass="btn btn-danger btn-sm"
                                CommandArgument='<%# Eval("NumeroDieta") %>' OnClick="btnExcluirGrid_Click" 
                                OnClientClick="return confirm('Tem certeza que deseja excluir TODAS as refeições desta dieta?');" />
                        </div>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gridMinhasDietas" runat="server" CssClass="table table-bordered table-hover"
                            AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="Nenhuma refeição cadastrada"
                            DataKeyNames="Id_Dieta">
                            <Columns>
                                <asp:BoundField DataField="Refeicao" HeaderText="Refeição" ItemStyle-CssClass="text-capitalize fw-bold" />
                                <asp:BoundField DataField="Horario" HeaderText="Horário" ItemStyle-CssClass="text-center" />
                                <asp:TemplateField HeaderText="Alimentos">
                                    <ItemTemplate>
                                        <asp:Literal ID="litAlimentos" runat="server" Text='<%# Eval("Alimentos") %>'></asp:Literal>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Calorias" HeaderText="Calorias (kcal)" ItemStyle-CssClass="text-end" />
                                <asp:BoundField DataField="Observacoes" HeaderText="Observações" />
                                <asp:TemplateField HeaderText="Links">
                                    <ItemTemplate>
                                        <a href='<%# Eval("LinksReferenciais") %>' target="_blank" class="btn btn-link p-0 text-decoration-none text-primary">
                                            Abrir Link
                                        </a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DataRegistro" HeaderText="Data de Registro" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-CssClass="text-center" />
                                <asp:TemplateField HeaderText="Ações" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <div class="btn-group" role="group">
                                            <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn btn-outline-primary btn-sm"
                                                CommandArgument='<%# Eval("Id_Dieta") %>' OnClick="btnEditar_Click" />
                                            <asp:Button ID="btnExcluir" runat="server" Text="Excluir" CssClass="btn btn-outline-danger btn-sm"
                                                CommandArgument='<%# Eval("Id_Dieta") %>' OnClick="btnExcluir_Click" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Modal para Edição -->
        <div id="modalEditar" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Editar Dieta</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <uc:EditarDieta ID="EditarDietaControl" runat="server" Visible="false" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        /* Paleta de Cores */
        :root {
            --primary-color: #2C3E50;
            --secondary-color: #E74C3C;
            --success-color: #28a745;
            --text-color: #FFFFFF;
            --background-color: #f9f9f9;
            --shadow-color: rgba(0, 0, 0, 0.1);
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
            background: var(--primary-color);
            color: var(--text-color);
            font-size: 18px;
        }
        
        .modal-header {
            background: var(--primary-color);
            border: none;
        }
        
        .card-header .btn-group {
            gap: 8px;
        }
        
        .card-header .btn-success {
            background: var(--success-color);
            border: none;
        }
        
        .card-header .btn-success:hover {
            background: #218838;
        }
        
        .card-header .btn-danger {
            background: var(--secondary-color);
            border: none;
        }
        
        .card-header .btn-danger:hover {
            background: #c82333;
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
            color: var(--secondary-color);
        }
    </style>

    <!-- Script para Manipulação do Modal -->
    <script>
        function abrirModalEdicao() {
            $('#modalEditar').modal('show');
        }

        $(document).ready(function () {
            $('.btn-link').on('click', function (e) {
                e.stopPropagation();
            });
        });
    </script>
</asp:Content>
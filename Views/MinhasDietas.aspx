<%@ Page Title="Minhas Dietas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MinhasDietas.aspx.cs" Inherits="ProjectFit.Views.MinhasDietas" Async="true" %>

<%@ Register Src="~/Views/EditarDieta.ascx" TagName="EditarDieta" TagPrefix="uc" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2 class="text-center mb-4">Minhas Dietas</h2>

        <!-- Repeater para exibir os grids -->
        <asp:Repeater ID="RptDietas" runat="server" OnItemDataBound="RptDietas_ItemDataBound">
            <ItemTemplate>
                <div class="card mb-4 shadow-sm">
                    <div class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
                        <span>Dieta <strong><%# ((ProjectFit.Views.MinhasDietas.DietaViewModel)Container.DataItem).NumeroDieta %></strong></span>
                        <asp:Button ID="btnExcluirGrid" runat="server" Text="Excluir Grid" CssClass="btn btn-danger btn-sm"
                            CommandArgument='<%# Eval("NumeroDieta") %>' OnClick="btnExcluirGrid_Click" />
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
                                        <a href='<%# Eval("LinksReferenciais") %>' target="_blank" class="btn btn-link p-0 text-decoration-none">
                                            Abrir Link
                                        </a>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="DataRegistro" HeaderText="Data de Registro" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-CssClass="text-center" />

                                <asp:TemplateField HeaderText="Ações" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn btn-primary btn-sm me-2"
                                            CommandArgument='<%# Eval("Id_Dieta") %>' OnClick="btnEditar_Click" />
                                        <asp:Button ID="btnExcluir" runat="server" Text="Excluir" CssClass="btn btn-danger btn-sm"
                                            CommandArgument='<%# Eval("Id_Dieta") %>' OnClick="btnExcluir_Click" />
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
                    <div class="modal-header bg-primary text-white">
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
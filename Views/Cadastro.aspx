<%@ Page Title="Cadastro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cadastro.aspx.cs" Inherits="ProjectFit.Cadastro" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script type="text/javascript">
        function confirmarExclusao(botao) {
            if (botao.dataset.confirmado === "true") {
                botao.dataset.confirmado = "false";
                return true;
            }

            event.preventDefault();

            Swal.fire({
                title: 'Tem certeza?',
                text: "Esta ação não poderá ser desfeita!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sim, excluir!',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    botao.dataset.confirmado = "true";
                    botao.click();
                }
            });

            return false;
        }
    </script>

    <style>

       .modern-grid {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            background-color: #ffffff;
        }

        .modern-grid th {
            background-color: #f8f9fa;
            color: #495057;
            font-weight: 600;
            text-align: center;
            padding: 12px;
            border-bottom: 2px solid #e0e0e0;
        }

        .modern-grid td {
            padding: 12px;
            text-align: center;
            vertical-align: middle;
            border-bottom: 1px solid #e0e0e0;
            color: #495057;
        }

        .modern-grid tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .modern-grid tr:hover {
            background-color: #e9ecef;
            transition: background-color 0.3s ease;
        }

        /* Estilo para a paginação /*/
        .pagination > li > a {
            color: #495057;
            border: 1px solid #e0e0e0;
            margin: 0 4px;
            border-radius: 4px;
            padding: 8px 12px;
            transition: all 0.3s ease;
        }

        .pagination > li > a:hover {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .pagination > .active > a {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        /*/ Estilo para o container do GridView */
        .grid-container {
            margin-top: 2rem;
            padding: 1rem;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
    </style>



    <div class="container mt-5">
        <h1 class="text-center mb-4"><strong>Cadastro de Alunos</strong></h1>
        <div class="col-md-8 mx-auto">
            <asp:Panel ID="CadastroPanel" runat="server" CssClass="p-4 border rounded shadow bg-light">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="txtCpf"><i class="fas fa-id-card"></i> CPF:</label>
                            <asp:TextBox ID="txtCpf" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtNome"><i class="fas fa-user"></i> Nome Completo:</label>
                            <asp:TextBox ID="txtNome" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtEmail"><i class="fas fa-envelope"></i> E-Mail:</label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtSenha"><i class="fas fa-lock"></i> Senha:</label>
                            <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" CssClass="form-control" placeholder="Digite a senha"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtCep"><i class="fas fa-map-marker-alt"></i> CEP:</label>
                            <asp:TextBox ID="txtCep" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="txtTelefone"><i class="fas fa-phone"></i> Telefone:</label>
                            <asp:TextBox ID="txtTelefone" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtPeso"><i class="fas fa-weight"></i> Peso (kg):</label>
                            <asp:TextBox ID="txtPeso" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtAltura"><i class="fas fa-ruler-vertical"></i> Altura (m):</label>
                            <asp:TextBox ID="txtAltura" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtIMC"><i class="fas fa-calculator"></i> IMC:</label>
                            <asp:TextBox ID="txtIMC" CssClass="form-control mb-3" runat="server" ReadOnly="True"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtMeta"><i class="fas fa-bullseye"></i> Meta:</label>
                            <asp:TextBox ID="txtMeta" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end mt-4">
                    <asp:Button ID="btnCadastrar" CssClass="btn btn-primary me-2" runat="server" Text="Salvar" OnClick="btnCadastrar_Click" />
                    <asp:Button ID="btnBuscar" CssClass="btn btn-success me-2" runat="server" Text="Buscar" OnClick="btnBuscar_Click" />
                    <asp:Button ID="btnLimpar" CssClass="btn btn-secondary me-2" runat="server" Text="Limpar" OnClick="btnLimpar_Click" />
                    <asp:Button ID="btnExcluir" CssClass="btn btn-danger" runat="server" Text="Excluir"
                        OnClientClick="return confirmarExclusao(this);" OnClick="btnExcluir_Click" />
                </div>
            </asp:Panel>
        </div>


    <div class="mt-5">
            <div class="table-responsive">
                <asp:GridView ID="gvAlunos" runat="server" AutoGenerateColumns="False" CssClass="table custom-grid" AllowPaging="True" PageSize="10" OnPageIndexChanging="gvAlunos_PageIndexChanging">
                    <Columns>
                        <asp:BoundField DataField="Id_Aluno" HeaderText="ID Aluno" />
                        <asp:BoundField DataField="Nome" HeaderText="Nome Completo" />
                        <asp:BoundField DataField="Cpf" HeaderText="CPF" />
                        <asp:BoundField DataField="Email" HeaderText="E-Mail" />
                        <asp:BoundField DataField="Cep" HeaderText="CEP" />
                        <asp:BoundField DataField="Telefone" HeaderText="Telefone" />
                        <asp:BoundField DataField="Peso" HeaderText="Peso (kg)" DataFormatString="{0:F2}" />
                        <asp:BoundField DataField="Altura" HeaderText="Altura (m)" DataFormatString="{0:F2}" />
                        <asp:BoundField DataField="IMC" HeaderText="IMC" DataFormatString="{0:F2}" />
                        <asp:BoundField DataField="CodigoMeta" HeaderText="Código da Meta" />
                        <asp:BoundField DataField="Meta" HeaderText="Meta" />
                        <asp:BoundField DataField="CodigoPlanoTreino" HeaderText="Código Plano Treino" />
                        <asp:BoundField DataField="PlanoTreino" HeaderText="Nome Plano Treino" />
                        <asp:BoundField DataField="DataGravacao" HeaderText="Data Cadastro" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                        <asp:BoundField DataField="DataAlteracao" HeaderText="Data Alteração" DataFormatString="{0:dd/MM/yyyy HH:mm}" NullDisplayText="N/A" />
                    </Columns>
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="Primeira" LastPageText="Última" />
                    <PagerStyle CssClass="pagination justify-content-center" />
                </asp:GridView>
            </div>
        </div>
    </div>

</asp:Content>
<%@ Page Title="Cadastro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cadastro.aspx.cs" Inherits="ProjectFit.Cadastro" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        function confirmarExclusao(botao) {
            // Verifica se a ação já foi confirmada
            if (botao.dataset.confirmado === "true") {
                // Reseta o atributo para futuras operações
                botao.dataset.confirmado = "false";
                // Permite o postback
                return true;
            }

            // Previne o postback inicial
            event.preventDefault();

            // Exibe o modal de confirmação
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
                    // Marca que a confirmação foi obtida
                    botao.dataset.confirmado = "true";
                    // Dispara o clique novamente para proceder com o postback
                    botao.click();
                }
            });

            // Impede o postback até que a confirmação seja obtida
            return false;
        }
    </script>


    <div class="container">
        <h1 class="text-center mb-4"><strong>Cadastro de Alunos</strong></h1>
        <div class="col-md-6 mx-auto">
            <asp:Panel ID="CadastroPanel" runat="server" CssClass="p-4 border rounded shadow">
                <div class="form-group">
                    <label for="txtCpf">CPF:</label>
                    <asp:TextBox ID="txtCpf" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                    <asp:Button ID="btnBuscar" CssClass="btn btn-success me-2" runat="server" Text="Buscar" OnClick="btnBuscar_Click" />
                    <div class="d-flex">
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtNome">Nome Completo:</label>
                    <asp:TextBox ID="txtNome" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtEmail">E-Mail:</label>
                    <asp:TextBox ID="txtEmail" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtSenha">Senha:</label>
                    <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" CssClass="form-control" placeholder="Digite a senha"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtCep">CEP:</label>
                    <asp:TextBox ID="txtCep" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtTelefone">Telefone:</label>
                    <asp:TextBox ID="txtTelefone" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtPeso">Peso (kg):</label>
                    <asp:TextBox ID="txtPeso" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtAltura">Altura (m):</label>
                    <asp:TextBox ID="txtAltura" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtIMC">IMC:</label>
                    <asp:TextBox ID="txtIMC" CssClass="form-control mb-3" runat="server" ReadOnly="True"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtMeta">Meta:</label>
                    <asp:TextBox ID="txtMeta" CssClass="form-control mb-3" runat="server"></asp:TextBox>
                </div>

                <div class="d-flex">
                    <asp:Button ID="btnCadastrar" CssClass="btn btn-primary me-2" runat="server" Text="Salvar" OnClick="btnCadastrar_Click" />
                    <asp:Button ID="btnLimpar" CssClass="btn btn-secondary me-2" runat="server" Text="Limpar" OnClick="btnLimpar_Click" />
                    <asp:Button ID="btnExcluir" CssClass="btn btn-danger" runat="server" Text="Excluir"
                        OnClientClick="return confirmarExclusao(this);" OnClick="btnExcluir_Click" />
                </div>
            </asp:Panel>
        </div>

        <div class="mt-5">
            <div class="table-responsive">
                <asp:GridView ID="gvAlunos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" AllowPaging="True" PageSize="10" OnPageIndexChanging="gvAlunos_PageIndexChanging">
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

<%@ Page Title="Cadastro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cadastro.aspx.cs" Inherits="ProjectFit.Cadastro" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow-lg" style="width: 100%; max-width: 1200px;">
            <div class="card-body p-5">
                <h1 class="text-center mb-4"><strong>Cadastro de Alunos</strong></h1>

                <!-- Mensagens de Erro -->
                <asp:ValidationSummary runat="server" CssClass="alert alert-danger mb-4" />
                <div class="text-danger mb-4">
                    <asp:Literal runat="server" ID="ErrorMessage" />
                </div>

                <!-- Formulário de Cadastro -->
                <asp:Panel ID="CadastroPanel" runat="server" CssClass="p-4 border rounded shadow bg-light">
                    <div class="row">
                        <!-- Coluna 1 -->
                        <div class="col-md-6">
                            <!-- CPF -->
                            <div class="mb-3">
                                <label for="txtCpf" class="form-label fw-bold"><i class="fas fa-id-card"></i> CPF</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-card-text"></i>
                                    </span>
                                    <asp:TextBox ID="txtCpf" CssClass="form-control form-control-lg" runat="server" placeholder="000.000.000-00" />
                                </div>
                            </div>

                            <!-- Nome Completo -->
                            <div class="mb-3">
                                <label for="txtNome" class="form-label fw-bold"><i class="fas fa-user"></i> Nome Completo</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-person"></i>
                                    </span>
                                    <asp:TextBox ID="txtNome" CssClass="form-control form-control-lg" runat="server" />
                                </div>
                            </div>

                            <!-- Email -->
                            <div class="mb-3">
                                <label for="txtEmail" class="form-label fw-bold"><i class="fas fa-envelope"></i> E-Mail</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-envelope"></i>
                                    </span>
                                    <asp:TextBox ID="txtEmail" CssClass="form-control form-control-lg" runat="server" placeholder="nome@exemplo.com" />
                                </div>
                                <div class="invalid-feedback" id="emailFeedback"></div>
                            </div>

                            <!-- Senha -->
                            <div class="mb-3">
                                <label for="txtSenha" class="form-label fw-bold"><i class="fas fa-lock"></i> Senha</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock"></i>
                                    </span>
                                    <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" CssClass="form-control form-control-lg" placeholder="Digite a senha" />
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="bi bi-eye-slash"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback" id="passwordFeedback"></div>
                            </div>

                            <!-- CEP -->
                            <div class="mb-3">
                                <label for="txtCep" class="form-label fw-bold"><i class="fas fa-map-marker-alt"></i> CEP</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-geo-alt"></i>
                                    </span>
                                    <asp:TextBox ID="txtCep" CssClass="form-control form-control-lg" runat="server" placeholder="00000-000" />
                                </div>
                            </div>
                        </div>

                        <!-- Coluna 2 -->
                        <div class="col-md-6">
                            <!-- Telefone -->
                            <div class="mb-3">
                                <label for="txtTelefone" class="form-label fw-bold"><i class="fas fa-phone"></i> Telefone</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-telephone"></i>
                                    </span>
                                    <asp:TextBox ID="txtTelefone" CssClass="form-control form-control-lg" runat="server" placeholder="(00) 00000-0000" />
                                </div>
                            </div>

                            <!-- Peso -->
                            <div class="mb-3">
                                <label for="txtPeso" class="form-label fw-bold"><i class="fas fa-weight"></i> Peso (kg)</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-speedometer2"></i>
                                    </span>
                                    <asp:TextBox ID="txtPeso" CssClass="form-control form-control-lg" runat="server" placeholder="Ex: 75" />
                                </div>
                            </div>

                            <!-- Altura -->
                            <div class="mb-3">
                                <label for="txtAltura" class="form-label fw-bold"><i class="fas fa-ruler-vertical"></i> Altura (m)</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-arrow-up"></i>
                                    </span>
                                    <asp:TextBox ID="txtAltura" CssClass="form-control form-control-lg" runat="server" placeholder="Ex: 1.75" />
                                </div>
                            </div>

                            <!-- IMC -->
                            <div class="mb-3">
                                <label for="txtIMC" class="form-label fw-bold"><i class="fas fa-calculator"></i> IMC</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-calculator"></i>
                                    </span>
                                    <asp:TextBox ID="txtIMC" CssClass="form-control form-control-lg bg-light" runat="server" ReadOnly="True" />
                                </div>
                            </div>

                            <!-- Meta -->
                            <div class="mb-3">
                                <label for="txtMeta" class="form-label fw-bold"><i class="fas fa-bullseye"></i> Meta</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-bullseye"></i>
                                    </span>
                                    <asp:TextBox ID="txtMeta" CssClass="form-control form-control-lg" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Botões -->
                    <div class="d-flex justify-content-end mt-4">
                        <asp:Button ID="btnCadastrar" CssClass="btn btn-primary me-2" runat="server" Text="Salvar" OnClick="btnCadastrar_Click" />
                        <asp:Button ID="btnBuscar" CssClass="btn btn-success me-2" runat="server" Text="Buscar" OnClick="btnBuscar_Click" />
                        <asp:Button ID="btnLimpar" CssClass="btn btn-secondary me-2" runat="server" Text="Limpar" OnClick="btnLimpar_Click" />
                        <asp:Button ID="btnExcluir" CssClass="btn btn-danger" runat="server" Text="Excluir"
                            OnClientClick="return confirmarExclusao(this);" OnClick="btnExcluir_Click" />
                    </div>
                </asp:Panel>

                <!-- GridView de Alunos -->
                <div class="mt-5">
                    <div class="table-responsive">
                        <asp:GridView ID="gvAlunos" runat="server" AutoGenerateColumns="False" CssClass="table modern-grid" AllowPaging="True" PageSize="10" OnPageIndexChanging="gvAlunos_PageIndexChanging">
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
        </div>
    </div>

    <style>
        .min-vh-100 {
            min-height: 100vh;
            background: #ffffff;
        }

        .card {
            border-radius: 20px;
            border: none;
            transition: transform 0.3s ease;
        }

       

        .input-group-text {
            background: #fff;
            border-right: none;
        }

        .form-control {
            border-left: none;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #dee2e6;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            position: relative;
            overflow: hidden;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0056b3 0%, #003d80 100%);
        }

        .hover-scale {
            transition: transform 0.2s ease;
        }

        .hover-scale:hover {
            transform: scale(1.02);
        }

        .invalid-feedback {
            display: none;
        }

        .was-validated .invalid-feedback {
            display: block;
        }

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
    </style>

    <script>
        // Função para alternar visibilidade da senha
        const togglePassword = document.getElementById('togglePassword');
        const passwordField = document.getElementById('<%= txtSenha.ClientID %>');

        togglePassword.addEventListener('click', () => {
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
            togglePassword.querySelector('i').classList.toggle('bi-eye');
            togglePassword.querySelector('i').classList.toggle('bi-eye-slash');
        });

        // Função para confirmar exclusão
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
</asp:Content>
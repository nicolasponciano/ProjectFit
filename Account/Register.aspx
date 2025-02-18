<%@ Page Title="Registre-se" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ProjectFit.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-8 col-xl-6">
                <!-- Cabeçalho -->
                <div class="text-center mb-5">
                    <h1 class="h2 mb-3">Registre-se</h1>
                    <p class="lead text-muted">Crie sua conta para começar</p>
                </div>

                <!-- Mensagens de Erro -->
                <asp:ValidationSummary runat="server" CssClass="alert alert-danger mb-4" />
                <div class="text-danger mb-4">
                    <asp:Literal runat="server" ID="ErrorMessage" />
                </div>

                <!-- Formulário -->
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <div class="row g-4">
                            <!-- Coluna 1 -->
                            <div class="col-12 col-md-6">
                                <!-- Email -->
                                <div class="mb-3">
                                    <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="form-label fw-bold">E-mail</asp:Label>
                                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control form-control-lg"
                                        placeholder="nome@exemplo.com" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                                        CssClass="text-danger small" ErrorMessage="Campo obrigatório" />
                                </div>

                                <!-- Nome Completo -->
                                <div class="mb-3">
                                    <asp:Label runat="server" AssociatedControlID="txtNome" CssClass="form-label fw-bold">Nome Completo</asp:Label>
                                    <asp:TextBox ID="txtNome" CssClass="form-control form-control-lg" runat="server" />
                                </div>

                                <!-- CPF -->
                                <div class="mb-3">
                                    <asp:Label runat="server" AssociatedControlID="txtCpf" CssClass="form-label fw-bold">CPF</asp:Label>
                                    <asp:TextBox ID="txtCpf" CssClass="form-control form-control-lg" runat="server" placeholder="000.000.000-00" />
                                </div>

                                <!-- Telefone -->
                                <div class="mb-3">
                                    <asp:Label runat="server" AssociatedControlID="txtTelefone" CssClass="form-label fw-bold">Telefone</asp:Label>
                                    <asp:TextBox ID="txtTelefone" CssClass="form-control form-control-lg" runat="server" placeholder="(00) 00000-0000" />
                                </div>
                            </div>

                            <!-- Coluna 2 -->
                            <div class="col-12 col-md-6">
                                <!-- Senha -->
                                <div class="mb-3">
                                    <asp:Label runat="server" AssociatedControlID="Password" CssClass="form-label fw-bold">Senha</asp:Label>
                                    <asp:TextBox runat="server" ID="Password" TextMode="Password"
                                        CssClass="form-control form-control-lg"
                                        placeholder="Mínimo 8 caracteres" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                        CssClass="text-danger small" ErrorMessage="Campo obrigatório" />
                                </div>

                                <!-- Confirmar Senha -->
                                <div class="mb-3">
                                    <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="form-label fw-bold">Confirmar Senha</asp:Label>
                                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password"
                                        CssClass="form-control form-control-lg"
                                        placeholder="Confirme sua senha" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                        CssClass="text-danger small" Display="Dynamic" ErrorMessage="Campo obrigatório" />
                                    <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                        CssClass="text-danger small" Display="Dynamic" ErrorMessage="Senhas não coincidem" />
                                </div>

                                <!-- Dados Físicos -->
                                <div class="row g-2 mb-3">
                                    <div class="col-6">
                                        <asp:Label runat="server" AssociatedControlID="txtPeso" CssClass="form-label fw-bold">Peso (kg)</asp:Label>
                                        <asp:TextBox ID="txtPeso" CssClass="form-control form-control-lg" runat="server" placeholder="Ex: 75" />
                                    </div>
                                    <div class="col-6">
                                        <asp:Label runat="server" AssociatedControlID="txtAltura" CssClass="form-label fw-bold">Altura (m)</asp:Label>
                                        <asp:TextBox ID="txtAltura" CssClass="form-control form-control-lg" runat="server" placeholder="Ex: 1.75" />
                                    </div>
                                </div>

                                <!-- IMC -->
                                <div class="mb-3">
                                    <asp:Label runat="server" AssociatedControlID="txtIMC" CssClass="form-label fw-bold">IMC</asp:Label>
                                    <asp:TextBox ID="txtIMC" CssClass="form-control form-control-lg bg-light" runat="server" ReadOnly="True" />
                                </div>

                                <!-- CEP e Meta lado a lado -->
                                <div class="row g-2">
                                    <div class="col-6">
                                        <asp:Label runat="server" AssociatedControlID="txtCep" CssClass="form-label fw-bold">CEP</asp:Label>
                                        <asp:TextBox ID="txtCep" CssClass="form-control form-control-lg" runat="server" placeholder="00000-000" />
                                    </div>
                                    <div class="col-6">
                                        <asp:Label runat="server" AssociatedControlID="cboMeta" CssClass="form-label fw-bold">Meta</asp:Label>
                                        <asp:DropDownList ID="cboMeta" CssClass="form-control form-control-lg" runat="server">
                                            <asp:ListItem Text="Selecione..." Value="0" Selected="True" />
                                            <asp:ListItem Text="Definição" Value="1" />
                                            <asp:ListItem Text="Ganho de Massa" Value="2" />
                                            <asp:ListItem Text="Perda de Peso" Value="3" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Botão de Registro -->
                        <div class="d-grid mt-4">
                            <asp:Button runat="server" OnClick="CreateUser_Click"
                                Text="Criar Conta"
                                CssClass="btn btn-primary btn-lg py-3" />
                        </div>
                    </div>
                </div>

                <!-- Link de Login -->
                <div class="text-center mt-4">
                    <p class="text-muted mb-0">
                        Já tem uma conta?
                        <asp:HyperLink runat="server" NavigateUrl="~/Account/Login" CssClass="fw-bold">Entrar</asp:HyperLink>
                    </p>
                    <p class="small text-muted mt-3">© 2025 - Meu Aplicativo ASP.NET</p>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
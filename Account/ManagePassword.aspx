<%@ Page Title="Gerenciar senha" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManagePassword.aspx.cs" Inherits="ProjectFit.Account.ManagePassword" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title" class="py-4">
        <div class="container">
            <h2 id="title" class="text-center mb-4"><%: Title %></h2>

            <!-- Mensagem de Sucesso -->
            <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="alert alert-success text-center" role="alert">
                            <%: SuccessMessage %>
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>

            <!-- Formulário de Definição de Senha -->
            <asp:PlaceHolder runat="server" ID="setPassword" Visible="false">
                <div class="row g-4">
                    <div class="col-md-6 offset-md-3">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h4 class="card-title text-center"><i class="fa-solid fa-lock me-2"></i>Definir Senha</h4>
                                <p class="card-text text-center">Você não tem uma senha local para este site. Adicione uma senha local para entrar sem um logon externo.</p>
                                <hr />
                                <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger text-center" />

                                <!-- Campo de Senha -->
                                <div class="mb-3">
                                    <label for="password" class="form-label"><i class="fa-solid fa-key me-2"></i>Senha</label>
                                    <asp:TextBox runat="server" ID="password" TextMode="Password" CssClass="form-control" placeholder="Digite sua nova senha" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="password"
                                        CssClass="text-danger" ErrorMessage="O campo senha é obrigatório."
                                        Display="Dynamic" ValidationGroup="SetPassword" />
                                    <asp:ModelErrorMessage runat="server" ModelStateKey="NewPassword" AssociatedControlID="password"
                                        CssClass="text-danger" SetFocusOnError="true" />
                                </div>

                                <!-- Campo de Confirmação de Senha -->
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label"><i class="fa-solid fa-lock me-2"></i>Confirmar Senha</label>
                                    <asp:TextBox runat="server" ID="confirmPassword" TextMode="Password" CssClass="form-control" placeholder="Confirme sua nova senha" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="confirmPassword"
                                        CssClass="text-danger" Display="Dynamic" ErrorMessage="O campo para confirmar senha é obrigatório."
                                        ValidationGroup="SetPassword" />
                                    <asp:CompareValidator runat="server" ControlToCompare="password" ControlToValidate="confirmPassword"
                                        CssClass="text-danger" Display="Dynamic" ErrorMessage="A senha e a senha de confirmação não coincidem."
                                        ValidationGroup="SetPassword" />
                                </div>

                                <!-- Botão de Ação -->
                                <div class="d-grid">
                                    <asp:Button runat="server" Text="Definir Senha" ValidationGroup="SetPassword" OnClick="SetPassword_Click" CssClass="btn btn-danger" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>

            <!-- Formulário de Alteração de Senha -->
            <asp:PlaceHolder runat="server" ID="changePasswordHolder" Visible="false">
                <div class="row g-4">
                    <div class="col-md-6 offset-md-3">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h4 class="card-title text-center"><i class="fa-solid fa-unlock me-2"></i>Alterar Senha</h4>
                                <hr />
                                <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger text-center" />

                                <!-- Campo de Senha Atual -->
                                <div class="mb-3">
                                    <label for="CurrentPassword" class="form-label"><i class="fa-solid fa-lock me-2"></i>Senha Atual</label>
                                    <asp:TextBox runat="server" ID="CurrentPassword" TextMode="Password" CssClass="form-control" placeholder="Digite sua senha atual" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                        CssClass="text-danger" ErrorMessage="O campo senha atual é obrigatório."
                                        ValidationGroup="ChangePassword" />
                                </div>

                                <!-- Campo de Nova Senha -->
                                <div class="mb-3">
                                    <label for="NewPassword" class="form-label"><i class="fa-solid fa-key me-2"></i>Nova Senha</label>
                                    <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" placeholder="Digite sua nova senha" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                        CssClass="text-danger" ErrorMessage="A nova senha é obrigatória."
                                        ValidationGroup="ChangePassword" />
                                </div>

                                <!-- Campo de Confirmação de Nova Senha -->
                                <div class="mb-3">
                                    <label for="ConfirmNewPassword" class="form-label"><i class="fa-solid fa-lock me-2"></i>Confirmar Nova Senha</label>
                                    <asp:TextBox runat="server" ID="ConfirmNewPassword" TextMode="Password" CssClass="form-control" placeholder="Confirme sua nova senha" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                        CssClass="text-danger" Display="Dynamic" ErrorMessage="Confirmar nova senha é obrigatório."
                                        ValidationGroup="ChangePassword" />
                                    <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                        CssClass="text-danger" Display="Dynamic" ErrorMessage="A nova senha e a senha de confirmação não coincidem."
                                        ValidationGroup="ChangePassword" />
                                </div>

                                <!-- Botão de Ação -->
                                <div class="d-grid">
                                    <asp:Button runat="server" Text="Alterar Senha" ValidationGroup="ChangePassword" OnClick="ChangePassword_Click" CssClass="btn btn-danger" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>
        </div>
    </main>
</asp:Content>
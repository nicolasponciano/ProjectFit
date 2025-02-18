<%@ Page Title="Gerenciar senha" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManagePassword.aspx.cs" Inherits="ProjectFit.Account.ManagePassword" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>
        <div class="row">
            <section id="passwordForm">
                <asp:PlaceHolder runat="server" ID="setPassword" Visible="false">
                    <p>
                        Você não tem uma senha local para este site. Adicione uma senha
                            local para entrar sem um logon externo.
                    </p>
                    <div>
                        <h4>Formulário de definição de senha</h4>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <hr />
                        <div class="row">
                            <asp:Label runat="server" AssociatedControlID="password" CssClass="col-md-2 col-form-label">Senha</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="password" TextMode="Password" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="password"
                                    CssClass="text-danger" ErrorMessage="O campo senha é obrigatório."
                                    Display="Dynamic" ValidationGroup="SetPassword" />
                                <asp:ModelErrorMessage runat="server" ModelStateKey="NewPassword" AssociatedControlID="password"
                                    CssClass="text-danger" SetFocusOnError="true" />
                            </div>
                        </div>

                        <div class="row">
                            <asp:Label runat="server" AssociatedControlID="confirmPassword" CssClass="col-md-2 col-form-label">Confirmar senha</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="confirmPassword" TextMode="Password" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="confirmPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="O campo para confirmar senha é obrigatório."
                                    ValidationGroup="SetPassword" />
                                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="confirmPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="A senha e a senha de confirmação não coincidem."
                                    ValidationGroup="SetPassword" />

                            </div>
                        </div>
                        <div class="row">
                            <div class="offset-md-2 col-md-10">
                                <asp:Button runat="server" Text="Definir senha" ValidationGroup="SetPassword" OnClick="SetPassword_Click" CssClass="btn btn-outline-dark" />
                            </div>
                        </div>
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder runat="server" ID="changePasswordHolder" Visible="false">
                    <div>
                        <h4>Formulário de Alteração de Senha</h4>
                        <hr />
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="row">
                            <asp:Label runat="server" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword" CssClass="col-md-2 col-form-label">Senha atual</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="CurrentPassword" TextMode="Password" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                    CssClass="text-danger" ErrorMessage="O campo senha atual é obrigatório."
                                    ValidationGroup="ChangePassword" />
                            </div>
                        </div>
                        <div class="row">
                            <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword" CssClass="col-md-2 col-form-label">Nova senha</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                    CssClass="text-danger" ErrorMessage="A nova senha é obrigatória."
                                    ValidationGroup="ChangePassword" />
                            </div>
                        </div>
                        <div class="row">
                            <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword" CssClass="col-md-2 col-form-label">Confirmar nova senha</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="ConfirmNewPassword" TextMode="Password" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="Confirmar nova senha é obrigatório."
                                    ValidationGroup="ChangePassword" />
                                <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="A nova senha e a senha de confirmação não coincidem."
                                    ValidationGroup="ChangePassword" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="offset-md-2 col-md-10">
                                <asp:Button runat="server" Text="Alterar senha" ValidationGroup="ChangePassword" OnClick="ChangePassword_Click" CssClass="btn btn-outline-dark" />
                            </div>
                        </div>
                    </div>
                </asp:PlaceHolder>
            </section>
        </div>
    </main>
</asp:Content>

<%@ Page Title="Redefinir senha" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="ProjectFit.Account.ResetPassword" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>
        <p class="text-danger">
            <asp:Literal runat="server" ID="ErrorMessage" />
        </p>

        <div>
            <h4>Digite sua nova senha</h4>
            <hr />
            <asp:ValidationSummary runat="server" CssClass="text-danger" />
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 col-form-label">E-mail</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                        CssClass="text-danger" ErrorMessage="O campo e-mail é exigido." />
                </div>
            </div>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 col-form-label">Senha</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                        CssClass="text-danger" ErrorMessage="O campo de senha é obrigatório." />
                </div>
            </div>
            <div class="row">
                <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 col-form-label">Confirmar senha</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                        CssClass="text-danger" Display="Dynamic" ErrorMessage="O campo para confirmar senha é obrigatório." />
                    <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                        CssClass="text-danger" Display="Dynamic" ErrorMessage="A senha e a senha de confirmação não coincidem." />
                </div>
            </div>
            <div class="row">
                <div class="offset-md-2 col-md-10">
                    <asp:Button runat="server" OnClick="Reset_Click" Text="Redefinir" CssClass="btn btn-outline-dark" />
                </div>
            </div>
        </div>
    </main>
</asp:Content>

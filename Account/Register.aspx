<%@ Page Title="Registre-se" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ProjectFit.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>
        <p class="text-danger">
            <asp:Literal runat="server" ID="ErrorMessage" />
        </p>
        <h4>Criar uma nova conta</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="row">
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 col-form-label">E-mail</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="O campo e-mail é obrigatório." />
            </div>
        </div>
        <div class="row">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 col-form-label">Senha</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="O campo senha é obrigatório." />
            </div>
        </div>
        <div class="row">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 col-form-label">Confirmar senha</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="O campo senha de confirmação é obrigatório." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="A senha e a senha de confirmação não correspondem." />
            </div>
        </div>
        <div class="row">
            <div class="offset-md-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Registre-se" CssClass="btn btn-outline-dark" />
            </div>
        </div>
    </main>
</asp:Content>

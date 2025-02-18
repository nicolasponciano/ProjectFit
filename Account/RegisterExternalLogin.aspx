<%@ Page Title="Registrar um logon externo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterExternalLogin.aspx.cs" Inherits="ProjectFit.Account.RegisterExternalLogin" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main>
        <h3>Registre-se com a conta <%: ProviderName %></h3>
        <asp:PlaceHolder runat="server">
            <h4>Formulário de associação</h4>
            <hr />
            <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
            <p class="text-info">
                Você foi autenticado com <strong><%: ProviderName %></strong>. Insira um e-mail abaixo para o site atual
                e clique no botão Iniciar sessão.
            </p>

            <div class="row">
                <asp:Label runat="server" AssociatedControlID="email" CssClass="col-md-2 col-form-label">E-mail</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="email" CssClass="form-control" TextMode="Email" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="email"
                        Display="Dynamic" CssClass="text-danger" ErrorMessage="O e-mail é exigido" />
                    <asp:ModelErrorMessage runat="server" ModelStateKey="email" CssClass="text-error" />
                </div>
            </div>

            <div class="row">
                <div class="offset-md-2 col-md-10">
                    <asp:Button runat="server" Text="Logon" CssClass="btn btn-outline-dark" OnClick="LogIn_Click" />
                </div>
            </div>
        </asp:PlaceHolder>
    </main>
</asp:Content>

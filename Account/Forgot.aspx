<%@ Page Title="Esqueci a senha" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Forgot.aspx.cs" Inherits="ProjectFit.Account.ForgotPassword" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>
        <div class="col-md-8">
            <asp:PlaceHolder id="loginForm" runat="server">
                <div class="row">
                    <h4>Esqueceu a senha?</h4>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="row">
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 col-form-label">E-mail</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="O campo e-mail é exigido." />
                        </div>
                    </div>
                    <div class="row">
                        <div class="offset-md-2 col-md-10">
                            <asp:Button runat="server" OnClick="Forgot" Text="Enviar link por email" CssClass="btn btn-outline-dark" />
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>
            <asp:PlaceHolder runat="server" ID="DisplayEmail" Visible="false">
                <p class="text-info">
                    Verifique seu email para redefinir a senha.
                </p>
            </asp:PlaceHolder>
        </div>
    </main>
</asp:Content>

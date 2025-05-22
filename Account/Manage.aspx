<%@ Page Title="Gerenciar conta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="ProjectFit.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title" class="py-4">

        <div class="container">
            <h2 id="title" class="text-center mb-4"><%: Title %></h2>

            <!-- Mensagem de Sucesso -->
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
                        <div class="alert alert-success text-center" role="alert">
                            <%: SuccessMessage %>
                        </div>
                    </asp:PlaceHolder>
                </div>
            </div>

            <!-- Configurações da Conta -->
            <div class="row g-4">
                <!-- Alteração de Senha -->
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fa-solid fa-lock me-2"></i>Alterar Senha</h5>
                            <p class="card-text">Atualize sua senha para manter sua conta segura.</p>
                            <asp:HyperLink NavigateUrl="/Account/ManagePassword" CssClass="btn btn-danger" Text="Alterar Senha" Visible="false" ID="ChangePassword" runat="server" />
                            <asp:HyperLink NavigateUrl="/Account/ManagePassword" CssClass="btn btn-danger" Text="Criar Senha" Visible="false" ID="CreatePassword" runat="server" />
                        </div>
                    </div>
                </div>

                <!-- Logins Externos -->
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fa-solid fa-link me-2"></i>Logins Externos</h5>
                            <p class="card-text">Você possui <%: LoginsCount %> login(s) externo(s) vinculado(s).</p>
                            <asp:HyperLink NavigateUrl="/Account/ManageLogins" CssClass="btn btn-primary" Text="Gerenciar Logins" runat="server" />
                        </div>
                    </div>
                </div>

                <!-- Autenticação de Dois Fatores -->
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fa-solid fa-shield-halved me-2"></i>Autenticação de Dois Fatores</h5>
                            <p class="card-text">
                                Não há provedores de autenticação de dois fatores configurados. Consulte 
                                <a href="https://go.microsoft.com/fwlink/?LinkId=403804" class="text-decoration-none">este artigo</a> para obter detalhes.
                            </p>
                            <% if (TwoFactorEnabled)
                                { %> 
                                <asp:LinkButton CssClass="btn btn-outline-danger" Text="Desativar 2FA" CommandArgument="false" OnClick="TwoFactorDisable_Click" runat="server" />
                            <% }
                                else
                                { %> 
                                <asp:LinkButton CssClass="btn btn-success" Text="Ativar 2FA" CommandArgument="true" OnClick="TwoFactorEnable_Click" runat="server" />
                            <% } %>
                        </div>
                    </div>
                </div>

                <!-- Número de Telefone -->
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fa-solid fa-phone me-2"></i>Número de Telefone</h5>
                            <p class="card-text">
                                O número de telefone pode ser usado como segundo fator de verificação.
                            </p>
                            <% if (HasPhoneNumber)
                                { %>
                                <asp:Label Text="<%: PhoneNumber %>" CssClass="me-2" ID="PhoneNumber" runat="server" />
                                <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" CssClass="btn btn-primary" Text="Alterar" runat="server" />
                                <asp:LinkButton CssClass="btn btn-outline-danger ms-2" Text="Remover" OnClick="RemovePhone_Click" runat="server" />
                            <% }
                                else
                                { %>
                                <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" CssClass="btn btn-success" Text="Adicionar Número" runat="server" />
                            <% } %>
                        </div>
                    </div>
                </div>

                <!-- Nova Seção: Conectar ao Google Fit -->
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fa-solid fa-heart-pulse me-2"></i>Google Fit</h5>
                            <p class="card-text">
                                Conecte sua conta do Google Fit para sincronizar seus dados de atividade física e saúde.
                            </p>
                            <asp:Button ID="btnGoogleFit" runat="server" Text="Conectar ao Google Fit" OnClick="btnGoogleFit_Click" CssClass="btn btn-success" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            window.onerror = function (message, source, lineno, colno, error) {
                console.error("Erro JavaScript detectado:");
                console.log("Mensagem:", message);
                console.log("Fonte:", source);
                console.log("Linha:", lineno, "Coluna:", colno);
                console.log("Erro:", error);
            };
        </script>
    </main>
</asp:Content>
﻿<%@ Page Title="Confirmação de Conta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Confirm.aspx.cs" Inherits="ProjectFit.Account.Confirm" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main aria-labelledby="title">
    <h2 id="title"><%: Title %>.</h2>
    <div>
        <asp:PlaceHolder runat="server" ID="successPanel" ViewStateMode="Disabled" Visible="true">
            <p>
                Obrigado por confirmar sua conta. Clique <asp:HyperLink ID="login" runat="server" NavigateUrl="~/Account/Login">aqui</asp:HyperLink>  para fazer logon             
            </p>
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="errorPanel" ViewStateMode="Disabled" Visible="false">
            <p class="text-danger">
                Ocorreu um erro.
            </p>
        </asp:PlaceHolder>
    </div>
    </main>
</asp:Content>

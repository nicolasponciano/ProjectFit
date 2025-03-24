<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditarDieta.ascx.cs" Inherits="ProjectFit.Views.EditarDieta" %>

<div class="container mt-4">
    <h4>Editar Dieta</h4>
    <div>
        <div class="mb-3">
            <label for="txtRefeicao" class="form-label">Refeição</label>
            <asp:TextBox ID="txtRefeicao" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtHorario" class="form-label">Horário</label>
            <asp:TextBox ID="txtHorario" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtAlimentos" class="form-label">Alimentos</label>
            <asp:TextBox ID="txtAlimentos" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtCalorias" class="form-label">Calorias</label>
            <asp:TextBox ID="txtCalorias" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtObservacoes" class="form-label">Observações</label>
            <asp:TextBox ID="txtObservacoes" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtLinks" class="form-label">Links Referenciais</label>
            <asp:TextBox ID="txtLinks" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="d-flex justify-content-end">
            <asp:Button ID="btnSalvar" runat="server" Text="Salvar" CssClass="btn btn-primary me-2" OnClick="btnSalvar_Click" />
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
        </div>
    </div>
    <asp:HiddenField ID="hdnDietaId" runat="server" Value="0" />
</div>

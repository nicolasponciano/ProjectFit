<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditarDieta.ascx.cs" 
    Inherits="ProjectFit.Views.EditarDieta" %>

<div class="container mt-4">
    <div class="card shadow-sm">
       
        <div class="card-body">
            <div class="mb-3">
                <label for="txtRefeicao" class="form-label">Refeição</label>
                <asp:TextBox ID="txtRefeicao" runat="server" CssClass="form-control" placeholder="Ex: Café da manhã"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="txtHorario" class="form-label">Horário</label>
                <asp:TextBox ID="txtHorario" runat="server" CssClass="form-control" placeholder="Ex: 08:00"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="txtAlimentos" class="form-label">Alimentos</label>
                <asp:TextBox ID="txtAlimentos" runat="server" CssClass="form-control" placeholder="Ex: Aveia, banana, leite"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="txtCalorias" class="form-label">Calorias (kcal)</label>
                <asp:TextBox ID="txtCalorias" runat="server" CssClass="form-control" placeholder="Ex: 350"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="txtObservacoes" class="form-label">Observações</label>
                <asp:TextBox ID="txtObservacoes" runat="server" CssClass="form-control" placeholder="Ex: Evitar açúcar refinado"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="txtLinks" class="form-label">Links Referenciais</label>
                <asp:TextBox ID="txtLinks" runat="server" CssClass="form-control" placeholder="Ex: https://www.exemplo.com"></asp:TextBox>
            </div>
            <div class="d-flex justify-content-end">
                <asp:Button ID="btnSalvar" runat="server" Text="Salvar" CssClass="btn btn-success me-2" OnClick="btnSalvar_Click" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdnDietaId" runat="server" Value="0" />
</div>

<style>
    /* Paleta de Cores */
    :root {
        --primary-color: #2C3E50; /* Azul escuro */
        --secondary-color: #E74C3C; /* Vermelho */
        --success-color: #28a745; /* Verde */
        --text-color: #FFFFFF; /* Branco */
        --background-color: #f9f9f9; /* Fundo claro */
        --shadow-color: rgba(0, 0, 0, 0.1); /* Sombra suave */
    }
    /* Estilos Gerais */
    .card {
        background: var(--background-color);
        border: none;
        box-shadow: 0 2px 10px var(--shadow-color);
    }
    .card-header {
        background: var(--primary-color);
        color: var(--text-color);
        font-size: 18px;
        padding: 15px;
    }
    .card-header i {
        font-size: 24px;
        color: var(--text-color);
    }
    .form-label {
        font-weight: bold;
        color: var(--primary-color);
    }
    .form-control {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
        transition: border-color 0.3s ease;
    }
    .form-control:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 5px rgba(44, 62, 80, 0.5);
    }
    .btn-success {
        background: var(--success-color);
        border: none;
        color: var(--text-color);
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .btn-success:hover {
        background: var(--success-color);
    }
    .btn-secondary {
        background: var(--secondary-color);
        border: none;
        color: var(--text-color);
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .btn-secondary:hover {
        background: var(--primary-color);
    }
</style>
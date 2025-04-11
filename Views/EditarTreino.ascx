<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditarTreino.ascx.cs" Inherits="ProjectFit.Views.EditarTreino" %>

<div class="container mt-4">
    <div>
        <div class="mb-3">
            <label for="txtDiaTreino" class="form-label">DiaTreino</label>
            <asp:TextBox ID="txtDiaTreino" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtExercicio" class="form-label">Exercicio</label>
            <asp:TextBox ID="txtExercicio" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtSeriesRepeticoes" class="form-label">SeriesRepeticoes</label>
            <asp:TextBox ID="txtSeriesRepeticoes" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtDescanso" class="form-label">Descanso</label>
            <asp:TextBox ID="txtDescanso" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtEquipamento" class="form-label">Equipamento</label>
            <asp:TextBox ID="txtEquipamento" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtGrupoMuscular" class="form-label">GrupoMuscular</label>
            <asp:TextBox ID="txtGrupoMuscular" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtDicas" class="form-label">Dicas</label>
            <asp:TextBox ID="txtDicas" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label for="txtLinks" class="form-label">Links Referenciais</label>
            <asp:TextBox ID="txtLinks" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="d-flex justify-content-end">
            <asp:Button ID="btnSalvar" runat="server" Text="Salvar" CssClass="btn btn-primary me-2 " OnClick="btnSalvar_Click" />
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
        </div>
        <button id="btnTop" class="btn btn-warning btn-lg rounded-circle shadow" onclick="scrollToTop()">
            <i class="fas fa-arrow-up"></i>
        </button>
    </div>
    <asp:HiddenField ID="hdnTreinoId" runat="server" Value="0" />
</div>
<script>
    // Função para rolar suavemente até o topo
    function smoothScrollTop() {
        const startPosition = window.scrollY;
        const distance = -startPosition;
        const duration = 500; // Duração em milissegundos
        let startTime = null;

        function animation(currentTime) {
            if (startTime === null) startTime = currentTime;
            const timeElapsed = currentTime - startTime;
            const run = easeInOutQuad(timeElapsed, startPosition, distance, duration);
            window.scrollTo(0, run);
            if (timeElapsed < duration) requestAnimationFrame(animation);
        }

        // Função de easing para suavizar a animação
        function easeInOutQuad(t, b, c, d) {
            t /= d / 2;
            if (t < 1) return c / 2 * t * t + b;
            t--;
            return -c / 2 * (t * (t - 2) - 1) + b;
        }

        requestAnimationFrame(animation);
    }

    // Adiciona o event listener ao botão
    document.getElementById('btnTop').addEventListener('click', function (e) {
        e.preventDefault(); // Previne qualquer comportamento padrão
        smoothScrollTop();
    });

    // Exibir o botão ao rolar a página
    window.addEventListener("scroll", function () {
        const btnTop = document.getElementById("btnTop");
        if (window.scrollY > 300) {
            btnTop.style.display = "flex";
        } else {
            btnTop.style.display = "none";
        }
    });
</script>

<style>
    /* Estilos existentes */
    #btnTop {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 50px;
        height: 50px;
        display: none;
        align-items: center;
        justify-content: center;
        font-size: 22px;
        border: none;
        cursor: pointer;
        transition: opacity 0.3s ease-in-out, transform 0.3s;
        z-index: 1000;
    }

        #btnTop:hover {
            transform: scale(1.1);
            background-color: #ffca2c;
        }
</style>

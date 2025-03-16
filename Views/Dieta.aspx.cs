using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.UI;
using Newtonsoft.Json;
using ProjectFit.Controllers;

namespace ProjectFit
{
    public partial class Dieta : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Mantém a página sempre com o UpdatePanel ativo
        }

        protected async void btnSubmit_Click(object sender, EventArgs e)
        {
            var formData = new
            {
                objetivo = ddlObjetivo.SelectedValue,
                refeicoes = txtRefeicoes.Text,
                restricoes = txtRestricoes.Text,
                agua = txtAgua.Text,
                fastFood = ddlFastFood.SelectedValue,
                preferencias = ddlPreferencias.SelectedValue,
                rotina = txtRotina.Text,
                alimentosEvitados = txtAlimentosEvitados.Text
            };

            string formattedText = $"Objetivo: {formData.objetivo}, Refeições: {formData.refeicoes}, " +
                                   $"Restrições: {formData.restricoes}, Água: {formData.agua}, " +
                                   $"FastFood: {formData.fastFood}, Preferências: {formData.preferencias}, " +
                                   $"Rotina: {formData.rotina}, Alimentos evitados: {formData.alimentosEvitados}.";

            var iaController = new IAController();
            try
            {
                var result = await iaController.GetAIBasedResultAsync(formattedText, "dieta");
                var responseObj = JsonConvert.DeserializeObject<ApiResponse>(result);

                if (responseObj?.Candidates?.Length > 0)
                {
                    string dietaGerada = responseObj.Candidates[0].Content.Parts[0].Text;
                    var refeicoes = ProcessarRespostaDieta(dietaGerada);

                    // Gerar observações automáticas para cada refeição
                    foreach (var refeicao in refeicoes)
                    {
                        refeicao.Observacoes = await GerarObservacoesAutomaticas(refeicao);
                    }

                    gridDieta.DataSource = refeicoes;
                    gridDieta.DataBind();
                }
                else
                {
                    gridDieta.DataSource = new List<RefeicaoDieta> { new RefeicaoDieta {
                        Refeicao = "Erro",
                        Alimentos = "Não foi possível gerar a dieta",
                        Observacoes = "Tente novamente"
                    }};
                    gridDieta.DataBind();
                }
            }
            catch (Exception ex)
            {
                gridDieta.DataSource = new List<RefeicaoDieta> { new RefeicaoDieta {
                    Refeicao = "Erro",
                    Alimentos = ex.Message,
                    Observacoes = "Contate o suporte"
                }};
                gridDieta.DataBind();
            }
        }

        private List<RefeicaoDieta> ProcessarRespostaDieta(string resposta)
        {
            var refeicoes = new List<RefeicaoDieta>();
            var linhas = resposta.Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var linha in linhas)
            {
                var partes = linha.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries);

                if (partes.Length >= 5)
                {
                    refeicoes.Add(new RefeicaoDieta
                    {
                        // Mantém o HTML formatado
                        Refeicao = partes[0].Trim(),
                        Horario = partes[1].Trim(),
                        // Converte ** para tags <strong> válidas
                        Alimentos = partes[2].Trim().Replace("**", "<strong>").Replace("**", "</strong>"),
                        Calorias = partes[3].Trim(),
                        Observacoes = partes[4].Trim()
                    });
                }
            }
            return refeicoes;
        }

        private async Task<string> GerarObservacoesAutomaticas(RefeicaoDieta refeicao)
        {
            var iaController = new IAController();
            string prompt = "Gere 2 dicas práticas de preparo para: " + refeicao.Refeicao + ".\n" +
                           "Ingredientes: " + refeicao.Alimentos.Replace("<strong>", "").Replace("</strong>", "") + "\n" +
                           "Regras:\n" +
                           "- Máximo 40 palavras\n" +
                           "- Formato: <li>[dica]</li>\n" +
                           "Exemplo:\n" +
                           "<li>Cozinhe os ovos em fogo médio</li>";

            try
            {
                var result = await iaController.GetAIBasedResultAsync(prompt, "preparo");
                var responseObj = JsonConvert.DeserializeObject<ApiResponse>(result);

                if (responseObj?.Candidates?.Length > 0)
                {
                    // Corrija a formatação
                    var dicas = responseObj.Candidates[0].Content.Parts[0].Text
                        .Replace("*", "") // Remove asteriscos
                        .Replace("<li>", "") // Remove tags incompletas
                        .Replace("</li>", "")
                        .Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);

                    return string.Join("", dicas.Select(d => $"<li>{d.Trim()}</li>"));
                }
            }
            catch
            {
                return GerarDicasFallback(refeicao.Refeicao);
            }
            return GerarDicasFallback(refeicao.Refeicao);
        }

        private string GerarDicasFallback(string refeicao)
        {
            var refLower = refeicao.ToLower();

            if (refLower.Contains("café") || refLower.Contains("cafe"))
            {
                return "<ul class='dicas-lista'><li>Utilize métodos de cocção com pouca gordura</li><li>Prefira alimentos integrais</li></ul>";
            }
            else if (refLower.Contains("almoço") || refLower.Contains("almoco"))
            {
                return "<ul class='dicas-lista'><li>Cozinhe os vegetais no vapor</li><li>Controle o tempo de cocção</li></ul>";
            }
            else if (refLower.Contains("jantar"))
            {
                return "<ul class='dicas-lista'><li>Reduza o uso de sal</li><li>Utilize ervas para temperar</li></ul>";
            }
            else
            {
                return "<ul class='dicas-lista'><li>Mantenha porções equilibradas</li><li>Higienize bem os alimentos</li></ul>";
            }
        }


        private string FormatRefeicao(string nomeRefeicao)
        {
            var nomeLower = nomeRefeicao.ToLower();

            if (nomeLower == "café da manhã" || nomeLower == "cafe da manha")
                return $"<span class='meal-type-badge breakfast-badge'>{nomeRefeicao}</span>";

            if (nomeLower == "almoço" || nomeLower == "almoco")
                return $"<span class='meal-type-badge lunch-badge'>{nomeRefeicao}</span>";

            if (nomeLower == "jantar")
                return $"<span class='meal-type-badge dinner-badge'>{nomeRefeicao}</span>";

            if (nomeLower.Contains("lanche"))
                return $"<span class='meal-type-badge snack-badge'>{nomeRefeicao}</span>";

            return nomeRefeicao;
        }

        public class RefeicaoDieta
        {
            public string Refeicao { get; set; }
            public string Horario { get; set; }
            public string Alimentos { get; set; }
            public string Calorias { get; set; }
            public string Observacoes { get; set; }
        }

        public class ApiResponse
        {
            public Candidate[] Candidates { get; set; }

            public class Candidate
            {
                public Content Content { get; set; }
            }

            public class Content
            {
                public Part[] Parts { get; set; }
            }

            public class Part
            {
                public string Text { get; set; }
            }
        }
    }
}
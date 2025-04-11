using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectFit
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string message = txtMessage.Text.Trim();
                string rating = hdnRating.Value; // Valor da avaliação (1-5)

                // Aqui você pode usar a avaliação como necessário
                // Exemplo: incluir no corpo do e-mail
                string emailBody = $"Nome: {name}\nE-mail: {email}\nAvaliação: {rating} estrelas\n\nMensagem:\n{message}";

                // Implemente o envio do e-mail aqui (como no exemplo anterior)
                // MailMessage mail = new MailMessage(...);
                // mail.Body = emailBody;
                // ...

                // Mostrar mensagem de sucesso
                ScriptManager.RegisterStartupScript(this, GetType(), "showSuccess",
                    "alert('Obrigado por sua avaliação! Sua mensagem foi enviada com sucesso.');", true);

                // Limpar os campos
                txtName.Text = "";
                txtEmail.Text = "";
                txtMessage.Text = "";
                hdnRating.Value = "";

                // Resetar as estrelas visualmente
                ScriptManager.RegisterStartupScript(this, GetType(), "resetStars",
                    "$('.rating-stars input').prop('checked', false);", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showError",
                    $"alert('Ocorreu um erro: {ex.Message}');", true);
            }
        }
    }
}
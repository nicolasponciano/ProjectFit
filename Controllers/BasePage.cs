using System;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using ProjectFit.Models;

public class BasePage : Page
{
    // Renomeado para evitar conflito com possíveis controles
    protected bool UserIsAdmin { get; private set; }
    protected string CurrentUserId { get; private set; }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        if (!Context.User.Identity.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        CurrentUserId = Context.User.Identity.GetUserId();

        using (var db = new ApplicationDbContext())
        {
            var user = db.Users.FirstOrDefault(u => u.Id == CurrentUserId);
            if (user != null)
            {
                UserIsAdmin = user.IsAdmin;
                System.Diagnostics.Debug.WriteLine("UserIsAdmin na BasePage (OnInit): " + UserIsAdmin);
            }
            else
            {
                Response.Redirect("~/Account/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
        }
    }
}

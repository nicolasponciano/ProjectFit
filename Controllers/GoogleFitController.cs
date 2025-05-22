using ProjectFit.Services;
using System.Net;
using System.Threading.Tasks;
using System.Web.Http;
using Microsoft.AspNet.Identity;
using System.Collections.Generic;
using System.Net.Http.Headers;
using System.Web;
using System.Net.Http;
using System;
using Microsoft.AspNet.Identity.EntityFramework;
using ProjectFit.Models;
using static ProjectFit.Services.GoogleFitService;
using System.Linq;
using Newtonsoft.Json;

[RoutePrefix("api/GoogleFit")]
public class GoogleFitController : ApiController
{
    private readonly GoogleFitService _googleFitService;

    public GoogleFitController()
    {
        _googleFitService = new GoogleFitService();
    }

    /// <summary>
    /// Inicia o fluxo de autenticação com o Google Fit
    /// </summary>
    [HttpGet]
    [Route("Authorize")]
    public IHttpActionResult Authorize()
    {
        string authUrl = _googleFitService.GenerateAuthorizationUrl();
        return Redirect(authUrl);
    }

    /// <summary>
    /// Callback que recebe o código de autorização e troca por token
    /// </summary>


    [HttpGet]
    [Route("Callback")]
    public async Task<IHttpActionResult> Callback([FromUri] string code, [FromUri] string error = null)
    {
        if (!string.IsNullOrEmpty(error))
            return BadRequest("Erro do Google: " + error);

        if (string.IsNullOrEmpty(code))
            return BadRequest("Código de autorização não recebido.");

        // Troca o código por tokens
        var token = await _googleFitService.ExchangeCodeForToken(code);
        if (token == null || string.IsNullOrEmpty(token.AccessToken) || string.IsNullOrEmpty(token.RefreshToken))
            return BadRequest("Falha ao obter token do Google.");

        // Obtém informações do usuário do Google
        var userInfo = await _googleFitService.GetUserInfo(token.AccessToken);
        if (userInfo == null || string.IsNullOrEmpty(userInfo.Email) || string.IsNullOrEmpty(userInfo.Name))
            return BadRequest("Falha ao obter dados do usuário.");

        // Obtém o ID do usuário logado
        var userId = User.Identity.GetUserId();
        if (string.IsNullOrEmpty(userId))
        {
            return BadRequest("Usuário não está logado.");
        }

        // Atualiza ou cria os dados do Google Fit para o usuário
        var healthData = new UserGoogleFit
        {
            FitUserId = userId,
            GoogleId = userInfo.Email, // Usando o e-mail como identificador único do Google
            NomeCompleto = userInfo.Name,
            Email = userInfo.Email,
            UrlFotoPerfil = userInfo.PictureUrl,
            DataColeta = DateTime.UtcNow,
            FonteDados = "Google Fit"
        };

        SaveOrUpdateHealthData(healthData);

        // Armazena tokens e informações do usuário em cookies seguros
        var cookies = new List<CookieHeaderValue>
    {
        new CookieHeaderValue("AccessToken", token.AccessToken) { HttpOnly = true, Secure = true },
        new CookieHeaderValue("RefreshToken", token.RefreshToken) { HttpOnly = true, Secure = true },
        new CookieHeaderValue("ExpiresIn", token.ExpiresIn.ToString()) { HttpOnly = true, Secure = true },
        new CookieHeaderValue("UserEmail", userInfo.Email) { HttpOnly = true, Secure = true },
        new CookieHeaderValue("UserName", userInfo.Name) { HttpOnly = true, Secure = true }
    };

        // Redireciona para a página principal
        var absolutePath = VirtualPathUtility.ToAbsolute("~/Default.aspx");
        var absoluteUri = new Uri(Request.RequestUri, absolutePath);
        var response = Request.CreateResponse(HttpStatusCode.Redirect);
        response.Headers.Location = absoluteUri;
        response.Headers.AddCookies(cookies.ToArray());

        return ResponseMessage(response);
    }

    private void SaveOrUpdateHealthData(UserGoogleFit healthData)
    {
        using (var db = new ApplicationDbContext())
        {
            // Verifica se já existe um registro para este usuário no Google Fit
            var existingData = db.UsersGoogleFits
                .FirstOrDefault(d => d.FitUserId == healthData.FitUserId && d.GoogleId == healthData.GoogleId);

            if (existingData != null)
            {
                // Atualiza os dados existentes
                existingData.NomeCompleto = healthData.NomeCompleto;
                existingData.UrlFotoPerfil = healthData.UrlFotoPerfil;
                existingData.DataColeta = healthData.DataColeta;
                existingData.FonteDados = healthData.FonteDados;
            }
            else
            {
                // Insere um novo registro
                db.UsersGoogleFits.Add(healthData);
            }

            db.SaveChanges();
        }
    }


    /// <summary>
    /// Obtém dados de passos do Google Fit
    /// </summary>
    [HttpGet]
    [Route("Steps")]
    public async Task<IHttpActionResult> GetSteps([FromUri] DateTime startDate, [FromUri] DateTime endDate)
    {
        var accessToken = await _googleFitService.GetValidAccessTokenAsync(User.Identity.GetUserId());
        if (string.IsNullOrEmpty(accessToken))
            return Unauthorized();

        var stepsData = await _googleFitService.GetStepsAsync(accessToken, startDate, endDate);
        return Ok(stepsData);
    }
}
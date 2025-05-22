using Microsoft.Owin;
using Newtonsoft.Json;
using ProjectFit.Models;
using ProjectFit.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Security.Claims;
using System.Threading.Tasks;
using static ProjectFit.Services.GoogleFitService;

public static class GoogleFitSyncService
{
    public static async Task SyncUserData()
    {
        using (var db = new ApplicationDbContext())
        {
            var users = db.Users.Where(u => u.GoogleRefreshToken != null).ToList();
            foreach (var user in users)
            {
                // Crie uma instância do GoogleFitService
                var googleFitService = new GoogleFitService();

                var accessToken = await googleFitService.GetValidAccessTokenAsync(user.GoogleRefreshToken);
                if (string.IsNullOrEmpty(accessToken))
                    continue;

                var startDate = DateTime.UtcNow.AddDays(-1); // Últimas 24h
                var endDate = DateTime.UtcNow;

                var stepsData = await googleFitService.GetStepsAsync(accessToken, startDate, endDate);
                foreach (var bucket in stepsData.Buckets)
                {
                    var date = DateTimeOffset.FromUnixTimeMilliseconds(long.Parse(bucket.StartTime)).DateTime;
                    var steps = bucket.DataSets
                                     .SelectMany(ds => ds.Points)
                                     .SelectMany(p => p.Values)
                                     .Sum(v => v.IntValue);

                    var healthData = new UserGoogleFit
                    {
                        FitUserId = user.Id,
                        DataColeta = date,
                        Passos = steps,
                        FonteDados = "Google Fit"
                    };

                    SaveOrUpdateHealthData(healthData);
                }
            }
        }
    }

    private static void SaveOrUpdateHealthData(UserGoogleFit healthData)
    {
        using (var db = new ApplicationDbContext())
        {
            // Verifica se já existe um registro para este usuário na data específica
            var existingData = db.UsersGoogleFits
                .FirstOrDefault(d => d.FitUserId == healthData.FitUserId && d.DataColeta.Date == healthData.DataColeta.Date);

            if (existingData != null)
            {
                // Atualiza os dados existentes
                existingData.Passos = healthData.Passos;
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
}
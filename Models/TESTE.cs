using System;
using System.Data.SqlClient;

namespace ProjectFit.Models
{

    public class TestarConexao
    {
        public static bool TestarBanco()
        {
            string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ProjectFitSQL.mdf;Initial Catalog=ProjectFitSQL;Integrated Security=True";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open(); // Tenta abrir a conexão
                    System.Diagnostics.Debug.WriteLine("Conexão bem-sucedida!"); // Log de sucesso
                    return true; // Retorna true se a conexão for bem-sucedida
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erro ao conectar: " + ex.Message); // Log de erro
                return false; // Retorna false se ocorrer uma exceção
            }
        }
    }
}
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFit.Models
{
	public class DietaModel
	{
        [JsonProperty("Objetivo")]
        public string Objetivo { get; set; }

        [JsonProperty("Refeições")]
        public string Refeicoes { get; set; }

        [JsonProperty("Restrições")]
        public string Restricoes { get; set; }

        [JsonProperty("Água")]
        public string Agua { get; set; }

        [JsonProperty("FastFood")]
        public string FastFood { get; set; }

        [JsonProperty("Preferências")]
        public string Preferencias { get; set; }

        [JsonProperty("Rotina")]
        public string Rotina { get; set; }

        [JsonProperty("AlimentosEvitados")]
        public string AlimentosEvitados { get; set; }

        [JsonProperty("CardapioExemplo")]
        public string CardapioExemplo { get; set; }
    }
}
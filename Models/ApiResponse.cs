using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFit.Models
{
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
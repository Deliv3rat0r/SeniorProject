using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyChurch.Code
{
    public class ChurchProfileBO
    {
        public String name { get; set; }
        public String email { get; set; }
        public String address { get; set; }
        public String city { get; set; }
        public String state { get; set; }
        public String zip { get; set; }
        public String web { get; set; }
        public String phone { get; set; }
        public Guid UserId { get; set; }
    }
}
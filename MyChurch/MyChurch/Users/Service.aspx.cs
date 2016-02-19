using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Security;
using MyChurch.Code;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace MyChurch.Users
{
    public partial class Service : System.Web.UI.Page
    {
        ScheduleBO sbo = new ScheduleBO();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["SessionSchedule"] != null)
            {
                sbo = (ScheduleBO)(Session["SessionSchedule"]);
                litScheduleInfo.Text = "<h2>" + sbo.ScheduleTitle + "</h2>";
            }
            else
            {
                Response.Redirect("~/Users/Schedule.aspx");
            }
        }
    }
}
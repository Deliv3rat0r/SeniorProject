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
    public partial class AssignJobs : System.Web.UI.Page
    {
        ServiceBO servbo = new ServiceBO();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["Service"] != null)
            {
                servbo = (ServiceBO)(Session["Service"]);
                litTop.Text = "<h2>" + servbo.title + "</h2>" + "<p>" + servbo.servicedate + "</p>";

                //set DB param
            }
            else
            {
                Response.Redirect("~/Users/Service.aspx");
            }
        }
    }
}
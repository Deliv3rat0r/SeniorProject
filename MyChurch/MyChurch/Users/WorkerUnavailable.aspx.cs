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
    public partial class WorkerUnavailable : System.Web.UI.Page
    {

        WorkerBO wbo = new WorkerBO();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["SessionWorker"] != null)
            {
                wbo = (WorkerBO)(Session["SessionWorker"]);
                litWorkerInfo.Text = "<h2>" + wbo.fname + " " + wbo.lname + "</h2>";
            }
            else
            {

            }
        }
    }
}
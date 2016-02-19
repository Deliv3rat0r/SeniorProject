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
    public partial class Schedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void dbScheduleAdd_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            //Currently not used
        }

        protected void dbScheduleAdd_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            //get logged in user id
            MembershipUser usr = Membership.GetUser();
            Guid uid = (Guid)usr.ProviderUserKey;

            //set the UserId parameter to current user for DB insert
            e.Command.Parameters["@UserId"].Value = uid;
        }

        protected void dbScheduleSelect_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            //get logged in user id
            MembershipUser usr = Membership.GetUser();
            Guid uid = (Guid)usr.ProviderUserKey;

            //set the UserId parameter to current user for DB select
            e.Command.Parameters["@UserId"].Value = uid;
        }

        protected void uxGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "ScheduleService")
            {
                ScheduleBO sbo = new ScheduleBO();

                int index = Convert.ToInt32(e.CommandArgument);

                //get row of selected index
                GridViewRow row = uxGridView.Rows[index];

                //set schedule object attributes
                sbo.sid = Convert.ToInt32(row.Cells[0].Text);
                sbo.ScheduleTitle = row.Cells[1].Text;

                //create a session variable
                Session["SessionSchedule"] = sbo;

                Response.Redirect("~/Users/Service.aspx");
            }
        }
    }
}
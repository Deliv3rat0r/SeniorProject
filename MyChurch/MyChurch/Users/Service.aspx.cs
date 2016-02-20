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

                dbServiceSql.SelectParameters["ScheduleID"].DefaultValue = sbo.sid.ToString();
            }
            else
            {
                Response.Redirect("~/Users/Schedule.aspx");
            }
        }

        protected void uxGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void dbServiceSql_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            //setup database connection
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DB_MYCHURCH"].ConnectionString);

            //setup a way to talk to the database
            SqlCommand command = new SqlCommand();
            command.Connection = connection;

            try
            {
                command.Connection.Open();
                command.CommandType = CommandType.Text;
                command.CommandText = "INSERT INTO SPScheduleService(ScheduleID, ServiceID) VALUES(@ScheduleID, @ServiceID)";
                
                command.Parameters.Add(new SqlParameter("@ServiceID", e.Command.Parameters["@ServiceID"].Value));
                command.Parameters.Add(new SqlParameter("@ScheduleID", sbo.sid.ToString()));

                command.ExecuteNonQuery();

            }
            catch
            {
                litScheduleInfo.Text = "error";
            }
            finally
            {
                command.Connection.Close();
            }
        }

        protected void dbServiceSql_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            //dbServiceSql.SelectParameters["@ScheduleID"].DefaultValue = sbo.sid.ToString();
        }

        protected void dbServiceSql_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            
        }

        protected void uxFormView_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            //Convert.ToInt32(e.Values["Duration"]);
        }
    }
}
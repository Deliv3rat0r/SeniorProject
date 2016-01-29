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
    public partial class Worker : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void uxAddWorker_Click(object sender, EventArgs e)
        {
            

        }

        protected void uxFormView_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            ////get user id
            //MembershipUser usr = Membership.GetUser();
            //Guid uid = (Guid)usr.ProviderUserKey;

            ////setup database connection
            //SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DB_MYCHURCH"].ConnectionString);

            ////setup a way to talk to the database
            //SqlCommand command = new SqlCommand();
            //command.Connection = connection;

            //try
            //{
            //    command.Connection.Open();
            //    command.CommandType = CommandType.StoredProcedure;
            //    command.CommandText = "ChurchWorkers_Insert";

            //    command.Parameters.Add(new SqlParameter("@UserId", uid));

            //    command.ExecuteNonQuery();

            //}
            //catch
            //{

            //}
            //finally
            //{
            //    command.Connection.Close();
            //}

        }

        protected void uxWorkerSql_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            //get user id
            MembershipUser usr = Membership.GetUser();
            Guid uid = (Guid)usr.ProviderUserKey;

            //setup database connection
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DB_MYCHURCH"].ConnectionString);

            //setup a way to talk to the database
            SqlCommand command = new SqlCommand();
            command.Connection = connection;

            try
            {
                command.Connection.Open();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ChurchWorkers_Insert";

                command.Parameters.Add(new SqlParameter("@UserId", uid));
                command.Parameters.Add(new SqlParameter("@WorkerID", e.Command.Parameters["@WorkerID"].Value));

                command.ExecuteNonQuery();

            }
            catch
            {

            }
            finally
            {
                command.Connection.Close();
            }
        }

        protected void uxWorkerSql_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            //get user id
            MembershipUser usr = Membership.GetUser();
            Guid uid = (Guid)usr.ProviderUserKey;

            //uxWorkerSql.SelectParameters.Add("@UserId", uid.ToString());
            e.Command.Parameters["@UserId"].Value = uid;
            
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace MyChurch.Code
{
    public class WorkerRepo
    {
        public static DataTable getWorkers(Guid id)
        {

            DataTable worker_table = new DataTable();

            //setup a connection to the database
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DB_MYCHURCH"].ConnectionString);
            //setup a way to talk to the database
            SqlCommand command = new SqlCommand();
            command.Connection = connection;

            try
            {
                //open connection and set command parameters and type
                command.Connection.Open();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "Workers_Get";
                command.Parameters.Add(new SqlParameter("@UserId", id));

                //setup a data reader to get worker info
                SqlDataReader reader = command.ExecuteReader();

                // create data adapter
                SqlDataAdapter da = new SqlDataAdapter(command);
                // store results in datatable
                da.Fill(worker_table);
                    
                //get rid of the data in the adapter
                da.Dispose();
            }
            catch
            {

            }
            finally
            {
                //close connection to database
                connection.Close();
            }

            //return the datatable with worker information
            return worker_table;
        }

    }
}
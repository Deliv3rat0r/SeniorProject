using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace MyChurch.Code
{
    public class ChurchProfileRepo
    {
        public static ChurchProfileBO getProfile(Guid id)
        {
            
            ChurchProfileBO church = new ChurchProfileBO();

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
                command.CommandText = "ChurchProfile_Get";
                command.Parameters.Add(new SqlParameter("@UserId", id));

                //setup a data reader to get user info
                SqlDataReader reader = command.ExecuteReader();

                if(reader.Read())
                {
                    //set the user object attributes to the information read in
                    church.UserId = (Guid)reader[0];
                    church.name = (String)reader[1];
                    if(reader[2] == System.DBNull.Value)
                    {
                        church.email = null;
                    }
                    else
                    {
                        church.email = (String)reader[2];
                    }
                    church.address = (String)reader[3];
                    church.city = (String)reader[4];
                    church.state = (String)reader[5];
                    church.zip = (String)reader[6];
                    if (reader[7] == System.DBNull.Value)
                    {
                        church.web = null;
                    }
                    else
                    {
                        church.web = (String)reader[7];
                    }
                    if (reader[8] == System.DBNull.Value)
                    {
                        church.phone = null;
                    }
                    else
                    {
                        church.phone = (String)reader[8];
                    }
                
                }
            }
            catch(Exception e)
            {

            }
            finally
            {
                command.Connection.Close();
            }



            return church;
        }

        public static void saveProfile(ChurchProfileBO profile)
        {
            //setup database connection
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DB_MYCHURCH"].ConnectionString);

            //setup a way to talk to the database
            SqlCommand command = new SqlCommand();
            command.Connection = connection;

            try
            {
                //open connection and set parameters
                command.Connection.Open();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ChurchProfile_InsertUpdate";

                //set all of the data to be sent to the database
                command.Parameters.Add(new SqlParameter("@UserId", profile.UserId));
                command.Parameters.Add(new SqlParameter("@ChurchName", profile.name));
                command.Parameters.Add(new SqlParameter("@ChurchEmail", profile.email));
                command.Parameters.Add(new SqlParameter("@ChurchAddress", profile.address));
                command.Parameters.Add(new SqlParameter("@ChurchCity", profile.city));
                command.Parameters.Add(new SqlParameter("@ChurchState", profile.state));
                command.Parameters.Add(new SqlParameter("@ChurchZip", profile.zip));
                command.Parameters.Add(new SqlParameter("@ChurchWeb", profile.web));
                command.Parameters.Add(new SqlParameter("@ChurchPhone", profile.phone));

                //send data to the database
                command.ExecuteNonQuery();
            }
            catch(Exception)
            {

            }
            finally
            {
                command.Connection.Close();
            }
            
        }
    }
}
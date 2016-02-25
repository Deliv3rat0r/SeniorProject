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
                dbJobs.SelectParameters["ServiceID"].DefaultValue = servbo.servid.ToString();
                dbJobs.InsertParameters["ServiceID"].DefaultValue = servbo.servid.ToString();
                dbJobs.UpdateParameters["ServiceID"].DefaultValue = servbo.servid.ToString();
            }
            else
            {
                Response.Redirect("~/Users/Service.aspx");
            }
        }

        protected void dbWorkers_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            //get user id
            MembershipUser usr = Membership.GetUser();
            Guid uid = (Guid)usr.ProviderUserKey;

            e.Command.Parameters["@UserId"].Value = uid;
        }

        protected void dbJobs_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            //get user id
            MembershipUser usr = Membership.GetUser();
            Guid uid = (Guid)usr.ProviderUserKey;

            e.Command.Parameters["@UserId"].Value = uid;

        }

        protected void dbJobs_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            //dbJobs.InsertParameters["@JobID"].DefaultValue = uxAssignJobsGrid.SelectedRow.Cells[0].Text;
        }

        protected void dbJobs_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            //dbJobs.UpdateParameters["@JobID"].DefaultValue = uxAssignJobsGrid.SelectedRow.Cells[0].Text;
        }

        protected void uxAssignJobsGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            //dbJobs.UpdateParameters["@JobID"].DefaultValue = uxAssignJobsGrid.SelectedRow.Cells[0].Text;
            //dbJobs.InsertParameters["@JobID"].DefaultValue = uxAssignJobsGrid.SelectedRow.Cells[0].Text;
        }

        protected void uxAssignJobsGrid_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            //dbJobs.UpdateParameters["@JobID"].DefaultValue = uxAssignJobsGrid.SelectedRow.Cells[0].Text;
            //dbJobs.InsertParameters["@JobID"].DefaultValue = uxAssignJobsGrid.SelectedRow.Cells[0].Text;
        }

        protected void uxAssignJobsGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //var ddl = uxAssignJobsGrid.Rows[e.NewEditIndex].FindControl("uxWorkerList") as DropDownList;
            //String tempnum = ddl.SelectedValue;
            //dbJobs.InsertParameters["WorkerID"].DefaultValue = tempnum;
            //dbJobs.UpdateParameters["WorkerID"].DefaultValue = tempnum;
        }

        protected void uxWorkerList_SelectedIndexChanged(object sender, EventArgs e)
        {
            String tempnum = ((DropDownList)sender).SelectedValue;
            dbJobs.InsertParameters["WorkerID"].DefaultValue = tempnum;
            dbJobs.UpdateParameters["WorkerID"].DefaultValue = tempnum;
        }

        protected void uxWorkerList_Load(object sender, EventArgs e)
        {
            String tempnum = ((DropDownList)sender).SelectedValue;
            dbJobs.InsertParameters["WorkerID"].DefaultValue = tempnum;
            dbJobs.UpdateParameters["WorkerID"].DefaultValue = tempnum;
        }
    }
}
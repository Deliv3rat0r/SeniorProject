using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Security;
using MyChurch.Code;

namespace MyChurch.Users
{
    public partial class ChurchProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            uxMultiView.ActiveViewIndex = 1;

            MembershipUser usr = Membership.GetUser();
            Guid uid = (Guid)usr.ProviderUserKey;


            ChurchProfileBO cpbo = ChurchProfileRepo.getProfile(uid);

            Session["ProfileData"] = cpbo;

            LitName.Text = "<h2>" + cpbo.name + "</h2>";
            LitEmail.Text = cpbo.email;
            LitAddress.Text = cpbo.address;
            LitCity.Text = cpbo.city;
            LitState.Text = cpbo.state;
            LitZip.Text = cpbo.zip;
            LitWeb.Text = cpbo.web;
            LitPhone.Text = cpbo.phone;
        }

        protected void uxSaveBtn_Click(object sender, EventArgs e)
        {
            if(Page.IsValid == true)
            {
                //get user id
                MembershipUser usr = Membership.GetUser();
                Guid uid = (Guid)usr.ProviderUserKey;

                //setup session object
                ChurchProfileBO cpbo = new ChurchProfileBO();
                cpbo.name = uxName.Text;
                cpbo.email = uxEmail.Text;
                cpbo.address = uxAddress.Text;
                cpbo.city = uxCity.Text;
                cpbo.state = uxState.Text;
                cpbo.zip = uxZip.Text;
                cpbo.web = uxWeb.Text;
                cpbo.phone = uxPhone.Text;
                cpbo.UserId = uid;

                //set active view to view 2
                uxMultiView.ActiveViewIndex = 1;

                //add info to literals
                LitName.Text = uxName.Text;
                LitEmail.Text = cpbo.email;
                LitAddress.Text = cpbo.address;// uxAddress.Text;
                LitCity.Text = uxCity.Text;
                LitState.Text = uxState.Text;
                LitZip.Text = uxZip.Text;
                LitWeb.Text = uxWeb.Text;
                LitPhone.Text = uxPhone.Text;

                //save in session
                Session["ProfileData"] = cpbo;

                //save in database
                ChurchProfileRepo.saveProfile(cpbo);

                Response.Redirect("ChurchProfile.aspx");
            }
            
        }

        protected void uxEditProfile_Click(object sender, EventArgs e)
        {
            uxMultiView.ActiveViewIndex = 0;

            if(Session["ProfileData"] != null)
            {
                ChurchProfileBO cpbo = (ChurchProfileBO)Session["ProfileData"];

                uxName.Text = cpbo.name;
                uxEmail.Text = cpbo.name;
                uxAddress.Text = cpbo.address;
                uxState.Text = cpbo.state;
                uxCity.Text = cpbo.city;
                uxZip.Text = cpbo.zip;
                uxWeb.Text = cpbo.web;
                uxPhone.Text = cpbo.phone;
                uxEmail.Text = cpbo.email;
            }
        }
    }
}
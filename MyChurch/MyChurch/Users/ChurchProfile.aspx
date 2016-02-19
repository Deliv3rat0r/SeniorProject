<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BaseTemplate.Master" AutoEventWireup="true" CodeBehind="ChurchProfile.aspx.cs" Inherits="MyChurch.Users.ChurchProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Church Profile</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <h1>Church Profile</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="nav" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="server">
    <asp:MultiView ID="uxMultiView" ActiveViewIndex="0" runat="server">
        <asp:View ID="View1" runat="server">

            <asp:Label ID="lblName" AssociatedControlID="uxName" runat="server">Church Name:</asp:Label>
            <asp:TextBox ID="uxName" Width="200px" runat="server" />
            <asp:RequiredFieldValidator ID="reqName" ControlToValidate="uxName" Display="Dynamic" Text="*" ErrorMessage="Church Name Required" runat="server" />

            <br />

            <asp:Label ID="lblEmail" AssociatedControlID="uxEmail" runat="server">Church Email:</asp:Label>
            <asp:TextBox ID="uxEmail" Width="200px" runat="server" />
            <asp:RequiredFieldValidator ID="reqEmail" ControlToValidate="uxEmail" Display="Dynamic" Text="*" ErrorMessage="Church Email Required" runat="server" />

            <br />

            <asp:Label ID="lblAddress" AssociatedControlID="uxAddress" runat="server">Church Address:</asp:Label>
            <asp:TextBox ID="uxAddress" Width="200px" runat="server" />
            <asp:RequiredFieldValidator ID="reqAddress" ControlToValidate="uxAddress" Display="Dynamic" Text="*" ErrorMessage="Church Address Required" runat="server" />

            <br />

            <asp:Label ID="lblCity" AssociatedControlID="uxCity" runat="server">Church City:</asp:Label>
            <asp:TextBox ID="uxCity" Width="200px" runat="server" />
            <asp:RequiredFieldValidator ID="reqCity" ControlToValidate="uxCity" Display="Dynamic" Text="*" ErrorMessage="Church City Required" runat="server" />

            <br />

            <asp:Label ID="lblState" AssociatedControlID="uxState" runat="server">Church State:</asp:Label>
            <asp:TextBox ID="uxState" Width="200px" runat="server" />
            <asp:RequiredFieldValidator ID="reqState" ControlToValidate="uxState" Display="Dynamic" Text="*" ErrorMessage="Church State Required" runat="server" />

            <br />

            <asp:Label ID="lblZip" AssociatedControlID="uxZip" runat="server">Church Zip:</asp:Label>
            <asp:TextBox ID="uxZip" Width="200px" runat="server" />
            <asp:RequiredFieldValidator ID="reqZip" ControlToValidate="uxName" Display="Dynamic" Text="*" ErrorMessage="Church Zip Required" runat="server" />

            <br />

            <asp:Label ID="lblWeb" AssociatedControlID="uxWeb" runat="server">Church Website:</asp:Label>
            <asp:TextBox ID="uxWeb" Width="200px" runat="server" />

            <br />

            <asp:Label ID="lblPhone" AssociatedControlID="uxPhone" runat="server">Church Phone:</asp:Label>
            <asp:TextBox ID="uxPhone" Width="200px" runat="server" />

            <br />

            <asp:Button ID="uxSaveBtn" Text="Save Church Profile" OnClick="uxSaveBtn_Click" runat="server" />

            <asp:ValidationSummary ID="VSView1" DisplayMode="BulletList" runat="server" />

        </asp:View>

        <asp:View ID="View2" runat="server">

            <asp:Label ID="lblNameV2" runat="server"></asp:Label>
            <asp:Literal ID="LitName" runat="server" />

            <br />

            <asp:Label ID="lblEmailV2" runat="server"><strong>Church Email: </strong></asp:Label>
            <asp:Literal ID="LitEmail" runat="server" />

            <br />

            <asp:Label ID="lblAddressV2" runat="server"><strong>Church Address: </strong></asp:Label>
            <asp:Literal ID="LitAddress" runat="server" />

            <br />

            <asp:Label ID="lblCityV2" runat="server"><strong>Church City: </strong></asp:Label>
            <asp:Literal ID="LitCity" runat="server" />

            <br />

            <asp:Label ID="lblStateV2" runat="server"><strong>Church State: </strong></asp:Label>
            <asp:Literal ID="LitState" runat="server" />

            <br />

            <asp:Label ID="lblZipV2" runat="server"><strong>Church Zip: </strong></asp:Label>
            <asp:Literal ID="LitZip" runat="server" />

            <br />

            <asp:Label ID="lblWebV2" runat="server"><strong>Church Website: </strong></asp:Label>
            <asp:Literal ID="LitWeb" runat="server" />

            <br />

            <asp:Label ID="lblPhoneV2" runat="server"><strong>Church Phone: </strong></asp:Label>
            <asp:Literal ID="LitPhone" runat="server" />

            <br /><br />

            <asp:Button ID="uxEditProfile" Text="Edit Info" OnClick="uxEditProfile_Click" runat="server" />

        </asp:View>

    </asp:MultiView>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

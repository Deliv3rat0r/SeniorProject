<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BaseTemplate.Master" AutoEventWireup="true" CodeBehind="WorkerUnavailable.aspx.cs" Inherits="MyChurch.Users.WorkerUnavailable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Worker Availability</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <h1>Worker Availability</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="nav" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="server">

    <asp:SqlDataSource ID="uxWorkerAvailableSql" runat="server"
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>">
    </asp:SqlDataSource>

    <asp:Literal ID="litWorkerInfo" runat="server" />


    <div id="WorkerCalendar">
        <asp:Label ID="lblStartDate" AssociatedControlID="uxStartDate" runat="server">Start Date:</asp:Label>
        <br />
        <asp:Calendar ID="uxStartDate" runat="server"></asp:Calendar>

        <br />

        <asp:Label ID="lblStartHour" AssociatedControlID="uxStartHour" runat="server">Hour:</asp:Label>
        <br />
        <asp:TextBox ID="uxStartHour" runat="server" />

        <br />

        <asp:Label ID="lblStartMinute" AssociatedControlID="uxStartMinute" runat="server">Minute</asp:Label>
        <br />
        <asp:TextBox ID="uxStartMinute" runat="server" />
    </div>

    <div id="WorkerCalendar">
        <asp:Label ID="lblEndDate" AssociatedControlID="uxEndDate" runat="server">End Date:</asp:Label>
        <br />
        <asp:Calendar ID="uxEndDate" runat="server"></asp:Calendar>

        <br />

        <asp:Label ID="lblEndHour" AssociatedControlID="uxEndHour" runat="server">Hour:</asp:Label>
        <br />
        <asp:TextBox ID="uxEndHour" runat="server" />

        <br />

        <asp:Label ID="lblEndMinute" AssociatedControlID="uxEndMinute" runat="server">Minute</asp:Label>
        <br />
        <asp:TextBox ID="uxEndMinute" runat="server" />
    </div>


    <asp:UpdatePanel ID="uxWorkerAvailableUpdate" runat="server">
        <ContentTemplate>

            <asp:GridView ID="uxGridView" AutoGenerateColumns="false" Width="100%" DataSourceID="uxWorkerAvailableSql"
                 DataKeyNames="WorkerID" AllowSorting="true" AllowPaging="true" PageSize="10" CssClass="datagrid" HeaderStyle-CssClass="gridview_header" runat="server">
                <Columns>
                    

                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />

                    
                </Columns>
            </asp:GridView> 

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

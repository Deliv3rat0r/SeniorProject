<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BaseTemplate.Master" AutoEventWireup="true" CodeBehind="Worker.aspx.cs" Inherits="MyChurch.Users.Worker" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Workers</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <h1>Workers</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="nav" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="uxWorkerSql" ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>" SelectCommandType="Text" SelectCommand="SELECT * FROM SPWorker" runat="server">

    </asp:SqlDataSource>

    <asp:UpdatePanel ID="uxWorkerUpdate" runat="server">
        <ContentTemplate>
            <asp:FormView ID="uxFormView" DataSourceID="uxWorkerSql" runat="server">
                <InsertItemTemplate>
                    Placeholder for insert new worker
                </InsertItemTemplate>
            </asp:FormView>

            <asp:GridView ID="uxGridView" AutoGenerateColumns="false" DataSourceID="uxWorkerSql" DataKeyNames="WorkerID" AllowSorting="true" AllowPaging="true" PageSize="10" runat="server">
                <Columns>
                    <asp:BoundField DataField="FName" SortExpression="FName" HeaderText="First Name" />
                    <asp:BoundField DataField="LName" SortExpression="LName" HeaderText="Last Name" />
                    <asp:BoundField DataField="Phone" SortExpression="Phone" HeaderText="Phone" />
                    <asp:BoundField DataField="Email" SortExpression="Email" HeaderText="Email" />
                    <asp:BoundField DataField="LastWorked" SortExpression="LastWorked" HeaderText="Last Worked" />

                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />

                </Columns>
            </asp:GridView> 

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

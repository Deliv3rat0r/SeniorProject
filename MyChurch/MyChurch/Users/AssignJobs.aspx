<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BaseTemplate.Master" AutoEventWireup="true" CodeBehind="AssignJobs.aspx.cs" Inherits="MyChurch.Users.AssignJobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Assign Jobs</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <h1>Assign Jobs</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="nav" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="server">
    <asp:Literal ID="litTop" runat="server"></asp:Literal>

    <asp:SqlDataSource ID="dbWorkers" 
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>" 
        SelectCommandType="Text" 
        SelectCommand="SELECT SPWorker.WorkerID, CONCAT(SPWorker.FName, ' ', SPWorker.LName) AS WholeName FROM SPWorker JOIN SPChurchWorkers ON SPWorker.WorkerID = SPChurchWorkers.WorkerID WHERE SPChurchWorkers.UserId=@UserId" 
        OnSelecting="dbWorkers_Selecting" 
        runat="server">
        <SelectParameters>
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dbJobs" 
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>"
        SelectCommandType="Text" 
        SelectCommand="SELECT SPJobs.JobID, SPJobs.JobTitle, SPAssignedJob.WorkerID FROM SPJobs LEFT OUTER JOIN SPAssignedJob ON SPJobs.JobID = SPAssignedJob.JobID AND SPAssignedJob.ServiceID=@ServiceID JOIN SPChurchJobs ON SPJobs.JobID = SPChurchJobs.JobID WHERE SPChurchJobs.UserId=@UserId" 
        runat="server" 
        OnSelecting="dbJobs_Selecting">

        <SelectParameters>
            <asp:Parameter Name="ServiceID" Direction="Input" Type="Int32" />
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:GridView ID="uxAssignJobsGrid" AutoGenerateColumns="false" runat="server" DataSourceID="dbJobs"
        CssClass="datagrid" HeaderStyle-CssClass="gridview_header" Width="100%">
        <Columns>
            <asp:BoundField DataField="JobTitle" HeaderText="Job Title" ReadOnly="true" />
            <asp:TemplateField HeaderText="Worker">
                <ItemTemplate>
                    <%#Eval("WorkerID") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="uxWorkerList" DataSourceID="dbWorkers" DataValueField="WorkerID" DataTextField="WholeName" runat="server">
                        
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField EditText="Edit" ShowEditButton="true" />
        </Columns>
    </asp:GridView>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

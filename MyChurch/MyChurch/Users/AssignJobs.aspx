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
        SelectCommand="SELECT SPWorker.WorkerID, CONCAT(SPWorker.FName, ' ', SPWorker.LName) AS WholeName FROM SPWorker JOIN SPChurchWorkers ON SPWorker.WorkerID = SPChurchWorkers.WorkerID LEFT JOIN SPWorkerUnavailable ON SPWorker.WorkerID = SPWorkerUnavailable.WorkerID WHERE SPChurchWorkers.UserId=@UserId AND NOT EXISTS (SELECT 1 FROM SPService WHERE SPService.ServiceDate BETWEEN SPWorkerUnavailable.UnavailableDateBegin AND SPWorkerUnavailable.UnavailableDateEnd)" 
        OnSelecting="dbWorkers_Selecting" 
        runat="server">
        <SelectParameters>
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
            <asp:Parameter Name="ServiceID" Direction="Input" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dbJobs" 
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>"
        SelectCommandType="Text" 
        SelectCommand="SELECT SPJobs.JobID, SPJobs.JobTitle, SPAssignedJob.WorkerID, CONCAT(SPWorker.Fname, ' ', SPWorker.Lname) AS WholeName FROM SPJobs LEFT OUTER JOIN SPAssignedJob ON SPJobs.JobID = SPAssignedJob.JobID AND SPAssignedJob.ServiceID=@ServiceID JOIN SPChurchJobs ON SPJobs.JobID = SPChurchJobs.JobID LEFT OUTER JOIN SPWorker ON SPAssignedJob.WorkerID = SPWorker.WorkerID WHERE SPChurchJobs.UserId=@UserId" 
        runat="server" 
        OnSelecting="dbJobs_Selecting" 
        InsertCommandType="StoredProcedure" 
        InsertCommand="AssignedJob_InsertUpdate" 
        OnInserting="dbJobs_Inserting" 
        UpdateCommandType="StoredProcedure" 
        UpdateCommand="AssignedJob_InsertUpdate" 
        OnUpdating="dbJobs_Updating">

        <SelectParameters>
            <asp:Parameter Name="ServiceID" Direction="Input" Type="Int32" />
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
        </SelectParameters>

        <InsertParameters>
            <asp:Parameter Name="ServiceID" Direction="Input" Type="Int32" />
            <asp:Parameter Name="WorkerID" Direction="Input" Type="Int32" />      
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="ServiceID" Direction="Input" Type="Int32" /> 
            <asp:Parameter Name="WorkerID" Direction="Input" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>

    <asp:GridView ID="uxAssignJobsGrid" DataKeyNames="JobID" AutoGenerateColumns="false" runat="server" DataSourceID="dbJobs"
        CssClass="datagrid" HeaderStyle-CssClass="gridview_header" Width="100%">
        <Columns>
            <asp:BoundField DataField="JobID" ReadOnly="true" />
            <asp:BoundField DataField="JobTitle" HeaderText="Job Title" ReadOnly="true" />
            <asp:TemplateField HeaderText="Worker">
                <ItemTemplate>
                    <%#Eval("WholeName") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="uxWorkerList" DataSourceID="dbWorkers" DataValueField="WorkerID" 
                        DataTextField="WholeName" OnSelectedIndexChanged="uxWorkerList_SelectedIndexChanged"
                         Width="100%" OnLoad="uxWorkerList_Load" runat="server">
                        
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField EditText="Assign Worker" ShowEditButton="true" />
        </Columns>
    </asp:GridView>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

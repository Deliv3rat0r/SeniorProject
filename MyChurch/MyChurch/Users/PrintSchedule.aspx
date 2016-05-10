<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BaseTemplate.Master" AutoEventWireup="true" CodeBehind="PrintSchedule.aspx.cs" Inherits="MyChurch.Code.PrintSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Print Schedule</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <h1>Print Schedule</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="nav" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="uxPrintSchedule" 
        runat="server" 
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>" 
        SelectCommandType="Text" 
        SelectCommand="SELECT SPService.Title, SPService.Duration, SPService.ServiceDate, SPJobs.JobTitle, CONCAT(SPWorker.FName, ' ', SPWorker.LName) AS WholeName FROM SPService JOIN SPScheduleService ON SPScheduleService.ServiceID = SPService.ServiceID JOIN SPSchedule ON SPScheduleService.ScheduleID = SPSchedule.ScheduleID JOIN SPAssignedJob ON SPAssignedJob.ServiceID = SPService.ServiceID JOIN SPJobs ON SPJobs.JobID = SPAssignedJob.JobID JOIN SPWorker ON SPWorker.WorkerID = SPAssignedJob.WorkerID WHERE SPSchedule.UserId=@UserId AND DATEDIFF(MONTH, SPService.ServiceDate, getdate()) = 0 OR DATEDIFF(MONTH, SPService.ServiceDate, getdate()) = -1 ORDER BY SPService.ServiceDate">

        <SelectParameters>
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:GridView ID="uxGridView" DataKeyNames="Title" AutoGenerateColumns="false" runat="server" 
        DataSourceID="uxPrintSchedule" CssClass="datagrid" HeaderStyle-CssClass="gridview_header" Width="100%">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Service Title" SortExpression="Title" />
            <asp:BoundField DataField="ServiceDate" HeaderText="Date" />
            <asp:BoundField DataField="Duration" HeaderText="Duration" />
            <asp:BoundField DataField="JobTitle" HeaderText="Job" />
            <asp:BoundField DataField="WholeName" HeaderText="Worker" />

        </Columns>
    </asp:GridView>

    <br />

    <input type="button" value="Print Schedule" onclick="window.open('Print.aspx')" />

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

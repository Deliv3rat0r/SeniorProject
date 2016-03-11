<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Print.aspx.cs" Inherits="MyChurch.Users.Print" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="uxPrintSchedule"
                runat="server"
                ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>"
                SelectCommandType="Text"
                SelectCommand="SELECT SPService.Title, SPService.Duration, SPService.ServiceDate, SPJobs.JobTitle, CONCAT(SPWorker.FName, ' ', SPWorker.LName) AS WholeName FROM SPService JOIN SPScheduleService ON SPScheduleService.ServiceID = SPService.ServiceID JOIN SPSchedule ON SPScheduleService.ScheduleID = SPSchedule.ScheduleID JOIN SPAssignedJob ON SPAssignedJob.ServiceID = SPService.ServiceID JOIN SPJobs ON SPJobs.JobID = SPAssignedJob.JobID JOIN SPWorker ON SPWorker.WorkerID = SPAssignedJob.WorkerID WHERE SPSchedule.UserId=@UserId AND DATEDIFF(MONTH, SPService.ServiceDate, getdate()) = 0 OR DATEDIFF(MONTH, SPService.ServiceDate, getdate()) = 1 ORDER BY SPService.ServiceDate">

                <SelectParameters>
                    <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
                </SelectParameters>

            </asp:SqlDataSource>

            <asp:GridView ID="uxGridView" DataKeyNames="Title" AutoGenerateColumns="false" runat="server"
                DataSourceID="uxPrintSchedule" Width="60%">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Service Title" SortExpression="Title" />
                    <asp:BoundField DataField="ServiceDate" HeaderText="Date" />
                    <asp:BoundField DataField="Duration" HeaderText="Duration" />
                    <asp:BoundField DataField="JobTitle" HeaderText="Job" />
                    <asp:BoundField DataField="WholeName" HeaderText="Worker" />

                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>

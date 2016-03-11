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
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>"
        SelectCommandType="Text"
        SelectCommand="SELECT * FROM SPWorkerUnavailable WHERE WorkerID=@WorkerID"
        InsertCommandType="Text"
        InsertCommand="INSERT INTO SPWorkerUnavailable(WorkerID, UnavailableDateBegin, UnavailableDateEnd, Reason) VALUES(@WorkerID, @UnavailableDateBegin, @UnavailableDateEnd, @Reason)"
        UpdateCommandType="Text"
        UpdateCommand="UPDATE SPWorkerUnavailable SET UnavailableDateBegin=@UnavailableDateBegin, UnavailableDateEnd=@UnavailableDateEnd, Reason=@Reason WHERE UnavailableID=@UnavailableID"
        DeleteCommandType="Text"
        DeleteCommand="DELETE FROM SPWorkerUnavailable WHERE UnavailableID=@UnavailableID">

        <SelectParameters>
            <asp:Parameter Name="WorkerID" Direction="Input" Type="Int32" />
        </SelectParameters>

        <InsertParameters>
            <asp:Parameter Name="WorkerID" Direction="Input" Type="Int32" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="WorkerID" Direction="Input" Type="Int32" />
        </UpdateParameters>

        <DeleteParameters>
            <asp:Parameter Name="WorkerID" Direction="Input" Type="Int32" />
        </DeleteParameters>

    </asp:SqlDataSource>

    <asp:Literal ID="litWorkerInfo" runat="server" />

    <asp:UpdatePanel ID="uxWorkerAvailableUpdate" runat="server">
        <ContentTemplate>
            <asp:FormView ID="uxFormView" DataSourceID="uxWorkerAvailableSql" DefaultMode="Insert" runat="server">
                <InsertItemTemplate>
                    <div id="WorkerCalendar">
                        <asp:Label ID="lblStartDate" AssociatedControlID="uxStartDate" runat="server">Start Date:</asp:Label>
                        <br />
                        <asp:Calendar ID="uxStartDate" SelectedDate='<%#Bind("UnavailableDateBegin") %>' runat="server"></asp:Calendar>

                        <br />

                    </div>

                    <div id="WorkerCalendar">
                        <asp:Label ID="lblEndDate" AssociatedControlID="uxEndDate" runat="server">End Date:</asp:Label>
                        <br />
                        <asp:Calendar ID="uxEndDate" SelectedDate='<%#Bind("UnavailableDateEnd") %>' runat="server"></asp:Calendar>

                        <br />

                    </div>

                    <asp:Label ID="lblReason" AssociatedControlID="uxReason" runat="server">Reason:</asp:Label>
                    <asp:TextBox ID="uxReason" Text='<%#Bind("Reason") %>' runat="server" />

                    <asp:Button ID="uxAddDates" Text="Add Dates" CommandName="Insert" runat="server" />

                    <hr />
                </InsertItemTemplate>
            </asp:FormView>


            <asp:GridView ID="uxGridView" AutoGenerateColumns="false" Width="100%" DataSourceID="uxWorkerAvailableSql"
                DataKeyNames="UnavailableID" AllowSorting="true" AllowPaging="true" PageSize="10" CssClass="datagrid" HeaderStyle-CssClass="gridview_header" runat="server">
                <Columns>
                    <asp:BoundField DataField="UnavailableDateBegin" SortExpression="UnavailableDateBegin" HeaderText="Start Date" />
                    <asp:BoundField DataField="UnavailableDateEnd" SortExpression="UnavailableDateEnd" HeaderText="End Date" />
                    <asp:BoundField DataField="Reason" SortExpression="Reason" HeaderText="Reason" />

                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />


                </Columns>
            </asp:GridView>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

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
    <asp:SqlDataSource ID="uxWorkerSql" 
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>"
        SelectCommandType="Text"
        SelectCommand="SELECT * FROM SPWorker JOIN SPChurchWorkers ON SPWorker.WorkerID = SPChurchWorkers.WorkerID WHERE SPChurchWorkers.UserID = @UserId" 
        OnSelecting="uxWorkerSql_Selecting"
        InsertCommandType="Text" 
        InsertCommand="INSERT INTO SPWorker(FName, LName, Phone, Email, LastWorked) VALUES(@FName, @LName, @Phone, @Email, @LastWorked); SELECT @WorkerID = @@IDENTITY" 
        OnInserted="uxWorkerSql_Inserted" runat="server"
        UpdateCommandType="Text" 
        UpdateCommand="UPDATE SPWorker SET FName=@FName, LName=@LName, Phone=@Phone, Email=@Email, LastWorked=@LastWorked WHERE WorkerID=@WorkerID" >
        
        <SelectParameters>
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
        </SelectParameters>

        <InsertParameters>
            <asp:Parameter Name="WorkerID" Direction="Output" Type="Int32" />
        </InsertParameters>

    </asp:SqlDataSource>

    <asp:UpdatePanel ID="uxWorkerUpdate" runat="server">
        <ContentTemplate>
            <asp:FormView ID="uxFormView" DataSourceID="uxWorkerSql" DefaultMode="Insert" runat="server">
                <InsertItemTemplate>
                    <%--Placeholder for insert new worker--%>

                    <asp:Label ID="lblFName" AssociatedControlID="uxFName" runat="server">First Name: </asp:Label>
                    <asp:TextBox ID="uxFName" MaxLength="30" Text='<%#Bind("FName") %>' runat="server" />

                    <br /><br />

                    <asp:Label ID="lblLName" AssociatedControlID="uxLName" runat="server">Last Name: </asp:Label>
                    <asp:TextBox ID="uxLName" MaxLength="30" Text='<%#Bind("LName") %>' runat="server" />

                    <br /><br />

                    <asp:Label ID="lblPhone" AssociatedControlID="uxPhone" runat="server">Phone: </asp:Label>
                    <asp:TextBox ID="uxPhone" MaxLength="10" Text='<%#Bind("Phone") %>' runat="server" />

                    <br /><br />

                    <asp:Label ID="lblEmail" AssociatedControlID="uxEmail" runat="server">Email: </asp:Label>
                    <asp:TextBox ID="uxEmail" MaxLength="50" Text='<%#Bind("Email") %>' runat="server" />

                    <br /><br />

                    <asp:Label ID="lblLastWorked" AssociatedControlID="uxLastWorked" runat="server">Last Worked:</asp:Label>
                    <br />
                    <asp:Calendar ID="uxLastWorked" SelectedDate='<%#Bind("LastWorked") %>' runat="server"></asp:Calendar>

                    <br />
                    
                    <%--OnClick="uxAddWorker_Click"--%>
                    <asp:Button ID="uxAddWorker" Text="Add Worker" CommandName="Insert"  runat="server" />

                    <hr />

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

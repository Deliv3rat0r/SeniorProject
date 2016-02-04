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
        UpdateCommand="UPDATE SPWorker SET FName=@FName, LName=@LName, Phone=@Phone, Email=@Email, LastWorked=@LastWorked WHERE WorkerID=@WorkerID"
        DeleteCommandType="Text" 
        DeleteCommand="DELETE FROM SPChurchWorkers WHERE WorkerID=@WorkerID; DELETE FROM SPWorker WHERE WorkerID=@WorkerID;" >
        
        <SelectParameters>
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
        </SelectParameters>

        <InsertParameters>
            <asp:Parameter Name="WorkerID" Direction="Output" Type="Int32" />
        </InsertParameters>

    </asp:SqlDataSource>

    <asp:UpdatePanel ID="uxWorkerUpdate" runat="server">
        <ContentTemplate>
            <asp:FormView ID="uxFormView" DataSourceID="uxWorkerSql" DefaultMode="Insert" CssClass="WorkerInsert" runat="server">
                <InsertItemTemplate>
                    <%--Placeholder for insert new worker--%>
                    <div id="WorkerTextInput">

                        <asp:Label ID="lblFName" AssociatedControlID="uxFName" CssClass="lblBlock" runat="server">First Name: </asp:Label>
                        <asp:TextBox ID="uxFName" MaxLength="30" Text='<%#Bind("FName") %>' runat="server" />
                        <%--<asp:RequiredFieldValidator ID="reqFName" ControlToValidate="uxFName" Display="Dynamic" Text="*" ErrorMessage="Worker First Name Required" runat="server" /> --%>

                        <br /><br />

                        <asp:Label ID="lblLName" AssociatedControlID="uxLName" CssClass="lblBlock" runat="server">Last Name: </asp:Label>
                        <asp:TextBox ID="uxLName" MaxLength="30" Text='<%#Bind("LName") %>' runat="server" />
                        <%--<asp:RequiredFieldValidator ID="reqLName" ControlToValidate="uxLName" Display="Dynamic" Text="*" ErrorMessage="Worker Last Name Required" runat="server" />--%>

                        <br /><br />

                        <asp:Label ID="lblPhone" AssociatedControlID="uxPhone" CssClass="lblBlock" runat="server">Phone: </asp:Label>
                        <asp:TextBox ID="uxPhone" MaxLength="10" Text='<%#Bind("Phone") %>' runat="server" />

                        <br /><br />

                        <asp:Label ID="lblEmail" AssociatedControlID="uxEmail" CssClass="lblBlock" runat="server">Email: </asp:Label>
                        <asp:TextBox ID="uxEmail" MaxLength="50" Text='<%#Bind("Email") %>' runat="server" />

                    </div>

                    <div id="WorkerCalendar">
                        <asp:Label ID="lblLastWorked" AssociatedControlID="uxLastWorked" runat="server">Last Worked:</asp:Label>
                        <br />
                        <asp:Calendar ID="uxLastWorked" SelectedDate='<%#Bind("LastWorked") %>' runat="server"></asp:Calendar>
                    </div>
                    <br />
                    
                    <%--OnClick="uxAddWorker_Click"--%>
                    <asp:Button ID="uxAddWorker" Text="Add Worker" CommandName="Insert"  runat="server" />

                </InsertItemTemplate>
            </asp:FormView>

            <hr />

            <asp:GridView ID="uxGridView" AutoGenerateColumns="false" Width="100%" DataSourceID="uxWorkerSql"
                 DataKeyNames="WorkerID" AllowSorting="true" AllowPaging="true" PageSize="10" CssClass="datagrid" HeaderStyle-CssClass="gridview_header" OnRowCommand="uxGridView_RowCommand" runat="server">
                <Columns>
                    <asp:BoundField DataField="WorkerID" ReadOnly="true" />
                    <asp:BoundField DataField="FName" SortExpression="FName" HeaderText="First Name" />
                    <asp:BoundField DataField="LName" SortExpression="LName" HeaderText="Last Name" />
                    <asp:BoundField DataField="Phone" SortExpression="Phone" HeaderText="Phone" />
                    <asp:BoundField DataField="Email" SortExpression="Email" HeaderText="Email" />
                    <asp:BoundField DataField="LastWorked" SortExpression="LastWorked" HeaderText="Last Worked" />

                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />


                    <asp:TemplateField HeaderText="Unavailable Dates" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Button ID="uxUnavailable" runat="server" CommandName="UnavailableDates" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Add Dates" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    
                </Columns>
            </asp:GridView> 

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

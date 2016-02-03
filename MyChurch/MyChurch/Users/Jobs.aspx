<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BaseTemplate.Master" AutoEventWireup="true" CodeBehind="Jobs.aspx.cs" Inherits="MyChurch.Users.Jobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Jobs</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <h1>Jobs</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="nav" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="server">

    <asp:SqlDataSource ID="uxJobSql" 
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>"
        SelectCommandType="Text"
        SelectCommand="SELECT * FROM SPJobs JOIN SPChurchJobs ON SPJobs.JobID = SPChurchJobs.JobID WHERE SPChurchJobs.UserID = @UserId" 
        OnSelecting="uxJobSql_Selecting"
        InsertCommandType="Text" 
        InsertCommand="INSERT INTO SPJobs(JobTitle) VALUES(@JobTitle); SELECT @JobID = @@IDENTITY" 
        OnInserted="uxJobSql_Inserted" runat="server"
        UpdateCommandType="Text" 
        UpdateCommand="UPDATE SPJobs SET JobTitle=@JobTitle WHERE JobID=@JobID"
        DeleteCommandType="Text" 
        DeleteCommand="DELETE FROM SPChurchJobs WHERE JobID=@JobID; DELETE FROM SPJobs WHERE JobID=@JobID;" >
        
        <SelectParameters>
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
        </SelectParameters>

        <InsertParameters>
            <asp:Parameter Name="JobID" Direction="Output" Type="Int32" />
        </InsertParameters>

    </asp:SqlDataSource>

    <asp:UpdatePanel ID="uxJobUpdate" runat="server">
        <ContentTemplate>
            <asp:FormView ID="uxFormView" DataSourceID="uxJobSql" DefaultMode="Insert" CssClass="JobInsert" runat="server">
                <InsertItemTemplate>
                    <%--Placeholder for insert new Job--%>
                    <div id="JobTextInput">

                        <asp:Label ID="lblJobTitle" AssociatedControlID="uxJobTitle" CssClass="lblBlock" runat="server">Job Title: </asp:Label>
                        <asp:TextBox ID="uxJobTitle" MaxLength="30" Text='<%#Bind("JobTitle") %>' runat="server" />
                        <%--<asp:RequiredFieldValidator ID="reqJobTitle" ControlToValidate="uxJobTitle" Display="Dynamic" Text="*" ErrorMessage="Job Title Required" runat="server" />--%> 

                    </div>

                    <br />
                    
                    <%--OnClick="uxAddJob_Click"--%>
                    <asp:Button ID="uxAddJob" Text="Add Job" CommandName="Insert"  runat="server" />

                </InsertItemTemplate>
            </asp:FormView>

            <hr />

            <asp:GridView ID="uxGridView" AutoGenerateColumns="false" Width="100%" DataSourceID="uxJobSql"
                 DataKeyNames="JobID" AllowSorting="true" AllowPaging="true" PageSize="10" CssClass="datagrid" HeaderStyle-CssClass="gridview_header" runat="server">
                <Columns>
                    <asp:BoundField DataField="JobTitle" SortExpression="JobTitle" HeaderText="Job Title" />

                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />

                </Columns>
            </asp:GridView> 

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BaseTemplate.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="MyChurch.Users.Schedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Schedule</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <h1>Schedule</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="nav" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="server">

    <asp:SqlDataSource ID="dbSchedule"
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>"
        InsertCommandType="Text"
        InsertCommand="INSERT INTO SPSchedule(UserId, ScheduleTitle) VALUES(@UserId, @ScheduleTitle)"
        runat="server"
        OnInserted="dbScheduleAdd_Inserted"
        OnInserting="dbScheduleAdd_Inserting"
        SelectCommandType="Text" 
        SelectCommand="SELECT * FROM SPSchedule WHERE UserId = @UserId"
        OnSelecting="dbScheduleSelect_Selecting" 
        UpdateCommandType="Text" 
        UpdateCommand="UPDATE SPSchedule SET ScheduleTitle=@ScheduleTitle WHERE ScheduleID=@ScheduleID;" 
        DeleteCommandType="Text" 
        DeleteCommand="DELETE FROM SPSchedule WHERE ScheduleID=@ScheduleID">

        <InsertParameters>
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
        </InsertParameters>

        <SelectParameters>
            <asp:Parameter Name="UserId" Direction="Input" DbType="Guid" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:UpdatePanel ID="uxScheduleUpdate" runat="server">
        <ContentTemplate>
            <asp:FormView ID="uxFormViewInsert" DefaultMode="Insert" DataSourceID="dbSchedule" runat="server">
                <InsertItemTemplate>
                    <asp:Label ID="lblScheduleName" AssociatedControlID="uxScheduleName" runat="server">Title:</asp:Label>
                    <asp:TextBox ID="uxScheduleName" Text='<%#Bind("ScheduleTitle") %>' runat="server" />

                    <br />

                    <asp:Button ID="uxInsertButton" Text="Add Schedule" CommandName="Insert" runat="server" />

                </InsertItemTemplate>
            </asp:FormView>

            <hr />

            <asp:GridView ID="uxGridView" AutoGenerateColumns="false" Width="100%" DataSourceID="dbSchedule"
                DataKeyNames="ScheduleID" AllowSorting="true" AllowPaging="true" PageSize="10"
                CssClass="datagrid" HeaderStyle-CssClass="gridview_header" runat="server" OnRowCommand="uxGridView_RowCommand">

                <Columns>
                    <asp:BoundField DataField="ScheduleID" ReadOnly="true" />
                    <asp:BoundField DataField="ScheduleTitle" SortExpression="ScheduleTitle" HeaderText="Schedule Title" />

                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />

                    <asp:TemplateField HeaderText="Services" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Button ID="uxScheduleServices" runat="server" CommandName="ScheduleService" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="View Services" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>



</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

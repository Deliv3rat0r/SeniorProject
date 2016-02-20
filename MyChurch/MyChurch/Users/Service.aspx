<%@ Page Title="" Language="C#" MasterPageFile="~/App_Master/BaseTemplate.Master" AutoEventWireup="true" CodeBehind="Service.aspx.cs" Inherits="MyChurch.Users.Service" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Services</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <h1>Services</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="nav" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="server">

    <asp:SqlDataSource ID="dbServiceSql" 
        runat="server"
        ConnectionString="<%$ConnectionStrings:DB_MYCHURCH %>" 
        InsertCommandType="Text" 
        OnInserting="dbServiceSql_Inserting"  
        InsertCommand="INSERT INTO SPService(Title, Duration, ServiceDate) VALUES(@Title, @Duration, @ServiceDate); SELECT @ServiceID = @@IDENTITY"
        OnInserted="dbServiceSql_Inserted"
        SelectCommandType="Text" 
        SelectCommand="SELECT * FROM SPService JOIN SPScheduleService ON SPService.ServiceID = SPScheduleService.ServiceID WHERE SPScheduleService.ScheduleID = @ScheduleID ORDER BY SPService.ServiceDate" 
        OnSelecting="dbServiceSql_Selecting">
        
        <InsertParameters>
            <asp:Parameter Name="ServiceID" Direction="Output" Type="Int32" />
            <asp:Parameter Name="ScheduleID" Direction="Input" Type="Int32" />
        </InsertParameters>

        <SelectParameters>
            <asp:Parameter Name="ScheduleID" Direction="Input" Type="Int32" />
        </SelectParameters>
    
    </asp:SqlDataSource>

    <asp:Literal ID="litScheduleInfo" runat="server"></asp:Literal>

    <asp:UpdatePanel ID="uxServiceUpdate" runat="server">
        <ContentTemplate>
            <asp:FormView ID="uxFormView" DataSourceID="dbServiceSql" DefaultMode="Insert" CssClass="ServiceInsert" OnItemInserting="uxFormView_ItemInserting" runat="server">
                <InsertItemTemplate>
                    <asp:Label ID="lblServiceName" AssociatedControlID="uxServiceName" CssClass="lblBlock" runat="server">Service Name:</asp:Label>
                    <asp:TextBox ID="uxServiceName" Text='<%#Bind("Title") %>' runat="server" />

                    <br /><br />

                    <asp:Label ID="lblDuration" AssociatedControlID="uxDuration" CssClass="lblBlock" runat="server">Duration:</asp:Label>
                    <asp:TextBox ID="uxDuration" Text='<%#Bind("Duration") %>' runat="server" />

                    <br /><br />

                    <asp:Label ID="lblDate" AssociatedControlID="uxDate" runat="server">Date:</asp:Label>
                    <br />
                    <asp:Calendar ID="uxDate" SelectedDate='<%#Bind("ServiceDate") %>' runat="server"></asp:Calendar>

                    <br /><br />

                    <asp:Button ID="uxAddService" Text="Add Service" CommandName="Insert" runat="server" />

                </InsertItemTemplate>
            </asp:FormView>

            <hr />

            <asp:GridView ID="uxGridView" AutoGenerateColumns="false" Width="100%" 
                DataSourceID="dbServiceSql" DataKeyNames="ServiceID" AllowSorting="true" 
                AllowPaging="true" PageSize="10" CssClass="datagrid" HeaderStyle-CssClass="gridview_header" 
                runat="server" OnRowCommand="uxGridView_RowCommand">

                <Columns>
                    <asp:BoundField DataField="ServiceID" ReadOnly="true" />
                    <asp:BoundField DataField="Title" HeaderText="Service Title" />
                    <asp:BoundField DataField="Duration" HeaderText="Duration" />
                    <asp:BoundField DataField="ServiceDate" SortExpression="ServiceDate" HeaderText="Service Date" />

                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />

                    <asp:TemplateField HeaderText="Show Schedule" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Button ID="uxServiceSchedule" runat="server" CommandName="ServiceSchedule" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="View Schedule" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="footer" runat="server">
</asp:Content>

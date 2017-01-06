<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Records</title>
    <style type="text/css">
        .body {
            text-align: center;
            position: static;
            width: 100%;
            left: 10%;
        }
        .newStyle1 {
            text-align: right;
            font-size: large;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="body">
        <h1>Call Records</h1>
        &nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblSELECT" runat="server" Font-Bold="True" Font-Size="Large" Text="Employee name:"></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" DataTextField="FULL_NAME" DataValueField="FULL_NAME" DataSourceID="SqlDataSource2" AutoPostBack="True" Font-Size="Large">
            <asp:ListItem Selected="True">All</asp:ListItem>
        </asp:DropDownList>
        <%--<asp:Button ID="btnShowLog" runat="server" Text="Show"  />--%>
        <br />
        <br />
        &nbsp;&nbsp;<asp:Label ID="lblTIME" runat="server" Font-Bold="True" Font-Size="Large" Text="Date:"></asp:Label>
        <asp:TextBox ID="txtCALENDER_FROM" runat="server" Width="131px" AutoPostBack="True" Font-Size="Large"></asp:TextBox>
        <asp:Label ID="lblTO" runat="server" Text="to" Font-Bold="True" Font-Size="Large"></asp:Label>
        <asp:TextBox ID="txtCALENDER_TO" runat="server" Width="120px" AutoPostBack="True" Font-Size="Large"></asp:TextBox>
        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" 
                                      runat="server" TargetControlID="txtCALENDER_FROM" />
        <br />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" 
                                      runat="server" TargetControlID="txtCALENDER_TO" />
        <br />
        
        <asp:ScriptManager ID="ScriptManager" 
                               runat="server" />

        <asp:UpdatePanel ID="UpdatePanel1" 
                             UpdateMode="Conditional"
                             runat="server">
        <ContentTemplate> 
            <div class="newStyle1">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblFOUND" runat="server" Text="found " style="text-align:right" CssClass="newStyle1"></asp:Label>

            <asp:Label ID="lblRECORD_NUMBER" runat="server" style="text-align:right" CssClass="newStyle1">0</asp:Label>
                &nbsp;<asp:Label ID="lblRECORDS" runat="server" style="text-align:right" CssClass="newStyle1">records.</asp:Label>
            </div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="body" Font-Size="Large">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="SYSTEM_DATE" HeaderText="TIME" SortExpression="SYSTEM_DATE" DataFormatString="{0:MM/dd/yyyy hh:mm tt}">
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="EMPLOYEE NAME" SortExpression="EMPLOYEE_NAME" />
                <asp:BoundField DataField="CONTACT_NAME" HeaderText="CONTACT NAME" SortExpression="CONTACT_NAME" />
                <asp:BoundField DataField="DESCRIPTION" HeaderText="DESCRIPTION" SortExpression="DESCRIPTION" >
                <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView>
          <%--Page_load All--%>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AfterHoursConnectionString %>" SelectCommand="SELECT * FROM [Call_log] ORDER BY [SYSTEM_DATE]" UpdateCommand="UPDATE Call_log SET SYSTEM_DATE = CAST(GETDATE() AS smalldatetime)">
            <UpdateParameters>
                <asp:QueryStringParameter Name="datetime" QueryStringField="SYSTEM_DATE" />
            </UpdateParameters>
            </asp:SqlDataSource>
    
        <br />
            <%--employee names--%>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TrackerConnectionString %>" SelectCommand="SELECT * FROM [tblTeamMembers] ORDER BY [FULL_NAME]"></asp:SqlDataSource>
            <br />

        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:AfterHoursConnectionString %>" SelectCommand="SELECT * FROM [Call_log] WHERE (([SYSTEM_DATE] &gt;= @SYSTEM_DATE) AND ([SYSTEM_DATE] &lt;= @SYSTEM_DATE2+1) AND ([EMPLOYEE_NAME] = @EMPLOYEE_NAME)) ORDER BY [SYSTEM_DATE], [CONTACT_NAME]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCALENDER_FROM" Name="SYSTEM_DATE" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtCALENDER_TO" Name="SYSTEM_DATE2" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="EMPLOYEE_NAME" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:AfterHoursConnectionString %>" SelectCommand="SELECT SYSTEM_DATE, EMPLOYEE_NAME, CONTACT_NAME, DESCRIPTION FROM Call_log WHERE (SYSTEM_DATE &gt;= @SYSTEM_DATE ) AND (SYSTEM_DATE &lt;= @SYSTEM_DATE2+1) ORDER BY SYSTEM_DATE">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCALENDER_FROM" Name="SYSTEM_DATE" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtCALENDER_TO" Name="SYSTEM_DATE2" PropertyName="Text" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate> 
        <Triggers>
            <asp:asyncpostbacktrigger controlid="DropDownList1"  />
            <asp:AsyncPostBackTrigger ControlID="txtCALENDER_FROM" />
            <asp:AsyncPostBackTrigger ControlID="txtCALENDER_TO" />
           
        </Triggers>
        </asp:UpdatePanel>


    </div>
    </form>
</body>
</html>

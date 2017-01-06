'check-in test
Imports System.Data
Partial Class _Default

    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ScriptManager.RegisterAsyncPostBackControl(DropDownList1)
        ScriptManager.RegisterAsyncPostBackControl(txtCALENDER_FROM)
        ScriptManager.RegisterAsyncPostBackControl(txtCALENDER_TO)

        If Not IsPostBack Then
            DropDownList1.DataBind()
            DropDownList1.Items.Insert(0, New ListItem("All", ""))


            Dim df As DateTime = Convert.ToDateTime(GridView1.Rows(0).Cells(0).Text)
            txtCALENDER_FROM.Text = df.Date

            Dim dt As DateTime = Convert.ToDateTime(GridView1.Rows(GridView1.Rows.Count - 1).Cells(0).Text)
            txtCALENDER_TO.Text = dt.Date

            lblRECORD_NUMBER.Text = GridView1.Rows.Count
        End If

    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        If DropDownList1.SelectedIndex = 0 Then
            GridView1.DataSourceID = "SqlDataSource4"
            GridView1.DataBind()
            lblRECORD_NUMBER.Text = GridView1.Rows.Count
            Return
        End If
        GridView1.DataSourceID = "SqlDataSource3"
        GridView1.DataBind()
        lblRECORD_NUMBER.Text = GridView1.Rows.Count
    End Sub

    Protected Sub txtCALENDER_FROM_TextChanged(sender As Object, e As EventArgs) Handles txtCALENDER_FROM.TextChanged
        If DropDownList1.SelectedIndex = 0 Then
            GridView1.DataSourceID = "SqlDataSource4"
            GridView1.DataBind()
            lblRECORD_NUMBER.Text = GridView1.Rows.Count
            Return
        End If
        GridView1.DataSourceID = "SqlDataSource3"
        GridView1.DataBind()
        lblRECORD_NUMBER.Text = GridView1.Rows.Count
    End Sub

    

    Protected Sub txtCALENDER_TO_TextChanged(sender As Object, e As EventArgs) Handles txtCALENDER_TO.TextChanged
        If DropDownList1.SelectedIndex = 0 Then
            GridView1.DataSourceID = "SqlDataSource4"
            GridView1.DataBind()
            lblRECORD_NUMBER.Text = GridView1.Rows.Count
            Return
        End If
        GridView1.DataSourceID = "SqlDataSource3"
        GridView1.DataBind()
        lblRECORD_NUMBER.Text = GridView1.Rows.Count
    End Sub
End Class

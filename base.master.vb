
Partial Class video
    Inherits System.Web.UI.MasterPage
    Private Sub Contenido_Editor_Index_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim Usuario = Session("dUsuario").Rows.Item(0).Item(1).ToString
        TituloNombreUsuario.InnerText = Usuario
    End Sub
    Protected Sub BtnSalir_Click(sender As Object, e As EventArgs) Handles BtnSalir.Click
        FormsAuthentication.SignOut()
        Response.Redirect("~/Login.aspx")
    End Sub
End Class


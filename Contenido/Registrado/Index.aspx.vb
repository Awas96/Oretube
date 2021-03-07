
Partial Class Contenido_Editor_Index
    Inherits System.Web.UI.Page

    Private Sub Contenido_Editor_Index_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim Usuario = Codigo.buscaNombre(User.Identity.Name)
        TituloNombreUsuario.InnerText = Usuario
    End Sub
    Protected Sub BtnSalir_Click(sender As Object, e As EventArgs) Handles BtnSalir.Click
        FormsAuthentication.SignOut()
        Response.Redirect("~/Login.aspx")
    End Sub
End Class

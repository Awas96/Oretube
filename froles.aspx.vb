
Imports System.Data

Partial Class froles
    Inherits System.Web.UI.Page
    Dim us As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        us = Context.User.Identity.Name
        If Roles.GetRolesForUser(us).Count = 0 Then
            If Not IsPostBack Then
                For Each fila As DataRow In Session("dUsuario").Rows
                    DDLroles.Items.Add(New ListItem With {.Text = fila(11), .Value = fila("rol")})
                Next
            End If
        Else
            Response.Redirect(Codigo.Redireccion(Roles.GetRolesForUser(us)(0)))
        End If
    End Sub
    Protected Sub BTempezar_Click(sender As Object, e As EventArgs) Handles BTempezar.Click
        us = Context.User.Identity.Name
        If CKcontinuar.Checked Then
            If us <> Nothing Then
                Codigo.UsuarioINrol(us, DDLroles.SelectedValue)
                Response.Redirect(Codigo.Redireccion(DDLroles.SelectedValue))
            Else
                Response.Redirect(Codigo.Redireccion(Roles.GetRolesForUser(us)(0)))
            End If
        Else
            Codigo.Salir(us, False)
        End If
    End Sub

End Class

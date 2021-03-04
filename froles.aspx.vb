
Imports System.Data

Partial Class froles
    Inherits System.Web.UI.Page
    Dim us As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        us = Context.User.Identity.Name
        If Roles.GetRolesForUser(us).Count = 0 Then

            If Not IsPostBack Then

                For Each fila As DataRow In Session("dUsuario").Rows
                    DDLroles.Items.Add(New ListItem With {.Text = fila("rol"), .Value = fila("idRol")})
                Next

            End If

        Else

            Response.Redirect(codigo.Redireccion(Roles.GetRolesForUser(us)(0)))

        End If

        us = Context.User.Identity.Name
        If CKcontinuar.Checked Then
            If us <> Nothing Then

                codigo.UsuarioINrol(us, DDLroles.SelectedValue)

                Response.Redirect(codigo.Redireccion(DDLroles.SelectedValue).ToString)
            Else
                Response.Redirect(codigo.Redireccion(Roles.GetRolesForUser(us)(0)))
            End If
        Else
            codigo.Salir(us, False)
        End If
    End Sub
End Class

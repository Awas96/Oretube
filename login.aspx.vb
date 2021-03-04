
Imports Recaptcha.Web

Partial Class login
    Inherits System.Web.UI.Page

    Dim us As Integer

    Private Sub Login_Init(sender As Object, e As EventArgs) Handles Me.Init
        TBAlias.Attributes.Add("placeholder", "Introduce tu correo electrónico")
        TBClave.Attributes.Add("placeholder", "Contraseña")

        If Request.IsAuthenticated Then
            Session("dUsuario") = Codigo.DUsuario(User.Identity.Name)
            Response.Redirect("froles.aspx") '
        End If


    End Sub





    Protected Sub OKusuario(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)


        Dim ok As Boolean = False

        Session("dUsuario") = Codigo.DUsuario(TBAlias.Text, TBClave.Text)

        If Session("dUsuario").Rows.Count > 0 And ok Then
            us = Session("dUsuario").Rows(0).item(0)


            Codigo.RemoveUsuarioyRoles(us, Roles.GetRolesForUser(us))

            args.IsValid = True


            FormsAuthentication.RedirectFromLoginPage(us, CKrecordar.Checked)
        Else
            args.IsValid = False
        End If

    End Sub


End Class

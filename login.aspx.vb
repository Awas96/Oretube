Imports Recaptcha.Web
Partial Class login
    Inherits System.Web.UI.Page

    Dim us As Integer

    Private Sub Login_Init(sender As Object, e As EventArgs) Handles Me.Init
        TBAlias.Attributes.Add("placeholder", "Introduce tu nombre de usuario")
        TBClave.Attributes.Add("placeholder", "Contraseña")

        If Request.IsAuthenticated Then
            Session("dUsuario") = Codigo.DUsuario(User.Identity.Name)
            Response.Redirect("froles.aspx")
        End If


    End Sub



    Protected Sub OKusuario(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)


        Dim ok As Boolean = False

        If String.IsNullOrEmpty(ReC.Response) Then


            lblMessage.Text = "Captcha no se debe de dejar en blanco"
        Else

            Dim result As RecaptchaVerificationResult = ReC.Verify()

            If result = RecaptchaVerificationResult.Success Then

                ok = True

            End If

            If result = RecaptchaVerificationResult.IncorrectCaptchaSolution Then

                lblMessage.Text = "Captcha no correcto"

            End If
        End If


        Session("dUsuario") = Codigo.dUsuario(TBAlias.Text, TBClave.Text)

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

<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)

        Codigo.SetRoles()

    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)

        If Request.IsAuthenticated Then
            Session("dUsuario") = Codigo.DUsuario(User.Identity.Name)
            If Session("dUsuario").Rows.Count = 0 Then
                Response.Redirect("~/login.aspx")
            End If
        End If

    End Sub
</script>
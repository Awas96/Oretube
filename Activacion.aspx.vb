
Imports System.Data.SqlClient

Partial Class Activacion
    Inherits System.Web.UI.Page

    Private Sub Activacion_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim query As String = Request.QueryString("k"
        If existe(query) Then
            'activar(query)
            Response.Write("si es")
        End If

    End Sub

    Private Function existe(ByVal key As String) As Boolean
        Dim ok As Boolean = False
        Dim cnx As New SqlConnection With {
           .ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("oretubeConnectionString").ConnectionString
    }
        Dim sentencia As String = "select count(*) from Usuario where key=@key"
        Dim cmd As New SqlCommand(sentencia, cnx)
        cmd.Parameters.AddWithValue("@key", key)

        Try
            cnx.Open()
            Dim resultado As Int32 = cmd.ExecuteScalar()
            If resultado > 0 Then ok = True
            Response.Write("Resultado = " & resultado)

        Catch ex As Exception

        Finally
            cnx.Close()
        End Try
        Return ok
    End Function

End Class

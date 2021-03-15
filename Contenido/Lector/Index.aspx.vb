
Imports System.Data.SqlClient

Partial Class Contenido_Lector_Index
    Inherits System.Web.UI.Page

    Private Sub Contenido_Lector_Index_Load(sender As Object, e As EventArgs) Handles Me.Load

    End Sub
    Private Sub Contenido_Editor_Index_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete
        fvDatosVideo.DataBind()
    End Sub







    Private Function buscaVideo(ByVal url As String) As Integer

        Dim respuesta As Integer = 0
        Dim cnx As New SqlConnection With {
           .ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("oretubeConnectionString").ConnectionString
    }
        Dim sentencia As String = "select id from video where [url] =  @url"
        Dim cmd As New SqlCommand(sentencia, cnx)
        cmd.Parameters.AddWithValue("@url", url)

        Try
            cnx.Open()
            Dim resultado As String = cmd.ExecuteScalar()
            If resultado <> Nothing Then respuesta = resultado

        Catch ex As Exception

        Finally
            cnx.Close()
        End Try
        Return respuesta
    End Function


    Protected Sub imgBtNoLikes_Click(sender As Object, e As EventArgs)
        darlikes(0)
    End Sub
    Protected Sub imgBtLikes_Click(sender As Object, e As EventArgs)
        darlikes(1)
    End Sub

    Private Sub darlikes(ByRef tipo As Integer)
        Dim idUsuario As Int32 = Session("dUsuario").Rows.Item(0).Item(0).ToString
        Dim urlVideo = Request.QueryString("vid")
        If urlVideo <> Nothing Then
            Dim idVideo As String = buscaVideo(urlVideo)
            Try
                Dim voto As Boolean

                Select Case tipo
                    Case 0
                        voto = False
                    Case 1
                        voto = True
                End Select

                SQLDSVotar.UpdateParameters.Item("votacion").DefaultValue = voto
                SQLDSVotar.UpdateParameters.Item("votante").DefaultValue = idUsuario
                SQLDSVotar.UpdateParameters.Item("elVideo").DefaultValue = idVideo
                SQLDSVotar.Update()
                If tipo = 0 Then

                Else

                End If
            Catch ex As Exception
                Throw (ex)
            Finally
                ActualizarVotosEnVideo(idVideo)
            End Try
        End If
    End Sub

    Private Sub ActualizarVotosEnVideo(ByVal video As Integer)
        Dim votosBuenos As Integer
        Dim votosMalos As Integer

        Dim code As New Codigo

        votosBuenos = code.BuscaVotos(video, 1)
        votosMalos = code.BuscaVotos(video, 0)


        SQLDSVotosUsuarios.UpdateParameters.Item("likes").DefaultValue = votosBuenos
        SQLDSVotosUsuarios.UpdateParameters.Item("nolikes").DefaultValue = votosMalos

        Try
            SQLDSVotosUsuarios.Update()
        Catch ex As Exception
            Throw ex
        End Try


    End Sub
    Public Function buscarLikes(ByVal tipo As Integer) As Integer
        Dim code As New Codigo
        Dim Result = code.BuscaVotosEnVideo(tipo, Request.QueryString("vid"))
        Return Result

    End Function

End Class

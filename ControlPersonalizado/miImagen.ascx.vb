
Partial Class MiImagen
    Inherits System.Web.UI.UserControl

    Protected src As String
    Protected url As String
    Public ReadOnly Property GetSrc As String
        Get
            Return src
        End Get
    End Property

    Public WriteOnly Property SetSrc As String
        Set(value As String)
            src = value
        End Set
    End Property

    Public ReadOnly Property GetUrl As String
        Get
            Return url
        End Get
    End Property
    Public WriteOnly Property SetUrl As String
        Set(value As String)
            url = value
        End Set
    End Property

    'Public Sub actualizaViews()
    '    Dim code As New Codigo
    '    Dim visitas = code.buscaVisitas(GetUrl)
    '    visitas += 1
    '    sqldsUpdateVideo.UpdateParameters.Item("url").DefaultValue = GetUrl
    '    sqldsUpdateVideo.UpdateParameters.Item("visualizacion").DefaultValue = visitas

    '    Try
    '        sqldsUpdateVideo.Update()
    '    Catch ex As Exception
    '        Throw ex
    '    End Try

    'End Sub

    Private Sub imVideo_Click(sender As Object, e As ImageClickEventArgs) Handles imVideo.Click
        'actualizaViews()
    End Sub

    Public Function construirPath(Optional ByVal rol As String = "0") As String
        Dim ruta As String = "/deposit/" & rol & "/" & src & ".png"
        Return ruta
    End Function

    Public Function aniadirRedireccion(Optional ByVal rol As String = "0") As String
        Dim ruta As String = url & "?vid=" & src
        Return ruta
    End Function
End Class

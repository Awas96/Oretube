
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

    Private Sub imVideo_Click(sender As Object, e As ImageClickEventArgs) Handles imVideo.Click

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

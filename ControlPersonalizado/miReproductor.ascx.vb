
Partial Class miReproductor
    Inherits System.Web.UI.UserControl

    Protected src As String

    Public ReadOnly Property getSrc As String
        Get
            Return src
        End Get
    End Property

    Public WriteOnly Property setSrc As String
        Set(value As String)
            src = value
        End Set
    End Property

    Public Function construirPath(Optional ByVal rol As String = "0") As String
        Dim url As String = "/deposit/" & rol & "/" & src & ".mp4#t=1"
        Return url
    End Function
End Class

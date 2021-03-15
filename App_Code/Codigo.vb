Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic

Public Class Codigo

    ' Sobrecarga(1) de dUsuario, para obtener el DataTable con todos los datos del usuario a partir de su email y el password.
    Public Shared Function dUsuario(ByVal usuario As String, ByVal clave As String) As DataTable
        Dim sentencia As String = "select Usuario.*, Rol.* from (Usuario join Rol on Usuario.rol=Rol.id) where Usuario.email= @email or Usuario.login= @login and Usuario.password= @password and activado=1"

        Dim cmd As New SqlCommand(sentencia)
        cmd.Parameters.Add("@login", SqlDbType.VarChar, 80).Value = usuario
        cmd.Parameters.Add("@email", SqlDbType.VarChar, 80).Value = usuario
        cmd.Parameters.Add("@password", SqlDbType.VarChar, 15).Value = clave
        Return ExecCMD(cmd)
    End Function

    ' Sobrecarga(2) de dUsuario, para obtener el DataTable con todos los datos del usuario a partir del idUsuario.
    Public Shared Function dUsuario(ByVal idusuario As Int32) As DataTable
        Dim sentencia As String = "select Usuario.*, Rol.* from (Usuario join Rol on Usuario.rol=Rol.id) where Usuario.id= @idUsuario and activado=1"
        Dim cmd As New SqlCommand(sentencia)
        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idusuario
        Return ExecCMD(cmd)
    End Function
    Public Shared Function ExecCMD(ByVal cmd As SqlCommand) As DataTable

        Dim cnx As New SqlConnection With {
            .ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("oretubeConnectionString").ConnectionString
        }
        cmd.Connection = cnx
        Dim dt As New DataTable
        Try
            Dim adt As New SqlDataAdapter(cmd)
            adt.Fill(dt)
        Catch ex As SystemException
            dt = Nothing
            Throw New System.Exception(ex.Message)
        Finally
            cnx.Close()
            cnx.Dispose()
        End Try
        Return dt
    End Function
    Public Shared Sub SetRoles()

        Dim cnx As New SqlConnection With {
            .ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("oretubeConnectionString").ConnectionString
        }
        Dim sentencia As String = "SELECT id FROM Rol"

        Dim dr As SqlDataReader
        Try
            Dim cmd As New SqlCommand(sentencia, cnx)
            cnx.Open()
            dr = cmd.ExecuteReader()
            While dr.Read
                If Not Roles.RoleExists(dr.GetByte(0)) Then Roles.CreateRole(dr.GetByte(0))
            End While
        Catch ex As SystemException
            Throw New System.Exception(ex.Message)
        Finally
            cnx.Close()
            cnx.Dispose()
        End Try
    End Sub

    Public Shared Function UsuarioINrol(ByVal usuario As String, ByVal rol As String) As Boolean

        Dim ok As Boolean = True
        Try
            If Not My.User.IsInRole(rol) Then Roles.AddUserToRole(usuario, rol)
        Catch ex As Exception
            ok = False
        End Try
        Return ok
    End Function

    Public Shared Function RemoveUsuarioyRoles(ByVal usuario As String, ByVal _roles() As String) As Boolean
        Dim ok As Boolean = True
        Try
            Roles.RemoveUserFromRoles(usuario, _roles)
            Membership.DeleteUser(usuario)
        Catch ex As Exception
            ok = False
        End Try
        Return ok
    End Function

    Public Shared Sub Salir(ByVal usuario As String, ByVal mismaCuenta As Boolean)

        Codigo.RemoveUsuarioyRoles(usuario, Roles.GetRolesForUser(usuario))

        If Not mismaCuenta Then

            FormsAuthentication.SignOut()
        End If
        HttpContext.Current.Session.Clear()
        HttpContext.Current.Session.Abandon()


        FormsAuthentication.RedirectToLoginPage()
    End Sub

    Public Shared Function Redireccion(ByVal funcion As String) As String
        Dim pagina As String = Nothing

        Select Case funcion
            Case 0
                pagina = "Contenido" & "/" & "Registrado" & "/" & "index.aspx"
            Case 1
                pagina = "Contenido" & "/" & "Lector" & "/" & "index.aspx"
            Case 2
                pagina = "Contenido" & "/" & "Editor" & "/" & "index.aspx"

        End Select
        Return pagina
    End Function
    Public Shared Function buscaNombre(ByRef idus As Integer) As String

        Dim cnx As New SqlConnection With {
            .ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("oretubeConnectionString").ConnectionString
        }
        Dim sentencia As String = "SELECT login FROM Usuario WHERE id = " & idus
        Dim cmd As SqlCommand = New SqlCommand(sentencia, cnx)
        Dim nombre As String = ""


        Try
            cnx.Open()
            nombre = cmd.ExecuteScalar()
        Catch ex As Exception

        End Try
        cnx.Close()

        Return nombre
    End Function
    Public Function BuscaVotos(ByVal id As String, voto As Integer) As Integer
        Dim respuesta = 0

        Dim cnx As New SqlConnection With {
           .ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("oretubeConnectionString").ConnectionString
    }
        Dim sentencia As String = "select Count(*) from voto where elVideo=@id AND votacion=@voto"
        Dim cmd As New SqlCommand(sentencia, cnx)
        cmd.Parameters.AddWithValue("@id", id)
        cmd.Parameters.AddWithValue("@voto", voto)

        Try
            cnx.Open()
            Dim resultado As String = cmd.ExecuteScalar()
            If String.IsNullOrEmpty(resultado) Then respuesta = 0 Else respuesta = resultado

        Catch ex As Exception
            Throw ex
        Finally
            cnx.Close()
        End Try
        Return respuesta
    End Function
    Public Function BuscaVotosEnVideo(tipo As Integer, vid As String) As Integer
        Dim respuesta = 0
        If vid = Nothing Then
            Return Nothing
        End If
        Dim sentencia = ""
        Dim cnx As New SqlConnection With {
           .ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("oretubeConnectionString").ConnectionString
    }
        If tipo = 0 Then
            sentencia = "select nolikes from video where url=@vid"
        Else
            sentencia = "select likes from video where url=@vid"
        End If

        Dim cmd As New SqlCommand(sentencia, cnx)
        cmd.Parameters.AddWithValue("@vid", vid)


        Try
            cnx.Open()
            Dim resultado As String = cmd.ExecuteScalar()
            If String.IsNullOrEmpty(resultado) Then respuesta = Nothing Else respuesta = resultado

        Catch ex As Exception
            Throw ex
        Finally
            cnx.Close()
        End Try
        Return respuesta
    End Function

    'Public Function buscaVisitas(ByVal url As String) As Integer
    '    Dim respuesta = 0
    '    Dim sentencia As String
    '    Dim cnx As New SqlConnection With {
    '       .ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("oretubeConnectionString").ConnectionString
    '}
    '    sentencia = "select visitas from video where url=@url"
    '    Dim cmd As New SqlCommand(sentencia, cnx)
    '    cmd.Parameters.AddWithValue("@url", url)

    '    Try
    '        cnx.Open()
    '        Dim resultado As String = cmd.ExecuteScalar()
    '        If String.IsNullOrEmpty(resultado) Then respuesta = 0 Else respuesta = resultado

    '    Catch ex As Exception
    '        Throw ex
    '    Finally
    '        cnx.Close()
    '    End Try
    '    Return respuesta
    'End Function

End Class

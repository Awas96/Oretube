Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic

Public Class Codigo
    Public Shared Function DUsuario(ByVal usuario As String, ByVal clave As String) As DataTable
        Dim sentencia As String = "SELECT Usuario.* WHERE Usuario.login=@login AND Usuario.password=@password"
        Dim cmd As New SqlCommand(sentencia)
        cmd.Parameters.Add("@login", SqlDbType.VarChar, 256).Value = usuario
        cmd.Parameters.Add("@password", SqlDbType.VarChar, 256).Value = clave
        Return ExecCMD(cmd)
    End Function
    Public Shared Function DUsuario(ByVal idusuario As Integer) As DataTable
        Dim sentencia As String = "SELECT Usuario.* WHERE id=@id"
        Dim cmd As New SqlCommand(sentencia)
        cmd.Parameters.Add("@id", SqlDbType.Int).Value = idusuario
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

    Public Shared Function RemoveUsuarioyRoles(ByVal usuario As String, ByVal _Rol() As String) As Boolean
        Dim ok As Boolean = True
        Try
            Roles.RemoveUserFromRoles(usuario, _Rol)
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
            Case 1
                pagina = "Contenido" & "/" & "Administrador" & "/" & "index.aspx"
            Case 2
                pagina = "Contenido" & "/" & "Gestor" & "/" & "index.aspx"
            Case 3
                pagina = "Contenido" & "/" & "Usuario" & "/" & "index.aspx"

        End Select
        Return pagina
    End Function

    Public Shared Function buscaNombre(ByRef idus As Integer) As String
        Dim cnx As SqlConnection = New SqlConnection("Data Source=(local);Initial Catalog=SistemaDeRanking;Integrated Security=SSPI;")
        Dim sentencia As String = "SELECT alias FROM Usuario WHERE id = " & idus
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



End Class

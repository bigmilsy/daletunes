<%-- 
    Document   : dirs
    Created on : 09/06/2019, 9:24:41 PM
    Author     : dmiller
--%>

<%@page import="javax.swing.filechooser.FileSystemView"%>
<%@page import="java.nio.file.Paths"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%=Paths.get("").toAbsolutePath().toString()%><br />
<%=System.getProperty("user.home")%><br />
<%=FileSystemView.getFileSystemView().getHomeDirectory()%><br />
<%=System.getProperty("user.dir")%><br />

    </body>
</html>

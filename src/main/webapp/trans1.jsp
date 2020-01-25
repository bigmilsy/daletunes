<%-- 
    Document   : trans1
    Created on : 06/11/2019, 11:22:20 PM
    Author     : dmiller
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.daletunes.Entry"%>
<%@page import="com.daletunes.DB"%>
<%@page import="com.daletunes.FileIO"%>
<%
FileIO fileIO = new FileIO();
DB.Tracks oldTracks = fileIO.getTracks();
DB.TrackV2 newTracks = new DB.TrackV2(oldTracks);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OK</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.daletunes.Entry"%>
<%@page import="com.daletunes.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%><%
Enumeration en = request.getParameterNames();
HashMap<String, String> pars = new HashMap<String, String>();

// enumerate through the keys and extract the values 
// from the keys! 
while (en.hasMoreElements()) {
    String parameterName = (String) en.nextElement();
    String parameterValue = request.getParameter(parameterName);
    pars.put(parameterName, parameterValue);
}
String command = (String)pars.get("command");
Entry entry = new Entry();
if (command.equals("getTracks")) {
  %><%=entry.getTracks(pars, request)%><%
} else if (command.equals("addTrackFromSearch")) {
  %><%=entry.addTrack(pars, request)%><%    
} else if (command.equals("deleteTrack")) {
  %><%=entry.deleteTrack(pars, request)%><%    
} else if (command.equals("editTrack")) {
  %><%=entry.editTrack(pars, request)%><%    
}%>
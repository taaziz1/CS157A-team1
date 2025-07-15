<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%
    // Invalidate the session and redirect to index.jsp
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
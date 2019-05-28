<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.InputStream"%>    
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Spring Boot Vaadin Template - Application Version Information Page</title>
</head>
<body bgcolor="#FFFFFF">
	<h2>--</h2>
<%

	try {
		InputStream in1 = config.getServletContext().getResourceAsStream("META-INF/MANIFEST.MF");
		int ch;
		boolean newline = false;
		boolean printChar = true;
		
		out.print("<h2>Application Info</h2>");
		out.print("<table cellpadding = 5>");
		out.print("<tr bgcolor=#ccccff><td><font color = #222299>");
		
		while((ch = in1.read()) != -1) {
			
			if(ch == '\r') {
				continue;
			}
			
			if(ch == '\n') {
				if(!newline) {
					newline = true;
					continue;
				}
			}
			
			if(ch == ' ' && newline) {
				printChar = false;
				newline = false;
			} else if(newline) {
				out.print("</td></tr>");
				out.print("\n");
				out.print("<tr bgcolor = #ccccff><td><font color = #222299>");
				newline = false;
			}
			
			if(ch == ':') {
				out.print("</font></td><td> &nbsp;");
				printChar = false;
			}
			
			if(printChar) {
				out.print((char)ch);
			} else {
				printChar = true;
			}
		}
		
		out.print("</td></tr>");
		out.print("\n");
		out.print("</table><br>");
	} catch (Throwable t) {
		out.print(t);
	}
%>	
</body>
</html>
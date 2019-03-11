<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.sun.xml.internal.bind.CycleRecoverable.Context"%>
<HTML>
	<head>
		<title>Application Version Information Page</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	</head>
	<BODY bgcolor="#FFFFFF">
		<% try {
			java.io.InputStream in1 = config.getServletContext().getResourceAsStream("META-INF/MANIFEST.MF");
			int ch;
			boolean newline = false;
			boolean printChar = true;

			out.print("<H2>Application Info</H2>");
			out.print("<TABLE  CELLPADDING = 5>");
			out.print("<TR BGCOLOR=#ccccff><TD><FONT COLOR = #222299>");

			while ((ch = in1.read()) != -1) {
				// control empty lines
				if (ch == '\r'){
					continue;
				}

				if (ch == '\n') {
					if (!newline) {
						newline = true; // potentially a new tag
						continue;
					}
				}

				// control content
				if (ch == ' ' && newline) { // do not print first blank char. It is a continuation of a value field
					printChar = false;
					newline = false; // value field continuation. Not a new tag
				} else if (newline) {
					out.print("</TD></TR>");
					out.print("\n");

					out.print("<TR BGCOLOR=#ccccff><TD><FONT COLOR = #222299>");
					newline = false;
				}
				if (ch == ':') { // do not print ':'
					out.print("</FONT></TD><TD> &nbsp;");
					printChar = false;
				}

				// print content
				if (printChar) {
					out.print((char) ch);
				} else {
					printChar = true;
				}
			}
			out.print("</TD></TR>");
			out.print("\n");
			out.print("</TABLE>");
		} catch (Throwable t) {
			out.print(t);
		}
		%>
	</BODY>
</HTML>
<%@page import="jsp.*,java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		int key = 0;
		String sessionID = null;
		session = request.getSession(false);
		System.out.println("User=" + session.getAttribute("user"));
		if (session != null) {
			System.out.println("session invalidated");
			session.invalidate();

		}
		
		response.sendRedirect("index.jsp");
	%>

</body>
</html>
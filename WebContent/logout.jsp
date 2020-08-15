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
		Cookie[] cookies = request.getCookies();
		Cookie loginCookie = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("loginindex")) {
					loginCookie = cookie;
					key = Integer.parseInt(cookie.getValue());
					break;
				}
			}
			for (Cookie cooki : cookies) {
				if (cooki.getName().equals("JSESSIONID")) {
					sessionID = cooki.getValue();
					System.out.println("JSESSIONID=" + sessionID);
					break;
				}
			}
		}

		session = request.getSession(false);
		System.out.println("User=" + session.getAttribute("user"));
		if (session != null) {
			System.out.println("loginindex="+key);
			Session.setlastSessionId(null, key);
			System.out.println("session invalidated");
			session.invalidate();

		}
		if (loginCookie != null) {
			loginCookie.setMaxAge(0);
			response.addCookie(loginCookie);
		}

		response.sendRedirect("index.jsp");
	%>

</body>
</html>
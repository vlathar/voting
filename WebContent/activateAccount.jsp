<%@ page import="jsp.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account</title>
</head>
<body>
<%
	String signupdetails = (String)session.getAttribute("signupdetails");
	String myHash = (String)session.getAttribute("hash");
	String hash = request.getParameter("otp");
	if(hash.equals(myHash)){
		String arr[] = signupdetails.split(":");
		String rollno = arr[0];
		String name = arr[1];
		String cgpa = arr[2];
		String batch = arr[3];
		String gender = arr[4];
		String email = arr[5];
		String mobile = arr[6];
		String password = arr[7];
		if(Signup.signupuser(rollno, name, cgpa, batch, gender, email, mobile, password)){
			response.sendRedirect("index.jsp");
		}
		else{
			response.sendRedirect("error.jsp");
		}
	}
%>
</body>
</html>
  
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@page import="jsp.*,java.sql.*,java.util.*,java.io.*"%>
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
	
	try{
	String email = null;
	String phoneno = null;
	String agenda = null; 
	
		 
		M_CandidatePortfolio CP = new M_CandidatePortfolio();
		if(session.getAttribute("fname").equals("view_candidate_portfolio")){
			String val = (String)session.getAttribute("details");
			String arr[] = val.split(":");
			String rollno = arr[0],EventName = arr[1];
			if(CP.deleteCN(rollno, EventName)){
				response.sendRedirect("ceo.jsp");
			}	
		}
	}
	catch(Exception e){
		System.out.println("error at C_candidate.jsp");
		e.printStackTrace();
	}
		
	%>


</body>
</html>
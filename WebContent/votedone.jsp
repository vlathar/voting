<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Voting</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
<script src="js/jquery.min.js"></script>
<script src="js/jquery.dropotron.min.js"></script>
<script src="js/jquery.scrolly.min.js"></script>
<script src="js/jquery.scrollgress.min.js"></script>
<script src="js/skel.min.js"></script>
<script src="js/skel-layers.min.js"></script>
<script src="js/init.js"></script>

	<link rel="stylesheet" href="css/skel.css" />
	<link rel="stylesheet" href="css/style.css" />
	<link rel="stylesheet" href="css/style-wide.css" />
	<link rel="stylesheet" href="css/style-noscript.css" />

</head>
<body>
<% 
		HttpSession session2 = request.getSession(false);
		if(Session.MultipleSessionCheck((String)session2.getAttribute("user"),(String)session2.getId())==true)
		{
			System.out.println("different session--2");
			response.sendRedirect("index.jsp");
			return;
		}
		try{
		String EName= request.getParameter("EName");
		String loggedinuser= (String) session.getAttribute("user");
		String[] candroll= request.getParameterValues("candroll");
		M_ElectionEvent EE= new M_ElectionEvent();
		if(EE.setVotedone(loggedinuser,EName,candroll)==true)
		{
			response.sendRedirect("success_voting.jsp");
			return;
		}
		else
		{
			response.sendRedirect("C_msg.jsp");
			return;
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
%>

</body>
</html>
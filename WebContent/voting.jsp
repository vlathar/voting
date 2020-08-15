<%@page import="jsp.*,java.sql.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!String username = "Username";
	String password = "Password";
	String message = "none";%>
	<%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		System.out.println(username);
		System.out.println(password);

		try {
			if (Voter.validate(username, password)) {

				message = "User login successfully ";

				session = request.getSession();
				String rollno = (String) session.getAttribute("user");
				System.out.println("session invalidated");
				session.invalidate();
				session = request.getSession();
				M_ElectionEvent EE = new M_ElectionEvent();

				if (EE.hasVoted(rollno)) {
					response.sendRedirect("index.jsp");
				}
				session.setMaxInactiveInterval(1800);
				String value = Integer
						.toString((int) (Math.random() * 2000));
				System.out.println("Random index = " + value);
				Cookie loginCookie = new Cookie("loginindex", value);
				Session.setlastSessionId("first", Integer.parseInt(value));
				loginCookie.setMaxAge(1800);
				response.addCookie(loginCookie);

				int currentee = EE.getCurrentEE();
				System.out.println(currentee);
				ArrayList<String> positions = new ArrayList<String>();
				if (currentee != -1) {

					positions = EE.getPositions(currentee);
					EE.setVotedone(rollno);
					System.out.println(positions.get(0));
				}

				ArrayList<String> candidates = new ArrayList<String>();
				session.setAttribute("positions", positions);
				session.setAttribute("rollno", rollno);
				session.setAttribute("eid",currentee);
				M_CandidatePortfolio CP= new M_CandidatePortfolio();
				M_CandidatureApplication CA = new M_CandidatureApplication();
				int batch = CA.getBatch(rollno);
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}

			}

			else {
				if (username == "" || password == ""
						|| (username == "" && password == "")) {
					message = "fields are empty";
					response.sendRedirect("Voting_terminal_login.jsp?error="
							+ message);
				} else {
					message = "No user or password matched";
					response.sendRedirect("error_terminal.jsp.jsp?error="
							+ message);
				}
			}

		} catch (Exception e) {

		}
	%>

</body>
</html>
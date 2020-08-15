<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>
<!--
AUTHOR                   : LNMIIT_ONLINE_VOTING_SYSTEM_TEAM
LAST MODIFIED DATE       : 17-APRIL-2015
-->
<%@page import="jsp.*,java.sql.*,java.util.*,java.text.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML>
<html>
<head>
<title>RESULTS</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
<script type="text/javascript" src="../1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="../1.8.11/jquery-ui.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- <script src="js/jquery.min.js"></script>-->
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
<link
	href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
	rel="stylesheet">


<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->
<style type="text/css">
#nav ul li {
	color: black;
}

.contact {
	background-color: #000;
	background: url("../images/LNMIIT-contact.jpg");
	background-position: center;
	background-repeat: no-repeat;
	background-size: 75em, 60em, auto, cover;
}
</style>
<script type="text/javascript">
	function FormValidate()
	{
		//validation if Required
	}
</script>

</head>
<body class="contact">
	<% 
		session.setAttribute("fname", "view_applications");
	String sessionID = null;
	int loginindex = 0;
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cooki : cookies) {
			if (cooki.getName().equals("JSESSIONID")) {
				sessionID = cooki.getValue();
				System.out.println("JSESSIONID=" + sessionID);
				break;
			}

		}
		for (Cookie cooki : cookies) {
			if (cooki.getName().equals("loginindex")) {
				loginindex = Integer.parseInt(cooki.getValue());
				System.out.println("loginindex=" + loginindex);
				break;
			}

		}
	}

	if (!Session.isSameSession(sessionID, loginindex)) {
		response.sendRedirect("index.jsp");
		System.out.println("different session");

	}


	%>

	<!-- Header -->
	<header id="header" class="alt">
		<h1 id="logo">
			<a href="http://www.lnmiit.ac.in"><img
				src="images/LNMIIT_logo.png" width="200px" height="100px"></a>
		</h1>
		<nav id="nav">
			<ul>
				<li><a href="index.jsp">Welcome</a></li>
				<li><a href="">Election Rules</a></li>
				<li><a href="">Help Page</a></li>
				<li><a href="contact.jsp">Contact Us</a></li>
				<li><a href="logout.jsp" class="button special">LOGOUT</a></li>
			</ul>
		</nav>
	</header>

	<!-- Main -->
	<article id="main">

		<header class="container">
			<!-- <span class="icon fa-envelope"></span>-->
			<h2 align="center">RESULTS</h2>
			<p></p>
		</header>

		<!-- One -->
		<section class="wrapper style4 special container 75%">

			<!-- Content -->
			<div class="content">
					<div class="row 50%">
						<!--class= 6u 12u(mobile) -->
						<div class="12u">
							

								<%!ArrayList<String> ApplicantsAdded = new ArrayList<String>();%>
								<%
									try 
									{
										ApplicantsAdded = (ArrayList<String>) (session.getAttribute("aprollno"));
										for (int i = 0; i < ApplicantsAdded.size(); i++)
										{
											String val = ApplicantsAdded.get(i);
								%>
											
											 <div class="content" align="center">
													<div class="row">
														<div class="coloumn" style="margin :40px;">	
															NAME: <p><%=val%></p>
														</div>	
														<div class="coloumn" style="margin :60px;">	
															POSITION: <p><%=val%></p>
														</div>
														<div class="coloumn" style="margin :60px;">														
															POINTS: <p><%=val%></p>
														</div>
													</div>
												</div>
											 	
								<%}
									} 
									catch (Exception e) 
									{
										e.printStackTrace();
									}
								%>
						</div>
					</div>
					
					</div>
					<br/><input type="button" width=100 name="BACK" value="BACK" id="viewtoceo" onclick="window.location = 'ceo.jsp';"/>

		</section>

	</article>

	<!-- Footer -->
	<footer id="footer">

		<ul class="icons">
			<li><a href="#" class="icon circle fa-twitter"><span
					class="label">Twitter</span></a></li>
			<li><a href="#" class="icon circle fa-facebook"><span
					class="label">Facebook</span></a></li>
			<li><a href="#" class="icon circle fa-google-plus"><span
					class="label">Google+</span></a></li>
			<li><a href="#" class="icon circle fa-github"><span
					class="label">Github</span></a></li>
			<li><a href="#" class="icon circle fa-dribbble"><span
					class="label">Dribbble</span></a></li>
		</ul>

		<ul class="copyright">
			<li>&copy; SEPM-GROUP 26</li>
		</ul>

	</footer>

</body>
</html>

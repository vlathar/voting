<%@page import="jsp.*,java.util.*, java.sql.*"%>
<%@ include file="noCache.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Apply for Candidature- MBM_ONLINE_VOTING_PORTAL</title>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
	background: url("../images/MBM-contact.jpg");
	background-position: center;
	background-repeat: no-repeat;
	background-size: 75em, 60em, auto, cover;
}
</style>
</head>
<body class="contact">
	<%
		HttpSession session2 = request.getSession(false);
		if(Session.MultipleSessionCheck((String)session2.getAttribute("user"),(String)session2.getId())==true)
		{
			System.out.println("different session--2");
			response.sendRedirect("index.jsp");
			return;
		}
		M_CandidatureApplication CA = new M_CandidatureApplication();
		String batch = CA.getBatch((String) (session.getAttribute("user")));
		session.setAttribute("fname", "apply");
		String EventName=request.getParameter("electionevent");
		session.setAttribute("EventName",EventName);
	%>

	<!-- Header -->
	<header id="header" class="alt">
		<h1 id="logo">
			<a href="http://www.mbm.ac.in"><img
				src="images/mbm-logo.png" width="100px" height="100px"></a>
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
			<h2 align="center">APPLY FOR CANDIDATURE</h2>
			<p></p>
		</header>

		<!-- One -->
		<section class="wrapper style4 special container 75%">

			<!-- Content -->
			<div class="content">
				<form name="form" action="C_msg.jsp" method="post">
					<div class="row">
						<div class="12u">
							Choose An Event: <input type="text" name="electionevent" readonly value="<%=EventName%>" />		  
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							Position Applying For: <select id="position" name="position">
								<option disabled="">Select Position</option>
								<%!ArrayList<String> Positions = new ArrayList<String>();%>
								<%
									M_ElectionEvent EE1= new M_ElectionEvent();
									int x=EE1.getEEId((request.getParameter("electionevent")));
									Positions = (ArrayList<String>) (EE1.getPositions(x));
									for (int i = 0; i < Positions.size(); i++) {
										String val = Positions.get(i);
										
								%>
								<option value ="<%=val%>"><%=val%></option>
								<%
					                }
								%>
							</select>
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<input type="text" id="agenda" name="agenda" placeholder="Election Agenda" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<input type="text" id="points" name="points" placeholder="Main Points/Issues" />
						</div>
					</div>
					<div class="row">
						<div class="12u">
							<ul class="buttons">
								<li><input type="submit" class="special" value="Apply" /></li>
							</ul>
						</div>
					</div>
				</form>
			</div>

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


	</footer>

</body>
</html>
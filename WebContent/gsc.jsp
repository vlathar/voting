<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>
<!--
AUTHOR                   : LNMIIT_ONLINE_VOTING_SYSTEM_TEAM
LAST MODIFIED DATE       : 7-MAY-2015
-->
<%@page import="jsp.*,java.sql.*,java.util.*,java.text.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML>
<html>
<head>
<title>G. Sec. Cultural-VOTING - LNMIIT_ONLINE_VOTING_PORTAL</title>
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

	function checkForm() {
		
		//VALIDATE
	}
</script>
<!-- <script>
	$(function() {
		$('#date').datepicker(
				{
					onSelect : function(dateText, inst) {
						//Get today's date at midnight
						var today = new Date();
						today = Date.parse(today.getMonth() + 1 + '/'
								+ today.getDate() + '/' + today.getFullYear());
						//Get the selected date (also at midnight)
						var selDate = Date.parse(dateText);

						if (selDate < today) {
							//If the selected date was before today, continue to show the datepicker
							$('#date').val('');
							$(inst).datepicker('show');
						}
					}
				});
	});
</script> -->

</head>
<body class="contact">
	<%
		
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

	session.setAttribute("fname", "GSC");

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
			<h2 align="center">VOTING FOR GENERAL SECRETARY CULTURAL</h2>
			<p></p>
		</header>

		<!-- One -->
		<section class="wrapper style4 special container 75%">

			<!-- Content -->
			<div class="content">
				<form name="form" action="C_candidate.jsp" method="post">
					<div class="row">
						<!--class= 6u 12u(mobile) -->
						<div class="12u">
							<b>PREFERENCE 1 :</b><select id="electionevent" name="pref1">
								<option value="0">Choose a unique value in all three preferences</option>

								<%!ArrayList<String> EventsAdded1 = new ArrayList<String>();%>
								<%
									try {
										EventsAdded1 = (ArrayList<String>) (session.getAttribute("EventsAdded"));
										for (int i = 0; i < EventsAdded1.size(); i++) {
											String val = EventsAdded1.get(i);
								%>
								<option value="<%=val%>"><%=val%></option>
								<%
									}
									} catch (Exception e) {
										e.printStackTrace();
									}
								%>
							</select>
							<br/>
							<b>PREFERENCE 2 :</b><select id="electionevent" name="pref2">
								<option value="0">Choose a unique value in all three preferences</option>

								<%!ArrayList<String> EventsAdded2 = new ArrayList<String>();%>
								<%
									try {
										EventsAdded2 = (ArrayList<String>) (session.getAttribute("EventsAdded"));
										for (int i = 0; i < EventsAdded2.size(); i++) {
											String val = EventsAdded2.get(i);
								%>
								<option value="<%=val%>"><%=val%></option>
								<%
									}
									} catch (Exception e) {
										e.printStackTrace();
									}
								%>
							</select>
							<br/>
							<b>PREFERENCE 3 :</b><select id="electionevent" name="pref3">
								<option value="0">Choose a unique value in all three preferences</option>

								<%!ArrayList<String> EventsAdded3 = new ArrayList<String>();%>
								<%
									try {
										EventsAdded3 = (ArrayList<String>) (session.getAttribute("EventsAdded"));
										for (int i = 0; i < EventsAdded3.size(); i++) {
											String val = EventsAdded3.get(i);
								%>
								<option value="<%=val%>"><%=val%></option>
								<%
									}
									} catch (Exception e) {
										e.printStackTrace();
									}
								%>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="12u">
							<ul class="buttons">
								<li><input type="submit" class="special"
									value="Submit" onclick="checkForm()"/></li>
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

		<ul class="copyright">
			<li>&copy; SEPM-GROUP 26</li>
		</ul>

	</footer>

</body>
</html>

<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>
<!--
AUTHOR                   : LNMIIT_ONLINE_VOTING_SYSTEM_TEAM
LAST MODIFIED DATE       : 17-APRIL-2015
-->

<!DOCTYPE HTML>
<html>
<head>
<title>Apply for Candidature- LNMIIT_ONLINE_VOTING_PORTAL</title>
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
		 
		 if(document.form.name.value == "")
			 {
			 	alert("Please Enter a valid name");
			 	document.form.name.focus();
				return false;	
			 }
		 if(document.form.email.value == "")
		 {
		 	alert("Please Enter Email ID");
		 	document.form.email.focus();
			return false;	
		 }
		
		 if(document.form.electionevent.value == "0")
			{
				alert (" Please Choose an Event ");
				document.form.electionevent.focus();
				return false;
			}
		//check for CGPA
		double valu = document.getElementById("cgpa");
		if (valu > 10 || valu < 0) {
			alert("Invalid Input");
		}
		if(document.form.cgpa.value="")
			{
				alert(" Please Choose an Event ");
				document.form.cgpa.focus();
				return false;
			}
	}
</script>

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
		int batch = CA.getBatch((String) (session.getAttribute("user")));
		session.setAttribute("fname", "apply");
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
			<h2 align="center">APPLY FOR CANDIDATURE</h2>
			<p></p>
		</header>

		<!-- One -->
		<section class="wrapper style4 special container 75%">

			<!-- Content -->
			<div class="content">
				<form name="form" action="C_msg.jsp" method="post">
					<div class="row 50%">
						<!--class= 6u 12u(mobile) -->
						<div class="12u">
							<input type="text" id="name" name="name" placeholder="NAME" />
						</div>
					</div>
					<!-- <div class="row 50%">
						<div class="12u">
							<input type="text"  name="Roll_no" value="Roll No."
								placeholder="Roll No." />
						</div>
					</div> -->
					<div class="row 50%">
						<div class="12u">
							<input type="email" id="email" name="email" placeholder="Email : format --> abc@xyz.com" />
						</div>
					</div>
					<div class="row">
						<div class="12u">
							Choose An Event: <select  id="electionevent" name="electionevent">
									<option value="0">Choose An Event</option>
	
									<%!ArrayList<String> EventsAdded = new ArrayList<String>();%>
									<%
										try {
											EventsAdded = (ArrayList<String>) (session.getAttribute("EventsAdded"));
											for (int i = 0; i < EventsAdded.size(); i++) {
												String val = EventsAdded.get(i);
									%>
									<option value="<%=val%>"><%=val%></option>
									<%
										}
										} catch (Exception e) {
											e.printStackTrace();
										}
									%>
								</select>
								
								  Gender: 
								<select id="gender" name="gender">
									<option value="M">Male</option>
									<option value="F">Female</option>
								</select>
						</div>
					</div>

					<div class="row 50%">
						<div class="12u">
							<input type="text" id="cgpa" name="cgpa" placeholder="CGPA" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<input type="text" id="phoneno" name="phoneno" placeholder="Phone No" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							Position Applying For: <select id="position" name="position">
								<option value="P">President</option>
								<option value="VP">Vice-President</option>
								<option value="GSS">G.Sec. Sports</option>
								<option value="GSC">G.Sec. Cultural</option>
								<option value="GSST">G.Sec. Science and Tech.</option>
								<%
									if (batch == 1) {
								%>
								<option value="UG_Senate_First_Year">Senate First Year
									UG</option>
								<%
									} else if (batch == 2) {
								%><option value="UG_Senate_Second_Year">Senate Second
									Year UG</option>
								<%
									} else if (batch == 3) {
								%><option value="UG_Senate_Third_Year">Senate Third
									Year UG</option>
								<%
									} else if (batch == 4) {
								%><option value="UG_Senate_Fourth_Year">Senate Fourth
									Year UG</option>
								<%
									} else if (batch == 5) {
								%>

								<option value="PG">Post Graduate</option>
								<%
									} else
										System.out.println("Error options");
								%>



							</select>
						</div>
					</div>
					<div class="row">
						<div class="12u">
							<ul class="buttons">
								<li><input type="submit" class="special" value="Apply" onclick="checkForm()"/></li>
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

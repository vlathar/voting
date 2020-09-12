<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Applications_details-MBM_ONLINE_VOTING_PORTAL</title>
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
		// Validation of the form
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
		//int batch = CA.getBatch((String) (session.getAttribute("user")));
		session.setAttribute("fname", "application_detail");
		
		
		
		
		
	%>

	<!-- Header -->
	<header id="header" class="alt">
		<h2 id="logo">
			<a href="http://www.mbm.ac.in" style="font: icon;">MBM</a>
		</h2>
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
			<h2 align="center">APPLICATION DETAILS</h2>
			<p></p>
		</header>

		<!-- One -->
		<section class="wrapper style4 special container 75%">

			<!-- Content -->
			<div class="content">
			
			<%
			ArrayList<String> applicantdetails = new ArrayList<String>();
			String val = (String)session.getAttribute("details");
			String arr[] = val.split(":");
			String rollno = arr[0], eventName = arr[1];
			
			applicantdetails = CA.getAD(rollno, eventName);
				ArrayList<String> userdetails = new ArrayList<String>();
				userdetails = CA.getuserdetails(rollno);
				String electionevent = applicantdetails.get(0);
				String position= applicantdetails.get(1);
				String name=userdetails.get(0);//applicantdetails.get(2);
				String cgpa = userdetails.get(1);
				String batch = userdetails.get(2);
				String email=userdetails.get(4);//applicantdetails.get(3);
				String phoneno=userdetails.get(5);//applicantdetails.get(4);
				String gender=userdetails.get(3);//applicantdetails.get(5);
				String agenda=applicantdetails.get(2);
				String points=applicantdetails.get(3);
				//System.out.println("position in C_MSG at approve:"+position);
				val+=":"+position;
				session.setAttribute("details", val);
				
				
			%>
			
				<form action="C_msg.jsp" method="post">
					<div class="row 50%">
						<!--class= 6u 12u(mobile) -->
						<div class="12u">
							<b>NAME:</b><input type="text" name="name"  readonly value="<%=name%>"/>
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<b>EMAIL:</b><input type="email" name="email" readonly value="<%=email%>" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<b>Election Event:</b><input type="text" name="election_event" readonly value="<%=electionevent%>" />							
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<b>Gender:</b><input type="text" name="gender" readonly value="<%=gender%>" maxlength=1 />
						</div>
					</div>

					<%-- <div class="row 50%">
						<div class="12u">
							<input type="text" id="cgpa" name="cgpa" readonly value="<%=cgpa%>" />
						</div>
					</div> --%>
					<div class="row 50%">
						<div class="12u">
							<b>Phone No:</b><input type="text" name="phoneno" readonly value="<%=phoneno%>" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<b>Position:</b><input type="text" name="position" readonly value="<%=position%>" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<b>Agenda:</b><input type="text" name="agenda" readonly value="<%=agenda%>" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<b>Points:</b><input type="text" name="points" readonly value="<%=points%>" />
						</div>
					</div>
					<div class="row">
						<div class="12u">
							<div class="buttons">
								<% boolean isceo=((String)session.getAttribute("user")).equalsIgnoreCase("CEO");
							System.out.println(isceo);
							if(isceo){%>
								<div><input type="button" class="special" value="Approve" onclick="window.location.href = 'C_msg.jsp?ID=0'" /></div><br/>
								<div><input type="button" class="special" value="Reject" onclick="window.location.href = 'C_msg.jsp?ID=1'" /></div><br/>																																																																																																																																																																																					
								<div><input type="button" class="special" value="Back" onclick="window.location.href = 'view_applications.jsp'"/></div>
								<%}
								else{%>
									<div><input type="button" class="special" value="Back" onclick="window.location.href = 'view_your_ap.jsp'"/></div>
								<%}
								%>
								
							</div>
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
<%@page import="jsp.*,java.util.*,java.io.*"%>
<%@ include file="noCache.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<title>View Candidate Portfolio(Verified) | MBM_ONLINE_VOTING_PORTAL</title>
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
	background: url("../images/MBM-contact.jpg");
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
		
		//M_CandidatureApplication CA = new M_CandidatureApplication();
		//int batch = CA.getBatch((String) (session.getAttribute("user")));
		session.setAttribute("fname", "view_candidate_portfolio");	
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
			<h2 align="center">CANDIDATE PORTFOLIO</h2>
			<p></p>
		</header>

		<!-- One -->
		<section class="wrapper style4 special container 75%">

			<!-- Content -->
			<div class="content">
			
			<%
			M_CandidatePortfolio CP= new M_CandidatePortfolio();
			String val = (String)session.getAttribute("details");
			//System.out.println("details at view_cpdetails.jsp------"+val);
			session.setAttribute("details",val);
			String arr[] = val.split(":");
			String rollno = arr[0], eventName = arr[1];
			ArrayList<String> candidatedetails = new ArrayList<String>();
			session.setAttribute("rollno", rollno);	
			candidatedetails = CP.getPD(rollno,eventName);
			M_CandidatureApplication CA = new M_CandidatureApplication();
			ArrayList<String> userdetails = new ArrayList<String>();
			userdetails = CA.getuserdetails(rollno);
				String electionevent = candidatedetails.get(0);
				String position= candidatedetails.get(1);
				String name=userdetails.get(0);//applicantdetails.get(2);
				String cgpa = userdetails.get(1);
				String batch = userdetails.get(2);
				String email=userdetails.get(4);//applicantdetails.get(3);
				String phoneno=userdetails.get(5);//applicantdetails.get(4);
				String gender=userdetails.get(3);//applicantdetails.get(5);
			    String agenda= candidatedetails.get(2);
			    String points= candidatedetails.get(3);
			    //byte[] imgData=CP.getImage(rollno);
				
				
			%><%
/* <jsp:useBean id="img" class="fxs.ReadFileIntoByteArray" scope="session" />
<jsp:useBean id="photo" class="fxs.Images" scope="session" /> */
%>	
				<form action="C_candidate.jsp" method="post">
					<div class="row 50%">
						<!--class= 6u 12u(mobile) -->
						<div class="12u">
							
							<!--  images/MBM_logo2.png use this as it is wrong src to check js -->
							NAME: <input type="text" name="name"  readonly value="<%=name%>"/>
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							EMAIL: <input type="email" name="email" readonly value="<%=email%>" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							Election Event:<input type="text" name="election_event" readonly value="<%=electionevent%>" />							
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							Gender:<input type="text" name="gender" readonly value="<%=gender%>" maxlength=1 />
						</div>
					</div>

					<div class="row 50%">
						<div class="12u">
							Phone No:<input type="text" name="phoneno" readonly value="<%=phoneno%>" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							Position:<input type="text" name="position" readonly value="<%=position%>" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							Agenda:<textarea  name="Agenda" disabled><%=agenda%></textarea>
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							Points:<textarea  name="Points" disabled><%=points%></textarea>
						</div>
					</div>
					<div class="row">
						<div class="12u">
							<ul class="buttons">
							<% boolean isceo=((String)session.getAttribute("user")).equalsIgnoreCase("CEO");
							System.out.println(isceo);
							if(isceo){%>
								<li><input type="submit" class="special" value="Disqualify" /><% session.setAttribute("fname","view_candidate_portfolio"); %>
								</li>
								<li><input type="button" class="special" value="Back" onclick="window.location.href = 'ceo.jsp'" /></li> <%}
								else{%>
								<li><input type="button" class="special" value="Back" onclick="window.location.href = 'msg.jsp'" /></li><%} %>
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
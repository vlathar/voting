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
		
		//M_CandidatureApplication CA = new M_CandidatureApplication();
		//int batch = CA.getBatch((String) (session.getAttribute("user")));
		session.setAttribute("fname", "view_candidate_portfolio");
		
		String rollno = request.getParameter("rollno");
		
		
		
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
			<h2 align="center">CANDIDATE PORTFOLIO</h2>
			<p></p>
		</header>

		<!-- One -->
		<section class="wrapper style4 special container 75%">

			<!-- Content -->
			<div class="content">
			
			<%
			/* ArrayList<String> applicantdetails = new ArrayList<String>();
			applicantdetails = CA.getAD(rollno);
			session.setAttribute("rollno", rollno);	 */
			M_CandidatePortfolio CP= new M_CandidatePortfolio();
			ArrayList<String> candidatedetails = new ArrayList<String>();
			session.setAttribute("rollno", rollno);	
			candidatedetails = CP.getPD(rollno);
			
			
				String electionevent = candidatedetails.get(0);
				String position= candidatedetails.get(1);
				String name= candidatedetails.get(2);
				String email= candidatedetails.get(3);
				String phoneno= candidatedetails.get(4);
				String gender= candidatedetails.get(5);
			    String agenda= candidatedetails.get(6);
			    byte[] imgData=CP.getImage(rollno);
				
			%><%
/* <jsp:useBean id="img" class="fxs.ReadFileIntoByteArray" scope="session" />
<jsp:useBean id="photo" class="fxs.Images" scope="session" /> */


%>	
				<form action="C_candidate.jsp" method="post">
					<div class="row 50%">
						<!--class= 6u 12u(mobile) -->
						<div class="12u">
							
							<!--  images/LNMIIT_logo2.png use this as it is wrong src to check js -->
							<img alt="Image" src="" name="photo" id="picture" onerror="if (this.src != 'images/df.png' && this.attribute('src') != 'error.jpg') this.src = 'images/df.png';" width= 240 height = 230/><br/>
							<script type="text/javascript">
								var currentSrc = $('#picture').attr('src');
								if(currentSrc==null || currentSrc=="")
								{
								    $('#picture').attr('src','images/df.png');
								}
							</script>
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

		<ul class="copyright">
			<li>&copy; SEPM-GROUP 26</li>
		</ul>

	</footer>

</body>
</html>

<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>
<!DOCTYPE HTML>


<html>
<head>
<title>Student_Terminal: MBM ONLINE VOTING SYSTEM</title>
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

<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->
</head>
<body class="index">
	<%
	
		String sessionID = null;
		//String username="";
		//Cookie[] cookies = request.getCookies();
		
		HttpSession session2 = request.getSession(false);
		//username=(String)session2.getAttribute("user");
		if(Session.MultipleSessionCheck((String)session2.getAttribute("user"),(String)session2.getId())==true)
		{
			System.out.println("different session--2");
			response.sendRedirect("index.jsp");
			return;
		}
		ArrayList<String> EventsAdded = new ArrayList<String>();			
		M_ElectionEvent EE = new M_ElectionEvent();		
		EventsAdded = EE.getEE();		
		session.setAttribute("EventsAdded",EventsAdded);
		ArrayList<ArrayList<String> >rollno = new ArrayList<ArrayList<String> >();
		M_CandidatePortfolio CP = new M_CandidatePortfolio();
		rollno =CP.getCP();
		session.setAttribute("rollno",rollno);
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
				<li><a href="Manual_for_MBM_Online_Voting_System.html">Help Page</a></li>
				<li><a href="">Contact Us</a></li>
				<li><a href="logout.jsp" class="button special">LOGOUT</a></li>
			</ul>
		</nav>
	</header>

	<!-- Banner -->
	<section id="banner">
		<div class="inner">

			<header>
				<h3>
					Welcome
					<%=request.getSession(false).getAttribute("user")%></h3>
			</header>
			<br />
			<br />
			<p class="ceo_quote">
				"Elections belong to the people. It's their decision. <br />If they
				decide to turn their back on the fire <br />and burn their
				behinds,then they will just<br /> have to sit on their blisters."<br />
				<br />
			</p>
			<p class="ceo_quote">-Abraham Lincoln</p>

		</div>

	</section>
	<!--End of banner-->

	<!-- Main -->
	<article id="main">

		<header class="special container"> </header>


		<!-- CEO's Operations -->
		<section class="wrapper style3 container special">

			<header class="major">
				<h2>
					Time to <strong>Act</strong>
				</h2>
			</header>

			<div class="row">
				<div class="6u 12u(narrower)">

					<section>
						<header>
							<h3>
								<a href="apply_for_cand.jsp">APPLY FOR CANDIDATURE</a>
							</h3>
						</header>
						<p></p>
					</section>

				</div>
				<div class="6u 12u(narrower)">

					<section>
						<header>
							<h3>
								<a href="view_your_ap.jsp">VIEW YOUR APPLICATION</a>
							</h3>
						</header>
						<p></p>
					</section>

				</div>
			</div>
			<div class="row">
				<div class="6u 12u(narrower)">

					<section>
						<header>
							<h3>
								<a href="view_candidates.jsp">VIEW CANDIDATE PORTFOLIOS</a>
							</h3>
						</header>
						<p></p>
					</section>

				</div>
				<div class="6u 12u(narrower)">

					<section>
						<header>
							<h3>
								<a href="view_your_candidature.jsp">VIEW YOUR CANDIDATURES</a>
							</h3>
						</header>
						<p></p>
					</section>

				</div>
			</div>
			<div class="row">
				<div class="6u 12u(narrower)">

					<section>
						<header>
							<h3>
								<a href="#">RESULTS</a>
							</h3>
						</header>
						<p></p>
					</section>

				</div>
				
			</div>

			<footer class="major">
				<ul class="buttons">
					<li><a href="V-ShowActiveEvents.jsp" class="button">VOTING</a></li>
				</ul>
			</footer>

		</section>
		<!--END OF CEO OPERATIONS -->

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
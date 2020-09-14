<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>

<%@page import="jsp.*,java.sql.*,java.util.*,java.text.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Vote- MBM_ONLINE_VOTING_PORTAL</title>
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


</head>
<body class="contact">
	<header id="header" class="alt">
		<h2 id="logo">
			<a href="http://www.mbm.ac.in"><img
				src="images/mbm-logo.png" width="100px" height="100px"></a>
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
	<article id="main">

		<header class="container">
			<!-- <span class="icon fa-envelope"></span>-->
			<h2 align="center">View Candidates Applications</h2>
			<p></p>
		</header>

		<!-- One -->
		<section class="wrapper style4 special container 75%">

			<!-- Content -->
			<div class="content">
					<div class="row 50%">
						<!--class= 6u 12u(mobile) -->
						<div class="12u">
								<%
	HttpSession session2 = request.getSession(false);
	if(Session.MultipleSessionCheck((String)session2.getAttribute("user"),(String)session2.getId())==true)
	{
		System.out.println("different session--2");
		response.sendRedirect("index.jsp");
		return;
	}
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	DateFormat df2 = new SimpleDateFormat("HH:mm:ss");
	String dates= df.format(new java.util.Date());
	String time=df2.format(new java.util.Date());
	M_CandidatureApplication CA = new M_CandidatureApplication();
	String batch = CA.getBatch((String) (session.getAttribute("user")));
	ArrayList<String> alist=M_ElectionEvent.getEvents(batch);
	for(int i=0;i<alist.size();i++)
	{
		String datetime[]=M_ElectionEvent.getDateTime(alist.get(i));
		if((datetime[0].compareTo(dates)==0&&datetime[2].compareTo(time)>=0&&datetime[1].compareTo(time)<=0))
		{
			System.out.println(alist.get(i));
			String s=alist.get(i);
%>
<div class="content">
 			<div class="12u">
				<form action="votingpage.jsp" method="post">
					<input type="submit" width ="100" class="buttons" name="eventname" value="<%=s %>" id="application" >
				</form>
 			</div>
		</div>
<%}} %>
						</div>
					</div>
					
	</div>
		</section>

	</article>
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

<%@ include file="noCache.jsp"%>
<%@page import="jsp.*,java.util.*"%>

<!DOCTYPE HTML>
<!--

AUTHOR                      : LNMIIT_ONLINE_VOTING_SYSTEM_DEVELOPMENT_TEAM_GROUP-26 SEPM2015
DATE OF LAST UPDATE         : 17 APRIL 2015 

-->
<html>
<head>
<title>Voting Terminal | LNMIIT ONLINE VOTING SYSTEM</title>
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
<script src="js/back.js"></script>

	<link rel="stylesheet" href="css/skel.css" />
	<link rel="stylesheet" href="css/style.css" />
	<link rel="stylesheet" href="css/style-wide.css" />
	<link rel="stylesheet" href="css/style-noscript.css" />

<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->

<script>
	function validLogin(){
		if (document.form.username.value == ""){
			alert ( "Please enter Login Name Given at booth" );
			document.form.username.focus();
			return false;
		}
		if (document.form.password.value == ""){
			alert ( "Please enter password Given at booth" );
			document.form.password.focus();
			return false;
		}
	}
</script>

</head>
<body class="index">
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
		
		//M_CandidatureApplication CA = new M_CandidatureApplication();
		//int batch = CA.getBatch((String) (session.getAttribute("user")));
		session.setAttribute("fname", "voting_terminal");
		
		String rollno = (String)session.getAttribute("user");
		System.out.println(rollno);
		
		
		
	%>
	<!-- Header -->
	<header id="header" class="alt">
		<h1 id="logo">
			<a href="http://www.lnmiit.ac.in"><img
				src="images/LNMIIT_logo.png" width="200px" height="100px"></a>
		</h1>
		<nav id="nav">
			<ul>
				<li class="current"><a href="index.jsp">Welcome</a></li>
				<li><a href="">Election Rules</a></li>
				<li><a href="">Help Page</a></li>
				<li><a href="contact.jsp">Contact Us</a></li>
			</ul>
		</nav>
	</header>

	<!-- Banner -->
	<section id="banner">
		<div class="inner">

			<header>
				<h3>VOTING TERMINAL</h3>
			</header>
			<form name="form" action="voting.jsp" method="post">

				<input type="text" placeholder="Username" name="username" size="20"
					value=""><br> <input type="password"
					placeholder="Password" name="password" size="20" value=""><br>
				<input type="submit" class="buttons" name="LOG IN" value="LOG IN"
					id="login_sub" onclick="validLogin()">

			</form>

		</div>

	</section>
	<!--End of banner-->
	<section>
		<div class="content">
			<div align="center">
				<h5><b>NOTE:</b></h5>
					<ul>
						<li><b>If you logIn successfully, It will be considered that you are on the Voting Terminal .</b></li>
						<li><b>You will be allowed to vote only once.</b></li>
					</ul>
			</div>
		</div>
	</section>
	
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
			<li>&copy; SEPM-Group-26</li>
		</ul>

	</footer>
</body>
</html>
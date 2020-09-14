<%@ page import="jsp.*" %>
<%@ include file="noCache.jsp"%>
<!DOCTYPE HTML>

<html>
<head>
<title>MBM ONLINE VOTING SYSTEM</title>
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
			alert ( "Please enter Login Name." );
			document.form.username.focus();
			return false;
		}
		if (document.form.password.value == ""){
			alert ( "Please enter password." );
			document.form.password.focus();
			return false;
		}
	}
	function loginfunction(){
		var x = document.getElementById("login-form");
		var y = document.getElementById("signup-form");
		if(x.style.display == "none")
		{	x.style.display = "block"; y.style.display="none";}
		else
			x.style.display = "none";
	}
	function signupfunction(){
		var x = document.getElementById("signup-form");
		var y = document.getElementById("login-form");
		if(x.style.display == "none")
			{x.style.display = "block";
			y.style.display="none";}
		else
			{x.style.display = "none";}
	}
</script>

</head>
<body class="index">
<% 
	if((String)session.getAttribute("user")!=null){
		Session.setSession((String)session.getAttribute("user"),"0");
	}
%>
	<!-- Header -->
	<header id="header" class="alt">
		<h2 id="logo">
			<a href="http://www.mbm.ac.in"><img
				src="images/mbm-logo.png" width="100px" height="100px"></a>
		</h2>
		<nav id="nav">
			<ul>
				<li class="current"><a href="index.jsp">Welcome</a></li>
				<li><a href="Manual_for_Online_Voting_System.html">Election Rules</a></li>
				<li><a href="Manual_for_Online_Voting_System.html">Help Page</a></li>
				<li><a href="contact.jsp">Contact Us</a></li>
			</ul>
		</nav>
	</header>

	<!-- Banner -->
	<section id="banner">

		<div class="inner">

			<header>
				<h3>MBM ONLINE VOTING SYSTEM</h3>
			</header>
			<div>
				<button class="button" onclick="loginfunction()">SignIn</button>
				<button class="button" onclick="signupfunction()">Signup</button>
			</div>
			<form id="login-form" name="login-form" action="loginp.jsp" method="post" style="display:none;">
				<input type="text" placeholder="Username" name="username" size="20"value=""><br> 
				<input type="password" placeholder="Password" name="password" size="20" value=""><br>
				<input type="submit" class="buttons" name="LOG IN" value="LOG IN" id="login_sub" onclick="validLogin()">
			</form>
			<form id="signup-form" name="signup-form" action="signup.jsp" method="post" style="display:none;">
				<input type="text" placeholder="rollno" name="rollno" size="20" value="">
				<br>
				<input type="text" placeholder="name" name="name" size="20" value="">
				<br>
				<input type="text" placeholder="batch" name="batch" size="20" value="">
				<br>
				<input type="text" placeholder="gender" name="gender" size="20" value="">
				<br>
				<input type="text" placeholder="email" name="email" size="20" value="">
				<br>
				<input type="text" placeholder="mobile" name="mobile" size="20" value="">
				<br>
				<input type="text" placeholder="cgpa" name="cgpa" size="20" value="">
				<br>
				<input type="text" placeholder="password" name="password" size="20" value="">
				<input type="submit">
		    </form>

		</div>

	</section>
	<!--End of banner-->

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
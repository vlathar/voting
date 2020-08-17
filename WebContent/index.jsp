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
</script>

</head>
<body class="index">

	<!-- Header -->
	<header id="header" class="alt">
		<h1 id="logo">
			<a href="http://www.mbm.ac.in"><img
				src="images/MBM_logo.png" width="200px" height="100px"></a>
		</h1>
		<nav id="nav">
			<ul>
				<li class="current"><a href="index.jsp">Welcome</a></li>
				<li><a href="#">Election Rules</a></li>
				<li><a href="Manual_for_MBM_Online_Voting_System.html">Help Page</a></li>
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
			<form name="form" action="loginp.jsp" method="post">

				<input type="text" placeholder="Username" name="username" size="20"
					value=""><br> <input type="password"
					placeholder="Password" name="password" size="20" value=""><br>
				<input type="submit" class="buttons" name="LOG IN" value="LOG IN"
					id="login_sub" onclick="validLogin()">

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

		<ul class="copyright">
			<li>&copy; SEPM-Group-26</li>
		</ul>

	</footer>
</body>
</html>
<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>
<!--
AUTHOR                   : LNMIIT_ONLINE_VOTING_SYSTEM_TEAM
LAST MODIFIED DATE       : 17-APRIL-2015
-->

<!DOCTYPE HTML>
<html>
<head>
<title>Create Election Event- MBM_ONLINE_VOTING_PORTAL</title>
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
		 
		 if(document.form.electionevent.value == "")
			{
				alert (" please Enter Event Name ");
				document.form.electionevent.focus(); 
			}
			if(document.form.date.value == "")
			{
				/* var form = document.getElementById("form_Submit");
				form.onsubmit = function() { */
					alert (" please Enter Date ");
					document.form.date.focus();
				  return false;
				/* }
				return false; */
			}
			if(document.form.starttime.value == "")
			{
				/* var form = document.getElementById("form_Submit");
				form.onsubmit = function() { */
					alert (" please Enter Start Time ");
					document.form.starttime.focus();
				  return false;
				/* }
				return false; */
			}
			if(document.form.endtime.value == "")
			{
				/* var form = document.getElementById("form_Submit");
				form.onsubmit = function() { */
					alert (" please Enter End Time ");
					document.form.endtime.focus();
					return false;
				/* }
				return false; */
			} 

		// regular expression to match required date format
		re = /^\d{1,2}\/\d{1,2}\/\d{4}$/;

		if (document.form.date.value != '' && !document.form.date.value.match(re)) {
			alert("Invalid date format: " + document.form.date.value);
			document.form.date.focus();
			return false;
		}

		// regular expression to match required time format
		re = /^\d{1,2}:\d{1,2}:\d{1,2}$/;
		if (document.form.starttime.value != '' && !document.form.starttime.value.match(re)) {
			alert("Invalid time format: " + document.form.starttime.value);
			document.form.starttime.focus();
			return false;
		}
		// Start Time <  End Time  validation :
		if((document.form.starttime.value > document.form.endtime.value) || (document.form.endtime.value < document.form.starttime.value))
			{
				alert("Invalid input");
				document.form.starttime.focus();
				document.form.endtime.focus();
				return false;
			}
		
		alert("All input fields have been validated!");
		return true;
	}
</script>
<script>
	$(function() {
		$('#date').datepicker(
				{
					onSelect : function(dateText, inst) {
						//Get today's date at midnight
						var today = new Date();
						today = Date.parse(today.getMonth() + 1 + '/'+ today.getDate() + '/' + today.getFullYear());
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
</script>

</head>
<body class="contact">
	<%
		
	session.setAttribute("fname", "create_ee");
	HttpSession session2 = request.getSession(false);
	//System.out.println((String)session2.getAttribute("user"));
	//System.out.println(session2.getId()+" --- ");
	if(Session.MultipleSessionCheck((String)session2.getAttribute("user"),(String)session2.getId())==true)
	{
		System.out.println("different session--2");
		response.sendRedirect("index.jsp");
		return;
	}
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
			<h2 align="center">CREATE ELECTION EVENT</h2>
			<p></p>
		</header>

		<!-- One -->
		<section class="wrapper style4 special container 75%">

			<!-- Content -->
			<div class="content">
				<form name="form" action="C_ceo.jsp" method="post">
					<div class="row 50%">
						<!--class= 6u 12u(mobile) -->
						<div class="12u">
							<input type="text" id="electionevent" name="electionevent" placeholder="Event Name" value=""/>
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<input type="date" id="date" name="date" value="" placeholder="Date" />
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<input type="time" id="starttime" name="starttime"
								placeholder="Start Time 24 hr format HH:MM:SS" value=""/>
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<input type="time" id="endtime" name="endtime"
								placeholder="End Time 24 hr format HH:MM:SS" value=""/>
						</div>
					</div>
					<div class="row 50%">
						<div class="12u">
							<p>Positions:</p>
							<input type="checkbox" name="list" value="P">President<br>
							<input type="checkbox" name="list" value="VP">Vice
							President<br> <input type="checkbox" name="list" value="GSS">G.Sec
							Sports<br> <input type="checkbox" name="list" value="GSC">G.sec
							Cultural<br> <input type="checkbox" name="list" value="GSST">G.Sec
							Science and Tech.<br> <input type="checkbox" name="list"
								value="UG_Senate_Fourth_Year">Senate Fourth Year UG<br>
							<input type="checkbox" name="list" value="UG_Senate_Third_Year">Senate
							Third Year UG<br> <input type="checkbox" name="list"
								value="UG_Senate_Second_Year">Senate Second Year UG<br>
							<input type="checkbox" name="list" value="UG_Senate_First_Year">Senate
							First Year UG<br> <input type="checkbox" name="list"
								value="PG">Post Graduate<br>
						</div>
					</div>
					<div class="row">
						<div class="12u">
							<ul class="buttons">
								<li><input id="form_Submit" type="submit" class="special" value="Create" onclick="checkForm()"/></li>
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

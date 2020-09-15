<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>
<%@page import="jsp.*,java.sql.*,java.util.*,java.text.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Update Election Event- MBM_ONLINE_VOTING_PORTAL</title>
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
background: url("../images/mbm-contact.jpg");
background-position: center;
background-repeat: no-repeat;
background-size: 75em, 60em, auto, cover;
}
</style>
<script type="text/javascript">
function disableCB(){
var x=document.getElementById("AllowedCand1");
var y=document.getElementById("CB1");
var x1=document.getElementById("AllowedBatch1");
if(y.checked){
x.disabled=false;
x1.disabled=false;
}
else{
x.disabled=true;
x1.disabled=true;
}
var x3=document.getElementById("AllowedCand3");
var y3=document.getElementById("CB3");
var x33=document.getElementById("AllowedBatch3");
if(y3.checked){
x3.disabled=false;
x33.disabled=false;
}
else{
x3.disabled=true;
x33.disabled=true;
}
var x2=document.getElementById("AllowedCand2");
var y2=document.getElementById("CB2");
var x22=document.getElementById("AllowedBatch2");
if(y2.checked){
x2.disabled=false;
x22.disabled=false;
}
else{
x2.disabled=true;
x22.disabled=true;
}

}
function checkForm() {

if(document.form.electionevent.value == "0")
{
alert (" please Choose an Event ");
document.form.electionevent.focus();
return false;
}
if(document.form.date.value == "")
{
alert (" please Enter Date ");
document.form.date.focus();
return false;
}
if(document.form.starttime.value == "")
{
alert (" please Enter Start Time ");
document.form.starttime.focus();
return false;
}
if(document.form.endtime.value =="")
{
alert (" please Enter End Time ");
document.form.endtime.focus();
return false;
}

// regular expression to match required date format
re = /^\d{4}\-\d{1,2}\-\d{1,2}$/;

if (form.date.value != '' && !form.date.value.match(re)) {
alert("Invalid date format: " + form.date.value);
form.date.focus();
return false;
}

// regular expression to match required time format
/*re = /^\d{1,2}:\d{1,2}:\d{1,2}$/;

if (form.starttime.value != '' && !form.starttime.value.match(re)) {
alert("Invalid time format: " + form.starttime.value);
form.starttime.focus();
return false;
}*/

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
today = Date.parse(today.getMonth() + 1 + '/'
+ today.getDate() + '/' + today.getFullYear());
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
session.setAttribute("fname", "update_ee");
HttpSession session2 = request.getSession(false);

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
<a href="http://www.mbm.ac.in"><img
				src="images/mbm-logo.png" width="100px" height="100px"></a>
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
<h2 align="center">UPDATE ELECTION EVENT</h2>
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
<select id="electionevent" name="electionevent">
<option value="0">Choose An Event</option>

<%!ArrayList<String> EventsAdded = new ArrayList<String>();%>
<%
try {
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	DateFormat df2 = new SimpleDateFormat("HH:mm:ss");
	String dates= df.format(new java.util.Date());
	String time=df2.format(new java.util.Date());
	ArrayList<String> EventsAdded = (ArrayList<String>) (session.getAttribute("EventsAdded"));
	for (int i = 0; i < EventsAdded.size(); i++) {
	String datetime[]=M_ElectionEvent.getDateTime(EventsAdded.get(i));
	if((datetime[0].compareTo(dates)>=0)){
	String eventname=EventsAdded.get(i);
	%>
		<option value="<%=eventname%>"><%=eventname%></option>
	<%
	}
	}
	}
catch (Exception e) {
	e.printStackTrace();
}
%>
</select>
</div>
</div>
<div class="row 50%">
<div class="12u">
<input type="date" id="date" name="date" value="" placeholder="Date" />
</div>
</div>
<div class="row 50%">
<div class="12u">
<input type="text" id="starttime" name="starttime"
placeholder="Start Time 24 hr format HH:MM:SS" value=""/>
</div>
</div>
<div class="row 50%">
<div class="12u">
<input type="text" id="endtime" name="endtime"
placeholder="End Time 24 hr format HH:MM:SS" value=""/>
</div>
</div>
<div class="row 50%">
<div class="12u">
<p>Positions:</p>
<input type="checkbox" name="list" id="CB1" value="President" onclick="disableCB()" >President<br>
<div class="row 50%">
<div class="12u">
<select id="AllowedCand1" name="AllowedCand" disabled>
<option value="NULL"> Allowed Candidates</option>
<option  value="UG_Fourth_Year">UG_Fourth_Year</option>
<option  value="UG_Third_Year">UG_Third_Year</option>
<option  value="UG_Second_Year">UG_Second_Year</option>
<option  value="UG_First_Year">UG_First_Year</option>
<option  value="PG">PG</option>
<option value="All">All</option>
</select>
</div>
</div>
<div class="row 50%">
<div class="12u">
<select id="AllowedBatch1" name="AllowedBatch" disabled>
<option value="NULL"> Allowed Batch - Voting</option>
<option  value="UG_Fourth_Year">UG_Fourth_Year</option>
<option  value="UG_Third_Year">UG_Third_Year</option>
<option  value="UG_Second_Year">UG_Second_Year</option>
<option  value="UG_First_Year">UG_First_Year</option>
<option  value="PG">PG</option>
<option value="All">All</option>
</select>
</div>
</div>
<input type="checkbox" name="list" id="CB2" value="Vice-President" onclick="disableCB()" >Vice-President<br>
<div class="row 50%">
<div class="12u">
<select id="AllowedCand2" name="AllowedCand" disabled>
<option value="NULL"> Allowed Candidates</option>
<option  value="UG_Fourth_Year">UG_Fourth_Year</option>
<option  value="UG_Third_Year">UG_Third_Year</option>
<option  value="UG_Second_Year">UG_Second_Year</option>
<option  value="UG_First_Year">UG_First_Year</option>
<option  value="PG">PG</option>
<option value="All">All</option>
</select>
</div>
</div>
<div class="row 50%">
<div class="12u">
<select id="AllowedBatch2" name="AllowedBatch" disabled>
<option value="NULL"> Allowed Batch - Voting</option>
<option  value="UG_Fourth_Year">UG_Fourth_Year</option>
<option  value="UG_Third_Year">UG_Third_Year</option>
<option  value="UG_Second_Year">UG_Second_Year</option>
<option  value="UG_First_Year">UG_First_Year</option>
<option  value="PG">PG</option>
<option value="All">All</option>
</select>
</div>
</div>
<input type="checkbox" name="list" id="CB3" value="G.Sec" onclick="disableCB()">G.Sec<br>
<div class="row 50%">
<div class="12u">
<select id="AllowedCand3" name="AllowedCand" disabled>
<option value="NULL"> Allowed Candidates</option>
<option  value="UG_Fourth_Year">UG_Fourth_Year</option>
<option  value="UG_Third_Year">UG_Third_Year</option>
<option  value="UG_Second_Year">UG_Second_Year</option>
<option  value="UG_First_Year">UG_First_Year</option>
<option  value="PG">PG</option>
<option value="All">All</option>
</select>
</div>
</div>
<div class="row 50%">
<div class="12u">
<select id="AllowedBatch3" name="AllowedBatch" disabled>
<option value="NULL"> Allowed Batch -Voting</option>
<option  value="UG_Fourth_Year">UG_Fourth_Year</option>
<option  value="UG_Third_Year">UG_Third_Year</option>
<option  value="UG_Second_Year">UG_Second_Year</option>
<option  value="UG_First_Year">UG_First_Year</option>
<option  value="PG">PG</option>
<option value="All">All</option>
</select>
</div>
</div>
</div>
</div>
<div class="row">
<div class="12u">
<ul class="buttons">
<li><input type="submit" class="special"
value="Update" onclick="checkForm()"/></li>
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
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
<script>
function checkForm()
{
	
}
</script>
<body>
<%
	HttpSession session2 = request.getSession(false);
	if(Session.MultipleSessionCheck((String)session2.getAttribute("user"),(String)session2.getId())==true)
	{
		System.out.println("different session--2");
		response.sendRedirect("index.jsp");
		return;
	}
	String message="";
	String val="";
	String val2="";
	String eventname=request.getParameter("eventname");
	M_CandidatureApplication CA = new M_CandidatureApplication();
	String batch = CA.getBatch((String) (session.getAttribute("user")));
	M_ElectionEvent EE = new M_ElectionEvent();
	int eid= EE.getEEId(request.getParameter("eventname"));
	ArrayList<String> pos=EE.getEligiblePositions(eid,batch);
	if(EE.hasVoted((String)session.getAttribute("user"),eventname))
	{
		message="You've already voted";
		response.sendRedirect("msg.jsp?success=" + message);
		return;
	}
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
<form name="form" action="votedone.jsp" method="post">
				<div class="content">
				<div class="row 50%">
						<div class="12u">
							<input type="hidden" name="EName" value="<%= eventname %>"/>
							<%
								for(int i=0;i<pos.size();i++){
									val=pos.get(i);
									System.out.println(val);
							%>
							
								<p>Vote for :<%= val %></p>
								
								 <select id="candroll" name="candroll">
									<%
										ArrayList<String> cand = new ArrayList<String>();
										cand= EE.getVotingCandidates(eventname, val);
										for (int j = 0; j < cand.size(); j++) {
											val2 = cand.get(j);
											//System.out.println(val2);
									%>
										<option value="<%=val2%>"><%= val2%></option>
										<% } %>
										<option value="0">NOTA</option>
								</select>
								<% } %>
							<div class="row">
								<div class="12u">
									<ul class="buttons">
										<li><input type="submit" class="special" value="Apply" onclick="checkForm()"/></li>
									</ul>
								</div>
							</div>
						</div>
				</div>
				</div>
	</form>
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
<%@page import="jsp.*,java.util.*"%>
<%@ include file="noCache.jsp"%>
<%@page import="jsp.*,java.sql.*,java.util.*,java.text.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Active Election Events</title>
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

</head>
<body>
<div class="inner">
				<h3>Welcome to the Chief Election Officer</h3>
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
</body>
</html>

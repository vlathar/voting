<%@page import="jsp.*,java.sql.*,java.util.*,java.text.*"%>
<%@ include file="noCache.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Apply for Candidature- MBM_ONLINE_VOTING_PORTAL</title>
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
<body>
<script type="text/javascript">
	 function checkForm() {
		 
		 if(document.form.position.value == "0")
			{
				alert (" Please Choose an position ");
				document.form.electionevent.focus();
				return false;
			}
	 }
</script>
			<%
				HttpSession session2 = request.getSession(false);
				if(Session.MultipleSessionCheck((String)session2.getAttribute("user"),(String)session2.getId())==true)
				{
					System.out.println("different session--2");
					response.sendRedirect("index.jsp");
					return;
				}
				M_CandidatureApplication CA = new M_CandidatureApplication();
				//System.out.println((String)session.getAttribute("user"));
				//System.out.println(request.getParameter("name"));
				int batch = CA.getBatch((String) (session.getAttribute("user")));
				session.setAttribute("fname", "apply");
				session.setAttribute("AFCname",request.getParameter("name"));
		        session.setAttribute("AFCemail",request.getParameter("email"));
		        session.setAttribute("AFCelectionevent",request.getParameter("electionevent"));
		        session.setAttribute("AFCgender",request.getParameter("gender"));
		        session.setAttribute("AFCphoneno",request.getParameter("phoneno"));
		        System.out.println(request.getParameter("name"));
			%>
			<form name="form" action="C_msg.jsp" method="post">
				<div class="row 50%">
						<div class="12u">
						
							Position Applying For: <select id="position21" name="position21">
																<option value="0">Choose An Position</option>
	
									<%!ArrayList<String> Positions = new ArrayList<String>();%>
									<%
										try {
											M_ElectionEvent EE1= new M_ElectionEvent();
											int x=EE1.getEEId((request.getParameter("electionevent")));
											Positions = (ArrayList<String>) (EE1.getPositions(x));
											for (int i = 0; i < Positions.size(); i++) {
												String val = Positions.get(i);
												System.out.println(val);
									%>
									<option value="<%=val%>"><%=val%></option>
									<%
										}
										} catch (Exception e) {
											e.printStackTrace();
										}
									%>
								<!--<option value="P">President</option>
								<option value="VP">Vice-President</option>
								<option value="GSS">G.Sec. Sports</option>
								<option value="GSC">G.Sec. Cultural</option>
								<option value="GSST">G.Sec. Science and Tech.</option> -->
								<%
									if (batch == 1) {
								%>
								<option value="UG_Senate_First_Year">Senate First Year
									UG</option>
								<%
									} else if (batch == 2) {
								%><option value="UG_Senate_Second_Year">Senate Second
									Year UG</option>
								<%
									} else if (batch == 3) {
								%><option value="UG_Senate_Third_Year">Senate Third
									Year UG</option>
								<%
									} else if (batch == 4) {
								%><option value="UG_Senate_Fourth_Year">Senate Fourth
									Year UG</option>
								<%
									} else if (batch == 5) {
								%>

								<option value="PG">Post Graduate</option>
								<%
									} else
										System.out.println("Error options");
								%>



							</select>
							<div class="row">
						<div class="12u">
							<ul class="buttons">
								<li><input type="submit" class="special" value="Apply" onclick="checkForm()"/></li>
							</ul>
						</div>
					</div>
						</div>
					</div>
					</form>
</body>
</html>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@page import="jsp.*,java.sql.*,java.util.*,java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	
	try{
	String email = null;
	String phoneno = null;
	String agenda = null; 
	
		 
		M_CandidatePortfolio CP = new M_CandidatePortfolio();
		if (session.getAttribute("fname").equals("update_portfolio")) {
			
			String rollno = (String)session.getAttribute("user");
			
			
			byte[] photo=null; 
			DiskFileItemFactory factory = new DiskFileItemFactory();

		      ServletFileUpload sfu = new ServletFileUpload(factory);
		      List items = sfu.parseRequest(request);

		      Iterator iter = items.iterator();
		      int k=0;
		      while (iter.hasNext()) {
		         FileItem item = (FileItem) iter.next();
		         System.out.println(k++);
		         if(k==2){
		        	 System.out.println("testupload"+k);
		        	 phoneno=item.getString();
		         }
		         
		         else if(k==3){
		        	 System.out.println("testupload"+k);
		        	 agenda=item.getString();
		         }
		         
		         if(item.isFormField()){
		        	
		        	 String name = item.getFieldName();
		        	 System.out.println(name);
		        	 String value = item.getString();		        	   
		        	    if(name.equals("phoneno"))phoneno=value;
		        	    else if(name.equals("email")) email=value;
		        	   
		        	    else if(name.equals("agenda"))agenda=value;
		        	 
		         }
		         else if(!item.isFormField()){
		              photo = item.get();
		              
		          }
		         
		        
		         
		        	 
		         
		      }
		      System.out.println("email"+email);
				System.out.println("phone"+phoneno);
				System.out.println("agenda"+agenda);
				

			rollno = (String)session.getAttribute("user");

			boolean isupdated = CP.updatePortfolio(email, phoneno, photo,
					agenda, rollno);
			
			if(isupdated){
				
				response.sendRedirect("msg.jsp");
			}
			
            else{
                
                String message="Invalid Entry";
                response.sendRedirect("error_pg_msg.jsp?error="+message);
            }
        }
        
		
		
		else if(session.getAttribute("fname").equals("view_candidate_portfolio")){
			
			M_CandidatureApplication CA = new M_CandidatureApplication();
			String rollno = (String)session.getAttribute("rollno");
			if(CA.deleteAP(rollno)){
				
				response.sendRedirect("ceo.jsp");
				
			}
			
		}
		
		else if(session.getAttribute("fname").equals("president")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}
		
		else if(session.getAttribute("fname").equals("vice_president")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}		else if(session.getAttribute("fname").equals("GSS")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}		else if(session.getAttribute("fname").equals("GSST")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}		else if(session.getAttribute("fname").equals("GSC")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}		else if(session.getAttribute("fname").equals("senator1")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}		else if(session.getAttribute("fname").equals("senator2")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}		else if(session.getAttribute("fname").equals("senator3")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}		else if(session.getAttribute("fname").equals("senator4")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}		else if(session.getAttribute("fname").equals("PG")){
			
			String pref1= request.getParameter("pref1");
			String pref2 = request.getParameter("pref2");
			String pref3 = request.getParameter("pref3");
			
			System.out.println(pref1+" "+pref2+" "+pref3);
			
			if(pref1.compareTo(pref2)==0||pref2.compareTo(pref3)==0||pref3.compareTo(pref1)==0)
				response.sendRedirect("error_preferences.jsp");
			
			
			else{
				int oldpoints = CP.getPoints(pref1);
				CP.setPoints(pref1, oldpoints+5);
				oldpoints = CP.getPoints(pref2);
				CP.setPoints(pref2, oldpoints+3);
				oldpoints = CP.getPoints(pref3);
				CP.setPoints(pref3, oldpoints+1);
				
				
				ArrayList<String> candidates = new ArrayList<String>();
				ArrayList<String> positions = new ArrayList<String>();
				
				positions=(ArrayList<String>)session.getAttribute("positions");
				String rollno = (String)session.getAttribute("rollno");
				int currentee =(int)session.getAttribute("eid");
				M_CandidatureApplication CA = new M_CandidatureApplication();
				positions.remove(0);
				session.setAttribute("positions", positions);
				int batch = CA.getBatch(rollno);
				System.out.println(positions.get(0));
				
				if (positions.get(0).compareTo("P")==0){
					candidates = CP.getCand("P", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("president.jsp");}
				else if (positions.get(0).compareTo("VP")==0){
					candidates = CP.getCand("VP", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("vice_president.jsp");}
				else if (positions.get(0).compareTo("GSS")==0){
					candidates = CP.getCand("GSS", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gss.jsp");}
				else if (positions.get(0).compareTo("GSST")==0){
					candidates = CP.getCand("GSST", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsst.jsp");}
				else if (positions.get(0).compareTo("GSC")==0){
					candidates = CP.getCand("GSC", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("gsc.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_First_Year")==0  && batch==1){
					candidates = CP.getCand("UG_Senate_First_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_1.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Second_Year")==0 && batch==2){
					candidates = CP.getCand("UG_Senate_Second_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_2.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Third_Year")==0 && batch==3){
					candidates = CP.getCand("UG_Senate_Third_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_3.jsp");}
				else if (positions.get(0).compareTo("UG_Senate_Fourth_Year")==0 && batch==4){
					candidates = CP.getCand("UG_Senate_Fourth_Year", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("senator_4.jsp");}
				else if (positions.get(0).compareTo("PG")==0 && batch==5){
					candidates = CP.getCand("PG", currentee);
					session.setAttribute("EventsAdded", candidates);
					response.sendRedirect("pg.jsp");}
				else{
					session.invalidate();
					response.sendRedirect("success_voting.jsp");
				}

			}
					
			
		}		
	}catch(Exception e){
		session.invalidate();
		response.sendRedirect("index.jsp");
		
	}
	%>


</body>
</html>
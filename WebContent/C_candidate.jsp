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
<%!
	
	String email = null;
	String phoneno = null;
	String agenda = null; 
%>
<%	
		 
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
			String val = (String)session.getAttribute("details");
			String arr[] = val.split(":");
			String rollno = arr[0],EventName = arr[1];
			if(CA.deleteAP(rollno, EventName)){
				response.sendRedirect("ceo.jsp");
			}
			
		}

	%>


</body>
</html>
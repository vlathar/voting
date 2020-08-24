<%@page import="jsp.*,java.sql.*,java.util.*,java.text.*,javafx.util.Pair"%>
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
String EventName = null;
String rollno = null;
String position = null;
String agenda = null;
String points = null;
String message=null;
int page_bit=0;

HttpSession session2 = request.getSession(false);
if(Session.MultipleSessionCheck((String)session2.getAttribute("user"),(String)session2.getId())==true)
{
	System.out.println("different session--2");
	response.sendRedirect("index.jsp");
	return;
}
// 0 default
// 1 Apply for Candidature
// 2 Applications details
// 3 Delete Applications
%>
 
<%//try{
    
    M_CandidatureApplication CA = new M_CandidatureApplication();
    String source = request.getPathTranslated();
    System.out.println(source);
    page_bit=1;
    
    if(session.getAttribute("fname").equals("apply")){
    	EventName = (String)session.getAttribute("EventName");
        rollno = (String)(session.getAttribute("user"));
        position = request.getParameter("position");
        agenda = request.getParameter("agenda");
        points = request.getParameter("points");
        String batch_by_rollno = CA.getBatch(rollno);
        String batch_by_position = CA.getBatch(EventName, position);
        System.out.println("batch_by_rollno:"+batch_by_rollno);
        System.out.println("batch_by_position:"+batch_by_position);  
        if(batch_by_rollno.equals(batch_by_position)||batch_by_position.equals("all")){
	        boolean isapplied = CA.createAP(EventName,position,rollno,agenda, points); 
	        if(isapplied){
	        	message="Successfully_applied_for_application";
	        	System.out.println("C-msg.jsp: "+message);
	        	response.sendRedirect("Success_MSG.jsp?success="+message);
	       }
	        else{	
	        	message="Already applied";
	        	System.out.println("C-msg.jsp: error in storing in database");
	        	response.sendRedirect("error_page.jsp?error="+message);
	        }
        }
        else
        {	
          	message="Invalid Entry";
    		response.sendRedirect("error_preferences.jsp?error="+message);
        }
           
    }
    
    else if(session.getAttribute("fname").equals("application_detail")){
        
    	page_bit=2;
    	String id = request.getParameter("ID");
    	String val = (String)session.getAttribute("details");
    	String arr[] = val.split(":");
		rollno = arr[0]; 
		EventName = arr[1];
		position = arr[2];
        if(id.equals("0")){     
           	boolean isapproved =CA.approve(rollno,EventName,position);
        	
        	if(isapproved){
        		System.out.println("application approved");
            	 message="Application_details";
                response.sendRedirect("Success_CEO.jsp?success="+message);
            }
            else{
            	System.out.println("error in approving application");
            	 message="Invalid Entry";
        		response.sendRedirect("error_page.jsp?error="+message);
            }
        }
        else if(id.equals("1")){
        	boolean isrejected =CA.reject(rollno,EventName);
        	if(isrejected){
        		System.out.println("application rejected");
            	 message="Application_details";
                response.sendRedirect("Success_CEO.jsp?success="+message);
            }
            else{
            	System.out.println("error in rejecting application");
            	 message="Invalid Entry";
        		response.sendRedirect("error_page.jsp?error="+message);
            }
        }
    }
    
    else if(session.getAttribute("fname").equals("delete_application")){
    	
    	page_bit=3;
    	System.out.println(session.getAttribute("fname"));
        String val = request.getParameter("details");
		String arr[] = val.split(":");
		rollno = arr[0]; 
		EventName = arr[1];
        boolean isdeleted = CA.deleteAP(rollno,EventName);
 
        if (isdeleted) {
        	 message="Successfully deleted";
            response.sendRedirect("Success_MSG.jsp?success="+message);
        }
        else{
        	
        	 message="Invalid Entry";
    		response.sendRedirect("error_pg_msg.jsp?error="+message);
        }
        
    }
    else
    {
    	 message="Something went wrong";
    	response.sendRedirect("error_pg_msg.jsp?error="+message);
    }
    
 
%>
 
 
 
</body>
</html>
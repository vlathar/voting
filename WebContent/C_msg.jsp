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
<% String name = null;
String email = null;
String EventName = null;
String gender = null;
//double cgpa = 0.0;
String phoneno = null;
String rollno = null;
String position = null;
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
    	System.out.println("Hello");
        name = (String)session.getAttribute("AFCname");
        email =(String) session.getAttribute("AFCemail");
        EventName = (String)session.getAttribute("AFCelectionevent");
        gender = (String)session.getAttribute("AFCgender");
        //cgpa = Double.parseDouble((String)session.getAttribute("AFCcgpa"));
        phoneno = (String)session.getAttribute("AFCphoneno");
        rollno = (String)(session.getAttribute("user"));
        position = request.getParameter("position21");
        //System.out.println(name);
        //System.out.println("  "+phoneno+"  "+rollno+"  "+position);
        //double cg = CA.getcgpa(rollno);
        //System.out.println("cgpadb"+cg);
        //if(cgpa == cg && cg>=7.0){
            
            boolean isapplied = CA.createAP(EventName,position,rollno,name,email,phoneno,gender); 
            String message;
            if(isapplied){

            	message="Successfully_applied_for_application";
                response.sendRedirect("Success_MSG.jsp?success="+message);
            	
           }
            else
            {	
            	message="Invalid Entry";
    			response.sendRedirect("error_pg_msg.jsp?error="+message);
            }
           
    }
    
    else if(session.getAttribute("fname").equals("application_detail")){
        
    	page_bit=2;
    	String id = request.getParameter("ID");
        rollno = (String)(session.getAttribute("rollno"));
        if(id.equals("0")){
        	String e_event= request.getParameter("Accept");      
           	boolean isapproved =CA.approve(rollno,e_event);
        	
        	if(isapproved){
        		System.out.println("application approved");
            	String message="Application_details";
                response.sendRedirect("Success_CEO.jsp?success="+message);
            }
            else{
            	System.out.println("error in approving application");
            	String message="Invalid Entry";
        		response.sendRedirect("error_page.jsp?error="+message);
            }
        }
        else if(id.equals("1")){
        	boolean isrejected =CA.reject(rollno);
        	if(isrejected){
        		System.out.println("application rejected");
            	String message="Application_details";
                response.sendRedirect("Success_CEO.jsp?success="+message);
            }
            else{
            	System.out.println("error in rejecting application");
            	String message="Invalid Entry";
        		response.sendRedirect("error_page.jsp?error="+message);
            }
        }
    }
    
    else if(session.getAttribute("fname").equals("delete_application")){
    	
    	page_bit=3;
        rollno = (String)(session.getAttribute("user"));
        System.out.println(session.getAttribute("fname"));
        boolean isdeleted = CA.deleteAP(rollno);
 
        if (isdeleted) {
        	String message="Successfully deleted";
            response.sendRedirect("Success_MSG.jsp?success="+message);
        }
        else{
        	
        	String message="Invalid Entry";
    		response.sendRedirect("error_pg_msg.jsp?error="+message);
        }
        
    }
    else
    {
    	String message="Something went wrong";
    	response.sendRedirect("error_pg_msg.jsp?error="+message);
    }
    
 
%>
 
 
 
</body>
</html>
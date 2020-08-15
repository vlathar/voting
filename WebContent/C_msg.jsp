<%@page import="jsp.*,java.sql.*,java.util.*,java.text.*"%>
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
double cgpa = 0;
String phoneno = null;
String rollno = null;
String position = null;
int page_bit=0;

// 0 default
// 1 Apply for Candidature
// 2 Applications details
// 3 Delete Applications
%>
 
<%try{
    
    M_CandidatureApplication CA = new M_CandidatureApplication();
    String source = request.getPathTranslated();
    System.out.println(source);
    page_bit=1;
    
    if(session.getAttribute("fname").equals("apply")){
        name = request.getParameter("name");
        email = request.getParameter("email");
        EventName = request.getParameter("electionevent");
        gender = request.getParameter("gender");
        cgpa = Double.parseDouble(request.getParameter("cgpa"));
        phoneno = request.getParameter("phoneno");
        rollno = (String)(session.getAttribute("user"));
        position = request.getParameter("position");
        System.out.println("cgpaform"+cgpa);
        double cg = CA.getcgpa(rollno);
        System.out.println("cgpadb"+cg);
        if(cgpa == cg && cg>=7.0){
            
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
        
        else
        {	
        	String message="Invalid Entry";
			response.sendRedirect("error_pg_msg.jsp?error="+message);
        }
        
    }
    
    else if(session.getAttribute("fname").equals("application_detail")){
        
    	page_bit=2;
        rollno = (String)(session.getAttribute("rollno"));
        boolean isapproved =CA.approve(rollno);
        
        if(isapproved){
        	
        	String message="Application_details";
            response.sendRedirect("Success_CEO.jsp?success="+message);
        }
        
        else
        {
        	String message="Invalid Entry";
    		response.sendRedirect("error_page.jsp?error="+message);
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
    
}catch(Exception e){
	
	if(EventName =="" || name== null || email== null || gender == null || phoneno==null ||rollno==null ||position==null)
	{
		String message="Invalid input";
		if(page_bit== 1)
		{
			response.sendRedirect("apply_for_cand.jsp?error=" + message);
		}
		else if(page_bit== 2)
		{
			response.sendRedirect("application_detail.jsp?error=" + message);
		}
		else if(page_bit == 3)
		{
			response.sendRedirect("delete_ap.jsp?error=" + message);
		}
		else
		{
			response.sendRedirect("msg.jsp?error=" + message);
		}
	}
    
}
 
%>
 
 
 
</body>
</html>
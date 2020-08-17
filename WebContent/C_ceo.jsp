
	
<%@page
    import="jsp.*,java.sql.*,java.util.*,java.text.*,java.util.regex.Matcher,java.util.regex.Pattern "%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <%!String EventName = "name";
    java.sql.Date date = null;
    java.sql.Time startTime = null;
    java.sql.Time endTime = null;
    ArrayList<String> positions = new ArrayList<String>();
    int page_bit = 0;
    
    // 1 for create_ee 
    // 2 for update_ee
    // 3 for delete_ee
    // 0 Back to CEO
    
    %>
 
    <%
        try {
 
        	
            M_ElectionEvent EE = new M_ElectionEvent();
            
            
 
            if (session.getAttribute("fname").equals("create_ee")) {
 				
            	page_bit= 1;
                positions.clear();
                SimpleDateFormat formatter = new SimpleDateFormat(
                        "MM/dd/yyyy");
                System.out.println(session.getAttribute("fname"));
 
                EventName = request.getParameter("electionevent");

                System.out.println("testname" + EventName);
                date = new java.sql.Date(formatter.parse(
                        request.getParameter("date")).getTime());
 
                String[] ids = request.getParameterValues("list");
                // this will get array of values of all checked checkboxes
                for (String id : ids) {
                    // do something with id, this is checkbox value
                    positions.add(id);
                    System.out.println(id);
                }
                SimpleDateFormat timeformatter = new SimpleDateFormat(
                        "HH:mm:ss");
 
                startTime = new java.sql.Time(timeformatter.parse(
                        request.getParameter("starttime")).getTime());
                System.out.println(startTime.toString());
 
                Time24HoursValidator time24HoursValidator = new Time24HoursValidator();
                boolean valid = time24HoursValidator.validate(startTime
                        .toString());
 
                endTime = new java.sql.Time(timeformatter.parse(
                        request.getParameter("endtime")).getTime());
 
                boolean valid_e = time24HoursValidator.validate(endTime
                        .toString());
                if (!valid_e || !valid) {
                    String message = "Invalid Input Time Format";
                    response.sendRedirect("error_time_format.jsp?error="
                            + message);
                }
 
                else {
                    boolean iscreated = EE.createEE(EventName, date,
                            startTime, endTime, positions);
                    String message=null;
                    if (iscreated) {
                    	
                    	if(session.getAttribute("res")=="Invalid Input")
                    	{
                    		message="Invalid Entry";
                        	response.sendRedirect("error_page.jsp?error="+message);
                    	}
                    	else
                    	{
 							message="Successfully_created_election_event";
                        	response.sendRedirect("Success_CEO.jsp?success="+message);
                    	}
                    }
 
                    else
                    {
                    	message="Invalid Entry";
                    	response.sendRedirect("error_page.jsp?error="+message);
                    }
 
                }
            }
 
            
            
            else if (session.getAttribute("fname").equals("update_ee")) {
 
            	page_bit= 2;
            	
                positions.clear();
 
                SimpleDateFormat formatter = new SimpleDateFormat(
                        "MM/dd/yyyy");
                System.out.println(session.getAttribute("fname"));
 
                EventName = request.getParameter("electionevent");
                System.out.println("testname" + EventName);
                date = new java.sql.Date(formatter.parse(
                        request.getParameter("date")).getTime());
 
                String[] ids = request.getParameterValues("list");
                // this will get array of values of all checked checkboxes
                for (String id : ids) {
                    // do something with id, this is checkbox value
                    positions.add(id);
                    System.out.println(id);
                }
                SimpleDateFormat timeformatter = new SimpleDateFormat(
                        "HH:mm:ss");
 
                startTime = new java.sql.Time(timeformatter.parse(
                        request.getParameter("starttime")).getTime());
 
                Time24HoursValidator time24HoursValidator = new Time24HoursValidator();
                boolean valid = time24HoursValidator.validate(startTime
                        .toString());
 
                endTime = new java.sql.Time(timeformatter.parse(
                        request.getParameter("endtime")).getTime());
 
                boolean valid_e = time24HoursValidator.validate(endTime
                        .toString());
                if (!valid_e || !valid) {
                    String message = "Invalid Input Time Format";
                    response.sendRedirect("error_time_format.jsp?error="+ message);
                }
                else if(EventName =="0" || date == null || startTime == null || endTime == null)
                {
                	String message="Invalid Entry";
            		response.sendRedirect("error_page.jsp?error="+message);
                }
 
                else {
                    boolean iscreated = EE.updateEE(EventName, date,
                            startTime, endTime, positions);
                    String message=null;
                    if (iscreated) {
 
                    	message="Successfully_Updated_election_event";
                        response.sendRedirect("Success_CEO.jsp?success="+message);
                    }
 
                    else
                    {
                    	message="Invalid Entry";
                		response.sendRedirect("error_page.jsp?error="+message);
                    }
 
                }
            }
 
            else if (session.getAttribute("fname").equals("delete_ee")) {
 
            	page_bit= 3;
                EventName = request.getParameter("electionevent");
                
                /* 
                 For De-bugging
                if(EventName=="0")
                	System.out.println(EventName+"1");
                else if(EventName==null)
                	System.out.println(EventName+"2");
                else if(EventName=="")
                	System.out.println(EventName+"3");
                else if(Integer.parseInt(EventName)==0)
                	System.out.println(EventName+"4");
                else
                	System.out.println(EventName+"5"); */
                	
                	String regex = "\\d+";
                	/* System.out.println(EventName.matches(regex)); */
                	
                if(EventName.matches(regex))
                {
                	boolean isdeleted = false; 
                	String message="Invalid Entry";
            		response.sendRedirect("error_page.jsp?error="+message);
                	
                }
                else{
                	
                	System.out.println(session.getAttribute("fname"));
                    boolean isdeleted = EE.deleteEE(EventName);
                    
                    System.out.println(EventName);
     				String message=null;
                    if (isdeleted) {

                    	message="Successfully_Deleted_election_event";
                        response.sendRedirect("Success_CEO.jsp?success="+message);
                    }
                    else
                    {
                    	message="Invalid Entry";
                		response.sendRedirect("error_page.jsp?error="+message);
                    }
                	
                }

            }
 
        } catch (Exception e) {
        	
        	e.printStackTrace();
 		
        		if(EventName =="" || date == null || startTime == null || endTime == null)
        		{
        			String message="Invalid input";
        			if(page_bit== 1)
        			{
        				response.sendRedirect("create_ee.jsp?error=" + message);
        			}
        			else if(page_bit== 2)
        			{
        				response.sendRedirect("Update_ee.jsp?error=" + message);
        			}
        			else if(page_bit == 3)
        			{
        				response.sendRedirect("delete_ee.jsp?error=" + message);
        			}
        			else
        			{
        				response.sendRedirect("ceo.jsp?error=" + message);
        			}
        		}
        		
        		else response.sendRedirect("error_page.jsp");
 
        }
    %>
 
 
</body>
<%@ page import="jsp.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%  String rollno = request.getParameter("rollno");
	String name = request.getParameter("name");
	String cgpa = request.getParameter("cgpa");
	String batch = request.getParameter("batch");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	String mobile = request.getParameter("mobile");
	String password=request.getParameter("password");
	String signupdetails = rollno+":"+name+":"+cgpa+":"+batch+":"+gender+":"+email+":"+mobile+":"+password;
	session.setAttribute("signupdetails",signupdetails);
    System.out.println("reached to signup.jsp");
   try{
	   //function to form 4 digit otp
	   String myHash="1234";
	   session.setAttribute("hash",myHash);
	   SendingEmail se = new SendingEmail(rollno, email, myHash);
	   if(se.sendMail()){
		   response.sendRedirect("verifyStudent.jsp");
	   }
	   else{
		   response.sendRedirect("index.jsp");
	   }
   }
   catch(Exception e){
	   e.printStackTrace();
   }
%>
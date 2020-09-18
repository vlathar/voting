<%@ page import="jsp.*, java.sql.*,java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%  String rollno = (String)session.getAttribute("user");
	M_ElectionEvent ca = new M_ElectionEvent();
	String email = ca.getEmail(rollno);
   try{
  //function to form 4 digit otp
  String numbers="0123456789";
  Random rand= new Random();
  String eventname=request.getParameter("eventname");
  session.setAttribute("Eventvote",eventname);
  String myHash=new String();
  for(int i=0;i<4;i++) { myHash+=numbers.charAt(rand.nextInt(numbers.length()));}
  System.out.println("otp send for vote is:"+myHash);
  session.setAttribute("hash",myHash);
  SendingEmail se = new SendingEmail(rollno, email, myHash);
  if(se.sendMail()){
  response.sendRedirect("votingpage.jsp");
  }
  else{
  response.sendRedirect("msg.jsp");
  }
   }
   catch(Exception e){
  e.printStackTrace();
   }
%>


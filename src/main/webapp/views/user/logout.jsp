<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.io.PrintWriter"%>
  
  <%
	session.removeAttribute("sid");

	PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그아웃 완료.')");
		script.println("location.href = '../main.jsp'");
		script.println("</script>");
		
  %>
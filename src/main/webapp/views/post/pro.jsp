<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.io.File" %>
    
<%
	request.setCharacterEncoding("UTF-8");
	String path = "D:/global/upload";
	int max = 1024*1024*10; // 10MB
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path);
	
	String name = mr.getParameter("name");
	File f = mr.getFile("save");
%>
<h1>name: <%=name %></h1>
<h1>파일 이름 : <%=f.getName() %></h1>
<h1>파일 업로드 된 이름 : <%=mr.getFilesystemName("save") %></h1>
<h1>파일 원본 이름 : <%=mr.getOriginalFileName("save") %></h1>
<h1>파일 크기 : <%=f.length() %></h1>
<h1>파일 타입 : <%=mr.getContentType("save") %></h1>
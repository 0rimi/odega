<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import = "java.io.File" %>
<%@ page import = "java.util.List"%>
<%@ page import = "java.util.Arrays"%>

<%@ page import = "odega.bean.PostsDAO"%>
<%@ page import = "odega.bean.PostsDTO"%>
<%@ page import = "odega.bean.MapDTO"%>
<%@ page import = "odega.bean.MapDAO"%>
<%@ page import = "odega.bean.ImageDAO"%>
<%@ page import = "odega.bean.ImageDTO"%>
<%@ page import = "odega.bean.TagDTO"%>
<%@ page import = "odega.bean.TagDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String path = "D:/global/upload";
	int max = 1024*1024*10; // 10MB
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path);
	
	String title = mr.getParameter("title");
	String contents = mr.getParameter("contents");
	int unum = Integer.parseInt(mr.getParameter("unum"));
	
	
	File f = mr.getFile("save");
	
	
	//posts(title,content,unum) 값을 DTO에 넣어서 보내주기
	
	//방금 넣은 DTO user_num 가장 최근 작성 postnum 가져오기
	
	//받은 postnum 바탕으로 map(places.place[])정보들 넣어주기
	
	//받은 postnum 바탕으로 순서대로 image[] 정보들 넣어주기
%>

<h1>title: <%=title %></h1>
<h1>파일 이름 : <%=f.getName() %></h1>
<h1>파일 업로드 된 이름 : <%=mr.getFilesystemName("save") %></h1>
<h1>파일 원본 이름 : <%=mr.getOriginalFileName("save") %></h1>
<h1>파일 크기 : <%=f.length() %></h1>
<h1>파일 타입 : <%=mr.getContentType("save") %></h1>
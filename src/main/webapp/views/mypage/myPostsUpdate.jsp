<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page import="odega.bean.mypage.myPageDTO" %>
<%@ page import="odega.bean.mypage.myPageDAO" %>

<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<h1 class="display-3 text-center">/views/postsLoginPro.jsp</h1><br />

<%
	int num = Integer.parseInt(request.getParameter("num"));
	myPageDAO dao = new myPageDAO();
	myPageDTO dto = new myPageDTO();
	String sid = (String)session.getAttribute("sid");
	if(sid != null){
	dao.updatePosts(num);
	response.sendRedirect("admin.jsp?sql1=posts_num&sql2=desc");
	//request.getRequestDispatcher("posts.jsp?num="+num);
	}else{ %>
	<a href="postsLoginForm.jsp?num=<%=dto.getPost_num()%>">로그인</a> 후 좋아요 사용가능
	<%} 
%>



</body>
</html>
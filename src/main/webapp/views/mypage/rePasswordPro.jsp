<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  

<jsp:useBean id="dto" class="odega.bean.mypage.myPageDTO" />
<jsp:useBean id="dao" class="odega.bean.mypage.myPageDAO" />
<%--<jsp:setProperty property="userpw" name="dto" />
<jsp:setProperty property="nickname" name="dto" />
<jsp:setProperty property="user_name" name="dto" />
<jsp:setProperty property="phone" name="dto" />
--%>
   
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<%
	
	String sid = (String)session.getAttribute("sid");
	String pw1 = request.getParameter("password");
	int result = dao.rePassword(pw1 , sid);

	if(result == 1){
	response.sendRedirect("myPage.jsp"); %>
	<script>
		alert("비밀번호가 변경되었습니다.");
	</script>
	<%}else{ %>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
	<%} 
%>



</body>
</html>
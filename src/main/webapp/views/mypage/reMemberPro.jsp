<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  

<jsp:useBean id="dto" class="odega.bean.mypage.myPageDTO" />
<jsp:useBean id="dao" class="odega.bean.mypage.myPageDAO" />
 
<jsp:setProperty property="userpw" name="dto" />
<jsp:setProperty property="nickname" name="dto" />
<jsp:setProperty property="user_name" name="dto" />
<jsp:setProperty property="phone" name="dto" />
<%
String birth = request.getParameter("birth");
%>
  
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<%
	String sid = (String)session.getAttribute("sid");
	String pw1 = request.getParameter("password");
	int result = dao.memberUpdate(dto , sid , birth);

	if(result == 1){%>
	<script>
		alert("회원정보가 변경되었습니다.");
	</script>
		<%response.sendRedirect("myPage.jsp"); %>
	<%}else{ %>
	<script>
		alert("회원정보가 변경되지 않았습니다.");
		history.go(-1);
	</script>
	<%} 
%>



</body>
</html>
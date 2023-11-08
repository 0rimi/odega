<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<%@ page import="java.util.ArrayList" %>
<%@ page import="odega.bean.mypage.myPageDTO" %>
<%@ page import="odega.bean.mypage.myPageDAO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<html>

<head>
<meta charset="UTF-8">
<title> ODEGA MyPage </title>
<link href="/odega/resources/img/good.PNG" rel="shortcut icon" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<body>
	<%-- 페이징 처리 --%>
<%
   	int pageSize = 6;
   
   	String pageNum = request.getParameter("pageNum");
   	if(pageNum == null){
      	pageNum = "1";
   	}
   
   	int currentPage = Integer.parseInt(pageNum);
   	int start = (currentPage - 1) * pageSize + 1;
   	int end = currentPage * pageSize;
%>


	<%-- 로그인 체크 --%>
<%
   String sid = (String)session.getAttribute("sid");
   if(sid == null){
%>      <script>
         alert("로그인 후 사용 가능합니다.");
         window.location="../user/loginform.jsp";
      </script>
<% }
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
   myPageDAO dao = new myPageDAO();
   myPageDTO dto = new myPageDTO();
   dto = dao.myInfo(sid);
%>



	<%-- 포스트 작성, 비밀번호 변경, 회원정보 변경 --%>
	<%-- 로그인 상태 = 로그아웃 버튼 출력 , 로그아웃 상태 = 로그인 버튼 출력 --%>
<div  align="center">
   <div class="col" align="left" >
			<%@ include file="../user/top.jsp"%>
			<h2 class="mt-3">
				<%
				   String logsid = (String)session.getAttribute("sid");
				   if(logsid != null){
				%>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<a href="../post/posting.jsp?"><button type="button" class="btn btn-success"">포스트 작성</button></a>
				&nbsp&nbsp
				<button type="button" class="btn btn-success" 
				data-bs-toggle="dropdown" aria-expanded="false">
   				회원정보</button>
   				  <ul class="dropdown-menu">
   				 	<li><a class="dropdown-item" href="myPageInfo.jsp">나의 정보 확인</a></li>
   				  	<li><a class="dropdown-item" href="myPage.jsp?sql1=posts_num&sql2=desc">내가쓴 포스트 보기</a></li>
				    <li><a class="dropdown-item" href="nowPassword.jsp">비밀번호 변경</a></li>
				    <li><a class="dropdown-item" href="nowMemberPass.jsp">회원정보 변경</a></li>
				  </ul>
				&nbsp&nbsp
				<button onclick="window.location='../user/logout.jsp'" type="button" class="btn btn-success">로그아웃</button>
				<%} else {
%>
				&nbsp&nbsp
				<button onclick="window.location='../user/loginform.jsp'" type="button" class="btn btn-success">로그인</button>
								
				<% }%>
			</h2>



	<%-- 관리자페이지 이동(admin 계정일때만 확인가능) --%>
<%
   if(sid == null){
%>      <script>
         alert("로그인 후 사용 가능합니다.");
         window.location="/odega/views/user/loginform.jsp";
      </script>
<% } else if(sid.equals("admin")){ %>
		<div align="center" ><p style="font-size:30px"><button onclick="window.location='admin.jsp'" type="button" class="btn btn-success"">관리자 페이지</button></div>
	<%}%>
		</div>
</div>
<hr />

<h1></h1><br />

	<%-- 접속한 계정의 글정보 확인(최신순, 오래된순, 좋아요순) --%>
	<%-- 검색(제목만 검색) , 검색(제목+본문 검색) --%>
<div  align="center">
	<form action="search.jsp">
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
      	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
      	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
      	<img src="/odega/resources/img/today.png" style="width:130px">
      	<img src="/odega/resources/img/odega.gif" style="width:200px">
      	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
      	<a href="../mypage/myPage.jsp?sql1=posts_num&sql2=desc"><button type="button" class="btn btn-outline-success">나의 최신순</button></a>
      	<a href="../mypage/myPage.jsp?sql1=posts_num&sql2=asc"><button type="button" class="btn btn-outline-success" >나의 오래된순</button></a>
      	<a href="../mypage/myPage.jsp?sql1=post_like_cnt&sql2=desc"><button type="button" class="btn btn-outline-success">나의 좋아요순</button></a>
      	<select name="searchOption">
         	<option value = "total" >제목+본문</option>
         	<option value = "title" >제목</option>
      	</select>
      	<input type="text" name="search" placeholder="보고싶은 포스팅은?" >
		<button type="submit" class="btn btn-success">검색</button>
    </form>
</div>


	<%-- 글 작성자 이름 출력 --%>
<div align="center" >
   <h4>[<%= dto.getNickname() %>]님의 정보</h4>
</div>

<div align="center">
	<table class="table table-hover table-bordered">
		<tr>
		<td align="center"><h5>아이디</h5></td>
		<td align="left"><h5>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<%=dto.getUserid() %></h5></td>
		</tr>
		<tr>
		<td align="center"><h5>이름</h5></td>
		<td align="left"><h5>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<%=dto.getUser_name() %></h5></td>
		</tr>
		<tr>
		<td align="center"><h5>닉네임</h5> </td>
		<td align="left"><h5>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<%=dto.getNickname() %></h5> </td>
		</tr>
		<tr>
		<td align="center"><h5>가입일</h5> </td>
		<td align="left"><h5>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<%=sdf.format(dto.getReg())%></h5> </td>
		</tr>
		<tr>
		<td align="center"><h5>생년월일</h5> </td>
		<td align="left"><h5>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<%=sdf.format(dto.getBirth()) %></h5> </td>
		</tr>
		<tr>
		<td align="center"><h5>전화번호</h5> </td>
		<td align="left"><h5>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<%=dto.getPhone() %></h5> </td>
		</tr>
	</table>
</div>


</body>
</html>
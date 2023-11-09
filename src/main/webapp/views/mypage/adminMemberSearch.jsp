<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html> 
<%@ page import="java.util.ArrayList"%>
<%@ page import="odega.bean.mypage.myPageDTO"%>
<%@ page import="odega.bean.mypage.myPageDAO"%>
<%@ page import = "java.text.SimpleDateFormat" %>

<head>
<meta charset="UTF-8">
<title>ODEGA 관리자 페이지</title>
<link href="/odega/resources/img/good.PNG" rel="shortcut icon" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<body>

	<%-- 페이징 --%>
<%
   	int pageSize = 10;
   
   	String pageNum = request.getParameter("pageNum");
   	if(pageNum == null){
		pageNum = "1";
   	}
   
   	int currentPage = Integer.parseInt(pageNum);
   	int start = (currentPage - 1) * pageSize + 1;
   	int end = currentPage * pageSize;
%>

	<%-- 포스트 작성, 비밀번호 변경, 회원정보 변경 --%>
	<%-- 로그인 상태 = 로그아웃 버튼 출력 , 로그아웃 상태 = 로그인 버튼 출력 --%>
	<div>
		<div class="col" align="left">
			<%@ include file="../user/top.jsp"%>
			<h2 class="mt-3"></h2>
		</div>
	</div>
	<hr />
	<br />
	<%
	String search = request.getParameter("search");
	String searchOption = request.getParameter("searchOption");
   	String sid = (String)session.getAttribute("sid");
	%>
	<%-- 관리자 계정의 글정보 확인(최신순, 오래된순, 좋아요순 , 검색) --%>
	<%-- 검색(제목만 검색) , 검색(제목+본문 검색) --%>
	<div align="center">
		<form action="adminPostSearch.jsp">
			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <img
				src="/odega/resources/img/today.png" style="width: 130px"> <img src="/odega/resources/img/odega.gif" style="width: 200px"> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
				<a href="admin.jsp?msql1=reg&msql2=desc"><button type="button" class="btn btn-success">추천/글삭제</button></a> 
				<a href="admin.jsp?msql1=p.reg&msql2=desc"><button type="button" class="btn btn-outline-success">전체 최신순</button></a> 
				<a href="admin.jsp?msql1=p.reg&msql2=asc"><button type="button" class="btn btn-outline-success">전체 오래된순</button></a>  
				<select name="searchOption">
					<option value="total">제목+본문</option>
					<option value="title">제목</option>
				</select> <input type="text" name="search" placeholder="보고싶은 포스팅은?">
				<button type="submit" class="btn btn-success">검색</button>
		</form>
	</div>

	<div align="center">
		<form action="adminMemberSearch.jsp">
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<a href="adminMembers.jsp?msql1=reg&msql2=asc"><button type="button" class="btn btn-success">회원 삭제</button></a> 
				<a href="adminMembers.jsp?msql1=num&msql2=desc"><button type="button" class="btn btn-outline-success">전체 최신순</button></a> 
				<a href="adminMembers.jsp?msql1=num&msql2=asc"><button type="button" class="btn btn-outline-success">전체 오래된순</button></a> 
				<select name="searchOption">
					<option value="name">회원명</option>
					<option value="nickname">닉네임</option>
					<option value="phone">전화번호</option>
				</select> <input type="text" name="search" placeholder="회원명 또는 닉네임">
				<button type="submit" class="btn btn-success">검색</button>
		</form>
	</div>
	
	<hr />

	<h1></h1>
	<br />

	<%-- 최신순, 오래된순으로 정렬하기위한 파라미터 설정(삭제할 회원) --%>
	<div class="container">
		<div class="col" align="left">

			<div>
				<%   
			   String msql1 = request.getParameter("msql1");
			   String msql2 = request.getParameter("msql2");
			   
			   if(msql1 == null || msql2 == null){
			      msql1 = "reg";
			      msql2 = "desc";
			   } else{
			      msql1 = request.getParameter("msql1");
			      msql2 = request.getParameter("msql2");   
			   }
			   %>
			   </div>
		</div>
	</div>
	
<%-- 삭제할 전체 회원 목록 호출 --%>
<div class="container">
	<div class="row" align="center">
			<script type="text/javascript">
				function del(userNum) {
					if(confirm("정말 삭제하시겠습니까?")==true){
						location.href='myMemberDelete.jsp?unum='+userNum;
					}
				}
			</script>
			<%
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일");
			myPageDAO dao = new myPageDAO();
			ArrayList<myPageDTO> list = dao.searchUser(search, searchOption, start, end, msql1, msql2);%>
			<table class="table table-hover table-bordered">
				<tr>
					<td align="center"><h5>유저 번호</h5></td>
					<td align="center"><h5>유저 아이디</h5></td>
					<td align="center"><h5>유저 이름</h5></td>
					<td align="center"><h5>유저 닉네임</h5></td>
					<td align="center"><h5>전화번호</h5></td>
					<td align="center"><h5>생년월일</h5></td>
					<td align="center"><h5>등록일</h5></td>
					<td align="center"><h5>글삭제</h5></td>
				</tr>
				<% for(myPageDTO dto : list){%>
			    <tr>
			      	<td align="center"><%=dto.getNum()%></td>
			      	<td align="center"><%=dto.getUserid()%></td>
			      	<td align="center"><%=dto.getUser_name()%></td>
			      	<td align="center"><%=dto.getNickname()%></td>
			      	<td align="center"><%=dto.getPhone()%></td>
			      	<td align="center"><%=sdf.format(dto.getBirth())%></td>
			      	<td align="center"><%=sdf.format(dto.getReg())%></td>
			      	<td align="center"><button onclick="del(<%=dto.getNum()%>);" type="button" class="btn btn-success" >삭제</button></td>
			    	</tr>
			    <%}%>
		</table>
	</div>
</div>
<h1></h1><br />


<div align="center">
	<%
   	int count = dao.userSearchCount(search, searchOption);
   	if(count > 0){
      	int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      	int startPage = (int)(currentPage/10)*10+1;
      	int pageBlock = 10;
      	int endPage = startPage + pageBlock - 1;
      	if(endPage > pageCount){
         	endPage = pageCount;
      }
	if(startPage > 10){
	%>
		<b><a href="adminMemberSearch.jsp?searchOption=<%=searchOption%>&search=<%=search%>&msql1=<%=msql1%>&msql2=<%=msql2%>&pageNum=<%=startPage-10%>">[이전]</a></b>
	<%}
      
	for(int i=startPage; i<=endPage; i++){
	%>
		<a href="adminMemberSearch.jsp?searchOption=<%=searchOption%>&search=<%=search%>&msql1=<%=msql1%>&msql2=<%=msql2%>&pageNum=<%=i%>"><b>[<%=i%>]</b></a>
		<%} if(endPage < pageCount){
   %>
		<b><a href="adminMemberSearch.jsp?searchOption=<%=searchOption%>&search=<%=search%>&msql1=<%=msql1%>&msql2=<%=msql2%>&pageNum=<%=startPage+10%>">[다음]</a></b>
		<%}   
   }%>
</div>
<h1></h1>
<br />
<h1></h1>
<br />
</body>
</html>




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


<% 
	String sid = (String)session.getAttribute("sid");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일");
   	myPageDAO dao = new myPageDAO();
   	myPageDTO dto = new myPageDTO();
   	dto = dao.myInfo(sid);
%>
<div align="center">
      <div class="col" align="left">
         <%@ include file="../user/top.jsp"%>
         <h2 class="mt-3"></h2>
	</div>
</div>
<hr />



	<%-- 관리자페이지 이동(admin 계정일때만 확인가능) --%>
<%
   if(sid == null){
%>      <script>
         alert("로그인 후 사용 가능합니다.");
         window.location="/odega/views/user/loginform.jsp";
      </script>
<% } else if(sid.equals("admin")){ %>


<div align="center" >      
	<p style="font-size:30px">
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<button onclick="window.location='admin.jsp'" type="button" class="btn btn-success"">관리자 페이지</button></div>
	<%}%>
</div>


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
   <h4>[<%= dto.getNickname() %>]님의 포스팅 목록</h4>
</div>


	<%-- 최신순, 오래된순으로 정렬하기위한 파라미터 설정 --%>
<div class="container" >
	<div class="col" align="left" >
		<div>
			<%
			   String sql1 = request.getParameter("sql1");
			   String sql2 = request.getParameter("sql2");
			
			   if(sql1 == null || sql2 == null){
			      sql1 = "posts_num";
			      sql2 = "desc";
			   } else{
			      sql1 = request.getParameter("sql1");
			      sql2 = request.getParameter("sql2");
			   }
			   ArrayList<myPageDTO> list = dao.list(sid, start, end , sql1 , sql2);
			   for(myPageDTO sdto : list){
			%>
         <hr />
	         <div style="display:inline-block; vertical-align:middle;">
	            <a href="../post/postView.jsp?num=<%= sdto.getPost_num()%>">
	            <img src="/odega/resources/img/<%=sdto.getImg()%>" style="width:200px; height:170px;" border="2;" />
	            </a>
	         </div>
	
	         <div style="display:inline-block; vertical-align:middle;">
	            <a href="../post/postView.jsp?num=<%= sdto.getPost_num()%>">
	               <b><p style="font-size:20px;">제목 : <%=sdto.getPost_title()%></p></b>
	            </a>
	            <p style="font-size:15px;">작성자 : <%=sdto.getNickname()%></p>
	            <p style="font-size:15px;">조회수 : <%=sdto.getPost_content_cnt() %></p>
	            <p style="font-size:15px;">작성일 : <%=sdf.format(sdto.getPost_reg())%></p>
	            <h5><img src="/odega/resources/img/good.PNG" style="width:30px"><%=sdto.getPost_like_cnt()%></h5>
	            
	         </div>
         <% } %>
      </div>
   </div>
</div>
<h1></h1><br/>

	<%-- 페이징 --%>
<%
	int count = dao.count(sid);
	if(count > 0){
	   int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	   int startPage = (int)(currentPage/10)*10+1;
	   int pageBlock = 10;
	   int endPage = startPage + pageBlock - 1;
	   if(endPage > pageCount){
	      endPage = pageCount;
	   } %>
		<div align="center">
<%      
		if(startPage > 10){%>   
			<b><a href="../mypage/myPage.jsp?sid=<%=sid%>&sql1=<%=sql1%>&sql2=<%=sql2%>&pageNum=<%=startPage-10%>">[이전]</a></b>
		<%}
			for(int i=startPage; i<=endPage; i++){%> 
				<a href="../mypage/myPage.jsp?sid=<%=sid%>&sql1=<%=sql1%>&sql2=<%=sql2%>&pageNum=<%=i%>"><b>[<%=i%>]</b></a>
		
				<%} if(endPage < pageCount){%>
				<b><a href="../mypage/myPage.jsp?sid=<%=sid%>&sql1=<%=sql1%>&sql2=<%=sql2%>&pageNum=<%=startPage+10%>">[다음]</a></b>
		   <%}   
		   }%>
		</div>
</body>
</html>
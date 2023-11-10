<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="odega.bean.mypage.myPageDTO" %>
<%@ page import="odega.bean.mypage.myPageDAO" %>
<jsp:useBean id="dto" class="odega.bean.mypage.myPageDTO" />
<jsp:useBean id="dao" class="odega.bean.mypage.myPageDAO" />
 
<head>
<meta charset="UTF-8">
<title> ODEGA 검색 </title>
<link href="/odega/resources/img/good.PNG" rel="shortcut icon" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>


<body>

	<%-- 페이징 --%>
<%
	int pageSize = 6;	// 한 페이지에 보여줄 글의 개수
	
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
<div  align="center">
	<div class="col" align="left" >
		<%@ include file="../user/top.jsp"%>
		<H4></H4>
		<h2>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp<a href="../post/posting.jsp?"><button type="button" class="btn btn-success"">포스트 작성</button></a>
		&nbsp&nbsp<a href="myPage.jsp?sql1=posts_num&sql2=desc"><button type="button" class="btn btn-success">마이페이지</button></a>
		
<%
		String search = request.getParameter("search");
		String searchOption = request.getParameter("searchOption");
		String sid = (String)session.getAttribute("sid");
		if(sid != null){%>
			&nbsp&nbsp<button onclick="window.location='../user/logout.jsp'" type="button" class="btn btn-success">로그아웃</button>
	<%} else {%>
			&nbsp&nbsp<button onclick="window.location='searchLoginFrom.jsp'" type="button" class="btn btn-success">로그인</button>
		<% }%>
		</h2>
	</div>
</div>
<hr />
<h1></h1><br />

	<%-- select를 사용하여 검색(제목만 검색) , 검색(제목+본문 검색) --%>
<div  align="center">
	<form action="search.jsp">
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<img src="/odega/resources/img/today.png" style="width:130px">
		<img src="/odega/resources/img/odega.gif" style="width:200px">
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<a href="search.jsp?searchOption=<%=searchOption%>&search=<%=search%>&sql1=p.reg&sql2=desc"><button type="button" class="btn btn-outline-success">검색 최신순</button></a>
		<a href="search.jsp?searchOption=<%=searchOption%>&search=<%=search%>&sql1=p.reg&sql2=asc"><button type="button" class="btn btn-outline-success" >검색 오래된순</button></a>
		<a href="search.jsp?searchOption=<%=searchOption%>&search=<%=search%>&sql1=p.post_like_cnt&sql2=desc"><button type="button" class="btn btn-outline-success">검색 좋아요순</button></a>
		<select name="searchOption">
			<option value = "total" >제목+본문</option>
			<option value = "title" >제목</option>
		</select>
		<input type="text" name="search" placeholder="보고싶은 포스팅은?" >
    	<button type="submit" class="btn btn-success">검색</button>
    </form>
</div>

 
<h1></h1><br />
<div align="center" >
	<h1>검색한 <% search = request.getParameter("search"); %>"<%=search %>" 의 포스트입니다.</h1>
	<h1></h1><hr />
</div>


<div class="container" >
	<div class="col" align="left" >
		<div>
			<%-- 검색시 최신순, 오래된순으로 검색하기위한 파라미터값 설정 --%>
<%
			String sql1 = request.getParameter("sql1");
			String sql2 = request.getParameter("sql2");
			if(sql1 == null || sql2 == null){
				sql1 = "p.reg";
				sql2 = "desc";
			} else{
				sql1 = request.getParameter("sql1");
				sql2 = request.getParameter("sql2");	
			}
	%>
				<div class="container" >
					<div class="row" align="center" >
						<%
							ArrayList<myPageDTO> list = dao.searchList(search, searchOption, start, end, sql1, sql2);
							for(myPageDTO sdto : list){
						%><div class="col-md-4">
									<a href="../post/postView.jsp?num=<%=sdto.getPost_num()%>">
										<img src="/odega/resources/img/<%=sdto.getImg()%>" style="width:200px; height:170px;" border="2;" />
									</a>
									<a href="posts.jsp?num=<%= sdto.getPost_num()%>">
										<b><p style="font-size:18px;">제목 : <%=sdto.getPost_title()%></p></b>
									</a>
									<p style="font-size:15px;">작성자 : <%=sdto.getNickname()%></p>
									<p style="font-size:15px;">조회수 : <%=	sdto.getPost_content_cnt() %></p>
									<p style="font-size:15px;">작성일 : <%=sdto.getPost_reg()%></p>
									<h5><img src="/odega/resources/img/good.PNG" style="width:30px"> <%=sdto.getPost_like_cnt()%></h5>
						</div>
							<% } %>
					</div>
				</div>
		</div>
	</div>
</div>
								<h1></h1><br/>
		
		
<div align="center">
<%
	int count = dao.searchCount(search, searchOption);
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (int)(currentPage/10)*10+1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}

		if(startPage > 10){
		%>	<b><a href="search.jsp?searchOption=<%=searchOption%>&search=<%=search%>&sql1=<%=sql1%>&sql2=<%=sql2%>&pageNum=<%=startPage-10%>">[이전]</a></b>
	<%	}
		
		for(int i=startPage; i<=endPage; i++){
		%> <a href="search.jsp?searchOption=<%=searchOption%>&search=<%=search%>&sql1=<%=sql1%>&sql2=<%=sql2%>&pageNum=<%=i%>"><b>[<%=i%>]</b></a>

	<%} if(endPage < pageCount){
	%>		<b><a href="search.jsp?searchOption=<%=searchOption%>&search=<%=search%>&sql1=<%=sql1%>&sql2=<%=sql2%>&pageNum=<%=startPage+10%>">[다음]</a></b>
	<%	}	
	}
%>
</div>
<h1></h1><br/>
<h1></h1><br/>
</body>
</html>



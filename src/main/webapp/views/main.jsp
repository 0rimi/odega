<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<%@ page import="java.util.ArrayList"%>
<%@ page import="odega.bean.mypage.myPageDTO"%>
<%@ page import="odega.bean.mypage.myPageDAO"%>
<%@ page import="odega.bean.mypage.MainDTO"%>
<%@ page import="odega.bean.mypage.MainDAO"%>

<head>
<meta charset="UTF-8">
<title>ODEGA</title>
<link href="/odega/resources/img/good.PNG" rel="shortcut icon" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<body>
 
   <%
   int pageSize = 6;   // 한 페이지에 보여줄 글의 개수
   
   String pageNum = request.getParameter("pageNum");
   if(pageNum == null){
      pageNum = "1";
   } 
   
   int currentPage = Integer.parseInt(pageNum);
   int start = (currentPage - 1) * pageSize + 1;
   int end = currentPage * pageSize;
%>

   <div align="center">
      <div class="col" align="left">
         <%@ include file="./user/top.jsp"%>
         <h2 class="mt-3"></h2>

      </div>
   </div>
   <hr />
   <h1></h1>
   <br />

   <div align="center">
      <form action="./mypage/search.jsp">
         &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <img
            src="/odega/resources/img/today.png" style="width: 130px"> <img src="/odega/resources/img/odega.gif" style="width: 200px"> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <a
            href="main.jsp?msql1=p.reg&msql2=desc"><button type="button" class="btn btn-outline-success">전체 최신순</button></a> <a href="main.jsp?msql1=p.reg&msql2=asc"><button type="button" class="btn btn-outline-success">전체 오래된순</button></a> <a
            href="main.jsp?msql1=p.post_like_cnt&msql2=desc"><button type="button" class="btn btn-outline-success">전체 좋아요순</button></a> <select name="searchOption">
            <option value="total">제목+본문</option>
            <option value="title">제목</option>
         </select> <input type="text" name="search" placeholder="보고싶은 포스팅은?">
         <button type="submit" class="btn btn-success">검색</button>
      </form>
   </div>

   <hr />

   <h1></h1>
   <br />


   <div class="container">
      <div class="col" align="left">

         <div>
            <%   
   String msql1 = request.getParameter("msql1");
   String msql2 = request.getParameter("msql2");
   
   if(msql1 == null || msql2 == null){
      msql1 = "p.reg";
      msql2 = "desc";
   } else{
      msql1 = request.getParameter("msql1");
      msql2 = request.getParameter("msql2");   
   }
   %>
   
<div class="container">
	<p style="padding-left: 20px;" class="display-6">최신글</p>
 	<div class="row" align="center">
 	<br />
<%
	   myPageDAO dao = new myPageDAO();
	   ArrayList<myPageDTO> list = dao.mainList(start, end , msql1 , msql2);
	   for(myPageDTO dto : list){
%>
			<div class="col-md-4">
                     <a href="../views/post/postView.jsp?num=<%= dto.getPost_num()%>"> <img src="/odega/resources/img/<%=dto.getImg()%>" style="width: 200px; height: 170px;" border="2;" />
                     </a> <a href="../views/post/postView.jsp?num=<%= dto.getPost_num()%>"> <b><p style="font-size: 18px;">
                              제목 :
                              <%=dto.getPost_title()%></p></b>
                     </a>
                     <p style="font-size: 15px;">
                        작성자 :
                        <%=dto.getNickname()%></p>
                     <p style="font-size: 15px;">
                        조회수 :
                        <%=dto.getPost_content_cnt() %></p>
                     <p style="font-size: 15px;">
                        작성일 :
                        <%=dto.getPost_reg()%></p>
                     <h5>
                        <img src="/odega/resources/img/good.PNG" style="width: 30px">
                        <%=dto.getPost_like_cnt()%></h5>
                  </div>
                  <% } %>
               </div>
               <hr />
            </div>
            <h1></h1>
            <br />

<div align="center">
               <%
   int mcount = dao.mcount();
   if(mcount > 0){
      int pageCount = mcount / pageSize + (mcount % pageSize == 0 ? 0 : 1);
      int startPage = (int)(currentPage/10)*10+1;
      int pageBlock = 10;
      int endPage = startPage + pageBlock - 1;
      if(endPage > pageCount){
         endPage = pageCount;
      }
      
      
      if(startPage > 10){
      %>
               <b><a href="main.jsp?msql1=<%=msql1%>&msql2=<%=msql2%>&pageNum=<%=startPage-10%>">[이전]</a></b>
               <%   }
      
      for(int i=startPage; i<=endPage; i++){
      %>
               <a href="main.jsp?msql1=<%=msql1%>&msql2=<%=msql2%>&pageNum=<%=i%>"><b>[<%=i%>]
               </b></a>

               <%} if(endPage < pageCount){
   %>
               <b><a href="main.jsp?msql1=<%=msql1%>&msql2=<%=msql2%>&pageNum=<%=startPage+10%>">[다음]</a></b>
               <%   }   
   }
%>
</div>
<h1></h1>

	 <!-- 운영자 추천 게시글 -->
			<div class="container">
			<p style="padding-left: 20px;" class="display-6">에디터's Pick</p>
			
					<div class="row" align="center">
					<br />
				<%
					MainDAO mdao = new MainDAO();
				
					ArrayList<MainDTO> aList = mdao.adminList();
					for (MainDTO mdto : aList){
					%>
						<div class="col-md-4">
							<a href="../views/post/postView.jsp?num=<%= mdto.getNum()%>"> <img src="/odega/resources/img/<%=mdto.getImg_url()%>" style="width: 200px; height: 170px;" border="2;" />
							</a> <a href="../views/post/postView.jsp?num=<%= mdto.getNum()%>"> <b><p style="font-size: 18px;">
										제목 :
										<%=mdto.getTitle()%></p></b>
							</a>
							<p style="font-size: 15px;">
								작성자 :
								<%=mdto.getNickname()%></p>
							<p style="font-size: 15px;">
								조회수 :
								<%=mdto.getPosts_views() %></p>
							<p style="font-size: 15px;">
								작성일 :
								<%=mdto.getReg()%></p>
							<h5>
								<a href="../views/recomm/like_cnt_up.jsp?num=<%=mdto.getNum()%>&page=main"><img src="/odega/resources/img/good.PNG" style="width: 30px"></a>
								<%=mdto.getPost_like_cnt()%></h5>
								</div>
					<%}%>
					</div>
					<hr />
				</div>
				<h1></h1>
				
			<!-- posts.reg 기준 현재 날짜에서 -6~-1일 중 좋아요 수가 높은 순 정렬 -->
			<div class="container">
			<p style="padding-left: 20px;" class="display-6">주간 랭킹</p>
			
					<div class="row" align="center">
					<br />
				<%
					ArrayList<MainDTO> wList = mdao.weeklyList();
					for (MainDTO mdto : wList){
					%>
						<div class="col-md-4">
							<a href="../views/post/postView.jsp?num=<%= mdto.getNum()%>"> <img src="/odega/resources/img/<%=mdto.getImg_url()%>" style="width: 200px; height: 170px;" border="2;" />
							</a> <a href="../views/post/postView.jsp?num=<%= mdto.getNum()%>"> <b><p style="font-size: 18px;">
										제목 :
										<%=mdto.getTitle()%></p></b>
							</a>
							<p style="font-size: 15px;">
								작성자 :
								<%=mdto.getNickname()%></p>
							<p style="font-size: 15px;">
								조회수 :
								<%=mdto.getPosts_views() %></p>
							<p style="font-size: 15px;">
								작성일 :
								<%=mdto.getReg()%></p>
							<h5>
								<a href="../views/recomm/like_cnt_up.jsp?num=<%=mdto.getNum()%>&page=main"><img src="/odega/resources/img/good.PNG" style="width: 30px"></a>
								<%=mdto.getPost_like_cnt()%></h5>
								</div>
					<%}%>
					</div>
					<hr />
				</div>
				<h1></h1>
<br />
<h1></h1>
<br />
</body>
</html>



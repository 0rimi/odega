<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="odega.bean.ThemeDAO"%>
<%@ page import="odega.bean.ThemeDTO"%>
<%@ page import="odega.bean.PostsDAO"%>
<%@ page import="odega.bean.PostsDTO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@include file="dbconn.jsp" %>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<%
   String sid = (String)session.getAttribute("sid");
   if(sid == null){
%>      <script>
         alert("로그인 후 사용 가능합니다.");
         window.location="../user/loginform.jsp";
      </script>
<%} else{
   		
   		int unum = (Integer)session.getAttribute("unum");
	%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>테마별</title>
<!--boot css-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<!--boot js-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link href="../../resources/static/css/themeView.css" rel="stylesheet">
</head>
<body>
	 <!--header-->
    <%@ include file="../user/top.jsp"%>
    <!--/header-->
	<!-- 메뉴 -->
	<div class="mt-3 ms-3">

	               	<b>테마별</b>
	               	<a href="./powerGuide.jsp">파워가이드</a></br>
	               	<hr>
	               	<%@include file="filter.jsp" %><!-- 필터 박스 -->
	                <!-- 검색전에는 인기 게시물을 나타냅니다 -->	
	               	<b>요즘 가장 많이 보는 포스팅</b><br><br>
	               	<div class="d-flex justify-content-start align-items-center">
	           <% 
			   	//	Connection conn = null;	
			   //		PreparedStatement pstmt = null;
			   //		ResultSet rs = null;
                	//인기글(게시물 좋아요를 많이 받은 순서)를 찾는 쿼리문
				  	String sql ="select a.*, b.*, nvl(( select distinct(img_url) from images c where  c.posts_num = a.num  and rownum =1 )   , 'cafe6.jpg')     as img_url   from posts a join users b on a.user_num = b.num where rownum < 11  order by a.post_like_cnt desc";
                	pstmt = conn.prepareStatement(sql);
    				rs = pstmt.executeQuery();
    				while (rs.next()) {
    			%>
                	<div id="profileBox" class="d-flex justify-content-center m-1">
                    <img src="/odega/resources/img/<%=rs.getString("img_url") %>" width="200 px" height="180 px">
                    <div id="infoBox" class="m-3">
                        <a href="../post/postView.jsp?num=<%=rs.getInt("num") %>" title="<%=rs.getString("nickname")%>의 포스팅 보기" ><%=rs.getString("title") %><a><br>      
                        <%=rs.getString("nickname") %> 님 <br>
                    
                        <div>
                            <div class="tag"><%=rs.getTimestamp("reg") %></div>
                         </div>
                        <div class="d-flex justify-content-start align-items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
                            </svg>
                            <div class="ms-1"><%=rs.getInt("post_like_cnt") %></div>
                        </div>
                </div>
            </div>
            </div>
            <br> <% }	
    				if (rs != null)
						rs.close();
		 			if (pstmt != null)
		 				pstmt.close();
		 			if (conn != null)
						conn.close();
			%> 
            <hr>
       		</div> 
       		<%} %>  
    </body>
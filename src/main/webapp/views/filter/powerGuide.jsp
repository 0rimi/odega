<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="odega.bean.ThemeDAO"%>
<%@ page import="odega.bean.ThemeDTO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>파워가이드</title>
<!--boot css-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<!--boot js-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link href="../../resources/static/css/themeView.css" rel="stylesheet">
</head>
<body>
	<!--header-->
	<%@ include file="../user/top.jsp"%>  
	<section>
		<div>
			<!-- 메뉴 -->
			<div class="mt-3 ms-3">
				
				<a href="../filter/main_theme.jsp">테마별</a> <b>파워가이드</b>
			</div>
			<hr>
			<!-- 파워가이드 -->
			<div class="container px-4 py-5" id="profile">
				<b class="pb-2 border-bottom" align="center">이달의 파워가이드</b>
				<div class="row g-4 py-5 row-cols-1 row-cols-lg-3">


					<%@include file="dbconn.jsp"%>

					<% 
				  	String sql ="select a.*, b.*, c.* from posts a join users b on a.user_num = b.num join images c on a.num = c.posts_num order by b.user_like_cnt desc";
                	pstmt = conn.prepareStatement(sql);
    				rs = pstmt.executeQuery();
    				while (rs.next()) {
    			%>
					<div class="col d-flex align-items-start">
						<div class="icon-square text-body-emphasis bg-body-secondary d-inline-flex align-items-center justify-content-center fs-4 flex-shrink-0 me-3">
							<img src="<%=rs.getString("img_url") %>" width="100 px" height="100px">
						</div>
						<div>
							<h3 class="fs-2 text-body-emphasis"><%=rs.getString("nickname") %>
								님
							</h3>
							<p>
								구독
								<%=rs.getInt("user_like_cnt") %>
								명
							</p>
							<a href="../post/postView.jsp?num=<%=rs.getInt("num") %>" class="btn btn-primary"> 방문하기 </a>
						</div>
					</div>
					<%} %>
					<!-- /프로필 끝  -->
				</div>
			</div>
	</section>
</html>
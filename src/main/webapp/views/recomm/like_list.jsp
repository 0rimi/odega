<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="odega.bean.PostsDTO"%>
<%@ page import="odega.bean.UserLikeDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>내가 좋아요 한 리스트</title>
</head>
<nav>
	<%@ include file="../user/top.jsp"%>
</nav>
<body>
	<%
   request.setCharacterEncoding("UTF-8");
   String user_id = (String)session.getAttribute("sid");
   
   
   UserLikeDAO likedao = new UserLikeDAO();
   
   ArrayList<PostsDTO> likelist = likedao.likeList(user_id);
%>
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">내가 좋아요 한 글 목록</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
					<thead>
						<tr role="row">
							<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 55px;">번호</th>
							<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending" style="width: 170px;">제목</th>
							<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending" style="width: 100px;">작성자</th>
							<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending" style="width: 260px;">내용</th>
							<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending" style="width: 115px;">작성일</th>
							<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Salary: activate to sort column ascending" style="width: 103px;">좋아요 수</th>
						</tr>
					</thead>
					<tfoot>
					</tfoot>
					<tbody>
						<%   
   
   if(likelist==null){   %>
						<tr class="odd">
							<td><h5>좋아요 한 글이 없습니다.</h5></td>
						</tr>
						<%   }else{
   
   for(PostsDTO dto : likelist){
   %>
						<tr class="odd">
							<td class="sorting_1"><%=dto.getNum()%></td>
							<td><a href="/odega/views/post/postView.jsp?num=<%= dto.getNum()%>"><%=dto.getTitle()%></a></td>
							<td><%=dto.getNickname()%></td>
							<td><%=dto.getContent()%></td>
							<td><%=dto.getReg()%></td>
							<td><%=dto.getPost_like_cnt()%></td>
						<tr>
						</tr>
						<%   }}
   %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
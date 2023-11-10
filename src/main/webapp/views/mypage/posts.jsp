<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="odega.bean.mypage.myPageDTO" %>
<%@ page import="odega.bean.mypage.myPageDAO" %>
<%@ page import="java.util.ArrayList" %>

<html>
 
<head>
<meta charset="UTF-8">
<title> ODEGA </title>
<link href="/odega/resources/img/good.PNG" rel="shortcut icon" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<body>
<div  align="center">
	<div class="col" align="left" >
	<H4></H4>
		<h2>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp<a href="main.jsp"><button type="button" class="btn btn-success">홈</button></a> 
		&nbsp&nbsp<a href="myPage.jsp?sql1=posts_num&sql2=desc"><button type="button" class="btn btn-success">마이페이지</button></a>

<%	// 글번호 전송을 위한 파라미터값 설정
int num = Integer.parseInt(request.getParameter("num"));
	myPageDAO dao = new myPageDAO();
	myPageDTO dto = dao.postsNum(num);

	String sid = (String)session.getAttribute("sid");
	if(sid != null){
%>
		&nbsp&nbsp<button onclick="window.location='postsLogout.jsp?num=<%=dto.getPost_num()%>'" type="button" class="btn btn-success">로그아웃</button>
	<%} else {
%>
		&nbsp&nbsp<button onclick="window.location='postsLoginForm.jsp?num=<%=dto.getPost_num()%>'" type="button" class="btn btn-success">로그인</button>
<% }%>
		</h2>

	</div>
</div>
<hr />

<h1></h1><br />

<div  align="center">
	<form action="search.jsp">
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<a href="main.jsp?msql1=p.reg&msql2=asc"><button type="button" class="btn btn-outline-success">최신순</button></a>
		<a href="main.jsp?msql1=p.reg&msql2=desc"><button type="button" class="btn btn-outline-success" >오래된순</button></a>
		<a href="main.jsp?msql1=p.post_like_cnt&msql2=desc"><button type="button" class="btn btn-outline-success">좋아요순</button></a>
		<select name="searchOption">
			<option value = "total" >제목+본문</option>
			<option value = "title" >제목</option>
		</select>
		<input type="text" name="search" placeholder="보고싶은 포스팅은?" >
    	<button type="submit" class="btn btn-success">검색</button>
    </form>
</div>


<%

	if(sid != null){ %>
<hr>
<div class="row" style="margin-bottom:20px; margin-left:1px;">
	<div class="col-lg-12" align="center">
		<a href="myPostsUpdate.jsp?num<%= dto.getPost_num()%>"><button type="button" class="btn btn-success">수정</button></a>
		<a href="myPostsDelete.jsp?num=<%=dto.getPost_num()%>"><button type="button" class="btn btn-success" >삭제</button></a>
	</div>
</div>
<%}%>
<div class="panel" style="margin-left:1px;">
	<div id="contAreaBox">
		<div class="panel">
			<div class="panel-body">
				<div class="table-responsive" style="text-align:center;">
					<table id="datatable-scroller"
						class="table table-bordered tbl_Form">
						<caption></caption>
						<colgroup>
							<col width="250px" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th class="active">작성자</th>
								<td>
									<%= dto.getNickname()%>
								</td>
							</tr>
							<tr>
								<th class="active">제목</th>
								<td>
									<%= dto.getPost_title()%>
								</td>
							</tr>
							
							<tr>
								<th class="active">조회수</th>
								<td>
									<% dao.contentCnt(dto); %>
								<%=	dto.getPost_content_cnt() %>
					
								</td>
							</tr>
							
							<tr>
								<th class="active">내용</th>
								<td>
									<%= dto.getPost_content()%><br />
									<%String img = dto.getImg();
									
									
									if(img != null) {
									%><img src="/odega/resources/img/<%=dto.getImg()%>" style="width:500px; height:300px;" border="2;" />
									<%} %>
								</td>
							</tr>
							<tr>
								<th class="active">작성일</th>
								<td>
									<%= dto.getPost_reg()%>
								</td>
							</tr>
							<tr>
								<th class="active">좋아요</th>
								<td>
									<%
										if(sid != null){
									%>
										<a href="likeCountPro.jsp?num=<%=dto.getPost_num()%>">
											<h5><img src="/odega/resources/img/good.PNG" style="width:30px"><%=dto.getPost_like_cnt()%></h5>
										</a>
									<%
										} else { %> 
										<a href="postsLoginForm.jsp?num=<%=dto.getPost_num()%>">
											<h5><img src="/odega/resources/img/good.PNG" style="width:30px"><%=dto.getPost_like_cnt()%></h5>
										</a>
									<% } %>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container">
	<div class="form-group">
		<%
		if(sid == null){%>
			<form action="postsLoginForm.jsp?num=<%= dto.getPost_num()%>" >
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<tr>
						<td style="border-bottom:none;" valign="middle">
							<a href="postsLoginForm.jsp?num=<%=dto.getPost_num()%>">
								<br>로그인</td>
							</a>
							<input type="hidden" name="num" value="<%= dto.getPost_num()%>"/>
							<td><input type="text" name = "comment" style="height:50px;" class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다."></td>
						<td><br><button type="submit" class="btn btn-success">작성</button></td>
					</tr>
				</table>
			</form>
		<%} else{
			int numId = (Integer)session.getAttribute("numId");
			String cmdCheck = (String)session.getAttribute("cmdCheck");%>
			<form action="postsComment.jsp?num=<%= dto.getPost_num()%>&numId=<%=numId%>" >
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<tr>
						<td style="border-bottom:none;" valign="middle"><br>[<%=cmdCheck%>]</td>
							<input type="hidden" name="num" value="<%= dto.getPost_num()%>"/>
							<td><input type="text" name = "comment" style="height:50px;" class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다."></td>
						<td><br><button type="submit" class="btn btn-success">작성</button></td>
					</tr>
				</table>
			</form>
		<%}%>
	</div>	
</div>


<div class="container">
	<div class="form-group">
		<form action="postsComment.jsp">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<tr>
					<%
					if(sid != null){
						ArrayList<myPageDTO> list = dao.commtList(num);
						for(myPageDTO cdto : list){
									
						int numId = (Integer)session.getAttribute("numId");
						%>
						<hr>
						<P>작성자&nbsp&nbsp&nbsp : <%=cdto.getNickname()%></P>
						<P>작성댓글 : <%=cdto.getComments_wri() %></P>
						<P>작성시간 : <%=cdto.getComments_reg() %></P>
							<%
							int cun = cdto.getComment_user_num();

							if(sid != null && numId == cun){ %>
							<a href="commentUpdate.jsp?num=<%= dto.getPost_num()%>&commNum=<%=cdto.getComments_num()%>"><button type="button" class="btn btn-success">수정</button></a>&nbsp&nbsp
							<a href="commentDelete.jsp?num=<%= dto.getPost_num()%>&commNum=<%=cdto.getComments_num()%>"><button type="button" class="btn btn-success" >삭제</button></a>
							<%}%>
						<%}%>
					<hr>
					<%} else {
						ArrayList<myPageDTO> list = dao.commtList(num);
							for(myPageDTO cdto : list){
										
							int numId = (Integer)session.getAttribute("numId");
							%>
							<hr>
							<P>작성자&nbsp&nbsp&nbsp : <%=cdto.getNickname()%></P>
							<P>작성댓글 : <%=cdto.getComments_wri() %></P>
							<P>작성시간 : <%=cdto.getComments_reg() %></P>	
						<%}
					}%>
					<hr>
				</tr>
			</table>
		</form>
	</div>	
</div>
<h1></h1><br /><h1></h1><br />
</body>
</html>
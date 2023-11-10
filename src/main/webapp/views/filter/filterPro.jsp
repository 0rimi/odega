<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="odega.bean.ThemeDAO" %>
<%@ page import="odega.bean.ThemeDTO" %>
<%@ page import="odega.bean.PostsDAO" %>
<%@ page import="odega.bean.PostsDTO" %>
<%@include file="dbconn.jsp" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색결과</title>
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
		<b>검색결과..</b><br><br>
	     <div class="d-flex justify-content-start align-items-center">  
	        
<%
	request.setCharacterEncoding("utf-8");
    //기본 쿼리문은 posts,tags,images,users 테이블을 조인하는 쿼리문입니다 
    String query = "select b.*, c.*, d.* from posts b join images c on b.user_num = c.num join users d on b.user_num = d.num " +  
    	" where 1=1 and b.num in (select a.post_num from tags a join posts b on a.post_num = b.num join images c on b.user_num = c.num join users d on b.user_num = d.num where 1=1   " ;
    // 항목별 각 선택 값을 입력받기 위한 변수를 선언
    String who = request.getParameter("who"); 
    String day = request.getParameter("day"); 
    String place = request.getParameter("place"); 
    String city = request.getParameter("city"); 
    System.out.println( "test1:" + who + " /" + day + "/" + place + "/" +city ); //선택한 항목값을 콘솔창에 확인하는 테스트용 출력문입니다. 
    			int x = 1;
		    	StringBuilder dynamicQuery = new StringBuilder(query);
		    	List <String> parameters = new ArrayList<>();
		 
				     if(who != null && !who.isEmpty()) { // append를 사용하여 체크된 값이 있을시 쿼리문 뒤에 붙는 형식의 메서드입니다. 
				  		dynamicQuery.append(" and tag_name like ?");
				     }  
				     if(day != null && !day.isEmpty()) {
					  		dynamicQuery.append(" or tag_name like ?");
					     }  
				     if(place != null && !place.isEmpty()) {
					  		dynamicQuery.append(" or tag_name like ?");
					     }  
				     if(city != null && !city.isEmpty()) {
					  		dynamicQuery.append(" or tag_name like ?"   );
					     }  
				     dynamicQuery.append(" group by post_num) order by b.post_like_cnt desc"); //if 쿼리문이 끝라면 작성일 순서로 출력하기 위한 쿼리문을 뒤에 붙였습니다.  
				         pstmt = conn.prepareStatement(dynamicQuery.toString());
				         pstmt.setString(1, "%" + who + "%");
				         pstmt.setString(2, "%" + day + "%");
				         pstmt.setString(3, "%" + place + "%");
				         pstmt.setString(4, "%" + city + "%"); 
				         rs = pstmt.executeQuery();
				         
	// 위에 쿼리문이 실행되는 구간입니다.		         
    while (rs.next()) { 
			x =x+1 ;     		
  %>    			
                	<div id="profileBox" class="d-flex justify-content-center m-1">
                    <img src="/odega/resources/img/<%=rs.getString("img_url")%>" width="200 px" height="180 px">
                    <div id="infoBox" class="m-3">
                        <a href="../post/postView.jsp?num=<%=rs.getInt("num") %>" title="<%=rs.getString("nickname")%>의 포스팅 보기" ><%=rs.getString("title") %><a><br>
                        <%=rs.getString("content") %><br>
                        <%=rs.getString("nickname") %> 님 <br>
                      <!--  다수의 태그를 하나로 묶기 위해 posts_num을 받아와 태그만 2차로 검색하는 쿼리문입니다. -->
                     <%
                     	pstmt = conn.prepareStatement("select tag_name from tags where post_num = ?");
                     	pstmt.setInt(1, rs.getInt("posts_num"));
                     	ResultSet rs2 = pstmt.executeQuery();
                     	while(rs2.next()){ 
                        String tag_name = rs2.getString("tag_name");%>
	                        <div class="tag">
	                        	#<%=tag_name %> 
	                        </div>
                        <%}%>
                        <div class="d-flex justify-content-start align-items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
                            </svg>
                            <div class="ms-1"><%=rs.getInt("post_like_cnt")%></div>
                        </div>
                </div>
                </div>
                </div>
            <br> 
           <%} 
    		if ( x== 1) { // 해당 검색 결과가 없을시 다시 main_theme로 돌아가는 메서드입니다. 
    	%> <script type="text/javascript" > 
			alert("해당 검색 결과가 없습니다!!");
			window.location.href = "main_theme.jsp";
			<% 
    		}
		    if (rs != null) {
		        rs.close();
		    }
		    if (pstmt != null) {
		        pstmt.close();
		    }
		    if (conn != null) {
		        conn.close();
		    }
		 %>
    	</script>
    		<% 
			    if (rs != null) {
			        rs.close();
			    }
			    if (pstmt != null) {
			        pstmt.close();
			    }
			    if (conn != null) {
			        conn.close();
			    }
			 %>
            <hr>
       	   </div>     
    </body>
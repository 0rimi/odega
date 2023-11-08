<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.*"%>
<%@ page import="odega.bean.PostsDAO"%>
<%@ page import="odega.bean.UserLikeDAO"%>
<html lang="ko">

<%
	String rpage = request.getParameter("page");
	
   int post_num = Integer.parseInt(request.getParameter("num"));
   String user_id = (String)session.getAttribute("sid");
   if(rpage  == null){
		rpage = "/odega/views/post/postView.jsp?num="+post_num;
	}else{
		rpage = "/odega/views/main.jsp";
	}
   if(user_id==null){%>
	<script> 
    alert("로그인 후 좋아요 할 수 있습니다.");
	history.go(-1);
	</script>
<%
   }else{
      UserLikeDAO like_dao = new UserLikeDAO();
      int check = like_dao.likeCheck(user_id, post_num);
      //System.out.println(user_id+"----"+post_num);
      if(check == 1 || check == 0){
         PostsDAO dao = new PostsDAO();
         dao.likeUp(post_num);
         like_dao.saveLikeList(user_id, post_num);
         if(user_id == "admin"){
        	dao.adminLike(post_num); 
         }
         response.sendRedirect(rpage);
      }else if(check == -1){%>
		<script> 
           alert("이미 좋아요 한 글입니다.");
           history.go(-1);
         </script>
<%
      }
   }
%>
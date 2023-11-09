<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="odega.bean.UserDAO"%> <!-- userdao의클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%>
 <%  request.setCharacterEncoding("UTF-8"); %> 
<jsp:useBean id="user" class="odega.bean.UserDTO" scope="page" />
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="user_pw" />
 <!DOCTYPE html>
     <html>
     <head>

     <title>loginAction</title>
     </head>
     <body>
<%
      	UserDAO userDAO = new UserDAO();
     	
     	int result = userDAO.login(user.getUser_id(), user.getUser_pw());
     	
    	if (result == 1) {
    		session.setAttribute("sid", user.getUser_id()); // 세션 생성 ☆★
    		
    		String checkbox = request.getParameter("checkbox");
    		if(checkbox!=null){ //체크박스가 클릭되어 있으면
    			Cookie cookie = new Cookie("id", user.getUser_id());
    			//유효시간 설정
    			cookie.setMaxAge(60*10); //10분간 유효
    			//사용자에게 쿠키값을 넘겨줌.
    			response.addCookie(cookie);
    		}
    		
     			PrintWriter script = response.getWriter();
     			script.println("<script>");
     			script.println("alert('로그인 성공')");
     			script.println("location.href = '../main.jsp'");
     			script.println("</script>");
     			String user_id = request.getParameter("user_id");
     			session.setAttribute("user_id", user_id); //세션저장
     			
     		} else if (result == 0){
     			PrintWriter script = response.getWriter();
     			script.println("<script>");
     			script.println("alert('비밀번호가 틀립니다.')");
     			script.println("history.back()");
     			script.println("</script>");
     			
     		} else if (result == -1){
     			PrintWriter script = response.getWriter();
     			script.println("<script>");
     			script.println("alert('존재하지 않는 아이디입니다.')");
     			script.println("history.back()");
     			script.println("</script>");
     			
     		} else if (result == -2){
     			PrintWriter script = response.getWriter();
     			script.println("<script>");
     			script.println("alert('데이터베이스 오류입니다.')");
     			script.println("history.back()");
     			script.println("</script>");
     		}
  
   

    	
    
   
   
     	%>
     	

     </body>
     </html>
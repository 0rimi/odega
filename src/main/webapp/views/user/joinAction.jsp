<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="odega.bean.UserDAO"%> <!-- userdao의클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%>

<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="odega.bean.UserDTO" scope="page" />
<jsp:setProperty name="user" property="*" />

<%


UserDAO userDAO = new UserDAO(); //데이터 베이스에 접근 가능한 객체생성

int result = userDAO.join(user.getUser_name(), user.getUser_id(), user.getUser_pw(), user.getNickname(), user.getBirth(), user.getPhone());


if (user.getUser_name() == null || user.getUser_id() == null || user.getUser_pw() == null 
|| user.getNickname() == null || user.getBirth() == null || user.getPhone() == null) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('입력이 안 된 사항이 있습니다.')");
    script.println("history.back()"); //뒤로가기
    script.println("</script>");
    
} else if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 존재하는 아이디입니다.')");
        script.println("history.back()");
        script.println("</script>");
        
      System.out.println(result);
        
    } else  { // 회원가입이 되었을때 로그인 페이지로 넘어감,-1이 아닌경우 전부 넘어가도록함
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입이 완료되었습니다.')");
        script.println("location.href = 'loginform.jsp'"); //로그인된 화면
        script.println("</script>");
    }
%>

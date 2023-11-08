<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="odega.bean.UserDAO"%> <!-- userdao의클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%>

<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="odega.bean.UserDTO" scope="page" />
<jsp:setProperty name="user" property="*" />
    

<meta charset="UTF-8">
<title>findPwAction</title>
<%

 UserDAO userDAO = new UserDAO();
 
String pw = userDAO.findPw(user.getUser_name(), user.getUser_id(), user.getPhone()); //비번을 디비에서 가져옴..실패시 널
System.out.println(pw);

if (user.getUser_name() == null || user.getUser_id() == null || user.getPhone() == null) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('입력이 안 된 사항이 있습니다.')");
    script.println("history.back()"); //뒤로가기
    script.println("</script>");
   
         
    
} else if (pw != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원님의 비밀번호는["+ pw + "]입니다.' );");
        script.println("location.href = 'loginform.jsp';");
        script.println("</script>");
        
 
    } else  { 
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('등록된 정보가 없습니다.')");
        script.println("history.back()"); 
        script.println("</script>");
    }
%>
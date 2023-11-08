<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="odega.bean.UserDAO"%> <!-- userdao의클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%>

<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="odega.bean.UserDTO" scope="page" />
<jsp:setProperty name="user" property="*" />
    

<meta charset="UTF-8">
<title>findIdAction</title>

<%

 UserDAO userDAO = new UserDAO();
 
String id = userDAO.findId(user.getUser_name(), user.getPhone()); //아이디를 디비에서 가져옴..실패시 널
System.out.println(id);

if (user.getUser_name() == null || user.getPhone() == null) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('입력이 안 된 사항이 있습니다.')");
    script.println("history.back()"); //뒤로가기
    script.println("</script>");
   
         
    
} else if (id != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원님의 아이디는["+ id + "]입니다.' );");
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

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
	
		//비밀번호 암호화해서 표출
	
			int pwSize = pw.length()/2;
			String resultPw_1 = pw.substring(0, pwSize );
	
			// 뒤의 절반은 *로 표시
			String tmp = "";
			if (pwSize%2 ==1) { // 홀수인 경우 * 한개 더 추가
				for( int i=0; i<pwSize+1; i++ ) {
					tmp += "*";
				}
			} else {
				for( int i=0; i<pwSize; i++ ) {
					tmp += "*";
				}
			}
			String resultPw = resultPw_1 + tmp;

	
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원님의 비밀번호는["+ resultPw + "]입니다.' );");
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
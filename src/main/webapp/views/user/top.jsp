<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%--  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> --%> 
<html>

<head>
<meta charset="UTF-8">
<title>ODEGA</title>
<link href="/odega/resources/img/good.PNG" rel="shortcut icon" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>


<style>
.dropdown>ul>li {
 display: inline-block;
 position: relative;
}

.dropdown>ul>li>ul {
 position: absolute;
 list-style-type: none;
 padding-left: 0px;
 padding-top: 5px;
 display: none;
}

.dropdown>ul>li:hover>ul {
 display: block;
}

w:hover {
 text-decoration: none;
 color: pink
}
</style>
</head>

<body>
				
  <font face="Yang Rounded">
   <table height="170px" border="0" width="100%"
    style="background-color: white" border="0">
    <tr>
     <td>
      <%
       if (session.getAttribute("sid") == null) {
      %>
      <table width="100%" height="50px" border="0" align="right"
       border="0" style="color: white; background-color: black">
      
       <h1 class="display-7">  <logo class="m-3"  style="cursor: pointer"><a href="/odega/views/main.jsp">✈ODEGA</a></logo></h1></i>
       
       <tr>
       
        <td style="width: 550px"></td>
        
        <td onClick="location.href='${pageContext.request.contextPath}/views/user/loginform.jsp'" style="cursor: pointer"><w>로그인</w></td>
        <td>
        <td onClick="location.href='${pageContext.request.contextPath}/views/user/joinform.jsp'" style="cursor: pointer"><w>회원가입</w></td>
        <td>
        <td onClick="location.href='${pageContext.request.contextPath}/views/user/findId.jsp'" style="cursor: pointer"><w>아이디찾기</w></td>
        <td>
        <td onClick="location.href='${pageContext.request.contextPath}/views/user/findPw.jsp'" style="cursor: pointer"><w>비밀번호찾기</w></td>
       </tr>
      </table>
<%} else {%>
      <table width="100%" height="50px" border="0" align="right"
       border="0" style="color: white; background-color: black">
       <b><h2>  <logo class="m-3"  style="cursor: pointer"><a href="/odega/views/main.jsp">✈ODEGA</a></logo></h2></b>
       <tr>
      
        <td style="width: 550px"></td>
        <td onClick="myinfomenu()" style="cursor: pointer"><w><%=session.getAttribute("user_id")%>님</w></td>
        <td></td>
        <td onClick="location.href='${pageContext.request.contextPath}/views/user/logout.jsp'" style="cursor: pointer"><w>로그아웃</w></td>
        <td></td>
        <td onClick="myinfomenu()" style="cursor: pointer"><w>회원 정보 관리</w></td>
       </tr>
      </table>
      
<%} %>
     </td>
    </tr>
    <tr align="center">
     <td align="center" style="height: 15px;">
      <table width="100%" align=center>
       <tr>
        <td>
         <table width="100%" height="50px" align=center border="0">
          <tr>
           <td align="center"><a href="${pageContext.request.contextPath}/views/main.jsp"></a></td>
          </tr>
         </table>
        </td>
       </tr>
      </table>
     </td>
    </tr>

    <tr>
     <td>
      <table width="100%" align="center" border="0" height="40px">
       <tr>
        <td>
         <table width="100%"  align="left" border="0" height="40px" style="color: black">
          <tr>
           <td>
            <div class="dropdown">
             <ul align="center" style="font-size: 17px">
              <li align="center" onClick="location.href='/odega/views/main.jsp'" 
              style="cursor: pointer;"><w>HOME</w></li>
              
              <li style="width: 80px">|</li>
              
              <li align="center" onclick="location.href='/odega/views/post/posting.jsp'" style="cursor: pointer;"><w>POSTING</w></li>
             
             <li style="width: 100px">|</li>
             
             
              <li align="center" style="cursor: pointer;" width="100px"><w>MYPAGE</w>
               <ul class="dropdown-menu"  align="center" style= "font-size: 14px;">
               
                <li  align="center" style="background-color: white;" 
                 onClick="location.href='/odega/views/mypage/myPageInfo.jsp'">내 정보 확인&nbsp;</li>
               
                <li  align="center" style="background-color: white; margin-top: 8px"
                 onClick="location.href='myPage.jsp?sql1=posts_num&sql2=desc'">내가 쓴 포스트 보기&nbsp;</li>
                
                <li  align="center" style="background-color: white; margin-top: 8px"
                 onClick="location.href='nowPassword.jsp'">비밀번호 변경&nbsp;</li>
               
                <li  align="center" style="background-color: white; margin-top: 8px"
                 onClick="location.href='nowMemberPass.jsp'">회원정보 변경&nbsp;</li>
               </ul></li>
               
              <li style="width: 100px">|</li>


                <li align="left"  onClick="location.href='/odega/views/filter/main_theme.jsp'" 
                style="cursor: pointer; "><w> FIND</w>
               <ul style="font-size: 16px; width: 55px;">
             </ul>
             
            </div>
           </td>
          </tr>

          <tr>
           <td height="10px"></td>
          </tr>
         </table>
        </td>
       </tr>
      </table>
     </font>
     </td>
    </tr>
   </table>
</body>

		</footer>
	
</html>
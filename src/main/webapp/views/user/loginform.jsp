<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HEAD>

<%
	request.setCharacterEncoding("UTF-8");
	String id = "";
	//쿠키 배열 생성
	Cookie[] cookies = request.getCookies(); 
	if(cookies !=null){
		for(int i=0;i<cookies.length;i++){ 
			if(cookies[i].getName().equals("id")){ //저장된 쿠키 이름이 "id" >인 경우
				id = cookies[i].getValue(); //쿠키값을 가져옴
				break;
			}
		}
	}	
%>
<TITLE>LOGIN</TITLE>


<style>
tr,td {
 border: 0px solid none;
}

#main-title {
 color: black;
 font-size: 65px;
 font-weight: bold;
}

#sub-title {
 color: black;
 font-size: 12pt;
}

#middle-title {
 color: black;
 font-size: 13pt;
 font-weight: bold;
}

k:hover {
 text-decoration: none;
 color: #FF1291
}
</style>

<script>

 function gologin() {
  var frm3 = document.loginscreen;
  frm3.method = "post";
  frm3.action = "./loginform.jsp";
  frm3.submit();
 }

 function gohome() {
  var frm = document.loginscreen;
  frm.method = "post";
  frm.action = "./top.jsp"; //넘어간화면
  frm.submit(); //등록이 될수 있는 조건이면, 정보를 보내겠다.
 }
 
 function gojoin() {
  var frm = document.loginscreen;
  frm.method = "post";
  frm.action = "./joinform.jsp";
  frm.submit();
 }

 function goidfind(){
  var frm = document.loginscreen;
  frm.method = "post";
  frm.action = "./id_find.jsp";
  frm.submit();
 }
 
 function gopwfind(){
  var frm = document.loginscreen;
  frm.method = "post";
  frm.action = "./pw_find.jsp";
  frm.submit();
 }
 
 function enter() {
  var frm = document.loginscreen;

  if (frm.user_id.value.length < 3) {
   alert("아이디를 올바르게 입력해주세요");
   return;
  }

  if (frm.user_pw.value.length < 3) {
   alert("비밀번호를 올바르게 입력해주세요");
   return;
  }
  frm.method = "post";
  frm.action = "./loginAction.jsp";
  frm.submit();
 }
 

</script>
</HEAD>

<BODY>

 
  <%@ include file="./top.jsp"%>
<br></br>
      <table width="450px" align="center" border="0" style="color: black; background-color: #F6F6F6; font-size: 30px; margin-top: -3%">
       <tr>
        <td>
         <table width="750px" align="center" border=0
          style="background-color: white">
          <tr>
           <td align="center">></td>
           <td>LOGIN</td>
           <td><div id="sub-title">| 로그인 페이지입니다.</td>
           <td width="300px"></td>
          </tr>
         </table>
        </td>
       </tr>
      </table>
      
<br></br><br></br>

     <form name="loginscreen" action="loginAction.jsp">
      <table width="500px" height="250px" align="center" border="8"
       style="font-size: 20px; border-color: #F6F6F6; border-style: solid; margin-top: 2%">
       <tr style="border: 0">
        <td style="border: 0">
         <table width="300px" height="100px" align="center" border="0">
          <tr align="center">
           <td colspan="4">* 아이디와 비밀번호를 입력하세요.</td>
          <tr align="center">
           <td><br>ID <input type="text" name="user_id" 
            style="width: 150px" value=<%=id%>></td>
          
           <td rowspan="2"><br>
           <input type="button" name="login" value="로그인"
            onClick="enter()" style="width: 80px; height: 60px"></td>
          </tr>
          <tr align="center">
           <td>PW <input type="password" name="user_pw"
            style="width: 150px"></td>
         
            <br></br>
          </tr> 
         </table>
        	<td height="50" colspan="2" align="center">아이디 저장<input type="checkbox" name="checkbox"></td>
</tr>
        </td>
       </tr>
      </table>
         
      </form>

</body>
	<br></br><br></br><br></br><br></br><br></br>
	 <!--css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
   
	<footer class="bg-dark text-white d-flex justify-content-between align-items-center" >  							  
			
			<h4><b><p>&copy; illuwa </p></b></h4>
			<h6>창완 영림 유미 예린 혜지 </h6>
			
		</footer>
	

</script>
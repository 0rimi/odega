<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findPw</title>

 <!--css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
   
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

</head>
<body>
 <%@ include file="./top.jsp"%>
<br></br>
      <table width="450px" align="center" border="0" style="color: black; background-color: #F6F6F6; font-size: 30px; margin-top: -3%">
       <tr>
        <td>
         <table width="750px" align="center" border=0
          style="background-color: white">
          <tr>
           <td align="center">></td>
           <td>FIND PW</td>
           <td><div id="sub-title">| 비밀번호 찾기 페이지입니다.</td>
           <td width="300px"></td>
          </tr>
         </table>
        </td>
       </tr>
      </table>
      
<br></br><br></br>
	<form action="findPwAction.jsp" name="pwfindscreen" method = "POST">
	
	<table width="500px" height="250px" align="center" border="8"
       style="font-size: 20px; border-color: #F6F6F6; border-style: solid; margin-top: 2%">
       <tr style="border: 0" >
        <td style="border: 0">
        
			<div class = "search-title">
				<h5>> 이름, 아이디, 휴대폰 번호를 입력하세요.</h5>
			</div>
		<section class = "form-search">
		<div class = "find-name">
				<label>NAME</label>
				<input type="text" name="user_name" class = "btn-name" placeholder = "회원 이름">
			<br>
			</div>
			<div class = "find-id">
				<label>ID</label>
				<input type="text" name="user_id" class = "btn-id" placeholder = "등록한 아이디">
			<br>
			</div>
			<div class = "find-phone">
				<label>PHONE</label>
				<input type="text" name="phone" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
			</div>
			<br>
	</section>
	
	<button type= "submit" value="찾기">찾기</button>
 	
 		  </td>
       </tr>
      </table>
      
 </form>
 
 </body>
 	<br></br><br></br><br></br><br></br><br></br>
		<footer class="bg-dark text-white d-flex justify-content-between align-items-center" >  							  
			
				<h4><b><p>&copy; illuwa </p></b></h4>
				<h6>창완 영림 유미 예린 혜지 </h6>
			
		</footer>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="odega.bean.ThemeDAO" %>
<%@ page import="odega.bean.ThemeDTO" %>
<%@ page import="odega.bean.FilterDAO" %>
<%@ page import="odega.bean.FilterDTO" %>
<%@ page import = "java.util.*" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<link href="../../resources/static/css/themeView.css" rel="stylesheet">
 <script type="text/javascript">
	 function reset(){  // 카테고리 선택 초기화 버튼 
		        location.reload();
	 }
	 
</script>
	<div id="title" class="text-center"> 
	               	<b>원하시는 항목을 선택하면 추천 여행지를 확인할 수 있습니다!</b><br><br>
	               	</div>
	     <form name="filterBox" action="filterPro.jsp" method="post" onreset="reset();">
	               	<div id="category">
	               	<div class="whoCategory">
	                <b>누구와</b> 
     					<input type="radio" value="혼자" id="혼자" name="who" checked ><label for="혼자" >혼자</label>
     					<input type="radio" value="친구" id="친구" name="who"><label for="친구">친구</label>
     					<input type="radio" value="연인" id="연인" name="who"><label for="연인">연인</label>
     					<input type="radio" value="가족" id="가족" name="who"><label for="가족">가족</label>
     					<input type="radio" value="반려견" id="반려견" name="who"><label for="반려견">반려견</label>
     					<input type="radio" value="아이" id="아이" name="who"><label for="아이">아이</label>
					</div></br>
					<div class ="dayCategory">
	               	<b>여행기간</b> 
	               		<input type="radio" value="당일치기" id="당일치기" name="day" checked><label for="당일치기">당일치기</label>
	               		<input type="radio" value="1박2일" id="1박2일" name="day"><label for="1박2일">1박2일</label>
	               		<input type="radio" value="2박3일" id="2박3일" name="day"><label for="2박3일">2박3일</label>
	               		<input type="radio" value="장기여행" id="장기여행" name="day"><label for="장기여행">장기여행</label>       	
	             	</div></br>
	   				<div class ="placeCategory">
	               	<b>여행목적</b> 
	               		<input type="radio" value="자연/힐링" id="자연/힐링" name="place" checked><label for="자연/힐링">자연/힐링</label>
	               		<input type="radio" value="맛집" id="맛집" name="place" ><label for="맛집">맛집</label>
	               		<input type="radio" value="레포츠/체험" id="레포츠/체험" name="place" ><label for="레포츠/체험">레포츠/체험</label>
	               		<input type="radio" value="드라이브" id="드라이브" name="place" ><label for="드라이브">드라이브</label>
	               		<input type="radio" value="쇼핑" id="쇼핑" name="place" ><label for="쇼핑">쇼핑</label>
	               		<input type="radio" value="포토스팟" id="포토스팟" name="place" ><label for="포토스팟">포토스팟</label>
	               	</div></br>
	           		<div class = "cityCategory">
	               	<b>여행지역</b>
		               	<select name="city" >
		               	<option value="선택안함">선택안함</option>
		               	<option value="서울">서울</option>
		               	<option value="인천">인천</option>
		               	<option value="부산">부산</option>
		               	<option value="광주">광주</option>
		               	<option value="대전">대전</option>
		               	<option value="대구">대구</option>
		               	<option value="울산">울산</option>
		               	<option value="제주도">제주도</option>
		               	</select><br><br>
	               	</div>
	               	</div>
	               	<div id="button" class="text-center">
	               	<input type="reset" class="btn btn-light" value="선택초기화" onclick="reset();"> 
	                <input type="submit" class="btn btn-light" value="여행지찾기" >
	               	</div>
	       
	     	</form>
	        <hr>
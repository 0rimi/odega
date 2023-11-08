<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    
<%--
	<form>태그 필수 설정
	전송방식 : post만 가능
	enctype 추가 : multipart/form-data
 --%>

<form action="pro.jsp" method="post" enctype="multipart/form-data">
	name:<input type="text" name="name"><br>
	file:<input type="file" name="save"><br>
	<button type="submit">업로드</button>
</form>
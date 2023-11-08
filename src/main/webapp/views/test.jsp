<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=bsyhva5qif"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!--boot css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <!--boot js-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- style -->
    <link href="test.css" rel="stylesheet">
</head>
<body>
<div><div class="places p-3 d-flex justify-content-between"><div><h4 id="">에그옐로우 주차장</h4><div class="des"><small>ㅁㄴㅇㄻㄴㅇㅁㅎ</small></div></div><div><span class="delPlace">X</span></div></div></div>
<div><div class="places p-3 d-flex justify-content-between"><div><h4 id="">에그옐로우 주차장</h4><div class="des"><small>ㅁㄴㅇㄻㄴㅇㅁㅎ</small></div></div><div><span class="delPlace">X</span></div></div></div>
<div><div class="places p-3 d-flex justify-content-between"><div><h4 id="">에그옐로우 주차장</h4><div class="des"><small>ㅁㄴㅇㄻㄴㅇㅁㅎ</small></div></div><div><span class="delPlace">X</span></div></div></div>
<div><div class="places p-3 d-flex justify-content-between"><div><h4 id="">에그옐로우 주차장</h4><div class="des"><small>ㅁㄴㅇㄻㄴㅇㅁㅎ</small></div></div><div><span class="delPlace">X</span></div></div></div>
<div><div class="places p-3 d-flex justify-content-between"><div><h4 id="">에그옐로우 주차장</h4><div class="des"><small>ㅁㄴㅇㄻㄴㅇㅁㅎ</small></div></div><div><span class="delPlace">X</span></div></div></div>


<script>
//장소삭제
$(document).on("click", ".delPlace", function (e) {
	 var thisDiv = $(this)[0].parentNode.parentNode.parentNode
	 console.log(thisDiv);
	 thisDiv.remove();
 });
</script>
</body>
</html>
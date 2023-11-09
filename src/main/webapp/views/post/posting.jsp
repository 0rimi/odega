<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포스팅</title>
<!--boot css-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<!--boot js-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- style -->
<link href="../../resources/static/css/posting.css" rel="stylesheet">

</head>
<body>
	<%-- header --%>
	<!-- <%@ include file="../user/top.jsp"%>  -->
	<%-- /header --%>
	
	<%
		//로그인 한 사람인지 확인
   		String sid = (String)session.getAttribute("sid");
   		if(sid == null){
	%>
		<script>
        	alert("로그인 후 사용 가능합니다.");
         	window.location="/odega/views/user/loginform.jsp";
      	</script>
	<%}
   		//로그인한 사용자 정보 받아오기
   		int unum = (Integer)session.getAttribute("unum");
	%>
	
	<section>
		<form method="post" action="#" enctype="multipart/form-data">
			<!-- 제목&본문 -->
			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="title" placeholder="제목을 입력하세요" name="title" onChange="onChangeInputTitle()">
				<label for="title">제목</label>
			</div>
															<!-- 임시유저넘버:3 -->
			<input class="form-control" id="unum" type="hidden" name="user_num" value="<%=unum%>">
			
			<!-- 태그추가 -->
			<div class="m-2 d-flex align-items-center">
				<div class="col-1">
					<label for="tag"></label><span style="width: 100px;">태그 입력</span>
				</div>
				<div class="col-2">
					<input class=" form-control" type="text" id="tag" size="20" placeholder="스페이스 혹은 엔터 입력" />
				</div>
			</div>
			<ul id="tag-list"></ul>
	
	
			<textarea class="form-control" rows="10" cols="40" id="contents" name="content" placeholder="본문을 입력해주세요!" onChange="onChangeInputContents()"></textarea>
			<!-- /제목&본문 -->
			
			<!-- 장소 추가하기 -->
			<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modal_addPlace" onclick="mapOpen()">장소 추가하기</button>
			
			<!-- 추가한 장소 리스트 -->
			<div id="placeList"></div>
			
			<!-- 포스트 전송 -->
			<button type="button" class="btn btn-primary" onclick="submitForm()">포스팅하기</button>
		</form>
		
		<!-- Modal -->
		<jsp:include page="modal.jsp" />
		
	</section>
</body>
<script>
//본문데이터 선언하기
var title;
var contents;
var unum = $('#unum').val();
function onChangeInputTitle () {
	title = document.getElementById('title').value;
}
function onChangeInputContents () {
	contents = document.getElementById('contents').value;
}

var tags = [];
var tag = {};
var places = [];
var imgs = []; 	

//폼전송
function submitForm(){
	//폼데이터	
	formData = new FormData();
	formData.append("title",title);
	formData.append("contents", contents);
	formData.append("unum", unum);
	for(i = 0 ; i < tags.length ; i++){
		formData.append("tag", tags[i]);
	}
	for(i = 0 ; i < places.length ; i++){
		formData.append("places", places[i]);
	}
	for(i = 0 ; i < imgs.length ; i++){
		formData.append("imgs"+i, imgs[i]);
	}
	console.log(imgs);
	$.ajax({
		type : 'POST',
		url : '/odega/views/post/postPro.jsp',
		//dataType : 'json',
		enctype: 'multipart/form-data',
		contentType: false,
        processData: false,
        //traditional : true,
		cache: false,
		data : formData,	//json일땐, JSON.stringify(data)
		success : function(result) {
			console.log(result);
		}
	});
	
	window.location.href = '/odega/views/main.jsp';	
}

$(document).ready(function () {
	
	var counter = 0;
	
  	//태그 추가
  	function addTag(value) {
	    tag[counter] = value; // 태그를 Object 안에 추가
	    counter++; // counter 증가 삭제를 위한 del-btn 의 고유 id 가 된다.
	    tags.push(value);	//태그값을 tags에 넣기
  	};
  	//서버에 넘길때 tag값들을 array type 으로 
  	function marginTag() {
	    return Object.values(tag).filter(function (word) {
	        return word !== "";
      	});
  	};

  $("#tag").on("keyup", function (e) {
      var self = $(this);
      console.log("입력중...");

      //엔터 및 스페이스바 입력(추가)
      if (e.key === "Enter" || e.keyCode == 32) {
        var tagValue = self.val(); // 입력값
        
        //null값이아니라면
        if (tagValue !== "") {
          	// 같은 태그가 있는지 검사, 해당값이 array 로 return
          	var result = Object.values(tag).filter(function (word) {
              	return word === tagValue;
          	});

          	// 태그 중복 검사
	        if (result.length == 0) {
	        	$("#tag-list").append("<li class='tag-item'>"
	        			+ tagValue
	        			+ "<span class='del-btn close-icon' idx='" + counter + "'>X</span></li>");
            	addTag(tagValue);
            	self.val("");
          	} else {
	            alert("태그값이 중복됩니다.");
          	}
        }
        
        e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
      }
    });

  // 삭제 버튼:비동기적 생성이므로 document 최초 생성시가 아닌 검색을 통해 이벤트를 구현시킨다.
  $(document).on("click", ".del-btn", function (e) {
      var index = $(this).attr("idx");
      tag[index] = "";
      $(this).parent().remove();
      tags.splice(index, 1);
   });
  
  //장소삭제
  $(document).on("click", ".delPlace", function (e) {
	  var thisDiv = $(this)[0].parentNode.parentNode.parentNode
	  //console.log(thisDiv);
	  console.log("추가된 장소 삭제");
	  thisDiv.remove();
	});
  
  
});
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- style -->
<link href="../../resources/static/css/mapSearch.css" rel="stylesheet">

<div class="modal modal-lg fade" id="modal_addPlace" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">장소 추가하기</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<h4>
					<b>지도에서 선택하기</b>
				</h4>
				<%--지도검색--%>
				<div class="modal-search">
					<div class="map_wrap">
						<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

						<div id="menu_wrap" class="bg_white">
							<div class="option">
								<div>
									<form onsubmit="searchPlaces(); return false;">
										키워드 : <input type="text" placeholder="검색어를 입력하세요." name="keyword" id="keyword" size="15">
										<button type="submit">검색하기</button>
									</form>
								</div>
							</div>
							<hr>
							<ul id="placesList"></ul>
							<div id="pagination"></div>
						</div>
					</div>
					<%-- 지도선택시 인포박스 --%>
					<div id="selectedMap" class="noShow"></div>


					<form id="img-add">
						<%--이미지저장--%>
						<h4>
							<label for="img"><b>사진 추가</b></label>
						</h4>
						<input type="file" id="img" name="img" class="form-control" accept="image/*" onchange="uploadImg(event);" required multiple="multiple">
						<div class="d-flex justify-content-center">
							<div id="imgBox" class=""></div>
						</div>
						<!-- 장소설명 -->
						<div>
							<h4>
								<b>장소 설명</b>
							</h4>
							<textarea class="form-control" rows="10" cols="40" id="description" placeholder="장소에 대해 설명해주세요!"></textarea>
						</div>
					</form>
				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="addPlace()">추가하기</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0cca8e3b19b74a631f6bc2cee6045b61&libraries=services"></script>
<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer;
var mapOption;

// 지도를 생성합니다    
var map;

// 장소 검색 객체를 생성합니다
var ps;

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow;

function mapOpen(){
	//console.log("맵");
	mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};

	// 지도를 생성합니다    
	map = new kakao.maps.Map(mapContainer, mapOption);

	// 장소 검색 객체를 생성합니다
	ps = new kakao.maps.services.Places();

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	infowindow = new kakao.maps.InfoWindow({
		zIndex : 1
	});
}


// 키워드로 장소 검색
searchPlaces();

// 키워드 검색 요청 함수
function searchPlaces() {
	//console.log(keyword+"를 검색!!!");
	var keyword = document.getElementById('keyword').value;

	if (!keyword.replace(/^\s+|\s+$/g, '')) {
		//console.log('키워드 입력 필요!');
		return false;
	}

	// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	ps.keywordSearch(keyword, placesSearchCB);
}

// 장소검색 완료 함수
function placesSearchCB(data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {

		// 정상적으로 검색이 완료됐으면
		// 검색 목록과 마커를 표출합니다
		displayPlaces(data);

		// 페이지 번호를 표출합니다
		displayPagination(pagination);

	} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

		alert('검색 결과가 존재하지 않습니다.');
		return;

	} else if (status === kakao.maps.services.Status.ERROR) {

		alert('검색 결과 중 오류가 발생했습니다.');
		return;

	}
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

	var listEl = document.getElementById('placesList'), menuEl = document
			.getElementById('menu_wrap'), fragment = document
			.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

	// 검색 결과 목록에 추가된 항목들을 제거합니다
	removeAllChildNods(listEl);

	// 지도에 표시되고 있는 마커를 제거합니다
	removeMarker();

	for (var i = 0; i < places.length; i++) {

		// 마커를 생성하고 지도에 표시합니다
		var placePosition = new kakao.maps.LatLng(places[i].y,
				places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
				i, places[i]); // 검색 결과 항목 Element를 생성합니다

		// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		// LatLngBounds 객체에 좌표를 추가합니다
		bounds.extend(placePosition);

		// 마커와 검색결과 항목에 mouseover 했을때
		// 해당 장소에 인포윈도우에 장소명을 표시합니다
		// mouseout 했을 때는 인포윈도우를 닫습니다
		(function(marker, title) {
			kakao.maps.event.addListener(marker, 'mouseover',
					function() {
						displayInfowindow(marker, title);
					});

			kakao.maps.event.addListener(marker, 'mouseout',
					function() {
						infowindow.close();
					});
			
			kakao.maps.event.addListener(marker, 'click',
					function() {
						console.log(marker);
					});
			
			itemEl.onmouseover = function() {
				displayInfowindow(marker, title);
			};

			itemEl.onmouseout = function() {
				infowindow.close();
			};
		})(marker, places[i].place_name);

		fragment.appendChild(itemEl);
	}

	// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	listEl.appendChild(fragment);
	menuEl.scrollTop = 0;

	// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

	var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
			+ (index + 1)
			+ '"></span>'
			+ '<div class="info" data-id="'+places.id+'" data-x="'+places.x+'" data-y="'+places.y+'">'
			+ '   <h5>'
			+ places.place_name + '</h5>';

	if (places.road_address_name) {
		itemStr += '    <span>' + places.road_address_name + '</span>'
				+ '   <span class="jibun gray">' + places.address_name
				+ '</span>';
	} else {
		itemStr += '    <span>' + places.address_name + '</span>';
	}

	itemStr += '  <span class="tel">' + places.phone + '</span>'
			+ '</div>';

	el.innerHTML = itemStr;
	el.className = 'item';

	return el;
}

// 검색결과 목록을 클릭했을 때 호출되는 함수입니다
$(document).on('click', '.info', function(e) {
	// console.log("클릭 : " + e.target.firstChild.nodeValue);
	//클릭한 값 추출 및 저장
	place_id = e.currentTarget.dataset.id;
	longi = e.currentTarget.dataset.x;
	lat = e.currentTarget.dataset.y;
	place_name = e.currentTarget.children[0].innerText;
	address_name = e.currentTarget.children[1].textContent;

	//console.log("id:"+id+", 좌표:"+lat+","+longi+", 장소:"+place_name+", 주소:"+address_name);
	
	//지도 닫기
	//$('#map').hide();
	$('.map_wrap').addClass('noShow');
	$('#menu_wrap').addClass('noShow');
	//뷰페이지에 선택장소 이름 띄워주기
	$('#selectedMap').empty();
	var selectM = '<h5><b>'+place_name+'</b></h5>'
					+'<span>'+address_name+'</span><hr>'
					+'<div class="d-flex justify-content-end"><button type="button" class="btn btn-secondary" id="reMap" onclick="reMap()">다시 선택하기</button></div>';
	$("#selectedMap").append(selectM);
	$('#selectedMap').removeClass('noShow');
});

//이미지 파일 업로드시
//썸네일 보여주기
  	function uploadImg(event) {
       var reader = new FileReader();

       reader.onload = function(event) {
       	if(document.getElementById('imgBox').children != null){
       		//console.log('기존 이미지 삭제');
       		$('#imgBox').empty();
       	} 
         	var img = document.createElement("img");
         	img.setAttribute("src", event.target.result);
         	document.querySelector("div#imgBox").appendChild(img);
       };

       reader.readAsDataURL(event.target.files[0]);
     }
//파일 업로드
/*
const fileInput = document.getElementById("img");
const handleFiles = () => {
	const selectedFile = fileInput.files[0];	//여러파일인경우 [...fileInput.files];
	console.log(selectedFile);
};
fileInput.addEventListener("change", handleFiles);	//파일(첨부)버튼에 addEventListener
*/


//e.target.files[0]
const fileInput = document.getElementById("img"); //file input btn

const fileEvent = (e) => {
  	const reader = new FileReader();
  	reader.onload = () => {
    console.log('파일 업로드 성공');
  };
  reader.readAsText(fileInput.files[0]);	//파일이하나이므로 첫번째 요소만 read
  uploadFile = fileInput.files[0];
  //console.log(fileInput.files[0]);
}

fileInput.addEventListener('change', fileEvent);//파일(첨부)버튼에 addEventListener

//formData
const upload = () => {
    let formData = new FormData();
    formData.append('uploadFile', e.target.files[0]);
}


var modalPlace = {};


//추가하기버튼 클릭시
function addPlace(){
	var place = [place_id,lat,longi,place_name,address_name];
	var des = $('#description').val();
	var file = uploadFile;

	modalPlace = {place,file,des};
	
	//console.log(modalPlace);
	
	var placeList = document.getElementById('placeList');
	var aPlace = document.createElement("div");
	aPlace.innerHTML = "<div class='places p-3 d-flex justify-content-between'>"
		+"<div>"
		+"<h4 id=''>"+place[3]+"</h4>"
		+"<div class='des'><small>"+des+"</small></div>"
		+"</div><div><span class='delPlace'>X</span>"
		+"</div>";
	placeList.append(aPlace);
	
	//본문 places 에 추가
	places.push(modalPlace);
	
	//input reset
	initialize();
	
	//모달 닫기
	$("#modal_addPlace").modal('hide');
}

//초기화
function initialize(){
	//지도 초기화
	reMap();
	//file 초기화
	$('#img').val(undefined);
	$('#imgBox').empty();
	//설명 초기화
	$('#description').val(undefined);
}

//다시선택하기 버튼 클릭시
function reMap(){
	console.log("지도다시선택");
	//info창 삭제
	$('#selectedMap').addClass('noShow');
	//지도 열기
	$('.map_wrap').removeClass('noShow');
	$('#menu_wrap').removeClass('noShow');
};

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
	imgOptions = {
		spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		offset : new kakao.maps.Point(13, 37)
	// 마커 좌표에 일치시킬 이미지 내에서의 좌표
	}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
			imgOptions), marker = new kakao.maps.Marker({
		position : position, // 마커의 위치
		image : markerImage
	});

	marker.setMap(map); // 지도 위에 마커를 표출합니다
	markers.push(marker); // 배열에 생성된 마커를 추가합니다

	return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
	var paginationEl = document.getElementById('pagination'), fragment = document
			.createDocumentFragment(), i;

	// 기존에 추가된 페이지번호를 삭제합니다
	while (paginationEl.hasChildNodes()) {
		paginationEl.removeChild(paginationEl.lastChild);
	}

	for (i = 1; i <= pagination.last; i++) {
		var el = document.createElement('a');
		el.href = "#";
		el.innerHTML = i;

		if (i === pagination.current) {
			el.className = 'on';
		} else {
			el.onclick = (function(i) {
				return function() {
					pagination.gotoPage(i);
				}
			})(i);
		}

		fragment.appendChild(el);
	}
	paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
	var content = '<div style="padding:5px;z-index:1;">' + title
			+ '</div>';

	infowindow.setContent(content);
	infowindow.open(map, marker);
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {
	while (el.hasChildNodes()) {
		el.removeChild(el.lastChild);
	}
}
</script>
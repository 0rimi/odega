<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import = "odega.bean.PostsDAO"%>
<%@ page import = "odega.bean.PostsDTO"%>
<%@ page import = "odega.bean.MapDAO"%>
<%@ page import = "odega.bean.MapDTO"%>
<%@ page import = "odega.bean.ImageDAO"%>
<%@ page import = "odega.bean.ImageDTO"%>
<%@ page import = "odega.bean.TagDAO"%>
<%@ page import = "odega.bean.TagDTO"%>

<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글</title>

    <!--boot css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <!--boot js-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <!-- naver map api -->
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=bsyhva5qif"></script>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <!-- css -->
    <link href="../../resources/static/css/postView.css" rel="stylesheet">
</head>
<body>
    <!--header-->
    <header class="bg-dark text-white d-flex justify-content-between align-items-center">
        <%-- 
        <logo class="m-3">ODEGA</logo>
        <!-- 로그인 안했을때 -->
        <div id="loginBox" class="d-flex justify-content-end m-3">
            <a>로그인</a>
            <a>회원가입</a>
        </div>
        <!-- 로그인 했을때
        <div id="miniProfile"></div> -->
        --%>
        <%@ include file="../user/top.jsp"%>
    </header>
    <!--/header-->

    <nav>
        
    </nav>


<%
	//포스팅넘버 받아오기
	//request.setCharacterEncoding("UTF-8");
	int postNum = Integer.parseInt(request.getParameter("num"));
	
	//임의의 포스트번호 1(이 후 파라미터로 받아오기)
	PostsDAO postDAO = new PostsDAO();
	PostsDTO post = postDAO.getPost(postNum);

   	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm");
%>
	<section>
        <div>
            <div class="mt-3 ms-3">
                <b><%=post.getNickname() %></b> 님의 홍대나들이
            </div>

            <!-- profileBox -->
            <hr>
            <div class="d-flex justify-content-start align-items-center">
                <div id="profileBox" class="d-flex justify-content-center m-1">
                    <img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png">
                    <div id="infoBox" class="m-3">
                        <b><%=post.getTitle() %></b><br>
                        <%=post.getNickname() %> 님<br>
                        <%= sdf.format(post.getReg())%> 수정<br>
                        <div>
                        	<%
                        		TagDAO tagDAO = new TagDAO();
								List<TagDTO> tagList = tagDAO.getTagList(postNum);
								
								for(int i=0; i<tagList.size(); i++){%>
									<div class="tag">#<%=tagList.get(i).getTag_name() %></div>
							<%}%>
                        </div>
                        <div class="d-flex justify-content-start align-items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                <a href="/odega/views/recomm/like_cnt_up.jsp?num=<%=post.getNum()%>">
                                <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></a>
                            </svg>
                            <!--<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                                <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
                            </svg>-->
                            <div class="ms-1"><%=post.getPost_like_cnt() %></div>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <!-- /profileBox -->
        </div>


		<%
			MapDAO mapDAO = new MapDAO();
			List<MapDTO> mapList = mapDAO.getMapList(postNum);
			
			ImageDAO imgDAO = new ImageDAO();
			List<ImageDTO> imgList = imgDAO.getImageList(postNum);
		%>
		<!--post-->
        <div id="contentBox">
            <div class="d-flex justify-content-center">
                <div id="maincon">
                    <div id="title" class="text-center"><b><i><%=post.getTitle() %></i></b></div>
                    <div id="content" class="text-center mt-3">
                        <%=post.getContent() %>
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-center mt-5">
            	<%if(mapList.size() != 0){%>
            	<div id="mapinfo" class="text-center">
                    <div class="d-flex justify-content-center">
                        <div id="imgs" class="d-flex justify-content-center">
							<ul class="list d-flex justify-content-between">
								<%-- image(map)갯수만큼 li 반복하기 --%>
								<%for(int i=0; i<mapList.size(); i++){%>
									<li class="flex-fill" id="tab<%=i%>">
										<a href="tab<%=i%>" class="btn btn-block flex-fill"><%=mapList.get(i).getPlace_name()%></a>
										<div id="tab<%=i%>" class="cont">
											<div id="imgBox">
												<img width="700px" src="../../resources/img/<%=imgList.get(i).getImg_url() %>" alt="">
											</div>
											<div class="d-flex justify-content-center">
												<div id="info" class="text-center m-3">
													<div id="infoDiv" class="d-flex justify-content-center">
														<div id="map<%=i%>" style="width:400px;height:400px;"></div>
														<script>
															var HOME_PATH = window.HOME_PATH || '.';
	
															var map_<%=mapList.get(i).getId()%> = new naver.maps.LatLng(<%=mapList.get(i).getLat()%>, <%=mapList.get(i).getLongi()%>),
																map<%=i%> = new naver.maps.Map('map<%=i%>', {
															        center: map_<%=mapList.get(i).getId()%>,
															        zoom: 19
															    }),
															    marker = new naver.maps.Marker({
															        map: map<%=i%>,
															        position: map_<%=mapList.get(i).getId()%>
															    });
															
															<%-- 
															var infowindow = new naver.maps.InfoWindow({
																content: [
																    '<div id="infoWindow">',
																    '   <div style="font-weight: bold; margin-bottom: 5px;">${sortedToiletData[0].FNAME}</div>',
																    '   <div style="font-size: 10px;">',
																    '		<h6><%=mapList.get(i).getPlace_name() %></h6>',
																    '		<p><%=mapList.get(i).getAddress_name() %></p>',
																    '<div>',
																    "</div>",
																  ].join(""),
																  maxWidth: 300,
																  anchorSize: {
																    width: 20,
																    height: 14,
																  },
																  borderColor: "#cecdc7"
															});	
														
															naver.maps.Event.addListener(marker, "click", function(e) {
															    if (infowindow.getMap()) {
															        infowindow.close();
															    } else {
															        infowindow.open(map<%=i%>, marker);
															    }
															});
															
															infowindow.open(map<%=i%>, marker);
															--%>
														</script>
													</div>
													<p><b><%=mapList.get(i).getPlace_name() %></b></p>
													<small><%=mapList.get(i).getAddress_name() %></small>
													<div>
														<%=mapList.get(i).getDescription() %>
													</div>
												</div>
											</div>
										</div>
									</li>
								<%} %>
							</ul>
						</div>
                    </div>
                </div>
                <%}else{%>
                	<div id="mapinfo" class="text-center">
	                    <div class="d-flex justify-content-center">
	                        <div id="imgs" class="d-flex justify-content-center">
								<ul class="list d-flex justify-content-between">
				                	<%for(int i=0; i<imgList.size(); i++){%>
										<li class="flex-fill" id="tab<%=i%>">
										<a href="tab<%=i%>" class="btn btn-block flex-fill"><%=i+1%></a>
										<div id="tab<%=i%>" class="cont">
											<div id="imgBox">
												<img width="700px" src="../../resources/img/<%=imgList.get(i).getImg_url() %>" alt="">
											</div>
										</div>
									</li>
									<%}%>
								</ul>
							</div>
						</div>
					</div>
                <%}%>
                <%-- /mapinfo --%>
            </div>
        </div>
        <!--/post-->
    </section>
</body> 

<script type="text/javascript">
	//페이지로드시에 tab0에만 is_on
	$(document).ready(function(){
		document.getElementById('tab0').classList.add('is_on');
		console.log('tab0 view');
	});

	const tabList = document.querySelectorAll('#imgs .list li');

	for (var i = 0; i < tabList.length; i++) {
		tabList[i].querySelector('.btn').addEventListener('click', function(e) {
			console.log("클릭: " + this)
			e.preventDefault();
			for (var j = 0; j < tabList.length; j++) {
				tabList[j].classList.remove('is_on');
			}
			this.parentNode.classList.add('is_on');
		});
	}
</script>
</html>
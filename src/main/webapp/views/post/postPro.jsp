<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import = "java.io.File" %>

<%@ page import = "odega.bean.PostsDAO"%>
<%@ page import = "odega.bean.PostsDTO"%>
<%@ page import = "odega.bean.MapDTO"%>
<%@ page import = "odega.bean.MapDAO"%>
<%@ page import = "odega.bean.ImageDAO"%>
<%@ page import = "odega.bean.ImageDTO"%>
<%@ page import = "odega.bean.TagDTO"%>
<%@ page import = "odega.bean.TagDAO"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <%
	String real = request.getRealPath("/resources/img");
    
    MultipartRequest mr = new MultipartRequest(request,real,1024*1024*10,"UTF-8");
    
  	//posts(title,content,unum) 값을 DTO에 넣어서 보내주기
  	PostsDTO post = new PostsDTO();
  	post.setTitle(mr.getParameter("title"));
  	post.setContent(mr.getParameter("contents"));
  	int unum = Integer.parseInt(mr.getParameter("unum"));
  	post.setUser_num(unum);
  	System.out.println(post);
  	//포스트 insert
  	PostsDAO postDAO = new PostsDAO();
  	postDAO.insertPost(post);
  	
  	//가장 최근 작성 postnum 가져오기
  	int postNum = postDAO.getLatestPostNum();
    
  	//img 각각 List에 넣기(img_post_num은 dao에서)
  	List<ImageDTO> imgList = new ArrayList<ImageDTO>();
  	Enumeration enu = mr.getFileNames();
  	
  	while(enu.hasMoreElements()){
  		//enu 의 요소를 file에 저장
  		String file= (String)enu.nextElement(); 
  		// 파일의 이름 얻기
  		String filename = mr.getFilesystemName(file);
		//System.out.println("=======sss========="+file); // image1
  		ImageDTO img = new ImageDTO();
  		img.setImg_url(filename);
  		img.setPosts_num(postNum);
  		imgList.add(img);
  	}
  	System.out.println(imgList);
  	//images insert
  	ImageDAO imgDAO = new ImageDAO();
  	imgDAO.insertImgs(imgList);
  	
	//tags 각각 List에 넣기
	List<TagDTO> tagList = new ArrayList<TagDTO>();
	for(int i=0; i<mr.getParameterValues("tag").length; i++){
		TagDTO tag = new TagDTO();
		tag.setPost_num(postNum);
		tag.setTag_name(mr.getParameterValues("tag")[i]);
		tagList.add(tag);
	}
	System.out.println(tagList);
	//tag insert
	TagDAO tagDAO = new TagDAO();
	tagDAO.insertTags(tagList);

	//map 각각 List에 넣기
	List<MapDTO> mapList = new ArrayList<MapDTO>();
	for(int i=0; i<mr.getParameterValues("places").length; i++){
		MapDTO map = new MapDTO();
		String str = mr.getParameterValues("places")[i];
		String[] strArr = str.split(",");
		map.setId(Integer.parseInt(strArr[0]));
		map.setLat(strArr[1]);
		map.setLongi(strArr[2]);
		map.setPlace_name(strArr[3]);
		map.setAddress_name(strArr[4]);
		map.setDescription(strArr[5]);
		map.setImage_num(i+1);
		map.setPost_num(postNum);
		mapList.add(map);
	}
	System.out.println(mapList);
	//map insert
	MapDAO mapDAO = new MapDAO();
	mapDAO.insertMaps(mapList);
   %>
  
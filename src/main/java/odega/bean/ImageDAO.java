package odega.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import odega.OracleDB;

public class ImageDAO extends OracleDB{

	private static ImageDAO instance = new ImageDAO();

	public static ImageDAO getInstance() {
		return instance;
	}

	public ImageDAO() {}

	// postnum에 따른 imgList
	public List<ImageDTO> getImageList(int post_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<ImageDTO> imgList = new ArrayList<ImageDTO>();

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(" select * from images where posts_num=? order by post_image_num asc ");
			pstmt.setInt(1, post_num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ImageDTO img = new ImageDTO();
				img.setNum(rs.getInt("num"));
				img.setImg_url(rs.getString("img_url"));
				img.setPosts_num(rs.getInt("posts_num"));
				img.setPost_image_num(rs.getInt("post_image_num"));
				imgList.add(img);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		System.out.println("ImageDAO.getImageList : " + imgList);

		return imgList;
	}
	
	//insert: postNum 받으면 해당 post에 imgList넣어주기
	public void insertImgs(List<ImageDTO> imgList) throws Exception {
		System.out.println("insertImages");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			//for문 돌려야함
			for(int i=0; i<imgList.size(); i++) {
				//insert into maps values (num,img_url,post_num,post_image_num);
				pstmt = conn.prepareStatement("insert into images values (images_seq.nextval,?,?,?)");
				pstmt.setString(1, imgList.get(i).getImg_url());
				pstmt.setInt(2,imgList.get(i).getPosts_num());
				pstmt.setInt(3, i+1);
				pstmt.executeUpdate();
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

}

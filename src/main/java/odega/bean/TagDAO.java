package odega.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import odega.OracleDB;

public class TagDAO extends OracleDB{
	
	private static TagDAO instance = new TagDAO();
	
	public static TagDAO getInstance() {
		return instance;
	}
	public TagDAO() {}
	
	//postnum에 따른 mapList
	public List<MapDTO> getMapList(int post_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<MapDTO> mapList = new ArrayList<MapDTO>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
			" select * from maps where post_num = ? ");
			pstmt.setInt(1, post_num);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MapDTO map = new MapDTO();
				map.setId(rs.getInt("id"));
				map.setPlace_name(rs.getString("place_name"));
				map.setAddress_name(rs.getString("address_name"));
				map.setDescription(rs.getString("description"));
				map.setLat(rs.getString("lat"));
				map.setLongi(rs.getString("longi"));
				map.setImage_num(rs.getInt("image_num"));
				map.setPost_num(rs.getInt("post_num"));
				mapList.add(map);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		System.out.println("MapDAO.getMapList : "+mapList);
		
		return mapList;
	}
	
}

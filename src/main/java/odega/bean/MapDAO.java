package odega.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import odega.OracleDB;

public class MapDAO extends OracleDB{
	
	private static MapDAO instance = new MapDAO();
	
	public static MapDAO getInstance() {
		return instance;
	}
	public MapDAO() {}
	
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
	
	
	//insert: postNum 받으면 해당 post에 mapList넣어주기
	public void insertMaps(int postNum, List<MapDTO> mapList) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			//insert into maps values (id,place_name,address_name,description,post_num,image_num,lat,longi);
			pstmt = conn.prepareStatement("insert into maps values (?,?,?,?,?,?,?,?)");
			
			//for문 돌려야함
			for(int i=0; i<mapList.size(); i++) {
				pstmt.setInt(1, mapList.get(i).getId());
				pstmt.setString(2, mapList.get(i).getPlace_name());
				pstmt.setString(3, mapList.get(i).getAddress_name());
				pstmt.setString(4, mapList.get(i).getDescription());
				pstmt.setInt(5,postNum);
				pstmt.setInt(6, mapList.get(i).getImage_num());
				pstmt.setString(7, mapList.get(i).getLat());
				pstmt.setString(8, mapList.get(i).getLongi());
			}
			pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
}

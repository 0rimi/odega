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
	
	//insert: 해당 post에 tagList넣어주기
	public void insertTags(List<TagDTO> tagList) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			//for문 돌려야함
			for(int i=0; i<tagList.size(); i++) {
				//insert into maps values (num,tagName,reg,postNum);
				pstmt = conn.prepareStatement(" insert into tags values (tag_num_seq.nextval,?,sysdate,?) ");
				pstmt.setString(1, tagList.get(i).getTag_name());
				pstmt.setInt(2, tagList.get(i).getPost_num());
				pstmt.executeUpdate();
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	
	// postnum에 따른 tagList
	public List<TagDTO> getTagList(int post_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<TagDTO> tagList = new ArrayList<TagDTO>();

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(" select * from tags where post_num = ? ");
			pstmt.setInt(1, post_num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				TagDTO tag = new TagDTO();
				tag.setTag_num(rs.getInt("tag_num"));
				tag.setTag_name(rs.getString("tag_name"));
				tag.setReg(rs.getTimestamp("reg"));
				tag.setPost_num(rs.getInt("post_num"));
				tagList.add(tag);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return tagList;
	}
	
}

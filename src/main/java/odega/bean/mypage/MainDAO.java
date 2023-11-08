package odega.bean.mypage;
import odega.OracleDB;
import java.sql.*;
import java.util.ArrayList;

public class MainDAO extends OracleDB{
	Connection conn = null;	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//전체 조회수 순으로 정렬
	public ArrayList<MainDTO> mostClickList(){
		conn = getConnection();
		ArrayList<MainDTO> list = new ArrayList<>();
		try {
			String sql = "select * from (select p.* , u.nickname , i.img_url from posts p , users u , (SELECT * FROM ( "
					+ "         SELECT posts_num, img_url "
					+ "              , ROW_NUMBER() OVER(PARTITION BY posts_num ORDER BY posts_num DESC) AS rn "
					+ "           FROM images "
					+ "       ) "
					+ " WHERE rn = 1) i where p.user_num = u.num and p.num = i.posts_num) "
					+ " order by content_cnt desc fetch first 3 rows only ";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				MainDTO dto = new MainDTO();
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
				dto.setPosts_views(rs.getInt("content_cnt"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setNickname(rs.getString("nickname"));
				dto.setImg_url(rs.getString("img_url"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	//일주일 간의 좋아요 높은 순
	public ArrayList<MainDTO> weeklyList(){
		conn = getConnection();
		ArrayList<MainDTO> list = new ArrayList<>();
		try {
			String sql = "select * from (select p.*, u.nickname, i.img_url from posts p, users u, (SELECT * FROM ( "
					+ "         SELECT posts_num, img_url "
					+ "              , ROW_NUMBER() OVER(PARTITION BY posts_num ORDER BY posts_num DESC) AS rn "
					+ "           FROM images "
					+ "       ) WHERE rn = 1) i where p.user_num = u.num and p.num = i.posts_num) where reg "
					+ "between sysdate - 6 and sysdate - 0 order by post_like_cnt desc fetch first 3 rows only";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				MainDTO dto = new MainDTO();
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
				dto.setPosts_views(rs.getInt("content_cnt"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setNickname(rs.getString("nickname"));
				dto.setImg_url(rs.getString("img_url"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	//관리자가 좋아요 한 글
		public ArrayList<MainDTO> adminList(){
			conn = getConnection();
			ArrayList<MainDTO> list = new ArrayList<>();
			try {
				String sql = "select * from (select p.*, u.nickname, i.img_url from posts p, users u, (SELECT * FROM ( SELECT posts_num, img_url "
						+ ", ROW_NUMBER() OVER(PARTITION BY posts_num ORDER BY posts_num DESC) AS rn "
						+ "FROM images ) WHERE rn = 1) i where p.user_num = u.num and p.num = i.posts_num) where admin_like=1 "
						+ "order by reg desc fetch first 3 rows only";
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					MainDTO dto = new MainDTO();
					dto.setNum(rs.getInt("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
					dto.setPosts_views(rs.getInt("content_cnt"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setNickname(rs.getString("nickname"));
					dto.setImg_url(rs.getString("img_url"));
					list.add(dto);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs, pstmt, conn);
			}
			return list;
		}
}

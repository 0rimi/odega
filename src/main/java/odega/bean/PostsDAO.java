package odega.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import odega.OracleDB;

public class PostsDAO extends OracleDB{
	
private static PostsDAO instance = new PostsDAO();
	
	public static PostsDAO getInstance() {
		return instance;
	}
	public PostsDAO() {}
	
	//Post num주고 하나 가져오기
	//조회수 증가 기능 추가
	public PostsDTO getPost(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		PostsDTO post=null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update posts set content_cnt =content_cnt+1 where num = ? ");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement( " select p.*, u.nickname "
										+ "	from posts p "
			+ "			INNER JOIN users u "
			+ "			ON p.user_num = u.num "
			+ "			where p.num = ? " );
			
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				post = new PostsDTO();
				post.setNum(rs.getInt("num"));
				post.setTitle(rs.getString("title"));
				post.setContent(rs.getString("content"));
				post.setPost_like_cnt(rs.getInt("post_like_cnt"));
				post.setReg(rs.getDate("reg"));
				post.setUser_num(rs.getInt("user_num"));
				post.setNickname(rs.getString("nickname"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		System.out.println("postsDAO.getPost : "+post);
		
		return post;
	}
	
	//포스트좋아요
	public int likeUp(int posts_num) {
        int likeup=0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
           conn=getConnection();
           pstmt = conn.prepareStatement("update posts set post_like_cnt = post_like_cnt + 1 where num = ?");
            pstmt.setInt(1, posts_num);
            likeup = pstmt.executeUpdate();
            
            PostsDTO dto = new PostsDTO();
            dto.setPost_like_cnt(likeup);
            
        }catch(Exception e) {
           e.printStackTrace();
        }finally {
           close(rs, pstmt, conn);
        }return likeup;
     }
	
	//관리자 계정으로 좋아요 시 admin_like 증가
	public int adminLike(int posts_num) {
		int adminlike=0;
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        	pstmt = conn.prepareStatement("select admin_like from posts where num = ?");
        	pstmt.setInt(1, posts_num);
        	rs = pstmt.executeQuery();
        	
        	if(rs.getInt("admin_like")<=0) {
        		pstmt = conn.prepareStatement("update posts set admin_like = admin_like + 1 where num = ?");
        		pstmt.setInt(1, posts_num);
        		adminlike = pstmt.executeUpdate();
        	}
        	
        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
        	close(rs, pstmt, conn);
        }
        return adminlike;
	}
	
	
	//insert : postsDTO값들 넣으면 포스트 작성
	public void insertPost(PostsDTO post) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
					//num, title, content, *post_like_cnt, user_num, *reg, *content_cnt, *posts_views, *admin_like, update_reg
		String SQL = "insert into posts (num, title, content, user_num, update_reg) values (posts_seq.nextval, ?,?,?,sysdate);";
		
		try {
			conn = getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, post.getTitle());
			pstmt.setString(2, post.getContent());
			pstmt.setInt(3, post.getUser_num());
		} catch(Exception e) {
			e.printStackTrace();	//예외처리
		}finally {
			 close(rs,pstmt,conn);
		}
	}
	
	//select : user_num 기준 가장 최근 작성 postNum 가져오기
	public int getPostNum(int unum) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int post_num = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select num from (select * from posts where user_num = 3 order by reg desc) where rownum = 1;");
			pstmt.setInt(1, unum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				post_num = rs.getInt("num");
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}	
		return post_num;
	}
}

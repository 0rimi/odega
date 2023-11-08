package odega.bean.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import odega.OracleDB;

public class myPageDAO extends OracleDB {
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
   
   //로그인 체크
	public boolean loginCheck(myPageDTO dto) {
		boolean result = false;
		try {
			conn = getConnection();
			String sql = " select user_id from users where user_id=? and user_pw=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 해당 계정의 비밀번호 확인
	public String passwordCheck(String sid) {
		String result = "";
		try {
			conn = getConnection();
			String sql = " select user_pw from users where user_id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("user_pw");
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 접속한 계정의 계정번호 확인
	public int loginUsernumCheck(myPageDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = " select num from users where user_id=? and user_pw=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt("num");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 접속한 계정의 닉네임 확인(댓글 적용)
	public String commentCheck(myPageDTO dto) {
		String result = "";
		try {
			conn = getConnection();
			String sql = " select nickname from users where user_id=? and user_pw=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getString("nickname");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 접속한 계정의 정보 확인
	public myPageDTO myInfo(String sid) {
		myPageDTO dto = new myPageDTO();
		try {
			conn = getConnection();
			String sql = "select * from users where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setUserid(rs.getString("user_id"));
				dto.setUserpw(rs.getString("user_pw"));
				dto.setNickname(rs.getString("nickname"));
				dto.setBirth(rs.getTimestamp("birth"));
				dto.setUser_like_cnt(rs.getInt("user_like_cnt"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setPhone(rs.getInt("phone"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	// 메인 페이지의 모든 글정보 리스트
	public ArrayList<myPageDTO> list(String sid, int start, int end , String sql1 , String sql2){
		ArrayList<myPageDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			String sql = " select * from "
					+ " (select ro.* , rownum r from "
					+ " (select u.num, u.nickname, p.title, p.user_num, p.reg, p.content_cnt, i.img_url, i.posts_num, p.posts_views, p.post_like_cnt, p.num \"PNUM\" "
					+ " from users u, posts p, images i "
					+ " where u.num = p.user_num and i.posts_num = p.num and user_id=? and p.posts_views=0  and post_image_num=1 order by "+ sql1 +" " + sql2 + " ) ro) "
					+ " where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()){
				myPageDTO dto = new myPageDTO();
				dto.setNum(rs.getInt("num"));
				dto.setNickname(rs.getString("nickname"));
				dto.setPost_title(rs.getString("title"));
				dto.setPost_user_num(rs.getInt("user_num"));
				dto.setPost_reg(rs.getTimestamp("reg"));
				dto.setPost_num(rs.getInt("posts_num"));
				dto.setImg(rs.getString("img_url"));
				dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
				dto.setPost_content_cnt(rs.getInt("content_cnt"));
				dto.setPost_views(rs.getInt("posts_views"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	// 마이페이지의 자신의 작성글 리스트
	public ArrayList<myPageDTO> mainList(int start, int end, String msql1, String msql2){
		ArrayList<myPageDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			String sql = " select * from "
					+ " (select ro.* , rownum r from "
					+ " (select u.status, u.num, u.nickname, p.title, p.user_num, p.reg, p.content_cnt, i.img_url, p.posts_views, i.posts_num, p.post_like_cnt, p.num \"PNUM\" "
					+ " from users u, posts p, images i "
					+ " where u.num = p.user_num and i.posts_num(+) = p.num and p.posts_views=0 and u.status=1 and post_image_num=1 order by " + msql1 + " " + msql2 + " ) ro) "
					+ " where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()){
				myPageDTO dto = new myPageDTO();
				dto.setNum(rs.getInt("num"));
				dto.setNickname(rs.getString("nickname"));
				dto.setPost_title(rs.getString("title"));
				dto.setPost_user_num(rs.getInt("user_num"));
				dto.setPost_reg(rs.getTimestamp("reg"));
				dto.setPost_num(rs.getInt("pnum"));
				dto.setImg(rs.getString("img_url"));
				dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
				dto.setPost_content_cnt(rs.getInt("content_cnt"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	// 검색한 글정보 리스트 (제목만 or 제목+글내용)
	public ArrayList<myPageDTO> searchList(String search, String searchOption, int start, int end, String sql1, String sql2){
		ArrayList<myPageDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			if(searchOption.equals("title")) {
				String sql = " select * from "
						+ " (select ro.* , rownum r from "
						+ " (select u.num, u.nickname, p.title, p.user_num, p.reg, i.img_url, p.content_cnt, i.posts_num, p.posts_views, p.post_like_cnt, p.num \"PNUM\" "
						+ " from users u, posts p, images i "
						+ " where u.num = p.user_num and i.posts_num(+) = p.num and p.title like ?  and p.posts_views=0 and post_image_num=1 order by " + sql1 + " " + sql2 +" ) ro) "
						+ " where r >= ? and r <= ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, start);  
				pstmt.setInt(3, end);  
				rs = pstmt.executeQuery();
				while(rs.next()){
					myPageDTO dto = new myPageDTO();
					dto.setNum(rs.getInt("num"));
					dto.setNickname(rs.getString("nickname"));
					dto.setPost_title(rs.getString("title"));
					dto.setPost_user_num(rs.getInt("user_num"));
					dto.setPost_reg(rs.getTimestamp("reg"));
					dto.setPost_num(rs.getInt("pnum"));
					dto.setImg(rs.getString("img_url"));
					dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
					dto.setPost_content_cnt(rs.getInt("content_cnt"));
					list.add(dto);
				}
			} else{
				String sql = " select * from "
						+ " (select ro.* , rownum r from "
						+ " (select u.num, u.nickname, p.title, p.user_num, p.reg, i.img_url, p.content_cnt, i.posts_num, p.posts_views, p.post_like_cnt, p.num \"PNUM\" "
						+ " from users u, posts p, images i "
						+ " where u.num = p.user_num and i.posts_num(+) = p.num and (p.title like ? or p.content like ?) and p.posts_views=0 and post_image_num=1  order by "  + sql1 + " " + sql2 + " ) ro) "
						+ " where r >= ? and r <= ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setString(2, "%" + search + "%");
				pstmt.setInt(3, start);  
				pstmt.setInt(4, end);  
				rs = pstmt.executeQuery();
				while(rs.next()){
					myPageDTO dto = new myPageDTO();
					dto.setNum(rs.getInt("num"));
					dto.setNickname(rs.getString("nickname"));
					dto.setPost_title(rs.getString("title"));
					dto.setPost_user_num(rs.getInt("user_num"));
					dto.setPost_reg(rs.getTimestamp("reg"));
					dto.setPost_num(rs.getInt("pnum"));
					dto.setImg(rs.getString("img_url"));
					dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
					dto.setPost_content_cnt(rs.getInt("content_cnt"));
					list.add(dto);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	// 유저 검색 (이름 or 닉네임)
	public ArrayList<myPageDTO> searchUser(String search, String searchOption, int start, int end, String sql1, String sql2){
		ArrayList<myPageDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			if(searchOption.equals("name")) {
				String sql = " select * from "
						+ " (select ro.* , rownum r from "
						+ " (select * "
						+ " from users "
						+ " where user_name like ? order by " + sql1 + " " + sql2 + ") ro) "
						+ " where r >= ? and r <= ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, start);  
				pstmt.setInt(3, end);  
				rs = pstmt.executeQuery();
				while(rs.next()){
					myPageDTO dto = new myPageDTO();
					dto.setNum(rs.getInt("num"));
					dto.setUserid(rs.getString("user_id"));
					dto.setNickname(rs.getString("nickname"));
					dto.setBirth(rs.getTimestamp("birth"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setStatus(rs.getInt("status"));
					list.add(dto);
				}
			} else if(searchOption.equals("nickname")){
				String sql = " select * from "
						+ " (select ro.* , rownum r from "
						+ " (select * "
						+ " from users "
						+ " where nickname like ? order by " + sql1 + " " + sql2 + ") ro) "
						+ " where r >= ? and r <= ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, start);  
				pstmt.setInt(3, end);  
				rs = pstmt.executeQuery();
				while(rs.next()){
					myPageDTO dto = new myPageDTO();
					dto.setNum(rs.getInt("num"));
					dto.setUserid(rs.getString("user_id"));
					dto.setNickname(rs.getString("nickname"));
					dto.setBirth(rs.getTimestamp("birth"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setStatus(rs.getInt("status"));
					list.add(dto);
				}
			}else{
				String sql = " select * from "
						+ " (select ro.* , rownum r from "
						+ " (select * "
						+ " from users "
						+ " where phone like ? order by " + sql1 + " " + sql2 + ") ro) "
						+ " where r >= ? and r <= ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, start);  
				pstmt.setInt(3, end);  
				rs = pstmt.executeQuery();
				while(rs.next()){
					myPageDTO dto = new myPageDTO();
					dto.setNum(rs.getInt("num"));
					dto.setUserid(rs.getString("user_id"));
					dto.setNickname(rs.getString("nickname"));
					dto.setBirth(rs.getTimestamp("birth"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setStatus(rs.getInt("status"));
					list.add(dto);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	// 삭제할 포스트 검색 (제목만 , 제목+본문)
	public ArrayList<myPageDTO> searchPostDel(String search, String searchOption, int start, int end, String sql1, String sql2){
		ArrayList<myPageDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			if(searchOption.equals("title")) {
				String sql = " select * from "
						+ " (select ro.* , rownum r from "
						+ " (select u.num, u.nickname, p.title, p.user_num, p.reg, i.img_url, p.content_cnt, i.posts_num, p.posts_views, p.post_like_cnt, p.num \"PNUM\" "
						+ " from users u, posts p, images i "
						+ " where u.num = p.user_num and i.posts_num(+) = p.num and p.title like ?  and p.posts_views=0 and post_image_num=1 order by " + sql1 + " " + sql2 +" ) ro) "
						+ " where r >= ? and r <= ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, start);  
				pstmt.setInt(3, end);  
				rs = pstmt.executeQuery();
				while(rs.next()){
					myPageDTO dto = new myPageDTO();
					dto.setNum(rs.getInt("num"));
					dto.setNickname(rs.getString("nickname"));
					dto.setPost_title(rs.getString("title"));
					dto.setPost_user_num(rs.getInt("user_num"));
					dto.setPost_reg(rs.getTimestamp("reg"));
					dto.setPost_num(rs.getInt("pnum"));
					dto.setImg(rs.getString("img_url"));
					dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
					dto.setPost_content_cnt(rs.getInt("content_cnt"));
					list.add(dto);
				}
			} else{
				String sql = " select * from "
						+ " (select ro.* , rownum r from "
						+ " (select u.num, u.nickname, p.title, p.user_num, p.reg, i.img_url, p.content_cnt, i.posts_num, p.posts_views, p.post_like_cnt, p.num \"PNUM\" "
						+ " from users u, posts p, images i "
						+ " where u.num = p.user_num and i.posts_num(+) = p.num and (p.title like ? or p.content like ?) and p.posts_views=0 and post_image_num=1  order by "  + sql1 + " " + sql2 + " ) ro) "
						+ " where r >= ? and r <= ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setString(2, "%" + search + "%");
				pstmt.setInt(3, start);  
				pstmt.setInt(4, end);  
				rs = pstmt.executeQuery();
				while(rs.next()){
					myPageDTO dto = new myPageDTO();
					dto.setNum(rs.getInt("num"));
					dto.setNickname(rs.getString("nickname"));
					dto.setPost_title(rs.getString("title"));
					dto.setPost_user_num(rs.getInt("user_num"));
					dto.setPost_reg(rs.getTimestamp("reg"));
					dto.setPost_num(rs.getInt("pnum"));
					dto.setImg(rs.getString("img_url"));
					dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
					dto.setPost_content_cnt(rs.getInt("content_cnt"));
					list.add(dto);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	// 댓글 목록
	public ArrayList<myPageDTO> commtList(int num){
		ArrayList<myPageDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			String sql =  " select u.num \"unum\", p.num, c.comment_wri, c.reg, c.comment_views, c.comment_num, u.nickname, c.comment_user_num "
			+ " from posts p, comments c, users u "
			+ " where c.comment_user_num = u.num and p.num = c.content_num and comment_views=0 and c.content_num=? order by reg ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				myPageDTO dto = new myPageDTO();
				dto.setNum(rs.getInt("unum"));
				dto.setPost_num(rs.getInt("num"));
				dto.setComments_wri(rs.getString("comment_wri"));
				dto.setComments_reg(rs.getTimestamp("reg"));
				dto.setComment_views(rs.getInt("comment_views"));
				dto.setComments_num(rs.getInt("comment_num"));
				dto.setNickname(rs.getString("nickname"));
				dto.setComment_user_num(rs.getInt("comment_user_num"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	// 해당 계정의 작성 포스트 개수 (페이징)
	public int count(String sid) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = " select  count(*) "
					+ " from users u, posts p "
					+ " where u.num = p.user_num and  user_id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return result;
	}

	// 전체 포스트 개수 (페이징)
	public int mcount() {
		int result = 0;
		try {
			conn = getConnection();
			String sql = " select  count(*) from users u, posts p where u.num = p.user_num and posts_views=0 ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return result;
	}
	
	
	public int ucount() {
		int result = 0;
		try {
			conn = getConnection();
			String sql = " select  count(*) from users where status=1 ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return result;
	}
	
	public int userSearchCount(String search , String searchOption) {
		int result = 0;
		try {
			conn = getConnection();
			if(searchOption.equals("name")) {
				String sql = " select  count(*) from users where user_name like ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			} else {
				String sql = " select  count(*) from users where nickname like ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return result;
	}
	
	// 좋아요 개수
	public int likeCountCnt(myPageDTO dto) {
		int result = 0;
		conn = getConnection();
		try {
		String sql = "update posts set post_like_cnt = post_like_cnt+1  where num=? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, dto.getPost_num());
		result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		close(rs, pstmt, conn);
		return result;
	}
	
	// 포스트 글 삭제
	public int deletePosts(int num) {
		int result = 0;
		conn = getConnection();
		try {
		String sql = " update posts set posts_views=1 where num=? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		close(rs, pstmt, conn);
		return result;
	}
	
	// 포스트 글 수정
	public int updatePosts(int num) {
		int result = 0;
		conn = getConnection();
		try {
		String sql = " update posts set admin_like=1,update_reg=sysdate where num=? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		close(rs, pstmt, conn);
		return result;
	}
	
	// 회원 정보 변경
	public int memberUpdate(myPageDTO dto, String sid, String birth) {
		int result = 0;
		conn = getConnection();
		try {
		String sql = " update users set user_name=?, nickname=?, phone=?, birth=? where user_id=? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getUser_name());
		pstmt.setString(2, dto.getNickname());
		pstmt.setInt(3, dto.getPhone());
		pstmt.setString(4, birth);
		pstmt.setString(5, sid);
		result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		close(rs, pstmt, conn);
		return result;
	}
	
	// 비밀번호 변경
	public int rePassword(String pw, String sid) {
		int result = 0;
		conn = getConnection();
		try {
		String sql = " update users set user_pw=? where user_id=? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pw);
		pstmt.setString(2, sid);
		result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		close(rs, pstmt, conn);
		return result;
	}
	
	// 회원 삭제
	public int deleteMember(int unum) {
		int result = 0;
		conn = getConnection();
		try {
		String sql = " update users set status=0 where num=? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, unum);
		result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		close(rs, pstmt, conn);
		return result;
	}
	
	// 댓글 삭제
	public int deleteComment(int commNum) {
		int result = 0;
		conn = getConnection();
		try {
		String sql = " update comments set comment_views=1 where comment_num=? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, commNum);
		result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		close(rs, pstmt, conn);
		return result;
	}
	
	// 조회수
	public int contentCnt(myPageDTO condto) {
		int conResult = 0;
		conn = getConnection();
		try {
		String sql = "update posts set content_cnt = content_cnt+1 where num=? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, condto.getPost_num());
		conResult = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		close(rs, pstmt, conn);
		return conResult;
	}
	
	// 검색한 글 개수(페이징)
	public int searchCount(String search, String searchOption) {
		int result = 0;
		conn = getConnection();
		try {
			if(searchOption.equals("total")) {
				String sql = " select  count(*) from posts where (title like ? or content like ?) ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setString(2, "%" + search + "%");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			} else {
				String sql = " select  count(*) from posts where (title like ? or content like ?) ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setString(2, "%" + search + "%");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
			}
			}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs, pstmt, conn);
			}
			return result;
		}
	
	// 상세 글정보
	public myPageDTO posts(int num) {
		myPageDTO dto = new myPageDTO();
		try {
			conn = getConnection();
			String sql = " select p.num , p.title, p.post_like_cnt, p.reg, p.content, p.content_cnt, u.nickname, i.img_url "
					+ " from users u, posts p, images i "
					+ " where u.num = p.user_num and i.posts_num(+) = p.num and p.num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setPost_num(rs.getInt("num"));
				dto.setNickname(rs.getString("nickname"));
				dto.setPost_title(rs.getString("title"));
				dto.setPost_content(rs.getString("content"));
				dto.setPost_reg(rs.getTimestamp("reg"));
				dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
				dto.setImg(rs.getString("img_url"));
				dto.setPost_content_cnt(rs.getInt("content_cnt"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return dto;
	}
	
	// 마이 페이지 글번호
	public myPageDTO postsNum(int num) {
		myPageDTO dto = new myPageDTO();
		try {
			conn = getConnection();
			String sql = " select p.num , p.title, p.post_like_cnt, p.reg, p.content, p.content_cnt, u.nickname, i.img_url "
					+ " from users u, posts p, images i "
					+ " where u.num = p.user_num and i.posts_num(+) = p.num and p.num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setPost_num(rs.getInt("num"));
				dto.setNickname(rs.getString("nickname"));
				dto.setPost_title(rs.getString("title"));
				dto.setPost_content(rs.getString("content"));
				dto.setPost_reg(rs.getTimestamp("reg"));
				dto.setPost_like_cnt(rs.getInt("post_like_cnt"));
				dto.setImg(rs.getString("img_url"));
				dto.setPost_content_cnt(rs.getInt("content_cnt"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return dto;
	}
	
	// 댓글 작성
	public int comment_wri(int numId , int num, String comment) {
		int result = 0;
		conn = getConnection();
		try {
		String sql = " insert into comments values (comments_seq.nextval, ? , ? , ? , sysdate, 0) ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, numId);
		pstmt.setInt(2, num);
		pstmt.setString(3, comment);
		result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		close(rs, pstmt, conn);
		return result;
	}
	
	// 계정 전체 정보
	public ArrayList<myPageDTO> userList(int start, int end , String msql1 , String msql2){
		ArrayList<myPageDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			String sql = " select * from "
					+ " (select ro.* , rownum r from "
					+ " (select * from users where status=1 order by " + msql1 + " " + msql2 + " ) ro) "
					+ " where r >= ? and r <= ? " ;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()){
				myPageDTO dto = new myPageDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserid(rs.getString("user_id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setBirth(rs.getTimestamp("birth"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setStatus(rs.getInt("status"));
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

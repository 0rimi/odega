package odega.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import odega.OracleDB;
import odega.bean.mypage.myPageDTO;


public class UserDAO extends OracleDB{
   private Connection conn;  //자바와 db연결
   private PreparedStatement pstmt;  //쿼리문 대기 및 설정
   private ResultSet rs;  //결과값 받아오기
   

   public int login(String user_id, String user_pw) {
       String sql = "SELECT user_pw FROM users WHERE user_id = ?";
       try {
          conn = getConnection();
          pstmt = conn.prepareStatement(sql); //sql 쿼리문 대기
          pstmt.setString(1, user_id); //첫번째 ?에 매개변수로 받아온 user_id를 대입
          rs = pstmt.executeQuery();   //쿼리를 실행한 결과를 rs에 저장
                                 //결과가 존재한다면 실행
          if(rs.next()) {
                                 //패스워드 일치한다면 실행
             if(rs.getString(1).equals(user_pw)) {
                return 1;  //로그인성공
                 
             }else
                return 0;  //비번 불일치
             
          }return -1;        //아이디 없음
          
       }catch(Exception e) {
          e.printStackTrace();
       }finally {
          close(rs,pstmt,conn);
       }
       return -2;           //데이터베이스 오류를 의미
    }
   
	//포스팅 작성시 유저 번호 확인 (창완이 작성)
	public int userNum(String user_id, String user_pw) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = " select num from users where user_id=? and user_pw=? ";	// id,pw를 사용하여 유저번호 확인
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("num");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
   
	public int join(String user_name, String user_id, String user_pw, String nickname, String birth, String phone) {
		String SQL = "INSERT INTO users VALUES (users_seq.nextval,?,?,?,?,0,sysdate,?,1,?)";   //총 다섯개의 값 들어가게
		try {
			//insert문장의 결과는 0이상의 숫자가 발현되기 떄문에 -1이 아닌경우는 성공적인 회원가입이 이뤄진 것.
			conn = getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pw);
			pstmt.setString(3, nickname);
			pstmt.setString(4, birth);
			pstmt.setString(5, user_name);
			pstmt.setString(6, phone);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			
			e.printStackTrace();	//예외처리
			
		}finally {
			 close(rs,pstmt,conn);
		}
		return -1;			//데이터베이스 오류를 의미
	}

	// ID 찾기
	public String findId(String user_name, String phone) {
		String id = null;
		String sql = "select user_id from users where user_name=? and phone=? ";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_name);
			pstmt.setString(2, phone);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				id = rs.getString("user_id");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}


	// PW 찾기
	public String findPw(String user_name, String user_id, String phone) {
		String pw = null;
		String sql = "select user_pw from users where user_name=? and user_id=? and phone=? ";
	try {
		conn = getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_name);
		pstmt.setString(2, user_id);
		pstmt.setString(3, phone);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			pw = rs.getString("user_pw");
		}
			
	} catch (Exception e) {
		e.printStackTrace();
	}
	return pw;
}
}
package odega;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OracleDB {

	// 변수 선언
	private Connection conn = null;

	// 커넥션메소드
	public Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.219.123:1521/orcl";
			String user = "team01";
			String pw = "team";
			conn = DriverManager.getConnection(url, user, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return conn;
	}
	
	//클로즈 메소드
	public void close(ResultSet rs,PreparedStatement pstmt,Connection conn) {
		try {if(rs != null) {rs.close();}} catch (SQLException e) {e.printStackTrace();}
		try {if(pstmt != null) {pstmt.close();	}} catch (SQLException e) {e.printStackTrace();}
		try {if(conn != null) {conn.close();}} catch (SQLException e) {e.printStackTrace();}
	}

}

package odega.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import odega.OracleDB;
public class FilterDAO extends OracleDB {
private static FilterDAO instance = new FilterDAO();
	
	public static FilterDAO getInstance() {
		return instance;
	
	}
	private FilterDAO() {}
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;	
		
}

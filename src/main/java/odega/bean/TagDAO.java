package odega.bean;

import odega.OracleDB;

public class TagDAO extends OracleDB{
	
	private static TagDAO instance = new TagDAO();
	
	public static TagDAO getInstance() {
		return instance;
	}
	public TagDAO() {}
	
	//postnum에 따른 mapList
	
	
}

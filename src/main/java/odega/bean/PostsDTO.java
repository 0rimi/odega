package odega.bean;

import java.util.Date;

public class PostsDTO {
	
	//field
	private int num;
	private String title;
	private String content;
	private int post_like_cnt;
	private int user_num;
	private Date reg;
	
	private String nickname;

	
	//g&s
	public int getNum() {
		return num;
	}

	public String getTitle() {
		return title;
	}

	public String getContent() {
		return content;
	}

	public int getPost_like_cnt() {
		return post_like_cnt;
	}

	public int getUser_num() {
		return user_num;
	}

	public Date getReg() {
		return reg;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setPost_like_cnt(int post_like_cnt) {
		this.post_like_cnt = post_like_cnt;
	}

	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}

	public void setReg(Date reg) {
		this.reg = reg;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	
	@Override
	public String toString() {
		return "PostsDTO [num=" + num + ", title=" + title + ", content=" + content + ", post_like_cnt=" + post_like_cnt + ", user_num=" + user_num + ", reg=" + reg + ", nickname=" + nickname + "]";
	}
}

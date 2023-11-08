package odega.bean.mypage;

import java.util.Date;

public class MainDTO {
	//field
		private int num;
		private String title;
		private String content;
		private int post_like_cnt;
		private int user_num;
		private Date reg;
		private int posts_views;

		private String nickname;
		private String img_url;


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
		
		public int getPosts_views() {
			return posts_views;
		}

		public void setPosts_views(int posts_views) {
			this.posts_views = posts_views;
		}
		public String getImg_url() {
			return img_url;
		}

		public void setImg_url(String img_url) {
			this.img_url = img_url;
		}
}

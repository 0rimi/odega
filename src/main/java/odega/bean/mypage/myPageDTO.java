package odega.bean.mypage;

import java.sql.Timestamp;
   
public class myPageDTO {

   private int num;
   private String userid;
   private String userpw;
   private String nickname;
   private Timestamp birth;
   private int user_like_cnt;
   private Timestamp reg;
   private String user_name;
   private int status; 
   private String phone;
   
   private int post_num;
   private String post_title;
   private String post_content;
   private int post_like_cnt;
   private int post_user_num;
   private Timestamp post_reg;
   private int post_content_cnt;
   private int post_views;
   
   private int img_num;
   private String img;
   private int img_post_num;
   
   private int comments_num;
   private int comment_user_num;
   private int comments_content_num;
   private String comments_wri;
   private Timestamp comments_reg;
   private int comment_views;
   
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
   	public int getStatus() {
   		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
   
   public int getNum() {
      return num;
   }
   public void setNum(int num) {
      this.num = num;
   }
   public String getUserid() {
      return userid;
   }
   public void setUserid(String userid) {
      this.userid = userid;
   }
   public String getUserpw() {
      return userpw;
   }
   public void setUserpw(String userpw) {
      this.userpw = userpw;
   }
   public String getNickname() {
      return nickname;
   }
   public void setNickname(String nickname) {
      this.nickname = nickname;
   }
   public Timestamp getBirth() {
      return birth;
   }
   public void setBirth(Timestamp birth) {
      this.birth = birth;
   }
   public int getUser_like_cnt() {
      return user_like_cnt;
   }
   public void setUser_like_cnt(int user_like_cnt) {
      this.user_like_cnt = user_like_cnt;
   }
   public Timestamp getReg() {
      return reg;
   }
   public void setReg(Timestamp reg) {
      this.reg = reg;
   }
   public String getUser_name() {
      return user_name;
   }
   public void setUser_name(String user_name) {
      this.user_name = user_name;
   }
   public int getPost_num() {
      return post_num;
   }
   public void setPost_num(int post_num) {
      this.post_num = post_num;
   }
   public String getPost_title() {
      return post_title;
   }
   public void setPost_title(String post_title) {
      this.post_title = post_title;
   }
   public String getPost_content() {
      return post_content;
   }
   public void setPost_content(String post_content) {
      this.post_content = post_content;
   }
   public int getPost_like_cnt() {
      return post_like_cnt;
   }
   public void setPost_like_cnt(int post_like_cnt) {
      this.post_like_cnt = post_like_cnt;
   }
   public int getPost_user_num() {
      return post_user_num;
   }
   public void setPost_user_num(int post_user_num) {
      this.post_user_num = post_user_num;
   }
   public Timestamp getPost_reg() {
      return post_reg;
   }
   public void setPost_reg(Timestamp post_reg) {
      this.post_reg = post_reg;
   }
   public int getPost_content_cnt() {
      return post_content_cnt;
   }
   public void setPost_content_cnt(int post_content_cnt) {
      this.post_content_cnt = post_content_cnt;
   }
   public int getPost_views() {
      return post_views;
   }
   public void setPost_views(int post_views) {
      this.post_views = post_views;
   }
   public int getImg_num() {
      return img_num;
   }
   public void setImg_num(int img_num) {
      this.img_num = img_num;
   }
   public String getImg() {
      return img;
   }
   public void setImg(String img) {
      this.img = img;
   }
   public int getImg_post_num() {
      return img_post_num;
   }
   public void setImg_post_num(int img_post_num) {
      this.img_post_num = img_post_num;
   }
   public int getComments_num() {
      return comments_num;
   }
   public void setComments_num(int comments_num) {
      this.comments_num = comments_num;
   }
   public int getComment_user_num() {
      return comment_user_num;
   }
   public void setComment_user_num(int comment_user_num) {
      this.comment_user_num = comment_user_num;
   }
   public int getComments_content_num() {
      return comments_content_num;
   }
   public void setComments_content_num(int comments_content_num) {
      this.comments_content_num = comments_content_num;
   }
   public String getComments_wri() {
      return comments_wri;
   }
   public void setComments_wri(String comments_wri) {
      this.comments_wri = comments_wri;
   }
   public Timestamp getComments_reg() {
      return comments_reg;
   }
   public void setComments_reg(Timestamp comments_reg) {
      this.comments_reg = comments_reg;
   }
   public int getComment_views() {
      return comment_views;
   }
   public void setComment_views(int comment_views) {
      this.comment_views = comment_views;
   }
}
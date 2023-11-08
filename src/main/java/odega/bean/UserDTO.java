package odega.bean;

public class UserDTO {

   private int num;
   private String user_id;
   private String user_pw;
   private String nickname;
   private String birth;
   private int user_like_cnt;
   private String reg;
   private String user_name;
   private String phone;
   

public int getNum() {
   return num;
}
public void setNum(int num) {
   this.num = num;
}
public String getUser_id() {
   return user_id;
}
public void setUser_id(String user_id) {
   this.user_id = user_id;
}
public String getUser_pw() {
   return user_pw;
}
public void setUser_pw(String user_pw) {
   this.user_pw = user_pw;
}
public String getNickname() {
   return nickname;
}
public void setNickname(String nickname) {
   this.nickname = nickname;
}
public String getBirth() {
   return birth;
}
public void setBirth(String birth) {
   this.birth = birth;
}
public int getUser_like_cnt() {
   return user_like_cnt;
}
public void setUser_like_cnt(int user_like_cnt) {
   this.user_like_cnt = user_like_cnt;
}
public String getReg() {
   return reg;
   
}
public void setReg(String reg) {
   this.reg = reg;
}
public String getUser_name() {
   return user_name;
}
public void setUser_name(String user_name) {
   this.user_name = user_name;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}


@Override
public String toString() {
 return "UserDTO [num=" + num + ", user_id=" + user_id + ", user_pw=" + user_pw +  ", nickname="+ nickname+", birth=" + birth
   + ", user_like_cnt=" + user_like_cnt + ", reg=" + reg + ", user_name=" + user_name + ", phone=" + phone  + "]";
}

} 
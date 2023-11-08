package odega.bean;
import java.sql.Timestamp;

public class UserLikeDTO {
   private int num;
   private int user_num;
   private int post_num;
   private Timestamp like_date;
   
   public Timestamp getLike_date() {
      return like_date;
   }
   public void setLike_date(Timestamp like_date) {
      this.like_date = like_date;
   }
   public int getNum() {
      return num;
   }
   public void setNum(int num) {
      this.num = num;
   }
   public int getUser_num() {
      return user_num;
   }
   public void setUser_num(int user_num) {
      this.user_num = user_num;
   }
   public int getPost_num() {
      return post_num;
   }
   public void setPost_num(int post_num) {
      this.post_num = post_num;
   }
   
}
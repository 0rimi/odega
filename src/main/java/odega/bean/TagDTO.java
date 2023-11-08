package odega.bean;

import java.security.Timestamp;

public class TagDTO {

   private int tag_num; //pk
   private String tag_name;
   private Timestamp reg; // 태그 생성일자
   private String post_num; //태그가 쓰인 게시물(posts테이블)의 넘버입니다.
   public int getTag_num() {
      return tag_num;
   }
   public void setTag_num(int tag_num) {
      this.tag_num = tag_num;
   }
   public String getTag_name() {
      return tag_name;
   }
   public void setTag_name(String tag_name) {
      this.tag_name = tag_name;
   }
   public Timestamp getReg() {
      return reg;
   }
   public void setReg(Timestamp reg) {
      this.reg = reg;
   }
   public String getPost_num() {
      return post_num;
   }
   public void setPost_num(String post_num) {
      this.post_num = post_num;
   }
}
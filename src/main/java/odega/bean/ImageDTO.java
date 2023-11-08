package odega.bean;

public class ImageDTO {

	//field
	private int num;
	private String img_url;
	private int posts_num;
	private int post_image_num;
	
	//g&s
	public int getNum() {
		return num;
	}
	public String getImg_url() {
		return img_url;
	}
	public int getPosts_num() {
		return posts_num;
	}
	public int getPost_image_num() {
		return post_image_num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}
	public void setPosts_num(int posts_num) {
		this.posts_num = posts_num;
	}
	public void setPost_image_num(int post_image_num) {
		this.post_image_num = post_image_num;
	}
	
	
	@Override
	public String toString() {
		return "ImageDTO [num=" + num + ", img_url=" + img_url + ", posts_num=" + posts_num + ", post_image_num=" + post_image_num + "]";
	}
}

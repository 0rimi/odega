package odega.bean;

public class MapDTO {
	
	//field
	private int id;
	private String place_name;
	private String address_name;
	private String description;
	private int post_num;
	private int image_num;
	private String lat;
	private String longi;
	
	
	//G&S
	public int getId() {
		return id;
	}
	public String getPlace_name() {
		return place_name;
	}
	public String getAddress_name() {
		return address_name;
	}
	public String getDescription() {
		return description;
	}
	public int getPost_num() {
		return post_num;
	}
	public int getImage_num() {
		return image_num;
	}
	public String getLat() {
		return lat;
	}
	public String getLongi() {
		return longi;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public void setAddress_name(String address_name) {
		this.address_name = address_name;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setPost_num(int post_num) {
		this.post_num = post_num;
	}
	public void setImage_num(int image_num) {
		this.image_num = image_num;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public void setLongi(String longi) {
		this.longi = longi;
	}
	
	
	@Override
	public String toString() {
		return "MapDTO [id=" + id + ", place_name=" + place_name + ", address_name=" + address_name + ", description=" + description + ", post_num=" + post_num + ", image_num=" + image_num + ", lat="
				+ lat + ", longi=" + longi + "]";
	}
}

package com.civildefense.dto;

public class TraineeDTO {

	private int no;
	
	private String name;
	
	private int zipcode_no;
	
	private String address;
	
	private String phone;

	private String del_gb;
	
	private String birth;
	

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getZipcode_no() {
		return zipcode_no;
	}

	public void setZipcode_no(int zipcode_no) {
		this.zipcode_no = zipcode_no;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDel_gb() {
		return del_gb;
	}

	public void setDel_gb(String del_gb) {
		this.del_gb = del_gb;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}
}

package com.civildefense.dto;

import java.util.Date;

public class QuestionDTO {

	private int no;
	private String content;
	private int zipcode_no;
	private String show_yn;
	private String register_date;
	
	
	public String getShow_yn() {
		return show_yn;
	}
	public void setShow_yn(String show_yn) {
		this.show_yn = show_yn;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getZipcode_no() {
		return zipcode_no;
	}
	public void setZipcode_no(int zipcode_no) {
		this.zipcode_no = zipcode_no;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	public String getDel_gb() {
		return del_gb;
	}
	public void setDel_gb(String del_gb) {
		this.del_gb = del_gb;
	}
	private String del_gb;
	
}

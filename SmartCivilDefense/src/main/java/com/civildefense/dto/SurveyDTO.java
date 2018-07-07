package com.civildefense.dto;

import java.util.Date;

public class SurveyDTO {

	private int no;
	private String start_date;
	private String end_date;
	private int zipcode_no;
	private String secret_code;
	private String secret_code_use;
	
	
	public int getZipcode_no() {
		return zipcode_no;
	}
	public void setZipcode_no(int zipcode_no) {
		this.zipcode_no = zipcode_no;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getSecret_code() {
		return secret_code;
	}
	public void setSecret_code(String secret_code) {
		this.secret_code = secret_code;
	}
	public String getSecret_code_use() {
		return secret_code_use;
	}
	public void setSecret_code_use(String secret_code_use) {
		this.secret_code_use = secret_code_use;
	}
	
	
}

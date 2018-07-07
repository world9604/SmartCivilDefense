package com.civildefense.dto;

import java.io.Serializable;

public class SigunguAdminDTO implements Serializable{

	private int no;
	private String id;
	private String passwd;
	private int zipcode_no;
	private int survey_no;
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getZipcode_no() {
		return zipcode_no;
	}
	public void setZipcode_no(int zipcode_no) {
		this.zipcode_no = zipcode_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getSurvey_no() {
		return survey_no;
	}
	public void setSurvey_no(int survey_no) {
		this.survey_no = survey_no;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	
	
	
	
}

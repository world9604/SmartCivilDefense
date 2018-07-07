package com.civildefense.dto;

public class SurveyResponseDTO {

	private int no;
	private String descriptive_answer;
	private String register_date;
	private int question_no;
	private int answer_no;
	private String trainee_no;
	
	
	public String getTrainee_no() {
		return trainee_no;
	}
	public void setTrainee_no(String trainee_no) {
		this.trainee_no = trainee_no;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getDescriptive_answer() {
		return descriptive_answer;
	}
	public void setDescriptive_answer(String descriptive_answer) {
		this.descriptive_answer = descriptive_answer;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	public int getQuestion_no() {
		return question_no;
	}
	public void setQuestion_no(int question_no) {
		this.question_no = question_no;
	}
	public int getAnswer_no() {
		return answer_no;
	}
	public void setAnswer_no(int answer_no) {
		this.answer_no = answer_no;
	}

	

}

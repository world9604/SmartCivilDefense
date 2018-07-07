package com.civildefense.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.civildefense.dto.AnswerCountDTO;
import com.civildefense.dto.AnswerDTO;
import com.civildefense.dto.QuestionDTO;
import com.civildefense.dto.SurveyDTO;
import com.civildefense.dto.SurveyResponseDTO;

 
@Repository("surveyDAO")
public class SurveyDAO extends AbstractDAO{

	public SurveyDTO selectSurvey(SurveyDTO map) {
		return (SurveyDTO) selectOne("survey.selectSurvey", map);
	}

	public ArrayList<QuestionDTO> selectQuestion(int map) {
		return (ArrayList<QuestionDTO>)selectList("survey.selectQuestion", map);
	}

	public ArrayList<AnswerDTO> selectAnswer(QuestionDTO question) {
		return (ArrayList<AnswerDTO>)selectList("survey.selectAnswer", question);
	}

	public int insertSurveyResponse(Map<String, List<SurveyResponseDTO>> map) {
		return insert("survey.insertSurveyResponse", map);
	}

	public int insertSurvey(SurveyDTO map) {
		return insert("survey.insertSurvey", map);
	}

	public int insertQuestion(Map<String, Object> map) {
		return insert("survey.insertQuestion", map);
	}

	public int insertAnswer(Map<String, Object> map) {
		return insert("survey.insertAnswer", map);
	}

	public ArrayList<AnswerCountDTO> selectAnswerCount(Map<String, Object> map) {
		return (ArrayList<AnswerCountDTO>)selectList("survey.selectAnswerCount", map);
	}

	public SurveyDTO selectSurveyByZipcode(Map<String, Object> commandMap) {
		return (SurveyDTO)selectOne("survey.selectSurveyByZipcode", commandMap);
	}

	public ArrayList<QuestionDTO> selectQuestionBySurveyNo(int survey_no) {
		return (ArrayList<QuestionDTO>)selectList("survey.selectQuestionBySurveyNo", survey_no);
	}

	public Object updateSurveyDate(Map<String, Object> map) {
		return update("survey.updateSurveyDate", map);
	}

	public void updateQuestionShowYnBy(Map<String, Object> map) {
		update("survey.updateQuestionShowYnBy", map);
	}


	
 
}
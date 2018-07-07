package com.civildefense.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.civildefense.dao.SurveyDAO;
import com.civildefense.dto.AnswerCountDTO;
import com.civildefense.dto.AnswerDTO;
import com.civildefense.dto.QuestionDTO;
import com.civildefense.dto.SurveyDTO;
import com.civildefense.dto.SurveyResponseDTO;

@Service("surveyService")
public class SurveyServiceImpl implements SurveyService{
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name="surveyDAO")
    private SurveyDAO surveyDAO;
    
	@Override
	public SurveyDTO selectSurvey(SurveyDTO map) {
		return surveyDAO.selectSurvey(map);
	}

	@Override
	public ArrayList<QuestionDTO> selectQuestion(int map) {
		return surveyDAO.selectQuestion(map);
	}

	@Override
	public ArrayList<AnswerDTO> selectAnswer(QuestionDTO question) {
		return surveyDAO.selectAnswer(question);
	}

	@Override
	public int insertSurveyResponse(Map<String, List<SurveyResponseDTO>> map) {
		return surveyDAO.insertSurveyResponse(map);
	}

	@Override
	public int insertSurvey(SurveyDTO map) {
		return surveyDAO.insertSurvey(map);
	}

	@Override
	public int insertQuestion(Map<String, Object> map) {
		return surveyDAO.insertQuestion(map);
	}

	@Override
	public int insertAnswer(Map<String, Object> map) {
		return surveyDAO.insertAnswer(map);
	}

	@Override
	public ArrayList<AnswerCountDTO> selectAnswerCount(Map<String, Object> map) {
		return surveyDAO.selectAnswerCount(map);
	}

	@Override
	public SurveyDTO selectSurveyByZipcode(Map<String, Object> commandMap) {
		return surveyDAO.selectSurveyByZipcode(commandMap);
	}

	@Override
	public ArrayList<QuestionDTO> selectQuestionBySurveyNo(int survey_no) {
		return surveyDAO.selectQuestionBySurveyNo(survey_no);
	}

	@Override
	public void updateSurveyDate(Map<String, Object> map) {
		surveyDAO.updateSurveyDate(map);
	}

	@Override
	public void updateQuestionShowYnBy(Map<String, Object> map) {
		surveyDAO.updateQuestionShowYnBy(map);
	}
     
   
 
}
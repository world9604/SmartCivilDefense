package com.civildefense.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.civildefense.dto.AnswerCountDTO;
import com.civildefense.dto.AnswerDTO;
import com.civildefense.dto.QuestionDTO;
import com.civildefense.dto.SurveyDTO;
import com.civildefense.dto.SurveyResponseDTO;

public interface SurveyService {

	SurveyDTO selectSurvey(SurveyDTO object);

	ArrayList<QuestionDTO> selectQuestion(int map);

	ArrayList<AnswerDTO> selectAnswer(QuestionDTO question);

	int insertSurveyResponse(Map<String, List<SurveyResponseDTO>> map);

	int insertSurvey(SurveyDTO map);

	int insertQuestion(Map<String, Object> map);

	int insertAnswer(Map<String, Object> map);

	ArrayList<AnswerCountDTO> selectAnswerCount(Map<String, Object> map);

	SurveyDTO selectSurveyByZipcode(Map<String, Object> commandMap);

	ArrayList<QuestionDTO> selectQuestionBySurveyNo(int survey_no);

	void updateSurveyDate(Map<String, Object> map);

	void updateQuestionShowYnBy(Map<String, Object> map);

}

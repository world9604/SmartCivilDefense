package com.civildefense.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.civildefense.dto.TraineeDTO;

public interface TrainService {

	void insertTrainee(TraineeDTO map) throws Exception;

	TraineeDTO selectTrainee(Map<String, Object> map) throws Exception;

	ArrayList<TraineeDTO> selectTrainees(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectPrivacyInfo() throws Exception;

	ArrayList<Map<String, Object>> selectSurveyResponseByZipcode(Map map) throws Exception;

	void deleteTraineeByZipcodeNo(Map<String, Object> map);

	void deleteTraineeByNo(Map<String, Object> map);

}

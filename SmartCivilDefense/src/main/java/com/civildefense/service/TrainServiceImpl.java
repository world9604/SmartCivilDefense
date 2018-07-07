package com.civildefense.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.civildefense.dao.TrainDAO;
import com.civildefense.dto.TraineeDTO;
import com.civildefense.dto.ZipcodeDTO;
import com.civildefense.dao.RegionDAO;

@Service("trainService")
public class TrainServiceImpl implements TrainService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Resource(name="regionDAO")
    private RegionDAO regionDAO;
    
    @Resource(name="trainDAO")
    private TrainDAO trainDAO;
     
	@Override
	public void insertTrainee(TraineeDTO map) throws Exception {
		trainDAO.insertTrainee(map);
	}

	@Override
	public TraineeDTO selectTrainee(Map<String, Object> map) throws Exception {
		TraineeDTO resultMap = trainDAO.selectTrainee(map);
		return resultMap;
	}

	@Override
	public ArrayList<TraineeDTO> selectTrainees(Map<String, Object> map) throws Exception {
		ArrayList<TraineeDTO> resultMap = trainDAO.selectTrainees(map);
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> selectPrivacyInfo() {
		List<Map<String, Object>> resultMap = trainDAO.selectPrivacyInfo();
		return resultMap;
	}

	@Override
	public ArrayList<Map<String, Object>> selectSurveyResponseByZipcode(Map map) throws Exception {
		ArrayList<Map<String, Object>> resultMap = trainDAO.selectSurveyResponseByZipcode(map);
		return resultMap;
	}

	@Override
	public void deleteTraineeByZipcodeNo(Map<String, Object> map) {
		trainDAO.deleteSurveyResponseByZipcodeNo(map);
		trainDAO.deleteTraineeByZipcodeNo(map);
	}

	@Override
	public void deleteTraineeByNo(Map<String, Object> map) {
		trainDAO.deleteSurveyResponseByTraineeNo(map);
		trainDAO.deleteTraineeByNo(map);
	}
 
}
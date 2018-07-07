package com.civildefense.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.civildefense.dao.SampleDAO;

@Service("sampleService")
public class SampleServiceImpl implements SampleService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Resource(name="sampleDAO")
    private SampleDAO sampleDAO;
     
    @Override
    public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
    	Map<String, Object> totalCountMap = sampleDAO.selectBoardListTotalCount(); //TotalCount
    	List<Map<String, Object>> resultMap = sampleDAO.selectBoardList(map);
    	resultMap.add(totalCountMap);
        return resultMap;
    }

	@Override
	public void insertBoard(Map<String, Object> map) throws Exception {
		sampleDAO.insertBoard(map);
	}

	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = sampleDAO.selectBoardDetail(map);
		return resultMap;
	}
 
}
package com.civildefense.service;

import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.civildefense.dao.RegionDAO;
import com.civildefense.dto.ZipcodeDTO;

@Service("regionService")
public class RegionServiceImpl implements RegionService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Resource(name="regionDAO")
    private RegionDAO regionDAO;
     
    @Override
    public ArrayList<ZipcodeDTO> selectRegionList() throws Exception {
    	ArrayList<ZipcodeDTO> resultMap = regionDAO.selectRegionList();
        return resultMap;
    }

	@Override
	public void insertBoard(Map<String, Object> map) throws Exception {
		regionDAO.insertBoard(map);
	}

	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = regionDAO.selectBoardDetail(map);
		return resultMap;
	}

	@Override
	public ZipcodeDTO selectRegionByNo(Map<String, Object> map) {
		ZipcodeDTO resultMap = regionDAO.selectRegionByNo(map);
		return resultMap;
	}

	@Override
	public ArrayList<String> selectSidoList() {
		ArrayList<String> resultMap = regionDAO.selectSidoList();
		return resultMap;
	}

	@Override
	public ArrayList<Map<String, Object>> selectSigunguList(Map<String, Object> map) {
		ArrayList<Map<String, Object>> resultMap = regionDAO.selectSigunguList(map);
		return resultMap;
	}

	@Override
	public ZipcodeDTO selectRegionBySigungu(Map<String, Object> map) {
		ZipcodeDTO resultMap = regionDAO.selectRegionBySigungu(map);
		return resultMap;
	}
 
}
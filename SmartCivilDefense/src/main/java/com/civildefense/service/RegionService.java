package com.civildefense.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.civildefense.dto.ZipcodeDTO;

public interface RegionService {

	ArrayList<ZipcodeDTO> selectRegionList() throws Exception;

	void insertBoard(Map<String, Object> map) throws Exception;

	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;

	ZipcodeDTO selectRegionByNo(Map<String, Object> map);

	ArrayList<String> selectSidoList();

	ArrayList<Map<String, Object>> selectSigunguList(Map<String, Object> map);

	ZipcodeDTO selectRegionBySigungu(Map<String, Object> map);

}

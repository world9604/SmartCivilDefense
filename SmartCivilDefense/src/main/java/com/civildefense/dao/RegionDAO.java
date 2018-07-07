package com.civildefense.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.civildefense.dto.ZipcodeDTO;

 
@Repository("regionDAO")
public class RegionDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public ArrayList<ZipcodeDTO> selectRegionList() {
		return (ArrayList<ZipcodeDTO>)selectList("region.selectRegionList");
	}

	public void insertBoard(Map<String, Object> map) {
		insert("inform.insertBoard", map);
	}

	public Map<String, Object> selectBoardDetail(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("inform.selectBoardDetail", map);
	}

	public Map<String, Object> selectRegionListTotalCount() {
		return (Map<String, Object>) selectOne("region.selectRegionListTotalCount");
	}

	public ZipcodeDTO selectRegionByNo(Map<String, Object> map) {
		return (ZipcodeDTO) selectOne("region.selectRegionByNo", map);
	}

	public ArrayList<String> selectSidoList() {
		return (ArrayList<String>) selectList("region.selectSidoList");
	}

	public ArrayList<Map<String, Object>> selectSigunguList(Map<String, Object> map) {
		return (ArrayList<Map<String, Object>>) selectList("region.selectSigunguListBySido", map);
	}

	public ZipcodeDTO selectRegionBySigungu(Map<String, Object> map) {
		return (ZipcodeDTO) selectOne("region.selectRegionBySigungu", map);
	}
 
}
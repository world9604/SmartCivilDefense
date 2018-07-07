package com.civildefense.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

 
@Repository("sampleDAO")
public class SampleDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("inform.selectBoardList", map);
	}

	public void insertBoard(Map<String, Object> map) {
		insert("inform.insertBoard", map);
	}

	public Map<String, Object> selectBoardDetail(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("inform.selectBoardDetail", map);
	}

	public Map<String, Object> selectBoardListTotalCount() {
		return (Map<String, Object>) selectOne("inform.selectBoardListTotalCount");
	}
 
}
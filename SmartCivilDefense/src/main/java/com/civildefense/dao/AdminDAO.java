package com.civildefense.dao;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.civildefense.dto.CompanyAdminDTO;
import com.civildefense.dto.SigunguAdminDTO;

 
@Repository("adminDAO")
public class AdminDAO extends AbstractDAO{

	public SigunguAdminDTO selectSigunguAdmin(Map<String, Object> map) {
		return (SigunguAdminDTO)selectOne("admin.selectSigunguAdmin", map);
	}

	public CompanyAdminDTO selectCompanyAdmin(Map<String, Object> map) {
		return (CompanyAdminDTO)selectOne("admin.selectCompanyAdmin", map);
	}

	public SigunguAdminDTO selectSigunguAdminID(Map<String, Object> map) {
		return (SigunguAdminDTO)selectOne("admin.selectSigunguAdminID", map);
	}

	public void insertSigunguAdmin(Map<String, Object> map) {
		insert("admin.insertSigunguAdmin", map);
	}

	public void updateSigunguPasswd(Map<String, Object> map) {
		update("admin.updateSigunguPasswd", map);
	}

	public ArrayList<SigunguAdminDTO> selectSigunguAdminList() {
		return (ArrayList<SigunguAdminDTO>)selectList("admin.selectSigunguAdminList");
	}

	public void deleteSigunguAdminByNo(String object) {
		delete("admin.deleteSigunguAdminByNo", object);
	}

	public ArrayList<Map> selectSigunguAdminAndSurvey() {
		return (ArrayList<Map>)selectList("admin.selectSigunguAdminAndSurvey");
	}


	
 
}
package com.civildefense.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.civildefense.dto.CompanyAdminDTO;
import com.civildefense.dto.SigunguAdminDTO;
import com.civildefense.dto.TraineeDTO;

public interface AdminService {

	SigunguAdminDTO selectSigunguAdmin(Map<String, Object> map);

	CompanyAdminDTO selectCompanyAdmin(Map<String, Object> map);

	SigunguAdminDTO selectSigunguAdminID(Map<String, Object> map);

	void insertSigunguAdmin(Map<String, Object> map);

	void updateSigunguPasswd(Map<String, Object> map);

	ArrayList<SigunguAdminDTO> selectSigunguAdminList();

	void deleteSigunguAdminByNo(String object);

	ArrayList<Map> selectSigunguAdminAndSurvey();


	

}

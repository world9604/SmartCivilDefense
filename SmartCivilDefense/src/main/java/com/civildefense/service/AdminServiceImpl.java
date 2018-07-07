package com.civildefense.service;

import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.civildefense.dao.AdminDAO;
import com.civildefense.dto.CompanyAdminDTO;
import com.civildefense.dto.SigunguAdminDTO;

@Service("adminService")
public class AdminServiceImpl implements AdminService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Resource(name="adminDAO")
    private AdminDAO adminDAO;

	@Override
	public SigunguAdminDTO selectSigunguAdmin(Map<String, Object> map) {
		return adminDAO.selectSigunguAdmin(map);
	}

	@Override
	public CompanyAdminDTO selectCompanyAdmin(Map<String, Object> map) {
		return adminDAO.selectCompanyAdmin(map);
	}

	@Override
	public SigunguAdminDTO selectSigunguAdminID(Map<String, Object> map) {
		return adminDAO.selectSigunguAdminID(map);
	}

	@Override
	public void insertSigunguAdmin(Map<String, Object> map) {
		adminDAO.insertSigunguAdmin(map);
	}

	@Override
	public void updateSigunguPasswd(Map<String, Object> map) {
		adminDAO.updateSigunguPasswd(map);
	}

	@Override
	public ArrayList<SigunguAdminDTO> selectSigunguAdminList() {
		return adminDAO.selectSigunguAdminList();
	}

	@Override
	public void deleteSigunguAdminByNo(String object) {
		adminDAO.deleteSigunguAdminByNo(object);
	}

	@Override
	public ArrayList<Map> selectSigunguAdminAndSurvey() {
		return adminDAO.selectSigunguAdminAndSurvey();
	}
     
   
 
}
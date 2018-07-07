package com.civildefense.controller;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.civildefense.dto.AnswerCountDTO;
import com.civildefense.dto.CompanyAdminDTO;
import com.civildefense.dto.QuestionDTO;
import com.civildefense.dto.SigunguAdminDTO;
import com.civildefense.dto.SurveyDTO;
import com.civildefense.dto.SurveyResponseDTO;
import com.civildefense.dto.TraineeDTO;
import com.civildefense.dto.ZipcodeDTO;
import com.civildefense.service.AdminService;
import com.civildefense.service.RegionService;
import com.civildefense.service.SampleService;
import com.civildefense.service.SurveyService;
import com.civildefense.service.TrainService;
import com.civildefense.util.CommandMap;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sampleService")
	private SampleService sampleService;
	
	@Resource(name="regionService")
	private RegionService regionService;
	
	@Resource(name="trainService")
	private TrainService trainService;
	
	@Resource(name="surveyService")
	private SurveyService surveyService;
	
	@Resource(name="adminService")
	private AdminService adminService;
		
	@RequestMapping(value="sample/testMapArgumentResolver.do")
	public ModelAndView testMapArgumentResolver(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("");

		if(commandMap.isEmpty() == false) {
			Iterator<Entry<String, Object>> iterator = commandMap.getMap().entrySet().iterator();
			Entry<String, Object> entry = null;
			while(iterator.hasNext()) {
				entry = iterator.next();
				log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
			}
		}
		return mv;
	}
	
	@RequestMapping(value = "/sample/openBoardWrite.do")
	public ModelAndView openSampleBoardWrite(Map<String, Object> commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("user/sample/boardWrite");
		
		return mv;
	}
	
	@RequestMapping(value="/sample/insertBoard.do")
	public ModelAndView insertBoard(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/user/sample/openBoardList.do");
		
		sampleService.insertBoard(commandMap.getMap());
		
		return mv;
	}
	
	@RequestMapping(value="/sample/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception{
	    ModelAndView mv = new ModelAndView("user/sample/boardDetail");
	     
	    Map<String,Object> map = sampleService.selectBoardDetail(commandMap.getMap());
	    mv.addObject("map", map);
	     
	    return mv;
	}
	
	@RequestMapping(value = "/sample/openBoardList.do")
	public ModelAndView openSampleBoardList(Map<String, Object> commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("user/sample/boardList");
		
		return mv;
	}
	
	@RequestMapping(value="/sample/selectBoardList.do")
	public ModelAndView selectBoardList(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		List<Map<String, Object>> list = sampleService.selectBoardList(commandMap.getMap());
		mv.addObject("list", list);
		if(list.size() > 0){
			 Long totalCount = (Long)(list.get(list.size()-1).get("TOTAL_COUNT"));
			mv.addObject("TOTAL", totalCount);
		}else {
			mv.addObject("TOTAL", 0);
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/region/sidoList.do")
	public ModelAndView sidoList(CommandMap commandMap, HttpServletRequest request, 
			SessionStatus sessionStatus) throws Exception {
		ModelAndView mv = new ModelAndView("user/region/regionList");
		
		/*if(device.isMobile()) {
			log.debug("device is Mobile!");
		}else if(device.isTablet()) {
			log.debug("device is Tablet!");
		}else if(device.isNormal()){
			log.debug("device is Normal!");
		}*/
			
		ArrayList<String> list = regionService.selectSidoList();
		log.debug(list);
		mv.addObject("list", list);
			
		return mv;
	}
	
	@RequestMapping(value = "/region/sigunguList.do")
	public ModelAndView sigunguList(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("user/region/regionList");
		
		if(commandMap.getMap() != null
				&& !"{}".equals(String.valueOf(commandMap.getMap()))) {
			
			ArrayList<Map<String, Object>> list = regionService.selectSigunguList(commandMap.getMap());
			if(list.size() == 1) {
				if(list.get(0).get("SIGUNGU") == null 
						|| "".equals(list.get(0).get("SIGUNGU"))) {
					mv.setViewName("redirect:/attend/informWrite.do");
					mv.addObject("NO", list.get(0).get("NO"));
					return mv;
				}
			}
			mv.addObject("list", list);
		
		}
		
		
		return mv;
	}
	
	@RequestMapping(value="/attend/informWrite.do")
	public ModelAndView informWrite(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/region/sidoList.do");
		log.debug(commandMap.getMap());
		
		if(commandMap.getMap().get("NO") != null) {
			
			//세션에 TraineeDTO 저장
			TraineeDTO traineeDTO = new TraineeDTO();
			traineeDTO.setZipcode_no(Integer.valueOf((String)commandMap.getMap().get("NO")));
			
			HttpSession session  = request.getSession(true);
			session.setAttribute("trainee", traineeDTO);
			
			Map<String, Object> map = new HashMap<>();
			map.put("zipcode", traineeDTO.getZipcode_no());
			SurveyDTO surveyDTO = surveyService.selectSurveyByZipcode(map);
			
			if(surveyDTO == null) {
				
				mv.setViewName("user/region/noTrainPeriod");
			
			}else if(surveyDTO.getStart_date() == null
				|| surveyDTO.getEnd_date() == null
				|| "".equals(surveyDTO.getStart_date())
				|| "".equals(surveyDTO.getEnd_date())) {
				
				mv.setViewName("user/region/noTrainPeriod");
			
			}else{
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				final Date fromDate = sdf.parse(surveyDTO.getStart_date());
				final Date toDate = sdf.parse(surveyDTO.getEnd_date());
				final Date currDate = new Date();
				final int compare1 = currDate.compareTo(fromDate);
				final int compare2 = currDate.compareTo(toDate);
				
				if(compare1 >= 0 && compare2 <= 0) {
					
					if(surveyDTO.getSecret_code_use() != null
							&& "Y".equals(surveyDTO.getSecret_code_use())) {
						mv.setViewName("user/attend/inputSecretCode");
						return mv;
					}
					mv.setViewName("user/attend/informWrite");

				}else {
					
					mv.setViewName("user/region/noTrainPeriod");
					
				}
			}
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/attend/checkSecretCode.do")
	public ModelAndView checkSecretCode(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/region/sidoList.do");
		log.debug(commandMap.getMap());

		HttpSession session = request.getSession(false);
		TraineeDTO trainee = (TraineeDTO)session.getAttribute("trainee");
		
		if(trainee != null
				&& commandMap.getMap() != null
				&& !"{}".equals(String.valueOf(commandMap.getMap()))) {
			Map<String, Object> map = new HashMap<>();
			map.put("zipcode", trainee.getZipcode_no());
			SurveyDTO surveyDTO = surveyService.selectSurveyByZipcode(map);
			String secretCode = String.valueOf(commandMap.getMap().get("secretCode"));
			
			if( secretCode.equals(surveyDTO.getSecret_code())) {
				mv.setViewName("user/attend/informWrite");
			}
		}
		
		return mv;
	}
	
	@RequestMapping(value="/attend/insertInform.do")
	public ModelAndView insertInform(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/region/sidoList.do");
		
		log.debug(commandMap.getMap());
		HttpSession session = request.getSession(false);
		TraineeDTO trainee = (TraineeDTO)session.getAttribute("trainee");
		
		if(trainee != null
				&& commandMap.getMap() != null
				&& !"{}".equals(String.valueOf(commandMap.getMap()))) {
			log.debug("@@trainee.getZipcode_no() : " + trainee.getZipcode_no());
			log.debug("@@commandMap.getMap().get(PHONE) : " + (String)commandMap.getMap().get("PHONE"));
			log.debug("@@commandMap.getMap() : " + String.valueOf(commandMap.getMap()));
			trainee.setPhone((String)commandMap.getMap().get("PHONE"));
			trainee.setAddress((String)commandMap.getMap().get("ADDRESS"));
			trainee.setBirth((String)commandMap.getMap().get("BIRTH"));
			trainee.setName((String)commandMap.getMap().get("NAME"));
			
			//대원 개인정보 insert
			trainService.insertTrainee(trainee);
			Map<String, Object> map = new HashMap<>();
			map.put("zipcode", trainee.getZipcode_no());
			SurveyDTO surveyDTO = surveyService.selectSurveyByZipcode(map);
			
			ArrayList<QuestionDTO> questionList 
				= surveyService.selectQuestion(surveyDTO.getNo());
		
			mv.addObject("questionList", questionList);
			mv.addObject("traineeNo", trainee.getNo());
			mv.setViewName("user/survey/surveyList");
		}
				
		return mv;
	}
	
	@RequestMapping(value="/attend/selectPrivacyInfo.do")
	public ModelAndView selectPrivacyInfo() throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> privacyInfo = trainService.selectPrivacyInfo();
		log.debug(privacyInfo);
		if(privacyInfo != null) {
			mv.addObject("privacyInfo", privacyInfo);
		}
		return mv;
	}
	
	@RequestMapping(value="/attend/insertSurveyResponse.do", consumes=MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView insertSurveyResponse(@RequestBody List<SurveyResponseDTO> commandList) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		log.debug(commandList);
		HashMap map = new HashMap<String, List<SurveyResponseDTO>>();
		map.put("list", commandList);
		
		surveyService.insertSurveyResponse(map);
		
		return mv;
	}
	
	
	@RequestMapping(value="/attend/certificateDetail.do")
	public ModelAndView certificateDetail(CommandMap commandMap, HttpServletRequest request, 
			SessionStatus sessionStatus) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/region/sidoList.do");
		
		log.info(commandMap.getMap());
		HttpSession session = request.getSession(false);
		TraineeDTO sessionTrainee = (TraineeDTO)session.getAttribute("trainee");
		
		if(sessionTrainee != null
				&& commandMap.getMap().get("traineeNo") != null
				&& !"".equals(commandMap.getMap().get("traineeNo"))) {
			TraineeDTO trainee = trainService.selectTrainee(commandMap.getMap());
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("ZIPCODE_NO", trainee.getZipcode_no());
			ZipcodeDTO zipcodeDto = regionService.selectRegionByNo(map);
			mv.addObject("trainee", trainee);
			mv.addObject("sido", zipcodeDto.getSido());
			mv.addObject("sigungu", zipcodeDto.getSigungu());
			mv.setViewName("user/attend/certificate");
			
			if(sessionStatus != null) {
				sessionStatus.setComplete();
				log.debug("@@session.setComplete");
			}
		}
		
		return mv;
	}
	
	@RequestMapping(value="/company_admin/login.do")
	public ModelAndView loginCompanyAdmin(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("company_admin/login");
		return mv;
	}
	
	@RequestMapping(value="/sigungu_admin/login.do")
	public ModelAndView openLoginPage(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("sigungu_admin/login");
		
		return mv;
	}
	
	@RequestMapping(value="/sigungu_admin/loginCheck.do")
	public ModelAndView loginCheck(CommandMap commandMap, 
			HttpServletRequest request) throws Exception{
		
		log.debug(commandMap.getMap());
		
		//로그인 실패시
		ModelAndView mv = new ModelAndView("sigungu_admin/login");
		SigunguAdminDTO sigunguAdminDto = adminService.selectSigunguAdmin(commandMap.getMap());

		//로그인 성공시
		if(sigunguAdminDto != null){
			
			HttpSession session  = request.getSession(true);
			session.setAttribute("sigungu_admin", sigunguAdminDto);

			mv.setViewName("redirect:adminPage.do");
			mv.addObject("ZIPCODE_NO", sigunguAdminDto.getZipcode_no());
			
		}
		return mv;
	}
	
	@RequestMapping(value="/sigungu_admin/adminPage.do")
	public ModelAndView sigunguAdminPage(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("sigungu_admin/adminPage");
		log.debug(commandMap.getMap());
		
		HttpSession session = request.getSession(false);
		SigunguAdminDTO sigunguAdminDTO = (SigunguAdminDTO)session.getAttribute("sigungu_admin");

		if(sigunguAdminDTO != null) {
			
			if(commandMap.getMap() != null
					&& !"{}".equals(String.valueOf(commandMap.getMap()))
					&& commandMap.getMap().get("deleteType") != null
					&& !"".equals(String.valueOf(commandMap.getMap().get("deleteType")))) {
				
				if("all".equals(String.valueOf(commandMap.getMap().get("deleteType")))){
					HashMap<String, Object> map = new HashMap<>();
					map.put("zipcode_no", sigunguAdminDTO.getZipcode_no());
					trainService.deleteTraineeByZipcodeNo(map);
				}else {
					trainService.deleteTraineeByNo(commandMap.getMap());
				}

			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("ZIPCODE_NO", sigunguAdminDTO.getZipcode_no());
			ArrayList<Map<String, Object>> surveyResponseList = trainService.selectSurveyResponseByZipcode(map);
			ZipcodeDTO zipcodeDTO = regionService.selectRegionByNo(map);
			mv.addObject("trainees", surveyResponseList);
		}
		
		return mv;
	}
	
	@RequestMapping(value="/sigungu_admin/openSurveyPage.do")
	public ModelAndView openSurveyPage(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("sigungu_admin/login");
		
		log.debug(commandMap.getMap());
		HttpSession session = request.getSession(false);
		SigunguAdminDTO sigunguAdminDTO = (SigunguAdminDTO)session.getAttribute("sigungu_admin");
		
		if(sigunguAdminDTO != null) {
			
			if(commandMap.get("content") != null
					&& commandMap.get("show_yn") != null
					&& !"".equals(String.valueOf(commandMap.get("content")))) {
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("survey_no", sigunguAdminDTO.getSurvey_no());
				map.put("content", commandMap.getMap().get("content"));
				map.put("show_yn", commandMap.getMap().get("show_yn"));
				surveyService.insertQuestion(map);
				
			}
			
			if(commandMap.get("fromDate") != null
					&& commandMap.get("toDate") != null
					&& !"".equals(String.valueOf(commandMap.get("fromDate")))
					&& !"".equals(String.valueOf(commandMap.get("toDate")))
					&& commandMap.get("secretCodeUse") != null
					&& commandMap.get("secretCode") != null
					&& !"".equals(String.valueOf(commandMap.get("secretCodeUse")))) {
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("survey_no", sigunguAdminDTO.getSurvey_no());
				map.put("fromDate", commandMap.getMap().get("fromDate"));
				map.put("toDate", commandMap.getMap().get("toDate"));
				map.put("secretCodeUse", commandMap.getMap().get("secretCodeUse"));
				map.put("secretCode", commandMap.getMap().get("secretCode"));
				surveyService.updateSurveyDate(map);
				
			}
			
			if(commandMap.get("update_show_yn") != null
					&& !"".equals(commandMap.get("update_show_yn"))) {
				
				Map<String, Object> map = new HashMap<>();
				map.put("updateShowYN", commandMap.get("update_show_yn"));
				map.put("questionNo", commandMap.getMap().get("questionNo"));
				surveyService.updateQuestionShowYnBy(map);
				
			}
			
			int survey_no = sigunguAdminDTO.getSurvey_no();
			ArrayList<QuestionDTO> questionList = surveyService.selectQuestionBySurveyNo(survey_no);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("zipcode", sigunguAdminDTO.getZipcode_no());
			SurveyDTO surveyDTO = surveyService.selectSurveyByZipcode(map);
			
			mv.addObject("survey", surveyDTO);
			mv.addObject("questionList", questionList);
			mv.setViewName("sigungu_admin/setSurvey");
		}
		
		return mv;
	}
	
	@RequestMapping(value="/sigungu_admin/setSurvey.do")
	public ModelAndView setSurvey(@RequestBody Map<String, Object> commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		log.debug(commandMap);
		HttpSession session = request.getSession(false);
		SigunguAdminDTO sigunguAdminDTO = (SigunguAdminDTO)session.getAttribute("sigungu_admin");
		
		if(sigunguAdminDTO != null) {
			Map map = new HashMap<String, Object>();
			map.put("survey_no", sigunguAdminDTO.getSurvey_no());
			map.put("content", commandMap.get("content"));
			map.put("show_yn", commandMap.get("show_yn"));
			surveyService.insertQuestion(map);
			
			int survey_no = sigunguAdminDTO.getSurvey_no();
			ArrayList<QuestionDTO> questionList = surveyService.selectQuestionBySurveyNo(survey_no);
			
			mv.addObject("questionList", questionList);
			mv.addObject("successInsert", "y");
		}
		
		return mv;
	}
	
	@RequestMapping("/sigungu_admin/downloadAttendExcel.do")
    public ModelAndView excelTransform(HttpServletResponse response, 
    		HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView("sigungu_admin/openSurveyPage.do");
		HttpSession session = request.getSession(false);
		SigunguAdminDTO sigunguAdminDTO = (SigunguAdminDTO)session.getAttribute("sigungu_admin");
		ZipcodeDTO zipcodeDto = null;
		
		if(sigunguAdminDTO != null) {
			Map map = new HashMap<String, Object>();
			map.put("ZIPCODE_NO", sigunguAdminDTO.getZipcode_no());
			zipcodeDto = regionService.selectRegionByNo(map);
		}
	
		if(zipcodeDto != null) {
			mv.setViewName("excelView");
			
			String fileName;
			StringBuilder fileNameSb = new StringBuilder();
			fileNameSb.append(zipcodeDto.getSido())
					 .append("_")
					 .append(zipcodeDto.getSigungu());
			fileName = fileNameSb.toString();
			
			//익스프로러 는 한문으로 깨져서 나온다@@
			if(request.getHeader("User-Agent").contains("MSIE")){
				
				fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
				
			}else if(request.getHeader("User-Agent").contains("Mozilla") 
					|| request.getHeader("User-Agent").contains("Chrome")
					|| request.getHeader("User-Agent").contains("Safari")
					|| request.getHeader("User-Agent").contains("Firefox")) {
				
				String fileNameStr = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
				fileName = fileNameStr;
			}
			
			response.setHeader("Content-disposition", 
		        		"attachment; filename=" + fileName + ".xlsx"); //target명을 파일명으로 작성
			response.setHeader("Content-Type", "application/octet-stream");
	//		response.setContentLength((int)file.getSize());
			response.setHeader("Content-Transfer-Encoding", "binary;");
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Expires", "-1;");
			
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("ZIPCODE_NO", zipcodeDto.getNo());
	        
	        //엑셀에 작성할 리스트를 가져온다.
	        ArrayList<Map<String, Object>> traineeList 
	        	= trainService.selectSurveyResponseByZipcode(map); 
	         
	        //ExcelView(kr.co.myapp.util.ExcelView) 에 넘겨줄 값 셋팅
	        mv.addObject("traineeList", traineeList); 
	        mv.addObject("fileName", fileName.toString());
		}
 
        return mv;
    }
	
	@RequestMapping(value="/sigungu_admin/resultSurvey.do")
	public ModelAndView resultSurvey(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("sigungu_admin/resultSurvey");
		log.debug(commandMap);
		
		HttpSession session = request.getSession(false);
		SigunguAdminDTO sigunguAdminDTO = (SigunguAdminDTO)session.getAttribute("sigungu_admin");
		
		if(sigunguAdminDTO != null) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("survey_no", sigunguAdminDTO.getSurvey_no());
			ArrayList<AnswerCountDTO> answerCountList = surveyService.selectAnswerCount(map);
			mv.addObject("answerCountList", answerCountList);
		}
			
		return mv;
	}
	
	@RequestMapping(value="/sigungu_admin/changePasswd.do")
	public ModelAndView changePasswd(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:login.do");
		log.debug(commandMap);
		
		HttpSession session = request.getSession(false);
		SigunguAdminDTO sigunguAdminDTO = (SigunguAdminDTO)session.getAttribute("sigungu_admin");
		
		if(sigunguAdminDTO != null) {
			
			if(commandMap.getMap().get("passwd") != null
					&& commandMap.getMap().get("passwdCheck") != null
					&& !"".equals(commandMap.getMap().get("passwd"))
					&& !"".equals(commandMap.getMap().get("passwdCheck"))) {
				
				final String passwd = String.valueOf(commandMap.getMap().get("passwd"));
				final String passwdCheck = String.valueOf(commandMap.getMap().get("passwdCheck"));
				
				if(passwd.equals(passwdCheck)) {
					final int sigunguNo = sigunguAdminDTO.getNo();
					Map<String, Object> map = new HashMap<>();
					map.put("sigunguNo", sigunguNo);
					map.put("passwd", passwd);
					adminService.updateSigunguPasswd(map);
					
					mv.addObject("response", "success");
				}
				
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("ZIPCODE_NO", sigunguAdminDTO.getZipcode_no());
			final ZipcodeDTO zipcodeDTO = regionService.selectRegionByNo(map);
			
			mv.addObject("id", sigunguAdminDTO.getId());
			mv.addObject("sido", zipcodeDTO.getSido());
			mv.addObject("sigungu", zipcodeDTO.getSigungu());
			mv.setViewName("sigungu_admin/passwdChange");
		}
			
		return mv;
	}
	
	@RequestMapping(value="/company_admin/loginCheck.do")
	public ModelAndView companyLoginCheck(CommandMap commandMap,
			HttpServletRequest request) throws Exception{
		
		//로그인 실패시
		ModelAndView mv = new ModelAndView("company_admin/login");
		CompanyAdminDTO companyAdminDto = adminService.selectCompanyAdmin(commandMap.getMap());
		
		//로그인 성공시
		if(companyAdminDto != null){
			
			HttpSession session  = request.getSession(true);
			session.setAttribute("company_admin", companyAdminDto);
			mv.setViewName("redirect:sigunguAdminList.do");
		}
		return mv;
	}
	
	@RequestMapping(value="/company_admin/assignSigunguAdmin.do")
	public ModelAndView assignSigunguAdmin(CommandMap commandMap,
			HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView("company_admin/login");
		log.debug(commandMap);
		
		HttpSession session = request.getSession(false);
		CompanyAdminDTO companyAdminDto = (CompanyAdminDTO)session.getAttribute("company_admin");
		
		if(companyAdminDto != null){
			ArrayList<ZipcodeDTO> list = regionService.selectRegionList();
			mv.addObject("list", list);
			mv.setViewName("company_admin/assignSigunguID");
		}
		return mv;
	}
	
	
	@RequestMapping(value="/company_admin/sigunguAdminList.do")
	public ModelAndView sigunguAdminList(CommandMap commandMap,
			HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView("company_admin/login");
		log.debug(commandMap);
		
		HttpSession session = request.getSession(false);
		CompanyAdminDTO companyAdminDto = (CompanyAdminDTO)session.getAttribute("company_admin");
		
		if(companyAdminDto != null){
			
			if(commandMap.getMap().get("sigunguAdminNo") != null
					&& !"".equals(String.valueOf(commandMap.getMap().get("sigunguAdminNo")))){
				adminService.deleteSigunguAdminByNo(String.valueOf(commandMap.getMap().get("sigunguAdminNo")));
			}
			
			//ArrayList<SigunguAdminDTO> sigunguAdminList = adminService.selectSigunguAdminList();
			ArrayList<Map> sigunguAdminAndSurveyList = adminService.selectSigunguAdminAndSurvey();
			ArrayList<ZipcodeDTO> zipcodeList = new ArrayList<>();
			
			if(sigunguAdminAndSurveyList != null) {
				
				for(Map sigunguAdminMap : sigunguAdminAndSurveyList) {
					
					Map<String, Object> map = new HashMap<>();
					map.put("ZIPCODE_NO", sigunguAdminMap.get("ZIPCODE_NO"));
					ZipcodeDTO zipcodeDTO = regionService.selectRegionByNo(map);
					zipcodeList.add(zipcodeDTO);
				}
				
				mv.addObject("zipcodeList", zipcodeList);
				mv.addObject("sigunguAdminList", sigunguAdminAndSurveyList);
				mv.setViewName("company_admin/sigunguAdminList");
				
			}
			
		}
		return mv;
	}
	
	@RequestMapping(value="/company_admin/enrollSigunguAdmin.do", consumes=MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView enrollSigunguAdmin(@RequestBody Map<String, Object> commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		log.debug(commandMap);
		
		try {
				final String passwd = (String)commandMap.get("passwd");
				final String passwdCheck = (String)commandMap.get("passwdCheck");
				
				if("".equals(passwd) || "".equals(passwdCheck) 
						|| passwd == null || passwdCheck == null) {
					
					mv.addObject("notMatch", "y");
					
				}else if(passwd.equals(passwdCheck)) {
					
					SigunguAdminDTO sigunguAdminDTO = adminService.selectSigunguAdminID(commandMap);
					
					if(sigunguAdminDTO != null) {
						mv.addObject("hasId", "y");
					}else {
						SurveyDTO surveyDTO = surveyService.selectSurveyByZipcode(commandMap);
						if(surveyDTO == null) {
							SurveyDTO surveyDTO2 = new SurveyDTO();
							surveyDTO2.setZipcode_no(Integer.valueOf((String)commandMap.get("zipcode")));
							surveyService.insertSurvey(surveyDTO2);
							commandMap.put("survey_no", surveyDTO2.getNo());
						}else {
							commandMap.put("survey_no", surveyDTO.getNo());
						}
						adminService.insertSigunguAdmin(commandMap);
					}
					
				}else {
					mv.addObject("notMatch", "y");
				}
		}catch(final MyBatisSystemException e) {
			mv.addObject("notMatch", "y");
		}
		
		return mv;
	}
	
}

package com.civildefense.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.civildefense.dto.TraineeDTO;

public class TraineeCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession(false);
		
		Logger log = Logger.getLogger(this.getClass());
		log.debug("getContextPath: " + request.getContextPath());
		log.debug("session: " + session);
		
		if(session == null) {
			response.sendRedirect(request.getContextPath() + "/region/sidoList.do");
			return false;
		}
		
		TraineeDTO traineeDTO = (TraineeDTO)session.getAttribute("trainee");
		
		if(traineeDTO == null) {
			response.sendRedirect(request.getContextPath() + "/region/sidoList.do");
			return false;
		}
		
		log.debug("traineeDTO::Zipcoe_no: " + traineeDTO.getZipcode_no());
		
		return true;
	}
}

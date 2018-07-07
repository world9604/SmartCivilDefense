package com.civildefense.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.civildefense.dto.CompanyAdminDTO;

public class CompanyLoginCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession(false);
		
		if(session == null) {
			response.sendRedirect(request.getContextPath() + "/company_admin/login.do");
			return false;
		}
		
		CompanyAdminDTO companyAdminDTO = (CompanyAdminDTO)session.getAttribute("company_admin");
		
		if(companyAdminDTO == null) {
			response.sendRedirect(request.getContextPath() + "/company_admin/login.do");
			return false;
		}
		
		return true;
	}
}

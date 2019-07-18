package com.cwb.finalproject.common;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class LoginIntercepter extends HandlerInterceptorAdapter{

	private Logger logger = LoggerFactory.getLogger(LoginIntercepter.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("preHandle()호출 - 컨트롤러 수행전 호출되는 메서드!!");
		
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("memId");
		if(userid == null || userid.isEmpty()) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인을 해주세요.')");
			out.println("location.href='"+request.getContextPath()+"/login/login.do'");
			out.println("</script>");
			
			return false;
		}
		
		return true;
	}
	
	
}

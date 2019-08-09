package com.cwb.finalproject.logout.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LogoutController {
	
	private Logger logger = LoggerFactory.getLogger(LogoutController.class);
	
	
	@RequestMapping("/logout/logout.do")
	public String logout(HttpSession session) {
		
		
		session.removeAttribute("memNo");
		session.removeAttribute("memId");
		session.removeAttribute("memName");
		session.removeAttribute("ranksNo");
		session.removeAttribute("fileName");
		
		if(session.getAttribute("memNo") == null) {
			logger.info("로그아웃 되었습니다.");
		}
		
		return "redirect:/login/login.do";
	}
}

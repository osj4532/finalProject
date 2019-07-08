package com.cwb.finalproject.commute.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cwb.finalproject.commute.model.CommuteService;

@Controller
@RequestMapping("/commute")
public class CommuteController {

	private Logger logger = LoggerFactory.getLogger(CommuteController.class); 
	
	@Autowired
	private CommuteService commuteService;
	
	//전체근태조회
	@RequestMapping("/commute.do")
	public String comMenu(@RequestParam(defaultValue = "0") String menu, HttpSession session, Model model) {
		String memId = "tester1";
		logger.info("유저 아이디 파라미터 memId={}", memId);
		
		
		logger.info("메뉴선택 파라미터 menu = {}", menu);
		
		
			if(menu.equals("AllAssiduity")) {
				List<Map<String, Object>> list = commuteService.selectAll();
				logger.info("전체조회 결과 list.size={}", list.size());
	
				model.addAttribute("list", list);
				return "commute/commute";
			}else if(menu.equals("")) {
				
			}

		return "commute/commute";
		
	}
	
}

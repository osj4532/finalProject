package com.cwb.finalproject.commute.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cwb.finalproject.commute.model.CommuteService;
import com.cwb.finalproject.commute.model.CommuteVO;

@Controller
@RequestMapping("/commute")
public class CommuteController {

	private Logger logger = LoggerFactory.getLogger(CommuteController.class); 
	
	@Autowired
	private CommuteService commuteService;
	
	@RequestMapping("/commute.do")
	public String comList(Model model) {
		
		List<Map<String, Object>> list = commuteService.selectAll();
		logger.info("전체조회 결과 list.size={}", list.size());
		
		model.addAttribute("list", list);
		
		return "commute/commute";
		
	}
}

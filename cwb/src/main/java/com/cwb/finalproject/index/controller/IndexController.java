package com.cwb.finalproject.index.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cwb.finalproject.commute.model.CommuteService;

@Controller
public class IndexController {

	private CommuteService commuteService;
	
	@RequestMapping("/index.do")
	public String index() {
		
		
		return null;
		
	}
}

package com.cwb.finalproject.resources.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/resources")
public class ResourcesController {
	private Logger logger = LoggerFactory.getLogger(ResourcesController.class);
	
	@RequestMapping("/list.do")
	public String resources_view() {
		logger.info("자원 목록 화면");
		
		return "resources/resourcesList";
	}
}

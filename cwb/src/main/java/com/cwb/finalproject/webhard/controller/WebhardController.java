package com.cwb.finalproject.webhard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/webhard")
public class WebhardController {

	Logger logger = LoggerFactory.getLogger(WebhardController.class);
	
	@RequestMapping("/webhard.do")
	public String webhard() {
		logger.info("webhard화면");
		
		return "webhard/webhard";
	}
}

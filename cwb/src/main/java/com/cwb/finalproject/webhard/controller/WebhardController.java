package com.cwb.finalproject.webhard.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cwb.finalproject.webhard.model.WebhardService;

@Controller
@RequestMapping("/webhard")
public class WebhardController {

	private Logger logger = LoggerFactory.getLogger(WebhardController.class);
	
	@Autowired
	private WebhardService webhardService;
	
	@RequestMapping("/webhard.do")
	public String webhard() {
		logger.info("webhard화면");
		
		return "webhard/webhard";
	}
	
	@RequestMapping("/webhardSetting.do")
	public String webhardSetting() {
		logger.info("webhardSetting 화면");
		
		return "webhard/webhardSetting"; 
	}
	
}

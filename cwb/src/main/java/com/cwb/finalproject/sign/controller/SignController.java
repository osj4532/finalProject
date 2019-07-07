package com.cwb.finalproject.sign.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/sign")
public class SignController {

	private Logger logger = LoggerFactory.getLogger(SignController.class);
	
	@RequestMapping(value="/signReg.do", method = RequestMethod.GET)
	public String signReg_get() {
		logger.info("사인 등록 화면 보여주기");
		return "sign/signReg";
	}
}

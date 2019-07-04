package com.cwb.finalproject.confirmline.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/document")
public class ConfirmlineController {

	private Logger logger = LoggerFactory.getLogger(ConfirmlineController.class);
	
	@RequestMapping(value="/docReg.do")
	public String docReg_get() {
		logger.info("문서등록 화면 보여주기");
		return "document/docreg";
	}
}

package com.cwb.finalproject.document.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/document")
public class DocumentController {
	
	private Logger logger = LoggerFactory.getLogger(DocumentController.class);
	
	@RequestMapping("/docType.do")
	public String docType() {
		logger.info("양식 등록 화면 보여주기");
		
		return "document/docset";
	}
}

package com.cwb.finalproject.document.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cwb.finalproject.document.model.DocFormService;
import com.cwb.finalproject.document.model.DocTypeService;
import com.cwb.finalproject.ranks.model.RanksService;
import com.cwb.finalproject.ranks.model.RanksVO;

@Controller
@RequestMapping("/document")
public class DocumentController {
	
	private Logger logger = LoggerFactory.getLogger(DocumentController.class);
	
	@Autowired
	private DocTypeService docTypeService;
	@Autowired
	private DocFormService docFormService;
	@Autowired
	private RanksService ranksService;
	
	@RequestMapping("/docType.do")
	public String docType(Model model) {
		logger.info("양식 등록 화면 보여주기");
		
		List<Map<String, Object>> typeList = docTypeService.selectDocType();
		List<Map<String, Object>> formList = docFormService.selectDocForm();
		List<RanksVO> rankList = ranksService.selectAll();
		
		model.addAttribute("typeList", typeList);
		model.addAttribute("formList", formList);
		model.addAttribute("rankList", rankList);
		
		return "document/docset";
	}
}

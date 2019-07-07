package com.cwb.finalproject.document.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cwb.finalproject.document.model.DocFormService;
import com.cwb.finalproject.document.model.DocFormVO;
import com.cwb.finalproject.document.model.DocTypeService;
import com.cwb.finalproject.document.model.DocTypeVO;
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
	
	@RequestMapping("/docSet.do")
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
	
	@RequestMapping(value="/docTypeIn.do",method = RequestMethod.POST)
	public String docTypeInsert(@ModelAttribute DocTypeVO vo,
			Model model) {
		logger.info("문서 종류 등록하기 매개변수 vo = {}",vo);
		
		int cnt = docTypeService.docTypeInsert(vo);
		logger.info("추가 결과 cnt = {}",cnt);
		
		String msg = "", url="/document/docSet.do";
		if(cnt > 0) {
			msg = "문서 종류 등록 성공!";
		}else {
			msg = "문서 종류 등록 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value="/docTypeDel.do", method = RequestMethod.POST)
	public String docTypeDel(@ModelAttribute DocTypeVO vo, Model model) {
		logger.info("문서 종류 삭제 매개변수 vo = {}", vo);
		
		int cnt = docTypeService.docTypeDel(vo.getTypeName());
		logger.info("결과 변수 cnt = {}",cnt);
		
		String msg = "", url="/document/docSet.do";
		if(cnt > 0) {
			msg = "문서 종류 삭제 성공!";
		}else {
			msg = "문서 종류 삭제 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value="/docFormIn.do", method = RequestMethod.POST)
	public String docFormInsert(@ModelAttribute DocFormVO vo, Model model) {
		logger.info("문서 양식 등록 매개변수 vo={}",vo);
		
		int cnt = docFormService.docFormInsert(vo);
		logger.info("결과 변수 cnt = {}",cnt);
		
		String msg = "", url="/document/docSet.do";
		if(cnt > 0) {
			msg = "문서 양식 종류 등록 성공!";
		}else {
			msg = "문서 양식 종류 등록 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value="/docFormDel.do", method = RequestMethod.POST)
	public String docFormDel(@RequestParam List<Integer> selForm, Model model) {
		logger.info("선택한 폼 지우기 매개변수 크기 = {}", selForm.size());
		int cnt = docFormService.docFormDel(selForm);
		logger.info("결과 변수 cnt = {}",cnt);
		
		String msg = "", url="/document/docSet.do";
		if(cnt > 0) {
			msg = "문서 양식 종류 삭제 성공!";
		}else {
			msg = "문서 양식 종류 삭제 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
}

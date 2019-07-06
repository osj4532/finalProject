package com.cwb.finalproject.confirm.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cwb.finalproject.confirm.model.ConfirmVO;
import com.cwb.finalproject.confirmline.controller.ConfirmlineController;
import com.cwb.finalproject.confirmline.model.ConfirmlineService;
import com.cwb.finalproject.document.model.DocFormService;
import com.cwb.finalproject.document.model.DocTypeService;
import com.cwb.finalproject.line.model.LineService;
import com.cwb.finalproject.line.model.LineVO;
import com.cwb.finalproject.member.model.MemberService;

@Controller
@RequestMapping("/document")
public class ConfirmController {
	
	private Logger logger = LoggerFactory.getLogger(ConfirmlineController.class);
	@Autowired
	private DocTypeService docTypeService;
	@Autowired
	private DocFormService docFormService;
	@Autowired
	private LineService lineService;
	@Autowired
	private ConfirmlineService confirmlineService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="/docSel.do", method = RequestMethod.GET)
	public String docSel_get(@RequestParam(required = false, defaultValue = "0") int formNo, 
			@RequestParam(required = false, defaultValue = "0") int regNo, 
			HttpSession session, Model model) {
		session.setAttribute("userNo", 1);
		int userNo = (Integer)session.getAttribute("userNo");
		logger.info("문서양식 및 종류 선택 화면 보여주기 userNo = {}",userNo);
		
		//1 문서 종류, 문서 양식 종류
		List<Map<String, Object>> docTypeList = docTypeService.selectDocType();
		List<Map<String, Object>> docFormList = docFormService.selectDocForm();
		
		
		if(formNo != 0) {
			logger.info("문서 양식 번호 formNo = {}", formNo);
			Map<String, Object> formInfo = docFormList.get(formNo-1);
			model.addAttribute("formInfo",formInfo);
		}
		
		
		logger.info("docTypeList 사이즈 = {}, docFormList 사이즈 = {}", docTypeList.size(), docFormList.size());

		//2 그사람이 등록한 결재라인 목록
		List<LineVO> lineList = lineService.selectAll(userNo);
		
		if(regNo != 0) {
			logger.info("결재라인 번호 regNo = {}", regNo);
			List<Map<String, Object>> clList = confirmlineService.selectAll(regNo);
			model.addAttribute("clList", clList);
		}
		
		model.addAttribute("docTypeList", docTypeList);
		model.addAttribute("docFormList", docFormList);
		model.addAttribute("lineList", lineList);
		
		return "document/docsel";
	}
	
	@RequestMapping(value="/docSel.do", method = RequestMethod.POST)
	public String docSel_post(@ModelAttribute ConfirmVO vo, 
			HttpSession session, Model model) {
		// confirmVO
		// form_no, mem_no, dept_no, reg_no, cf_title, cf_content, cf_state
		// cf_file, cf_tmpstorage, cf_del, cf_order, cf_regdate, cf_okdate
		
		//form_no, mem_no, reg_no, 
		int memNo = (Integer)session.getAttribute("userNo");
		vo.setMemNo(memNo);
		logger.info("문서 작성화면으로 넘기기 매개변수 vo = {}",vo);
		
		Map<String, Object> member = memberService.selectByNo(memNo);
		List<Map<String, Object>> clList = confirmlineService.selectAll(vo.getRegNo());
		Map<String, Object> formInfo = docFormService.selectDocFormByNo(vo.getFormNo());
		
		model.addAttribute("member", member);
		model.addAttribute("clList",clList);
		model.addAttribute("formInfo",formInfo);
		model.addAttribute("today", new Date());
		
		return "document/docreg";
	}
}

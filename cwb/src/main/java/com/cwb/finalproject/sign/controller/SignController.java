package com.cwb.finalproject.sign.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cwb.finalproject.common.FileUploadUtil;
import com.cwb.finalproject.sign.model.SignService;
import com.cwb.finalproject.sign.model.SignVO;

@Controller
@RequestMapping("/sign")
public class SignController {

	private Logger logger = LoggerFactory.getLogger(SignController.class);
	
	@Autowired
	private FileUploadUtil fileUtil; 
	
	@Autowired
	private SignService signService;
	
	@RequestMapping(value="/signReg.do", method = RequestMethod.GET)
	public String signReg_get(Model model, HttpSession session) {
		logger.info("사인 등록 화면 보여주기");
		int memberNo = (Integer)session.getAttribute("memNo");
		
		SignVO vo = signService.selectSign(memberNo);
		
		model.addAttribute("signVo", vo);
		
		return "sign/signReg";
	}
	
	@RequestMapping(value="/signReg.do", method = RequestMethod.POST)
	public String signReg_post(@ModelAttribute SignVO signVo, HttpServletRequest request,
			Model model) {
		logger.info("사인 등록 처리 매개변수 signVo = {}", signVo);
		
		HttpSession session = request.getSession();
		int memberNo = (Integer)session.getAttribute("memNo");
		
		Map<String, Object> map = fileUtil.singleUpload(request, FileUploadUtil.SIGN_UPLOAD);
		String fileName = (String)map.get("fileName");
		long fileSize = (Long)map.get("fileSize");
		String originalFileName = (String)map.get("originalFileName");
		
		signVo.setMemNo(memberNo);
		signVo.setSignFileName(fileName);
		signVo.setSignFileSize(fileSize);
		signVo.setSignOriginalFileName(originalFileName);
		
		int cnt = signService.insertSign(signVo);
		
		String msg = "", url ="/index.do";
		if(cnt > 0) {
			msg = "결재 사인 등록 성공!";
		}else {
			msg = "결재 사인 등록 실패!";
			url = "/sign/signReg.do";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value="/signEdit.do", method = RequestMethod.POST)
	public String signEdit_post(@ModelAttribute SignVO signVo, HttpServletRequest request,
			Model model) {
		logger.info("사인 수정 처리 매개변수 signVo = {}", signVo);
		
		HttpSession session = request.getSession();
		int memberNo = (Integer)session.getAttribute("memNo");
		
		Map<String, Object> map = fileUtil.singleUpload(request, FileUploadUtil.SIGN_UPLOAD);
		String fileName = (String)map.get("fileName");
		long fileSize = (Long)map.get("fileSize");
		String originalFileName = (String)map.get("originalFileName");
		
		signVo.setMemNo(memberNo);
		signVo.setSignFileName(fileName);
		signVo.setSignFileSize(fileSize);
		signVo.setSignOriginalFileName(originalFileName);
		
		int cnt = signService.updateSign(signVo, request);
		
		String msg = "", url ="/index.do";
		if(cnt > 0) {
			msg = "결재 사인 수정 성공!";
		}else {
			msg = "결재 사인 수정 실패!";
			url = "/sign/signReg.do";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	
}

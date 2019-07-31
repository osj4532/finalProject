package com.cwb.finalproject.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cwb.finalproject.member.model.MemberService;
import com.cwb.finalproject.member.model.MemberVO;

@Controller
public class MemberController {

	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="/member/memberRegister.do", method=RequestMethod.GET)
	public void registerShow() {
		logger.info("멤버 등록 화면");
	}
	
	@RequestMapping(value="/member/memberRegister.do", method = RequestMethod.POST)
	public String register(@ModelAttribute MemberVO vo, @RequestParam String email3, Model model) {
		
		logger.info("회원가입 처리, 파라미터 vo={}", vo);
		
		if(vo.getMemHp2() == null || vo.getMemHp2().isEmpty() || vo.getMemHp3() == null || vo.getMemHp3().isEmpty()) {
			vo.setMemHp1("");
			vo.setMemHp2("");
			vo.setMemHp3("");
		}
		
		//email
		if(vo.getMemEmail1() == null || vo.getMemEmail1().isEmpty()) {
			vo.setMemEmail1("");
			vo.setMemEmail2("");
		}else {
			if(vo.getMemEmail2().equals("etc")) {
				if(email3 == null || email3.isEmpty()) {
					vo.setMemEmail1("");
					vo.setMemEmail2("");
				}else {
					vo.setMemEmail2(email3); 
				}
			}
		}
		
		//int cnt = memberService.insertMember(vo);
		//logger.info("회원가입 처리 결과 cnt = {}", cnt);
		
		return null;
		
	}
	
	@RequestMapping("/member/memberList.do")
	public void list() {
		logger.info("멤버 조회 화면");
		
	}
	@RequestMapping("/member/memberEdit.do")
	public void edit() {
		logger.info("멤버 수정 화면");
	}
	@RequestMapping("/member/memberDetail.do")
	public void detail() {
		logger.info("멤버 상세보기 화면");
	}
	
	
}

package com.cwb.finalproject.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cwb.finalproject.member.model.MemberService;

@Controller
public class MemberController {

	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/member/memberRegister.do")
	public void Register() {
		logger.info("멤버 등록 화면");
	}
	@RequestMapping("/member/memberList.do")
	public void List() {
		logger.info("멤버 조회 화면");
		
	}
	@RequestMapping("/member/memberEdit.do")
	public void Edit() {
		logger.info("멤버 수정 화면");
	}
	@RequestMapping("/member/memberDetail.do")
	public void Detail() {
		logger.info("멤버 상세보기 화면");
	}
	
	
}

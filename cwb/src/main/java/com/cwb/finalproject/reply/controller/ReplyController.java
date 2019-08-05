package com.cwb.finalproject.reply.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.member.model.MemberService;
import com.cwb.finalproject.member.model.MemberVO;
import com.cwb.finalproject.reply.model.ReplyService;
import com.cwb.finalproject.reply.model.ReplyVO;

@Controller
@RequestMapping("/Reply")
public class ReplyController {
	Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@Autowired ReplyService replyService;
	@Autowired MemberService memberService;

	
	@RequestMapping("/ReplyWrite.do")
	public String ReplyWrite(@ModelAttribute ReplyVO replyVo,
			Model model,HttpSession session) {
		logger.info("댓글 입력 replyVo={}",replyVo); 
		int memNo= (Integer)session.getAttribute("memNo");
		replyVo.setMemNo(memNo);
		
		String type =replyVo.getRepSecret();
		if(type==null || type.isEmpty()) {
			replyVo.setRepSecret("N");
		}else { 
			replyVo.setRepSecret("Y");
		} 
		
		int cnt = replyService.insertOriginReply(replyVo);
		String msg = "",url="/Board/BoardDetail.do?boardNo="+replyVo.getBoardNo();
		if(cnt>0) {
			msg="댓글 입력 성공";
		}else {
			msg="댓글 입력 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value = "/findAjaxMember.do" ,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String findReplyMember(@RequestParam(defaultValue = "0") int memNo) {
		MemberVO memVo= memberService.selectByMemNotoVo(memNo);
		String replycheck=memVo.getMemName(); 
		logger.info("ajax 작성자 구해오기 replycheck={}",replycheck);
		return replycheck;  
	} 
	
}

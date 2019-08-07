package com.cwb.finalproject.reply.controller;

import java.util.HashMap;
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
	@RequestMapping("/GroupWrite.do")
	@ResponseBody
	public void Group(@RequestParam int repNo,@RequestParam String content
			,HttpSession session) {  
		logger.info("대댓글 입력 repNo={},content={}",repNo,content); 
		int memNo= (Integer)session.getAttribute("memNo");
		
		ReplyVO originReVo = replyService.selectOriginReply(repNo);
		int cnt = replyService.updateSortNo(originReVo);
		ReplyVO ReVo= new ReplyVO();
		ReVo.setMemNo(memNo);
		ReVo.setRepSecret("Y");
		ReVo.setRepGroup(originReVo.getRepNo());
		ReVo.setRepContent(content);
		ReVo.setBoardNo(originReVo.getBoardNo());
		ReVo.setRepDepth(originReVo.getRepDepth()+1);
		ReVo.setRepSortno(originReVo.getRepSortno()+1);
		logger.info("대댓글 입력 ReVo={}",ReVo); 
		int cntt = replyService.insertReply(ReVo);
		
		logger.info("대댓글 입력 cntt={}",cntt);
		
	}
	
	@RequestMapping("/ReplyEdit.do")
	public String ReplyEdit(@ModelAttribute ReplyVO replyVo,
			Model model,HttpSession session) {
		logger.info("댓글 수정 replyVo={}",replyVo); 
		
		int cnt = replyService.updateReplyByNo(replyVo);
		String msg = "",url="/Board/BoardDetail.do?boardNo="+replyVo.getBoardNo();
		if(cnt>0) {
			msg="댓글 수정 성공";
		}else {
			msg="댓글 수정 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	
	
	@RequestMapping(value = "/findAjaxMember.do") //produces = "application/text; charset=utf8")
	@ResponseBody
	public Map<String, String> findReplyMember(@RequestParam(defaultValue = "0") int memNo,
			HttpSession session,@RequestParam String repSecret) {
		Map<String, String> map = new HashMap<String, String>();
		int loginMemNo=(Integer)session.getAttribute("memNo");
		int ranksNo=(Integer)session.getAttribute("ranksNo"); 
		
		String show ="N",divshow ="N";
		if(repSecret.equals("Y")) {
			show="Y";
		}else {
			if(loginMemNo==memNo) {
				show="Y";
			}
			if(ranksNo==3) { 
				show="Y";
			}
		}
		if(loginMemNo==memNo) {
			divshow="Y";
		}
		if(ranksNo==3) { 
			divshow="Y"; 
		}
		
		
		MemberVO memVo= memberService.selectByMemNotoVo(memNo);
		String memName=memVo.getMemName(); 
		
		
		map.put("memName", memName);
		map.put("show", show);
		map.put("divshow", divshow);
		logger.info("ajax 작성자 구해오기 map={}",map);
		return map;  
	} 
	@RequestMapping(value = "/GroupSelect.do") //produces = "application/text; charset=utf8")
	@ResponseBody
	public List<ReplyVO> replyGroupSelect(@RequestParam(defaultValue = "0") int repNo) {
		List<ReplyVO> reList = replyService.selectReplyGroup(repNo);
		
		for (int i = 0; i < reList.size(); i++) {
			ReplyVO vo=reList.get(i);
			MemberVO memVo= memberService.selectByMemNotoVo(vo.getMemNo());
			vo.setMemName(memVo.getMemName()); 
		}
		
		
		return reList;  
	} 
	
	
	
}

package com.cwb.finalproject.address.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.dept.model.DeptService;
import com.cwb.finalproject.dept.model.DeptVO;
import com.cwb.finalproject.member.model.MemberService;

@Controller
@RequestMapping("/address")
public class AddressController {

	private Logger logger = LoggerFactory.getLogger(AddressController.class);
	@Autowired
	private DeptService deptService;
	@Autowired
	private MemberService memberService;
	@RequestMapping("/privateAddr.do")
	public String showPrivAddr() {
		logger.info("개인 주소록 보여주기");
		return "address/privateAddr";
	}
	
	@RequestMapping("/companyAddr.do")
	public String showCompAddr(Model model) {
		logger.info("회사 주소록 보여주기");
		
		List<DeptVO> depts = deptService.selectAll();
		List<Map<String, Object>> members = memberService.selectOrSearch(null);
		logger.info("부서 사이즈={}, member사이즈={}",depts.size(),members.size());
		
		model.addAttribute("depts", depts);
		model.addAttribute("members", members);
		
		return "address/companyAddr";
	}
	
	@RequestMapping("/companySearch.do")
	@ResponseBody
	public List<Map<String, Object>> searchMem(@RequestParam String keyword){
		logger.info("검색어 = {}", keyword);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyword",keyword);
		
		List<Map<String,Object>> members = memberService.selectOrSearch(map);
		for(Map<String, Object> mem : members) {
			//Timestamp는 json으로 바꾸지 못함
			mem.put("MEM_JOINDATE", null);
		}
		logger.info("검색 결과 리스트 사이즈 = {}",members.size());
		return members;
	}
	
	@RequestMapping("/memInfo.do")
	@ResponseBody
	public Map<String, Object> memInfo(@RequestParam int memNo){
		logger.info("멤버 정보 보여주기 memNo = {}", memNo);
		Map<String, Object> member = memberService.selectByNo(memNo);
		String memberPic = (String)member.get("MEM_FILENAME"); 
		if(memberPic == null || memberPic.isEmpty()) {
			member.put("MEM_FILENAME","user.png");
		}
		member.put("MEM_JOINDATE",null);
		return member;
	}
	
	@RequestMapping("/sendEmail.do")
	public String sendEmail(@RequestParam(required = false) String email, 
			HttpSession session, Model model) {
		logger.info("이메일 보내기 화면 보여주기 매개변수 = {}", email);
		int memNo = (Integer)session.getAttribute("memNo");
		Map<String, Object> member = memberService.selectByNo(memNo);
		
		String senderMail = member.get("MEM_EMAIL1")+"@"+member.get("MEM_EMAIL2");
		model.addAttribute("sender", senderMail);
		model.addAttribute("receiver", email);
		
		return "address/sendEmail";
	}
	
	
	@RequestMapping("/sendMessage.do")
	public String sendMessage(@RequestParam(required = false) int memNo, Model model) {
		logger.info("쪽지 보내기 화면 보여주기 매개변수 = {}", memNo);
		
		model.addAttribute("memNo", memNo);
		return "address/sendMessage";
	}
}

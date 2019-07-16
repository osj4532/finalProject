package com.cwb.finalproject.address.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
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
}

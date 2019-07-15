package com.cwb.finalproject.address.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String showCompAddr(@RequestParam(required = false)String keyword,  Model model) {
		logger.info("회사 주소록 보여주기");
		List<DeptVO> depts = deptService.selectAll();
		List<Map<String, Object>> members = memberService.selectOrSearch(keyword);
		
		model.addAttribute("depts", depts);
		model.addAttribute("members", members);
		
		return "address/companyAddr";
	}
}

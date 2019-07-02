package com.cwb.finalproject.dept.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cwb.finalproject.dept.model.DeptService;
import com.cwb.finalproject.dept.model.DeptVO;

@Controller
public class DeptController {

	@Autowired
	private DeptService deptService;
	
	private Logger logger = LoggerFactory.getLogger(DeptController.class);
	
	@RequestMapping("/dept/deptList.do")
	public String selectDept(Model model) {
		logger.info("부서 목록 보여주기");
		List<DeptVO> list = deptService.selectAll();
		logger.info("부서 목록 조회 결과 list.size() = {}",list.size());
		
		model.addAttribute("list",list);
		return "dept/deptList";
	}
}

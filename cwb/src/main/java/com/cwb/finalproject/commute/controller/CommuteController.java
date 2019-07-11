package com.cwb.finalproject.commute.controller;

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

import com.cwb.finalproject.commute.model.CommuteService;

@Controller
@RequestMapping("/commute")
public class CommuteController {

	private Logger logger = LoggerFactory.getLogger(CommuteController.class); 
	
	@Autowired
	private CommuteService commuteService;
	
	//전체근태조회
	@RequestMapping("/commute.do")
	public String comMenu(@RequestParam(defaultValue = "indWork") String menu, HttpSession session, Model model) {
		session.setAttribute("memId", "tester1");
		session.setAttribute("memNo", 1);
		
		String memId = (String) session.getAttribute("memId");
		int memNo = (Integer) session.getAttribute("memNo");
		
		logger.info("유저 아이디 파라미터 memId={}, menu={}", memId, menu);
		
			if(menu.equals("allAssiduity")) {	//전체 조회
				List<Map<String, Object>> list = commuteService.selectAll();
				logger.info("전체조회 결과 list.size={}", list.size());
	
				model.addAttribute("list", list);
				return "commute/commute";
				
			}else if(menu.equals("indWork")) {	//개인 출퇴근 조회
				List<Map<String, Object>> list = commuteService.selectIndiv(memNo);
				logger.info("개인출퇴근 조회 결과 list.size={}", list.size());
				
				model.addAttribute("list", list);
				return "commute/commute";
				
			}else if(menu.equals("depAssiduity")) {	//부서 근태조회
				String deptName = commuteService.selectByMemNo(memNo);
				logger.info("번호로 부서이름 조회 결과 deptName={}", deptName);
				
				List<Map<String, Object>> list = commuteService.selectDep(deptName);
				logger.info("부서이름으로 조회 결과 list.size={}", list.size());
				
				model.addAttribute("list", list);
				
				return "commute/commute";
				
			}else if(menu.equals("indHoly")) {
				List<Map<String, Object>> list = commuteService.selectIndivHoly(memNo);
				logger.info("개인 연차 조회 결과 list.size={}", list.size());
				
				model.addAttribute("list", list);
				
				return "commute/commute";
			}else if(menu.equals("allHoly")) {
				List<Map<String, Object>> list = commuteService.selectAllHoly();
				logger.info("전체 연차 조회 결과 list.size={}", list.size());
				
				model.addAttribute("list", list);
				
				return "commute/commute";
			}

		return "commute/commute";
		
	}
	
	
}

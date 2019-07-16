package com.cwb.finalproject.commute.controller;

import java.util.List;
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
import org.springframework.web.bind.annotation.RequestParam;

import com.cwb.finalproject.common.PaginationInfo;
import com.cwb.finalproject.common.WebUtility;
import com.cwb.finalproject.commute.model.CommuteService;

@Controller
@RequestMapping("/commute")
public class CommuteController {

	private Logger logger = LoggerFactory.getLogger(CommuteController.class); 
	
	@Autowired
	private CommuteService commuteService;
	
	
	
	@RequestMapping(value="/commute.do", method = RequestMethod.GET) 
	public String comMenu(@RequestParam(defaultValue = "indWork") String menu,	HttpSession session, Model model) {
	  
		int memNo = (Integer) session.getAttribute("memNo");
		  
		List<Map<String, Object>> list = commuteService.selectIndiv(memNo);
		logger.info("초기화면 결과 list.size={}", list.size());
		  
		String title = "개인 출퇴근 조회";
		model.addAttribute("title", title);
		model.addAttribute("list", list);
		  
		return "commute/commute";
	  
	}
	 
	
	@RequestMapping(value="/commute.do", method = RequestMethod.POST)
	public String comMenu(@RequestParam String menu, String currentPage, String countPerPage, HttpSession session, Model model) {
		
		String memId = (String) session.getAttribute("memId");
		int memNo = (Integer) session.getAttribute("memNo");
		
		logger.info("유저 아이디 파라미터 memId={}, menu={}", memId, menu);
		
		
		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(WebUtility.BLOCK_SIZE);
		pagingInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		pagingInfo.setCurrentPage(Integer.parseInt(currentPage));
		 
		
		
		
			String title = "";
			List<Map<String, Object>> list = null;
			if(menu.equals("allAssiduity")) {	//전체 조회
				list = commuteService.selectAll();
				logger.info("전체조회 결과 list.size={}", list.size());
				title = "전체 조회";
				
			}else if(menu.equals("indWork")) {	//개인 출퇴근 조회
				list = commuteService.selectIndiv(memNo);
				logger.info("개인출퇴근 조회 결과 list.size={}", list.size());
				
				title = "개인 출퇴근 조회";
				
			}else if(menu.equals("depAssiduity")) {	//부서 근태조회
				String deptName = commuteService.selectByMemNo(memNo);
				logger.info("번호로 부서이름 조회 결과 deptName={}", deptName);
				
				list = commuteService.selectDep(deptName);
				logger.info("부서이름으로 조회 결과 list.size={}", list.size());
				
				title = "부서 근태 조회";
				
			}else if(menu.equals("indHoly")) {
				list = commuteService.selectIndivHoly(memNo);
				logger.info("개인 연차 조회 결과 list.size={}", list.size());
				
				title = "개인 연차 조회";
			}else if(menu.equals("allHoly")) {
				list = commuteService.selectAllHoly();
				logger.info("전체 연차 조회 결과 list.size={}", list.size());
				
				title = "전체 연차 조회";
			}

			model.addAttribute("title", title);
			model.addAttribute("list", list);
			//model.addAttribute("pagingInfo", pagingInfo);
			
			return "commute/commute";
		
	}
	
	
	
}

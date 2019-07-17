package com.cwb.finalproject.commute.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.record.pivottable.PageItemRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.common.PaginationInfo;
import com.cwb.finalproject.common.WebUtility;
import com.cwb.finalproject.commute.model.CommuteService;

@Controller
@RequestMapping("/commute")
public class CommuteController {

	private Logger logger = LoggerFactory.getLogger(CommuteController.class); 
	
	@Autowired
	private CommuteService commuteService;
	
	
	
	@RequestMapping("/commute.do") 
	public String commute() {
		logger.info("근태관리 화면");
		
		return "commute/commute";
	}
	
	
	@RequestMapping("/comPage.do")
	public List<Map<String, Object>> comShow(@RequestParam String menu, @RequestParam(required = false, defaultValue = "1")int currentPage, String countPerPage, HttpSession session, Model model) {
		
		String memId = (String) session.getAttribute("memId");
		int memNo = (Integer) session.getAttribute("memNo");
		
		logger.info("유저 아이디 파라미터 memId={}, menu={}", memId, menu);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(WebUtility.BLOCK_SIZE);
		pagingInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		pagingInfo.setCurrentPage(currentPage);
		
		map.put("firstRecordIndex", pagingInfo.getFirstRecordIndex());
		map.put("recordCountPerPage", pagingInfo.getRecordCountPerPage());
		
		String title = "";
		List<Map<String, Object>> list = null;
		int totalRecord = 0;
		if(menu.equals("allAssiduity")) {	//전체 조회
			list = commuteService.selectAll(map);
			logger.info("전체조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countSelectAll();
			logger.info("전체조회 결과 갯수 totalRecord={}", totalRecord);
			title = "전체 조회";

		}else if(menu.equals("indWork")) {	//개인 출퇴근 조회
			map.put("memNo", memNo);
			list = commuteService.selectIndiv(map);
			logger.info("개인출퇴근 조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countSelectIndiv(memNo);
			logger.info("개인출퇴근 조회 결과 갯수 totalRecord={}", totalRecord);
			title = "개인 출퇴근 조회";

		}else if(menu.equals("depAssiduity")) {	//부서 근태조회
			String deptName = commuteService.selectByMemNo(memNo);
			logger.info("번호로 부서이름 조회 결과 deptName={}", deptName);
			
			map.put("deptName", deptName);
			list = commuteService.selectDep(map);
			logger.info("부서이름으로 조회 결과 list.size={}", list.size());

			totalRecord = commuteService.countSelectDep(deptName);
			logger.info("부서이름으로 조회 결과 갯수 totalRecord={}", totalRecord);
			title = "부서 근태 조회";

		}else if(menu.equals("indHoly")) {
			map.put("memNo", memNo);
			
			list = commuteService.selectIndivHoly(map);
			logger.info("개인 연차 조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countSelectIndivHoly(memNo);
			logger.info("개인연차 조회 결과 갯수 totalRecord={}", totalRecord);
			title = "개인 연차 조회";
		}else if(menu.equals("allHoly")) {
			list = commuteService.selectAllHoly(map);
			logger.info("전체 연차 조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countSelectAllHoly();
			logger.info("전체연차 조회 결과 갯수 totalRecord={}", totalRecord);
			title = "전체 연차 조회";
		}
		
		pagingInfo.setTotalRecord(totalRecord);
		Map<String, Object> page = new HashMap<String, Object>();
		page.put("page", pagingInfo);
		list.add(page);
		
		return list;

	}
	
}

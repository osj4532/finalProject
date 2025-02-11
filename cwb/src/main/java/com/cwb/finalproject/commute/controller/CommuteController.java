package com.cwb.finalproject.commute.controller;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.common.PaginationInfo;
import com.cwb.finalproject.common.WebUtility;
import com.cwb.finalproject.commute.model.CommuteService;
import com.cwb.finalproject.commute.model.CommuteVO;

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
	@ResponseBody
	public List<Map<String, Object>> comShow(@RequestParam(defaultValue = "indWork") String menu, @RequestParam(required = false, defaultValue = "1")int currentPage, HttpSession session) {
		
		String memId = (String) session.getAttribute("memId");
		int memNo = (Integer) session.getAttribute("memNo");
		
		
		logger.info("유저 아이디 파라미터 memId={}, menu={}", memId, menu);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(WebUtility.BLOCK_SIZE);
		pagingInfo.setRecordCountPerPage(10);
		pagingInfo.setCurrentPage(currentPage);
		
		map.put("firstRecordIndex", pagingInfo.getFirstRecordIndex());
		map.put("recordCountPerPage", pagingInfo.getRecordCountPerPage());
		
		List<Map<String, Object>> list = null;
		int totalRecord = 0;
		if(menu.equals("allAssiduity")) {	//전체 조회
			list = commuteService.selectAll(map);
			logger.info("전체조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countSelectAll();
			logger.info("전체조회 결과 갯수 totalRecord={}", totalRecord);

		}else if(menu.equals("indWork")) {	//개인 출퇴근 조회
			map.put("memNo", memNo);
			list = commuteService.selectIndiv(map);
			logger.info("개인출퇴근 조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countSelectIndiv(memNo);
			logger.info("개인출퇴근 조회 결과 갯수 totalRecord={}", totalRecord);
			
			
			
		}else if(menu.equals("depAssiduity")) {	//부서 근태조회
			String deptName = commuteService.selectByMemNo(memNo);
			logger.info("번호로 부서이름 조회 결과 deptName={}", deptName);
			
			map.put("deptName", deptName);
			list = commuteService.selectDep(map);
			logger.info("부서이름으로 조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countSelectDep(deptName);
			logger.info("부서이름으로 조회 결과 갯수 totalRecord={}", totalRecord);

		}else if(menu.equals("indHoly")) {
			map.put("memNo", memNo);
			
			list = commuteService.selectIndivHoly(map);
			logger.info("개인 연차 조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countSelectIndivHoly(memNo);
			logger.info("개인연차 조회 결과 갯수 totalRecord={}", totalRecord);
		}else if(menu.equals("allHoly")) {
			list = commuteService.selectAllHoly(map);
			logger.info("전체 연차 조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countSelectAllHoly();
			logger.info("전체연차 조회 결과 갯수 totalRecord={}", totalRecord);
		}else if(menu.equals("depAssi")) {
			list = commuteService.selectDepAssi();
			logger.info("부서별 근태 조회 결과 list.size={}", list.size());
			
			totalRecord = commuteService.countDepAssi();
			logger.info("부서별 근태 조회 결과 갯수 totalRecord={}", totalRecord);
		}
		
		pagingInfo.setTotalRecord(totalRecord);
		Map<String, Object> page = new HashMap<String, Object>();
		page.put("page", pagingInfo);
		
		list.add(0, page);
		//[{"page":{"currentPage":1,"recordCountPerPage":5,"blockSize":10,"totalRecord":1,"totalPage":1,"firstPage":1,"lastPage":1,"firstRecordIndex":0,"lastRecordIndex":5}},{"COMOUTDATE":1563250427000,"RNUM":1,"DEPTNAME":"기획팀","COMSTATUS":"N","COMINDATE":1563250427000,"POSNAME":"사원","MEMNO":4,"MEMNAME":"사원2"}]
		return list;
	}
	
	@RequestMapping("/inout.do")
	public String inout(@RequestParam String status, HttpSession session, HttpServletRequest request) {
		logger.info("출근, 퇴근 체크 파라미터 status = {}", status);
		
		int memNo = (Integer) session.getAttribute("memNo");
		String comindate = (String) session.getAttribute("cominDate");
		int state = (Integer) session.getAttribute("state");
		
		CommuteVO vo = new CommuteVO();
		vo.setMemNo(memNo);
		int cnt = 0;
		int comNo = 0;
		logger.info("comindate = {}", comindate);
		if(status.equals("in")) {

			if(state == 3 && (comindate == null || comindate.isEmpty())) {
				comNo = commuteService.selectComNo(memNo);
				cnt = commuteService.updateComin(comNo);
				logger.info("출근 입력 처리 결과 cnt = {}", cnt);
				state = CommuteService.WORK;
				session.setAttribute("state", state);
			}
			
		}else if(status.equals("out")) {
			logger.info("state체크 = {}", state);
			if(state == 1 || state == 2) {
				comNo = commuteService.selectComNo(memNo);
				
				cnt = commuteService.updateComout(comNo);
				logger.info("퇴근 업데이트 처리 결과 cnt = {}", cnt);
				state = CommuteService.LEAVE;
				session.setAttribute("state", state);
			}
		}
		
		String referer = request.getHeader("Referer");
		
	    return "redirect:"+ referer;
	}
	
	
}

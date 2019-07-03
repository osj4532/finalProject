package com.cwb.finalproject.line.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cwb.finalproject.confirmline.model.ConfirmlineVO;
import com.cwb.finalproject.dept.model.DeptService;
import com.cwb.finalproject.dept.model.DeptVO;
import com.cwb.finalproject.line.model.LineService;
import com.cwb.finalproject.line.model.LineVO;
import com.cwb.finalproject.member.model.MemberService;

@Controller
public class LineController {
	
	@Autowired
	private DeptService deptService;
	@Autowired
	private LineService lineService;
	@Autowired
	private MemberService memberService;
	
	private Logger logger = LoggerFactory.getLogger(LineController.class);
	
	@RequestMapping(value="/line/linereg.do", method = RequestMethod.GET)
	public String lineReg_get(Model model) {
		logger.info("결재 라인 등록 화면 보여주기");
		
		List<DeptVO> deptList = deptService.selectAll();
		model.addAttribute("deptList", deptList);
		
		return "/line/linereg";
	}
	
	@RequestMapping(value="/line/linereg.do", method = RequestMethod.POST)
	public String lineTmp_post(@RequestParam(required = false) List<String> selArr, 
			@RequestParam(required = false, defaultValue = "0") int deptNo,
			ModelMap model) {
		logger.info("결재 라인 등록 임시 매개변수 selArr = {}, deptNo = {}",selArr, deptNo);
		
		//부서 번호로 인원 조회 리스트 뿌려주기
		List<Map<String, Object>> memberList = null;
		if(deptNo != 0) {
			memberList = memberService.selectByDeptNo(deptNo);
			logger.info("부서별 팀장이상 리스트사이즈 memberList.size={}", memberList.size());
		}
		 
		model.addAttribute("memberList", memberList);
		
		
		List<Map<String, Object>> selMemberList = new ArrayList<Map<String, Object>>();
		if(selArr.size() != 0) {
			for(String memNo : selArr) {
				Map<String, Object> memBerVo = memberService.selectByNo(Integer.parseInt(memNo));
				selMemberList.add(memBerVo);
			}
		}
		model.addAttribute("selMemberList",selMemberList);
		
		
		//부서 목록을 뿌려준다.
		List<DeptVO> deptList = deptService.selectAll();
		model.addAttribute("deptList", deptList);
		
		return "/line/linereg";
	}
	
	@RequestMapping(value="/line/lineproc.do", method = RequestMethod.POST)
	public String lineReg_post(@RequestParam(required = false) List<String> selArr,
			@RequestParam String lineName, HttpSession session) {
		logger.info("결재 라인 등록 처리 매개변수 selArr = {}, lineName = {}",selArr, lineName);
		
		//1. linereg에 linename으로 insert 후
		LineVO lineVo = new LineVO();

		session.setAttribute("userNo", 9);
		
		lineVo.setMemNo((Integer)session.getAttribute("userNo"));
		lineVo.setRegName(lineName);
		
		List<ConfirmlineVO> confirmList = new ArrayList<ConfirmlineVO>();
		for(int i = 0; i < selArr.size(); i++) {
			ConfirmlineVO confirmVo = new ConfirmlineVO();
			confirmVo.setLineOrder(i);
			confirmVo.setMemNo(Integer.parseInt(selArr.get(i)));
			confirmList.add(confirmVo);
		}
		
		//2. confirmline에 insert
		int cnt = lineService.regLine(lineVo, confirmList);
		logger.info("결재라인 등록 처리 결과 cnt = {}",cnt);
		
		return "/line/linereg";
	}
	
	
	
}

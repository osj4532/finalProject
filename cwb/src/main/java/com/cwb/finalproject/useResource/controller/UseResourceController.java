package com.cwb.finalproject.useResource.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cwb.finalproject.resScheduler.model.ResSchedulerVO;
import com.cwb.finalproject.useResource.model.UseResourceService;
import com.cwb.finalproject.useResource.model.UseResourceVO;

@Controller
@RequestMapping("/useResource")
public class UseResourceController {
	private Logger logger = LoggerFactory.getLogger(UseResourceController.class);
	
	@Autowired UseResourceService useResourceService;
	
	@RequestMapping("/useResList.do")
	public String useResList(HttpSession Session,Model model) {
		int memNo=(Integer)Session.getAttribute("memNo");
		logger.info("유저 자원 사용 내역 보여주기 memNO={}", memNo);
		
		List<UseResourceVO> myUseList = useResourceService.selectMyUseRes(memNo);
		for (UseResourceVO vo : myUseList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
		}
		
		List<UseResourceVO> canList = useResourceService.selectMyNotUseRes(memNo);
		for (UseResourceVO vo : canList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
		}
		
		List<UseResourceVO> waitList = useResourceService.selectMyNotWaitRes(memNo);
		for (UseResourceVO vo : waitList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
		}
		
		List<UseResourceVO> refuseList = useResourceService.selectMyNotRefuseRes(memNo);
		for (UseResourceVO vo : refuseList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
		}
		
		model.addAttribute("waitList", waitList);
		model.addAttribute("refuseList", refuseList);
		model.addAttribute("canList", canList);
		model.addAttribute("myUseList", myUseList);
		
		return "resources/useRes/uesResList";
	}
	
}

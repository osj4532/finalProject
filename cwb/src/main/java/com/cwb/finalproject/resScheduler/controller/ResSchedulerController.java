package com.cwb.finalproject.resScheduler.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.resScheduler.model.ResSchedulerService;
import com.cwb.finalproject.resScheduler.model.ResSchedulerVO;
import com.cwb.finalproject.resources.model.ResourcesService;
import com.cwb.finalproject.resources.model.ResourcesVO;

@Controller
@RequestMapping("/resScheduler")
public class ResSchedulerController {
	private Logger logger = LoggerFactory.getLogger(ResSchedulerController.class);
	
	@Autowired private ResourcesService resourcesService;
	@Autowired private ResSchedulerService resSchedulerService;
	
	@RequestMapping("/resScheduler.do")
	public String resScheduler(@RequestParam int resNo,
			Model model) {
		logger.info("자원 스케줄 보여주기");
		
		ResourcesVO resVo= resourcesService.selectResByNo(resNo);
		model.addAttribute("resVo", resVo);
		return "resources/resourcesScheduler";
	}
	@RequestMapping("/ResScdFind.do")
	@ResponseBody
	public List<ResSchedulerVO> ResScdFind(@RequestParam int resNo) {
		logger.info("ajax 이용 자원스케줄 가지고오기 resNo={}",resNo);
		List<ResSchedulerVO> list = resSchedulerService.selectResScdByResNo(resNo);
		logger.info("ajax 스케줄 결과 list.size={},list={}", list.size(), list);

		for (ResSchedulerVO vo : list) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
				vo.setIsday(true);
			}
		}
		return list; 
	}
	@RequestMapping("/ResScdWrite.do")
	@ResponseBody
	public void ResScdput(@ModelAttribute ResSchedulerVO resSchedulerVo,
			HttpSession session) {

		int memNo = (Integer)session.getAttribute("memNo");
		logger.info("ajax 이용 스케줄 입력 schedulerVo={},memNo={}", resSchedulerVo,memNo);
		resSchedulerVo.setMemNo(memNo);
		if (resSchedulerVo.getUseRegdate().length() == 10 && resSchedulerVo.getReturnRegdate().length() == 10) {
			resSchedulerVo.setIsday(true);
		}
		logger.info("종일 결과 is={}", resSchedulerVo.isIsday());

		int cnt = resSchedulerService.insertResScd(resSchedulerVo, resSchedulerVo.isIsday());
		logger.info("ajax 이용 자원스케줄 완료 결과 int={}", cnt);

	}
	
	
}

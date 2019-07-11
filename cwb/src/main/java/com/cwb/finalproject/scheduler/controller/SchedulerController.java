package com.cwb.finalproject.scheduler.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.scheduler.model.SchedulerService;
import com.cwb.finalproject.scheduler.model.SchedulerVO;

@Controller
@RequestMapping("/scheduler")
public class SchedulerController {
	private Logger logger = LoggerFactory.getLogger(SchedulerController.class);
	
	@Autowired private SchedulerService schedulerService;
	
	@RequestMapping("/scheduler.do")
	public String scheduler_view() {
		logger.info("개인스케줄러 보여주기");
		return "scheduler/scheduler";
	}
	
	@RequestMapping("/userScdWrite.do")
	@ResponseBody
	public SchedulerVO userScdput(@ModelAttribute SchedulerVO schedulerVo
			,HttpSession session) {
		logger.info("ajax 이용 스케줄 입력 schedulerVo={}",schedulerVo);
		
		//int memNo = (Integer)session.getAttribute("memNo");
		schedulerVo.setMemNo(1);
		int cnt =schedulerService.insertUserScd(schedulerVo);
		logger.info("ajax 이용 스케줄 완료 결과 int={}",cnt);
		
		return schedulerVo;
	}
	
	@RequestMapping("/userScdFind.do")
	@ResponseBody
	public List<SchedulerVO> userScdFind(HttpSession session){
		//int memNo = (Integer)session.getAttribute("memNo");
		logger.info("ajax 이용 스케줄 가지고오기");
		int memNo = 1;
		List<SchedulerVO> list= schedulerService.selectByUser(memNo);
		logger.info("ajax 스케줄 결과 list.size={},list={}",list.size(),list);
		/*
		 * for (SchedulerVO vo : list) { vo.setScdStart(vo.getScdStart().substring(0,
		 * 10)); vo.setScdEnd(vo.getScdEnd().substring(0, 10)); }
		 */
		
		return list;
	}
}

package com.cwb.finalproject.scheduler.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.scheduler.model.SchedulerService;
import com.cwb.finalproject.scheduler.model.SchedulerVO;

@Controller
@RequestMapping("/scheduler")
public class SchedulerController {
	private Logger logger = LoggerFactory.getLogger(SchedulerController.class);

	@Autowired
	private SchedulerService schedulerService;

	@RequestMapping("/scheduler.do")
	public String scheduler_view() {
		logger.info("개인스케줄러 보여주기");
		return "scheduler/scheduler";
	}
	
	@RequestMapping("/userScdWrite.do")
	@ResponseBody
	public void userScdput(@ModelAttribute SchedulerVO schedulerVo, HttpSession session) {

		int memNo = (Integer)session.getAttribute("memNo");
		logger.info("ajax 이용 스케줄 입력 schedulerVo={},memNo={}", schedulerVo,memNo);
		schedulerVo.setMemNo(memNo);
		if (schedulerVo.getScdStart().length() == 10 && schedulerVo.getScdEnd().length() == 10) {
			schedulerVo.setIsday(true);
		}
		logger.info("종일 결과 is={}", schedulerVo.isIsday());

		int cnt = schedulerService.insertUserScd(schedulerVo, schedulerVo.isIsday());
		logger.info("ajax 이용 스케줄 완료 결과 int={}", cnt);

	}

	@RequestMapping("/userScdFind.do")
	@ResponseBody
	public List<SchedulerVO> userScdFind(HttpSession session) {
		int memNo = (Integer)session.getAttribute("memNo");
		logger.info("ajax 이용 스케줄 가지고오기 memNo={}",memNo);
		List<SchedulerVO> list = schedulerService.selectByUser(memNo);
		logger.info("ajax 스케줄 결과 list.size={},list={}", list.size(), list);

		for (SchedulerVO vo : list) {
			if(vo.getScdStart().substring(11).equals("00:00:00")
					&& vo.getScdEnd().substring(11).equals("00:00:00")) {
				vo.setScdStart(vo.getScdStart().substring(0, 10));
				vo.setScdEnd(vo.getScdEnd().substring(0, 10));
				vo.setIsday(true);
			}
		}

		return list; 
	}
	
	@RequestMapping("/userScdFindByNo.do")
	@ResponseBody
	public SchedulerVO userScdFindByNo(@RequestParam(defaultValue = "1") int scdNo) {
		logger.info("번호 이용 스케줄  가지고오기 scdNo={}",scdNo);
		SchedulerVO schedulerVo = schedulerService.selectByNo(scdNo);
		logger.info("번호 이용 스케줄 결과 list.schedulerVo={}", schedulerVo);
		
		return schedulerVo;
	}
	
	@RequestMapping("/userScdDel.do")
	@ResponseBody
	public void userScdDel(@ModelAttribute SchedulerVO schedulerVo) {
		logger.info("개인스케줄 삭제 파라미터 schedulerVo={}",schedulerVo);
		
		int cnt = schedulerService.deleteByscdNo(schedulerVo.getScdNo());
		logger.info("개인스케줄 삭제 결과 cnt={}",cnt); 
		
	}
	
	@RequestMapping("/userScdEdit.do")
	@ResponseBody
	public void userScdEdit(@ModelAttribute SchedulerVO schedulerVo) {
		logger.info("개인스케줄 수정 파라미터 schedulerVo={}",schedulerVo);
		boolean isday = false;
		if (schedulerVo.getScdStart().length() == 10
				&& schedulerVo.getScdEnd().length() == 10) {
			isday = true;
		}
		logger.info("종일 결과 is={}", isday);
		
		int cnt =schedulerService.updateUserScd(schedulerVo, isday);
		logger.info("개인스케줄 수정 결과 cnt={}",cnt); 
	}
	
	@RequestMapping("/userScdEditCon.do")
	@ResponseBody
	public void userScdEditCon(@ModelAttribute SchedulerVO schedulerVo) {
		logger.info("개인스케줄 내용 수정 파라미터 schedulerVo={}",schedulerVo);
		
		int cnt =schedulerService.updateUserScdContent(schedulerVo);
		logger.info("개인스케줄 내용 수정 결과 cnt={}",cnt); 
	}
}

package com.cwb.finalproject.teamscheduler.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.member.model.MemberService;
import com.cwb.finalproject.member.model.MemberVO;
import com.cwb.finalproject.scheduler.model.SchedulerService;
import com.cwb.finalproject.scheduler.model.SchedulerVO;
import com.cwb.finalproject.teamscheduler.model.TeamSchedulerService;
import com.cwb.finalproject.teamscheduler.model.TeamSchedulerVO;

@Controller
@RequestMapping("/teamscheduler")
public class TeamschedulerController {
	private Logger logger = LoggerFactory.getLogger(TeamschedulerController.class);

	@Autowired
	private TeamSchedulerService teamSchedulerService;
	@Autowired private MemberService memberService;
	
	@RequestMapping("/scheduler.do")
	public String scheduler_view(HttpSession session,Model model) {
		int ranksNo = (Integer)session.getAttribute("ranksNo");
		logger.info("팀스케줄러 보여주기 rankNo={}",ranksNo);
		model.addAttribute("ranksNo", ranksNo);
		return "scheduler/teamscheduler";
	}

	@RequestMapping("/TeamScdWrite.do")
	@ResponseBody
	public void teamScdput(@ModelAttribute TeamSchedulerVO teamSchedulerVo, HttpSession session) {
		logger.info("ajax 이용 팀스케줄 입력 schedulerVo={}", teamSchedulerVo);

		int memNo = (Integer)session.getAttribute("memNo");
		String memId =(String)session.getAttribute("memId");
		teamSchedulerVo.setMemNo(memNo);
		MemberVO memberVo= memberService.selectByUserid(memId);
		teamSchedulerVo.setDeptNo(memberVo.getDeptNo());
		boolean isday = false;
		if (teamSchedulerVo.getTscdStartdate().length() == 10 && teamSchedulerVo.getTscdEnddate().length() == 10) {
			isday = true;
		}
		logger.info("종일 결과 is={}", isday);

		int cnt = teamSchedulerService.insertTeamScd(teamSchedulerVo, isday);
		logger.info("ajax 이용 팀스케줄 완료 결과 int={}", cnt);

	}
	@RequestMapping("/TeamScdFind.do")
	@ResponseBody
	public List<TeamSchedulerVO> teamScdFind(HttpSession session) {
		logger.info("ajax 이용 스케줄 가지고오기");
		String memId =(String)session.getAttribute("memId");
		MemberVO memberVo= memberService.selectByUserid(memId);
		int deptNo=memberVo.getDeptNo();
		List<TeamSchedulerVO> list = teamSchedulerService.selectByTeam(deptNo);
		logger.info("ajax 팀스케줄 결과 list.size={},list={}", list.size(), list);
 
		for (TeamSchedulerVO vo : list ) {
			if(vo.getTscdStartdate().substring(11).equals("00:00:00")) {
				vo.setTscdStartdate(vo.getTscdStartdate().substring(0, 10));
				vo.setTscdEnddate(vo.getTscdEnddate().substring(0, 10));
			}
		}
		return list; 
	}
	@RequestMapping("/TeamScdDel.do")
	@ResponseBody
	public void teamScdDel(@ModelAttribute TeamSchedulerVO teamSchedulerVo) {
		logger.info("팀스케줄 삭제 파라미터 schedulerVo={}",teamSchedulerVo);
		
		int cnt = teamSchedulerService.deleteByscdNo(teamSchedulerVo.getTscdNo());
		logger.info("팀스케줄 삭제 결과 cnt={}",cnt); 
		
	}
	
	@RequestMapping("/TeamScdEdit.do")
	@ResponseBody
	public void teamScdEdit(@ModelAttribute TeamSchedulerVO teamSchedulerVo) {
		logger.info("팀스케줄 수정 파라미터 schedulerVo={}",teamSchedulerVo);
		boolean isday = false;
		if (teamSchedulerVo.getTscdStartdate().length() == 10
				&& teamSchedulerVo.getTscdEnddate().length() == 10) {
			isday = true;
		}
		logger.info("종일 결과 is={}", isday);
		
		int cnt =teamSchedulerService.updateTeamScd(teamSchedulerVo, isday); 
		logger.info("팀스케줄 수정 결과 cnt={}",cnt); 
	}
	
	@RequestMapping("/TeamScdEditCon.do")
	@ResponseBody
	public void teamScdEditCon(@ModelAttribute TeamSchedulerVO teamSchedulerVo) {
		logger.info("팀스케줄 내용 수정 파라미터 schedulerVo={}",teamSchedulerVo);
		
		int cnt =teamSchedulerService.updateTeamScdContent(teamSchedulerVo);
		logger.info("팀스케줄 내용 수정 결과 cnt={}",cnt); 
	} 
}

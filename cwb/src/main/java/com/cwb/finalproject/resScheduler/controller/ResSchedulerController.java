package com.cwb.finalproject.resScheduler.controller;

import java.util.List;
import java.util.Map;

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

import com.cwb.finalproject.member.model.MemberService;
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
	@Autowired private MemberService memberService;
	
	@RequestMapping("/resScheduler.do")
	public String resScheduler(@RequestParam int resNo,
			Model model,HttpSession session) {
		int ranksNo = (Integer)session.getAttribute("ranksNo");
		int memNo = (Integer)session.getAttribute("memNo");
		logger.info("자원 스케줄 보여주기rankNo={}",ranksNo);
		ResourcesVO resVo= resourcesService.selectResByNo(resNo);
		logger.info("자원 스케줄 자원 resVo={}",resVo);
		
		model.addAttribute("ranksNo", ranksNo);
		model.addAttribute("resVo", resVo);
		model.addAttribute("memNo", memNo);
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
		logger.info("자원 스케줄 신청 입력 schedulerVo={},memNo={}", resSchedulerVo,memNo);
		resSchedulerVo.setMemNo(memNo);
		if (resSchedulerVo.getUseRegdate().length() == 10 && resSchedulerVo.getReturnRegdate().length() == 10) {
			resSchedulerVo.setIsday(true);
		}
		int ranksNo = (Integer)session.getAttribute("ranksNo");
		if(ranksNo>=2) {
			resSchedulerVo.setApprFlag("Y");
		}else {
			resSchedulerVo.setApprFlag("W");
		}
		logger.info("종일 결과 is={},flag={}",
				resSchedulerVo.isIsday(),resSchedulerVo.getApprFlag());

		int cnt = resSchedulerService.insertResScd(resSchedulerVo, resSchedulerVo.isIsday());
		logger.info("ajax 이용 자원스케줄 완료 결과 int={}", cnt);

	}
	@RequestMapping(value = "/findMember.do", produces = "application/text; charset=utf8")
	@ResponseBody
	public String findMember(@RequestParam int memNo) {
		logger.info("자원 신청자 찾기 memNo={}",memNo);
		Map<String, Object> memMap= memberService.selectByNo(memNo);
		String memName=(String)memMap.get("MEM_NAME");	
		logger.info("자원 신청자이름 찾기 memName={}",memName);
		return	memName;
	}
	
	@RequestMapping("/approve.do")
	@ResponseBody
	public void approve(@RequestParam int reservNo) {
		logger.info("자원 신청승인 reservNo={}",reservNo);
		int cnt=resSchedulerService.updateResScdApprove(reservNo);
		logger.info("자원 신청 승인 cnt={}",cnt);
	}
	
	@RequestMapping("/refuse.do")
	@ResponseBody
	public void refuse(@RequestParam int reservNo) {
		logger.info("자원 신청반려 reservNo={}",reservNo);
		int cnt = resSchedulerService.updateResScdRefuse(reservNo);
		logger.info("자원 신청 반려 cnt={}",cnt);
	}
	@RequestMapping("/Wait.do")
	@ResponseBody
	public void Wait(@RequestParam int reservNo) {
		logger.info("자원 신청 대기 reservNo={}",reservNo);
		int cnt = resSchedulerService.updateResScdWait(reservNo);
		logger.info("자원 신청 대기 cnt={}",cnt);
	}
	
	@RequestMapping("/ExistDay.do")
	@ResponseBody
	public String ExistDay(@ModelAttribute ResSchedulerVO resSchedulerVo) {
		logger.info("신청 가능 여부 확인 resSchedulerVo={}",resSchedulerVo);
		resSchedulerVo.setIsday(false);
		if (resSchedulerVo.getUseRegdate().length() == 10 && resSchedulerVo.getReturnRegdate().length() == 10) {
			resSchedulerVo.setIsday(true);
		}
		
		
		String result =resSchedulerService.selectExistDay(resSchedulerVo,
				resSchedulerVo.isIsday());
		logger.info("신청 가능 여부 result={}",result);
		
		return result;
	}
	@RequestMapping("/findsysday.do")
	@ResponseBody
	public String findsysday(@ModelAttribute ResSchedulerVO resSchedulerVo) {
		int cnt =resSchedulerService.findsysday(resSchedulerVo);
		String isSysDay= "Y";
		if(cnt>0) {
			isSysDay="N";
		}
		return isSysDay;
	}
	
}

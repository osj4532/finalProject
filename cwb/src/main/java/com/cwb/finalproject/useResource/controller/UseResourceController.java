package com.cwb.finalproject.useResource.controller;

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

import com.cwb.finalproject.common.PaginationInfo;
import com.cwb.finalproject.common.WebUtility;
import com.cwb.finalproject.useResource.model.UseResourceService;
import com.cwb.finalproject.useResource.model.UseResourceVO;

@Controller
@RequestMapping("/useResource")
public class UseResourceController {
	private Logger logger = LoggerFactory.getLogger(UseResourceController.class);
	
	@Autowired UseResourceService useResourceService;
	
	@RequestMapping("/usefindResList.do")
	@ResponseBody
	public List<UseResourceVO> usefindResList(@ModelAttribute UseResourceVO useResourceVo,
			HttpSession Session){
		int memNo=(Integer)Session.getAttribute("memNo");
		logger.info("유저 ajax 이용 페이지처리 memNo={}", memNo);
		useResourceVo.setMemNo(memNo);
		
		
		PaginationInfo pagingInfo=new PaginationInfo();
		pagingInfo.setBlockSize(5);
		pagingInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		pagingInfo.setCurrentPage(useResourceVo.getCurrentPage());
		
		useResourceVo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		useResourceVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		
		logger.info("ajax 이용 내역 useResourceVo={}",useResourceVo); 
		List<UseResourceVO> myUseList = useResourceService.selectMyUseRes(useResourceVo);
		int totalRecord=0;
		totalRecord=useResourceService.selectUseRestotalCount(useResourceVo);
		for (UseResourceVO vo : myUseList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
			vo.setTotalCount(totalRecord);
		}
		
		logger.info("ajax 이용 내역 myUseList={}",myUseList);
		pagingInfo.setTotalRecord(totalRecord);
		return myUseList;
	}
	
	@RequestMapping("/useResList.do")
	public String useResList(@ModelAttribute UseResourceVO useResourceVo,HttpSession Session,Model model) {
		int memNo=(Integer)Session.getAttribute("memNo");
		logger.info("유저 자원 사용 내역 보여주기 memNO={}", memNo);
		useResourceVo.setMemNo(memNo);
		
		PaginationInfo pagingInfo=new PaginationInfo();
		pagingInfo.setBlockSize(WebUtility.BLOCK_SIZE);
		pagingInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		pagingInfo.setCurrentPage(useResourceVo.getCurrentPage());
		
		useResourceVo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		useResourceVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		
		logger.info("사용내역 useResourceVo={}",useResourceVo); 
		List<UseResourceVO> myUseList = useResourceService.selectMyUseRes(useResourceVo);
		for (UseResourceVO vo : myUseList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
		}
		
		int totalRecord=0;
		totalRecord=useResourceService.selectUseRestotalCount(useResourceVo);
		
		pagingInfo.setTotalRecord(totalRecord);
		
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
		model.addAttribute("pagingInfo", pagingInfo);
		
		return "resources/useRes/uesResList";
	}
	
	@RequestMapping("/delResSchedul.do")
	public String delResSechedul(@RequestParam int reservNo,
			Model model) {
		logger.info("자원 신청 스케줄 취소 reservNo={}",reservNo);
		
		int cnt = useResourceService.delUseResSchedule(reservNo);
		
		String msg="",url="/useResource/useResList.do";
		if(cnt>0) {
			msg="신청 취소 완료";
		}else {
			msg="신청 취소 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		 
		return "common/message";
	}
	@RequestMapping("/reResSchedule.do")
	public String reResSchedul(@RequestParam int reservNo,
			Model model){
		logger.info("자원 재신청 reservNo={}",reservNo);
		
		int cnt = useResourceService.updateUseResSchedule(reservNo);
		
		String msg="",url="/useResource/useResList.do";
		if(cnt>0) {
			msg="신청 재신청 완료";
		}else {
			msg="신청 재신청 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		 
		return "common/message";
	}
	
}

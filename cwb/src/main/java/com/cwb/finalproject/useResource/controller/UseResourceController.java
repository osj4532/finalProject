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
import com.cwb.finalproject.resScheduler.model.ResSchedulerService;
import com.cwb.finalproject.useResource.model.UseResourceService;
import com.cwb.finalproject.useResource.model.UseResourceVO;

@Controller
@RequestMapping("/useResource")
public class UseResourceController {
	private Logger logger = LoggerFactory.getLogger(UseResourceController.class);
	
	@Autowired UseResourceService useResourceService;
	@Autowired ResSchedulerService resSchedulerService;
	
	
	@RequestMapping("/usefindResList.do")
	@ResponseBody
	public List<UseResourceVO> usefindResList(@ModelAttribute UseResourceVO useResourceVo,
			HttpSession Session){
		int memNo=(Integer)Session.getAttribute("memNo");
		logger.info("유저 ajax 이용 페이지처리 memNo={}", memNo);
		useResourceVo.setMemNo(memNo);
		
		
		PaginationInfo pagingInfo=new PaginationInfo();
		pagingInfo.setBlockSize(WebUtility.RES_BLOCK_SIZE);
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
		return myUseList;
	}
	@RequestMapping("/AllUsefindResList.do")
	@ResponseBody
	public List<UseResourceVO> AllusefindResList(@ModelAttribute UseResourceVO useResourceVo,
			HttpSession Session){
		logger.info("전체 사용 ajax 이용 페이지처리 useResourceVo={}", useResourceVo);
		
		
		PaginationInfo pagingInfo=new PaginationInfo();
		pagingInfo.setBlockSize(WebUtility.RES_BLOCK_SIZE);
		pagingInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		pagingInfo.setCurrentPage(useResourceVo.getCurrentPage());
		
		useResourceVo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		useResourceVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		
		logger.info("ajax 전체 사용  내역 useResourceVo={}",useResourceVo); 
		List<UseResourceVO> AllUseList = useResourceService.selectAllUseRes(useResourceVo);
		int totalRecord=0;
		totalRecord=useResourceService.selectAllUseRestotalCount(useResourceVo);
		for (UseResourceVO vo : AllUseList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
			vo.setTotalCount(totalRecord);
		}
		
		logger.info("ajax 이용 내역 myUseList={}",AllUseList);
		return AllUseList;
	}
	
	@RequestMapping("/useResList.do")
	public String useResList(HttpSession Session,Model model) {
		int memNo=(Integer)Session.getAttribute("memNo");
		logger.info("유저 자원 사용 내역 보여주기 memNO={}", memNo);
		/*
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
		
		pagingInfo.setTotalRecord(totalRecord);*/
		
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
		//model.addAttribute("myUseList", myUseList); 
		//model.addAttribute("pagingInfo", pagingInfo);
		
		return "resources/useRes/uesResList";
	}
	@RequestMapping("/AllUseResList.do")
	public String AlluseResList(Model model,
			@RequestParam(defaultValue = "1") int AppcurrentPage
			,@RequestParam(defaultValue = "1") int WaitcurrentPage
			,@RequestParam(defaultValue = "1") int ReJectcurrentPage
			,@RequestParam(required = false) String AppsearchCondition
			,@RequestParam(required = false) String AppsearchKeyword
			,@RequestParam(required = false) String WaitsearchCondition
			,@RequestParam(required = false) String WaitsearchKeyword
			,@RequestParam(required = false) String ReJectsearchCondition
			,@RequestParam(required = false) String ReJectsearchKeyword
			) { 
		
		
		UseResourceVO AppUesResVo = new UseResourceVO();
		PaginationInfo AppPagingInfo=new PaginationInfo();
		AppUesResVo.setCurrentPage(AppcurrentPage);
		
		AppUesResVo.setSearchCondition(AppsearchCondition);
		AppUesResVo.setSearchKeyword(AppsearchKeyword);
		
		AppPagingInfo.setBlockSize(WebUtility.RES_BLOCK_SIZE);
		AppPagingInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		AppPagingInfo.setCurrentPage(AppUesResVo.getCurrentPage());
		
		AppUesResVo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		AppUesResVo.setFirstRecordIndex(AppPagingInfo.getFirstRecordIndex());
		 
		logger.info("전체  자원 사용 내역 보여주기 AppUesResVo={}",AppUesResVo);
		List<UseResourceVO> AppList = useResourceService.selectAllNotUseRes(AppUesResVo);
		for (UseResourceVO vo : AppList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
		} 
		logger.info("전체  자원 사용 내역 보여주기 AppList={}",AppList);
		int ApptotalRecord=0;
		ApptotalRecord=useResourceService.selectAllNotUseRestotalCount(AppUesResVo);
		
		AppPagingInfo.setTotalRecord(ApptotalRecord);
		
		
		UseResourceVO WaitResVo = new UseResourceVO();
		PaginationInfo WaitPagingInfo=new PaginationInfo();
		WaitResVo.setCurrentPage(WaitcurrentPage);
		 
		WaitResVo.setSearchCondition(WaitsearchCondition);
		WaitResVo.setSearchKeyword(WaitsearchKeyword);
		
		WaitPagingInfo.setBlockSize(WebUtility.RES_BLOCK_SIZE);
		WaitPagingInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		WaitPagingInfo.setCurrentPage(WaitResVo.getCurrentPage());
		
		WaitResVo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		WaitResVo.setFirstRecordIndex(WaitPagingInfo.getFirstRecordIndex());
		 
		logger.info("전체 자원 검토 내역 보여주기 WaitResVo={}",WaitResVo);
		List<UseResourceVO> waitList = useResourceService.selectAllNotWaitRes(WaitResVo);
		for (UseResourceVO vo : waitList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
		}
		logger.info("전체  자원 검토 내역 보여주기 waitList={}",waitList);
		int WaittotalRecord=0;
		WaittotalRecord=useResourceService.selectAllNotWaitRestotalCount(WaitResVo);
		
		WaitPagingInfo.setTotalRecord(WaittotalRecord);
		
		
		UseResourceVO ReFuesResVo = new UseResourceVO();
		PaginationInfo ReFusePagingInfo=new PaginationInfo();
		ReFuesResVo.setCurrentPage(ReJectcurrentPage);
		
		ReFuesResVo.setSearchCondition(ReJectsearchCondition);
		ReFuesResVo.setSearchKeyword(ReJectsearchKeyword);		
		  
		ReFusePagingInfo.setBlockSize(WebUtility.RES_BLOCK_SIZE);
		ReFusePagingInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		ReFusePagingInfo.setCurrentPage(ReFuesResVo.getCurrentPage());
		
		ReFuesResVo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		ReFuesResVo.setFirstRecordIndex(ReFusePagingInfo.getFirstRecordIndex());
		
		logger.info("전체 자원 반려 내역 보여주기 ReFuesResVo={}",ReFuesResVo);
		List<UseResourceVO> refuseList = useResourceService.selectAllNotRefuseRes(ReFuesResVo);
		for (UseResourceVO vo : refuseList) {
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
		}
		
		logger.info("전체  자원 반려 내역 보여주기 refuseList={}",refuseList);
		int ReFuestotalRecord=0;
		ReFuestotalRecord=useResourceService.selectAllNotRefuesRestotalCount(ReFuesResVo);
		
		ReFusePagingInfo.setTotalRecord(ReFuestotalRecord);
		
		
		
		model.addAttribute("waitList", waitList);
		model.addAttribute("refuseList", refuseList);
		model.addAttribute("AppList", AppList);
		model.addAttribute("AppPagingInfo", AppPagingInfo);
		model.addAttribute("WaitPagingInfo", WaitPagingInfo);
		model.addAttribute("ReFusePagingInfo", ReFusePagingInfo);
		
		return "resources/useRes/AllUesResList";
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
	@RequestMapping("/WaitResSchedule.do")
	public String WaitResSchedul(@RequestParam int reservNo,
			Model model){
		logger.info("자원 재신청 reservNo={}",reservNo);
		 
		int cnt = useResourceService.updateUseResSchedule(reservNo);
		
		String msg="",url="/useResource/AllUseResList.do";
		if(cnt>0) {
			msg="신청 재신청 완료"; 
		}else {
			msg="신청 재신청 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	@RequestMapping("/rejectResSchedule.do")
	public String rejectResSchedule(@RequestParam int reservNo,
			Model model){
		logger.info("자원 반려 reservNo={}",reservNo);
		
		int cnt = resSchedulerService.updateResScdRefuse(reservNo);
		
		String msg="",url="/useResource/AllUseResList.do";
		if(cnt>0) {
			msg="신청 반려 완료";
		}else {
			msg="신청 반려 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	@RequestMapping("/AppResSchedule.do")
	public String AppResSchedule(@RequestParam int reservNo,
			Model model){
		logger.info("자원 승인 reservNo={}",reservNo);
		
		int cnt = resSchedulerService.updateResScdApprove(reservNo);
		
		String msg="",url="/useResource/AllUseResList.do";
		if(cnt>0) {
			msg="신청 승인 완료";
		}else {
			msg="신청 승인 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
}

package com.cwb.finalproject;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.address.model.EmailService;
import com.cwb.finalproject.address.model.EmailVO;
import com.cwb.finalproject.common.PaginationInfo;
import com.cwb.finalproject.common.WebUtility;
import com.cwb.finalproject.confirm.controller.ConfirmController;
import com.cwb.finalproject.confirm.model.ConfirmService;
import com.cwb.finalproject.member.model.MemberService;
import com.cwb.finalproject.message.model.MessageService;
import com.cwb.finalproject.scheduler.model.SchedulerService;
import com.cwb.finalproject.scheduler.model.SchedulerVO;
import com.cwb.finalproject.useResource.model.UseResourceService;
import com.cwb.finalproject.useResource.model.UseResourceVO;
import com.cwb.finalproject.webhard.model.WebhardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class IndexController {
	
	private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Autowired
	private MessageService messageService;
	@Autowired
	private ConfirmService confirmService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private WebhardService webhardService;
	@Autowired UseResourceService useResourceService;
	@Autowired SchedulerService schedulerService;
	@Autowired
	private MemberService memberService;
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		int memNo = (Integer)session.getAttribute("memNo");
		double usingWB = webhardService.selectUseing(memNo);
		List<Map<String, Object>> list = memberService.selectYearAll(memNo);
		
		model.addAttribute("list", list);
		model.addAttribute("usingWB", usingWB);
		
		return "indexTest";
	}
	
	@RequestMapping("indexMsgShow.do")
	public String msgShow() {
		return "inc/indexMsgList";
	}
	
	@RequestMapping("/indexMsgList.do")
	@ResponseBody
	public List<Map<String, Object>> msgList(HttpSession session) {
		int memNo = (Integer) session.getAttribute("memNo");
		logger.info("ajax- index 쪽지함 리스트 memNo = {}", memNo);
		
		List<Map<String, Object>> list = messageService.indexListMsg(memNo);
		
		return list;
	}
	
	
	@RequestMapping("/indexConfirmWaitShow.do")
	public String confirmWaitList() {
		return "inc/indexConfirmWaitList";
	}
	
	@RequestMapping("/indexConfirmWaitList.do")
	@ResponseBody
	public List<Map<String, Object>> confirmWaitList(HttpSession session) {
		int memNo = (Integer) session.getAttribute("memNo");
		logger.info("ajax- index 결재 대기함 리스트 memNo = {}", memNo);
		
		List<Map<String, Object>> list = confirmService.indexConfirmWaitList(memNo);
		
		return list;
	}
	
	@RequestMapping("/indexRecentConfirmShow.do")
	public String recentConfirmList() {
		return "inc/indexRecentConfirmList";
	}
	
	
	@RequestMapping("/indexRecentConfirmList.do")
	@ResponseBody
	public List<Map<String, Object>> recentConfirmList(HttpSession session) {
		int memNo = (Integer) session.getAttribute("memNo");
		logger.info("ajax- index 최근 결재 등록 리스트 memNo = {}", memNo);
		
		List<Map<String, Object>> list = confirmService.recentConfirmList(memNo);
		return list;
	}
	
	
	@RequestMapping("/indexMailShow.do")
	public String mailList() {
		return "inc/indexMailList";
	}
	
	@RequestMapping("/indexMailList.do")
	@ResponseBody
	public List<EmailVO> mailList(HttpSession session){
		int memNo = (Integer) session.getAttribute("memNo");
		logger.info("ajax - index 최근 보낸 메일 리스트, memNo = {}", memNo);
		
		List<EmailVO> list = emailService.indexMailList(memNo);
		return list;
	}
	@RequestMapping("/ressSchedulerIns.do")
	public String resSchedulerIns_view(Model model, HttpSession Session) {
		int memNo=(Integer)Session.getAttribute("memNo");
		List<UseResourceVO>  ulist=useResourceService.selectResRow(memNo);
		for (UseResourceVO vo : ulist) {  
			if(vo.getUseRegdate().substring(11).equals("00:00:00")
					&& vo.getReturnRegdate().substring(11).equals("00:00:00")) {
				vo.setUseRegdate(vo.getUseRegdate().substring(0, 10));
				vo.setReturnRegdate(vo.getReturnRegdate().substring(0, 10));
			}
		}
		model.addAttribute("ulist", ulist);
		return "inc/resSchedulerIns";
	}
	@RequestMapping("/SchedulerIns.do")
	public String schedulerIns_view(Model model, HttpSession Session) {
		int memNo=(Integer)Session.getAttribute("memNo");
		List<SchedulerVO> scList = schedulerService.selectNewTopSchedule(memNo);
		for (SchedulerVO vo : scList) { 
			if(vo.getScdStart().substring(11).equals("00:00:00")
					&& vo.getScdEnd().substring(11).equals("00:00:00")) {
				vo.setScdStart(vo.getScdStart().substring(0, 10));
				vo.setScdEnd(vo.getScdEnd().substring(0, 10));
			}
		}
		
		model.addAttribute("scList", scList);  
		return "inc/schedulerIns";
	}  
}

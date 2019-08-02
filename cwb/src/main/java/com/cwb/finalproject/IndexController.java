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
import com.cwb.finalproject.message.model.MessageService;

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
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
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
}

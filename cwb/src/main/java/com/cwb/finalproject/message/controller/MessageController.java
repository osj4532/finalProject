package com.cwb.finalproject.message.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.common.PaginationInfo;
import com.cwb.finalproject.common.WebUtility;
import com.cwb.finalproject.message.model.MessageService;

@Controller
@RequestMapping("/message")
public class MessageController {
	@Autowired
	private MessageService messageService;
	private Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@RequestMapping("/msgList.do")
	public String msgList() {
		logger.info("쪽지함 보여주기");
		return "message/msgList";
	}
	
	@RequestMapping("/showMsgList.do")
	@ResponseBody
	public List<Map<String, Object>> showMsgList(@RequestParam int kind,@RequestParam String keyword,
			@RequestParam int currentPage, HttpSession session){
		int memNo = (Integer) session.getAttribute("memNo");
		logger.info("ajax-쪽지함 리스트 memNo = {}, kind = {}", memNo, kind);
		logger.info("ajax-쪽지함 리스트 keyword = {}, currentPage = {}", keyword, currentPage);
		
		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setBlockSize(WebUtility.BLOCK_SIZE);
		pageInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		pageInfo.setCurrentPage(currentPage);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword",keyword);
		map.put("firstRecordIndex", pageInfo.getFirstRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		map.put("memNo",memNo);
		int totalRec = 0;
		
		List<Map<String, Object>> list = null;
		if(kind == 1) {
			list = messageService.selectRevMsg(map);
			totalRec = messageService.countRevMsg(map);
		}else if(kind == 2) {
			list = messageService.selectSenMsg(map);
			totalRec = messageService.countSenMsg(map);
		}
		logger.info("list 사이즈 = {}", list.size());
		
		pageInfo.setTotalRecord(totalRec);
		Map<String, Object> page = new HashMap<String, Object>();
		page.put("pageInfo",pageInfo);
		
		list.add(0,page);
		
		return list;
	}
	
	@RequestMapping("/msgDetail.do")
	public String msgDetail(@RequestParam int kind,
							@RequestParam int revNo,
							@RequestParam int msgNo, Model model) {
		logger.info("쪽지함 상세보기 revNo={}, msgNo={}",revNo, msgNo);
		Map<String, Object> info = new HashMap<String, Object>();
		info.put("msgNo",msgNo);
		info.put("msgrevNo",revNo);
		
		Map<String, Object> map = null;
		if(kind == 1) {
			map = messageService.selectByNo(info);
			if(map.get("MSGREV_DATE") == null) {
				int cnt = messageService.readCheck(revNo);
				logger.info("수신확인 체크 결과 cnt = {}",cnt);
			}
			model.addAttribute("map", map);
		}else if(kind == 2) {
			map = messageService.selectByNoSen(info);
			logger.info("보낸쪽지 확인 map = {}",map);
			model.addAttribute("map", map);
		}
		
		
		return "message/msgDetail";
	}
}

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
							@RequestParam int revNo,Model model,
							HttpSession session) {
		logger.info("쪽지함 상세보기 revNo={}, kind={}",revNo, kind);
		Map<String, Object> info = new HashMap<String, Object>();
		info.put("msgrevNo",revNo);
		
		int memNo = (Integer)session.getAttribute("memNo");
		info.put("memNo",memNo);
		
		Map<String, Object> map = null;
		if(kind == 1) {
			map = messageService.selectByNo(info);
			if(map.get("MSGREV_DATE") == null) {
				int cnt = messageService.readCheck(revNo);
				logger.info("수신확인 체크 결과 cnt = {}",cnt);
			}
			
			
			int count = messageService.countMsgPre(info);
			logger.info("pre = {}",count);
			if(count > 0) {
				int pre = messageService.msgPre(info);
				model.addAttribute("pre", pre);
			}
			
			count = messageService.countMsgNext(info);
			logger.info("next = {}",count);
			if(count > 0) {
				int next = messageService.msgNext(info);
				model.addAttribute("next", next);
			}
			
			model.addAttribute("map", map);
		}else if(kind == 2) {
			map = messageService.selectByNoSen(info);
			logger.info("보낸쪽지 확인 map = {}",map);
			model.addAttribute("map", map);
			
			
			int count = messageService.countSenMsgPre(info);
			logger.info("pre = {}",count);
			if(count > 0) {
				int pre = messageService.senMsgPre(info);
				model.addAttribute("pre", pre);
			}
			
			count = messageService.countSenMsgNext(info);
			logger.info("next = {}",count);
			if(count > 0) {
				int next = messageService.senMsgNext(info);
				model.addAttribute("next", next);
			}
		}
		
		return "message/msgDetail";
	}
	
	@RequestMapping("/revMsgDel.do")
	@ResponseBody
	public int revMsgDel(@RequestParam(value = "sel[]") List<Integer> sel, @RequestParam int kind) {
		logger.info("받은 쪽지함 지우기 체크사이즈 = {}, kind = {}", sel.size(), kind);
		
		int cnt = 0;
		
		if(kind == 1) {
			//받은
			for(int revNo : sel) {
				String msgDel = messageService.selectMsgDel(revNo);
				logger.info("조회 결과 msgDel = {}", msgDel);
				
				int msgNo = messageService.selectMsgNo(revNo);
				
				if(msgDel.equals("Y")) {
					//msgrev삭제
					cnt = messageService.deleteMsgRev(revNo);
					logger.info("삭제 결과 cnt = {}", cnt);
				}else {
					//msgrev update
					cnt = messageService.msgRevChangeY(revNo);
					logger.info("업데이트 Y 결과 cnt = {}", cnt);
				}
				
				//revcount 조회 시 0이면 message 삭제
				int count = messageService.countMsgRev(msgNo);
				logger.info("개수 조회 결과 count = {}", count);
				if(count < 1) {
					int dbDel = messageService.deleteMsg(msgNo);
					logger.info("db 삭제 결과 cnt = {}", dbDel);
				}
			}
		}else if(kind == 2) {
			//보낸
			for(int revNo : sel) {
				String msgrevDel = messageService.selectMsgRevDel(revNo);
				logger.info("조회 결과 msgDel = {}", msgrevDel);
				
				int msgNo = messageService.selectMsgNo(revNo);
				
				if(msgrevDel.equals("Y")) {
					//msgrev삭제
					cnt = messageService.deleteMsgRev(revNo);
					logger.info("삭제 결과 cnt = {}", cnt);
				}else {
					//msg update
					cnt = messageService.msgChangeY(revNo);
					logger.info("업데이트 Y 결과 cnt = {}", cnt);
				}
				//revcount 조회 시 0이면 message 삭제
				int count = messageService.countMsgRev(msgNo);
				logger.info("개수 조회 결과 count = {}", count);
				if(count < 1) {
					int dbDel = messageService.deleteMsg(msgNo);
					logger.info("db 삭제 결과 cnt = {}", dbDel);
				}
			}
		}
		
		return cnt;
	}

	
}

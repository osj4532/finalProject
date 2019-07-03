package com.cwb.finalproject.resources.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cwb.finalproject.resources.model.ResourcesService;

@Controller
@RequestMapping("/resources")
public class ResourcesController {
	private Logger logger = LoggerFactory.getLogger(ResourcesController.class);
	
	@Autowired
	private ResourcesService resourcesService;
	
	@RequestMapping("/list.do")
	public String resources_view() {
		logger.info("자원 목록 화면");
		
		return "resources/resourcesList";
	}
	
	@RequestMapping("/restype/write.do")
	public String restypeWrite(@RequestParam String typeName
			,Model model) {
		logger.info("자원 리스트추가 화면 typeName={}",typeName);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("typeName", typeName);
			
		int cnt =resourcesService.insertResType(map);
		logger.info("자원 리스트추가  cnt={}",cnt);
		String msg="",url="/resources/list.do";
		if(cnt>0) {
			msg="자원 리스트등록 완료";
		}else {
			msg="자원 리스트등록 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "common/message";
	}
}

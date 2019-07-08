package com.cwb.finalproject.resources.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cwb.finalproject.common.ResImgUploadUtility;
import com.cwb.finalproject.resources.model.ResourcesService;
import com.cwb.finalproject.resources.model.ResourcesVO;
import com.cwb.finalproject.resources.model.RestypeVO;

@Controller
@RequestMapping("/resources")
public class ResourcesController {
	private Logger logger = LoggerFactory.getLogger(ResourcesController.class);
	
	@Autowired
	private ResourcesService resourcesService;
	@Autowired private  ResImgUploadUtility resImgUtility;
	
	@RequestMapping("/list.do")
	public String resources_view(Model model) {
		logger.info("자원 목록 화면");
		
		List<RestypeVO> ResTypelist = resourcesService.selectResType();
		List<List<ResourcesVO>> ResList= resourcesService.selectAllRes();
		
		model.addAttribute("ResTypelist", ResTypelist);
		model.addAttribute("ResList", ResList);
		
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
	@RequestMapping("/restype/del.do")
	public String restypeWrite(@RequestParam int typeNo
			,Model model) {
		logger.info("자원리스트 삭제,typeNo={}",typeNo);
		
		int cnt =resourcesService.delResType(typeNo);
		logger.info("자원 리스트삭제 cnt={}",cnt);
		String msg="",url="/resources/list.do";
		if(cnt>0) {
			msg="자원 리스트삭제 완료";
		}else {
			msg="자원 리스트삭제 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value = "/resourcesWrite.do",method = RequestMethod.GET)
	public String resourcesWrite_get(@RequestParam int typeNo,
			Model model) {
		logger.info("자원 등록 화면 보여주기");
		
		String typeName = resourcesService.selectResTypeByNo(typeNo);
		
		model.addAttribute("typeName", typeName);
		return "resources/resourcesWrite";
	}
	
	@RequestMapping(value = "/resourcesWrite.do",method = RequestMethod.POST)
	public String resourcesWrite_post(@ModelAttribute ResourcesVO resourcesVo,
			HttpServletRequest request,Model model) {
		logger.info("자원 등록 ");
		
		//파일 업로드 
		List<Map<String, Object>> list= resImgUtility.fileUpload(request,resImgUtility.PDS_FILE_UPLOAD);
		
		String resFilename = "";
		for (Map<String, Object> map : list) {
			resFilename = (String) map.get("fileName");
		}
		logger.info("체크 list={}",list.size());
		resourcesVo.setResFilename(resFilename);
		int cnt= resourcesService.insertRes(resourcesVo);

		logger.info("자원 추가 cnt={}",cnt);
		String msg = "",url="/resourcesWrite.do?typeNo="+resourcesVo.getTypeNo();
		if(cnt>0) {
			msg="자원 등록되었습니다.";
		}else {
			msg="자원 등록 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "common/message";
		
	}
}

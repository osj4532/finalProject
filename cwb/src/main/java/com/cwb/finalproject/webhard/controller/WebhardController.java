package com.cwb.finalproject.webhard.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.cwb.finalproject.common.DownZip;
import com.cwb.finalproject.common.FileUploadUtil;
import com.cwb.finalproject.webhard.model.WebhardListVO;
import com.cwb.finalproject.webhard.model.WebhardService;
import com.cwb.finalproject.webhard.model.WebhardVO;

@Controller
@RequestMapping("/webhard")
public class WebhardController {

	private Logger logger = LoggerFactory.getLogger(WebhardController.class);
	@Autowired
	private WebhardService webhardService;
	@Autowired
	private FileUploadUtil fileUtil;
	@Autowired
	private DownZip downZip;
	
	@RequestMapping("/webhard.do")
	public String webhard(Model model) {
		logger.info("webhard화면");
		
		List<WebhardListVO> wbList = webhardService.selectWBList();
		model.addAttribute("WBList", wbList);
		
		return "webhard/webhard";
	}
	
	@RequestMapping("/webhardSetting.do")
	public String webhardSetting() {
		logger.info("webhardSetting 화면");
		
		return "webhard/webhardSetting"; 
	}
	
	
	private int webNo;
	@RequestMapping("/setwebNo.do")
	public void setWeb(@RequestParam int webNo) {
		this.webNo = webNo;
	}
	
	@RequestMapping("/webhardUpload.do")
	@ResponseBody
	public void webhardUpload(MultipartHttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = (Integer)session.getAttribute("memNo");
		
		logger.info("웹하드 파일 업로드 = {}", request);
		List<Map<String, Object>> fileList = fileUtil.multipleUpload(request, FileUploadUtil.WEBHARD_UPLOAD);
		logger.info("업로드한 파일 갯수 = {}",fileList.size());
		
		WebhardVO vo = new WebhardVO();
		vo.setMemNo(memNo);
		vo.setWebNo(webNo);
		
		int cnt = webhardService.insertWBFile(vo, fileList);
		logger.info("DB 업로드 결과 cnt = {}",cnt);
	}
	
	@RequestMapping("/webhardFileList.do")
	@ResponseBody
	public List<Map<String, Object>> webhardFileList(@ModelAttribute WebhardVO vo){
		logger.info("웹하드 파일 목록 vo = {}", vo);
		List<Map<String, Object>> fileList = webhardService.selectFileByWebNo(vo); 
		return fileList;
	}
	
	@RequestMapping("/webhardDownZip.do")
	public ModelAndView webhardDownZip(@RequestParam int[] selFile, 
			HttpServletRequest request,
			HttpServletResponse response) {
		logger.info("웹하드 파일 zip다운");
		
		String path = fileUtil.getUploadPath(request, FileUploadUtil.WEBHARD_UPLOAD);
		logger.info("다운로드 path = {}",path);
		
		String zipName = downZip.downloadZip(selFile, response, path);
		zipName = zipName.substring(zipName.lastIndexOf("/")+1);
		
		
		File file = new File(path, zipName);
		File file1 = new File(zipName);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("downFile",file);
		map.put("downFileName",file1);
		map.put("isZip",true);
		
		ModelAndView mav = new ModelAndView("downloadView",map);
		return mav;
	}
	
}

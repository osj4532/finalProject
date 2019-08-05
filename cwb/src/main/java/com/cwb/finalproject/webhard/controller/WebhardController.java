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
		
		int cnt = webhardService.upDowncount(selFile);
		logger.info("웹하드파일 다운로드수 증가 cnt = {}",cnt);
		
		File file = new File(path, zipName);
		File file1 = new File(zipName);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("downFile",file);
		map.put("downFileName",file1);
		map.put("isZip",true);
		
		ModelAndView mav = new ModelAndView("downloadView",map);
		return mav;
	}
	
	@RequestMapping("/deleteWBFile.do")
	@ResponseBody
	public int deleteWBFile(@RequestParam(value="selFile[]") int[] selFile, HttpSession session){
		logger.info("ajax 웹하드 파일 삭제하기");
		int memNo = (Integer)session.getAttribute("memNo");
		int ranksNo = (Integer)session.getAttribute("ranksNo");
		
		int cnt = webhardService.deleteWBFile(selFile, ranksNo, memNo);
		logger.info("ajax 웹하드 파일 삭제 결과 = {}", cnt);
		return cnt;
	}
	
	
	@RequestMapping("/webhardSetting.do")
	public String webhardSetting() {
		logger.info("webhardSetting 화면");
		return "webhard/webhardSetting"; 
	}
	
	@RequestMapping("/showWBList.do")
	@ResponseBody
	public List<WebhardListVO> showWBList(){
		logger.info("ajax-웹하드 관리_웹하드 목록 보여주기");
		List<WebhardListVO> wbList = webhardService.selectWBList();
		return wbList;
	}
	
	@RequestMapping("/addWBList.do")
	@ResponseBody
	public int addWBList(@RequestParam String webCategory){
		logger.info("ajax-웹하드 관리_웹하드 목록 추가하기");
		int cnt = webhardService.insertWBCate(webCategory);
		logger.info("웹하드 목록 추가 결과 = {}",cnt);
		return cnt;
	}
	
	@RequestMapping("/editWBList.do")
	@ResponseBody
	public int editWBList(@ModelAttribute WebhardListVO vo){
		logger.info("ajax-웹하드 관리_웹하드 목록 수정하기 vo = {}", vo);
		int cnt = webhardService.updateWBCate(vo);
		logger.info("웹하드 목록 수정 결과 = {}",cnt);
		return cnt;
	}
	
	@RequestMapping("/delWBList.do")
	@ResponseBody
	public int delWBList(@RequestParam int webNo) {
		logger.info("ajax-웹하드 관리_웹하드 목록 삭제하기 webNo = {}", webNo);
		int cnt = webhardService.deleteWBCate(webNo);
		logger.info("웹하드 목록 삭제 결과 = {}",cnt);
		return cnt;
	}
	
}

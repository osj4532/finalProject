package com.cwb.finalproject.resources.controller;

import java.io.File;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.common.ResImgUploadUtility;
import com.cwb.finalproject.resScheduler.model.ResSchedulerService;
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
	@Autowired private ResSchedulerService resSchedulerService;
	
	
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
			,Model model,HttpServletRequest request) {
		logger.info("자원리스트 삭제,typeNo={}",typeNo);
		
		List<ResourcesVO> resVo = resourcesService.selectImgNameBytype(typeNo);
		int cnt =resourcesService.delAlltypeandRes(typeNo);
		logger.info("자원 리스트삭제 cnt={},resVo.size={}",cnt,resVo.size());
		
		
		String msg="",url="/resources/list.do";
		if(cnt>0) {
			msg="자원 리스트삭제 완료";
			for (ResourcesVO vo : resVo) {
				String path =resImgUtility.getUploadPath(request);
				File file = new File(path,vo.getResFilename());
				if(file.exists()) {
					boolean bool = file.delete();
					logger.info("자원리스트 속 리스트이미지 삭제 결과={}",bool);
				}
			}
		}else {
			msg="자원 리스트삭제 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	//
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
		String msg = "",url="/resources/close.do";
		if(cnt>0) {
			msg="자원 등록되었습니다.";
		}else {
			msg="자원 등록 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "common/message";
		
	}
	
	@RequestMapping("resourcesMap.do")
	public String resourcesFindMap(@RequestParam int resNo,
			Model model) {
		logger.info("자원 위치 확인! resNo={}",resNo);
		
		ResourcesVO resVo= resourcesService.selectResByNo(resNo);
		
		model.addAttribute("resVo", resVo);
		
		return "resources/resourcesMap";
	}
	//
	@RequestMapping(value = "/resourcesEdit.do",method = RequestMethod.GET)
	public String resourcesEdit_get(@RequestParam int resNo,
			Model model) {
		logger.info("자원 수정 화면 보여주기");
		
		ResourcesVO  resVo= resourcesService.selectResByNo(resNo);
		
		model.addAttribute("resVo", resVo);
		return "resources/resourcesEdit";
	}
	
	@RequestMapping(value = "/resourcesEdit.do",method = RequestMethod.POST)
	public String resourcesEdit_post(@ModelAttribute ResourcesVO resourcesVo,
			HttpServletRequest request,Model model,String oldImg) {
		logger.info("자원 등록 oldImg={},resourcesVo={}",oldImg,resourcesVo);
		
		//파일 업로드 
		List<Map<String, Object>> list= resImgUtility.fileUpload(request,resImgUtility.PDS_FILE_UPLOAD);
		logger.info("체크 list={}",list.size());
		String resFilename = "";
		boolean fixImg=false;
		for (Map<String, Object> map : list) {
			resFilename = (String) map.get("fileName");
		}
		logger.info("체크 list={}",list.size());
		
		if(resFilename==null || resFilename.isEmpty()) {
			resourcesVo.setResFilename(oldImg);
		}else {
			resourcesVo.setResFilename(resFilename);
			fixImg=true;
		}
		
		int cnt= resourcesService.updateResByNo(resourcesVo);
		
		logger.info("자원 수정 결과 cnt={}",cnt);
		
		String msg = "",url="/resources/close.do";
		if(cnt>0) {
			msg="자원 수정 완료";
			if(fixImg) {
				String path =resImgUtility.getUploadPath(request);
				File file = new File(path,oldImg);
				if(file.exists()) {
					boolean bool = file.delete();
					logger.info("변경 후 기존 이미지 삭제 결과={}",bool);
				}
			}
			
		}else {
			msg="자원 수정 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "common/message"; 
	}
	
	@RequestMapping("/resourcesDelete.do")
	public String deleteRes(@RequestParam int resNo,
			Model model,HttpServletRequest request) {
		logger.info("자원삭제 기능 resNo={}",resNo);
		
		ResourcesVO resVo= resourcesService.selectResByNo(resNo);
		int cnt =resourcesService.deleteResByno(resNo);
		
		String msg="",url="/resources/list.do";
		if(cnt>0) {
			msg="자원 삭제 성공";
			String path =resImgUtility.getUploadPath(request);
			File file = new File(path,resVo.getResFilename());
			if(file.exists()) {
				boolean bool = file.delete();
				logger.info("자원 삭제 후 이미지 삭제 결과={}",bool);
			}
		}else {
			msg="자원 삭제 실패!";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/close.do")
	public String openerAndclose() {
		logger.info("부모창 새로고침 후 닫기");
		
		return "resources/close";
	}
	
	@RequestMapping("/canRes.do")
	@ResponseBody
	public String canRes(@RequestParam(defaultValue = "0") int resNo){
		logger.info("자원 사용중 확인 resNo={}",resNo);
		
		int useing = resSchedulerService.selectNowSysDay(resNo);
		String result="N";
		if(useing>0) {
			result= "Y";
		}
		logger.info("자원 사용중 확인 result={}",result);
		return result;
	}
}

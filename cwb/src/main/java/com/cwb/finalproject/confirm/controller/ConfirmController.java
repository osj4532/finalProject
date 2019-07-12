package com.cwb.finalproject.confirm.controller;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.cwb.finalproject.common.FileUploadUtil;
import com.cwb.finalproject.confirm.model.ConfirmFileVO;
import com.cwb.finalproject.confirm.model.ConfirmService;
import com.cwb.finalproject.confirm.model.ConfirmVO;
import com.cwb.finalproject.confirmline.controller.ConfirmlineController;
import com.cwb.finalproject.confirmline.model.ConfirmlineService;
import com.cwb.finalproject.document.model.DocFormService;
import com.cwb.finalproject.document.model.DocTypeService;
import com.cwb.finalproject.line.model.LineService;
import com.cwb.finalproject.line.model.LineVO;
import com.cwb.finalproject.member.model.MemberService;

@Controller
@RequestMapping("/document")
public class ConfirmController {
	
	private Logger logger = LoggerFactory.getLogger(ConfirmlineController.class);
	@Autowired
	private DocTypeService docTypeService;
	@Autowired
	private DocFormService docFormService;
	@Autowired
	private LineService lineService;
	@Autowired
	private ConfirmlineService confirmlineService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ConfirmService confirmService;
	@Autowired
	private FileUploadUtil fileUtil;
	
	@RequestMapping(value="/docSel.do", method = RequestMethod.GET)
	public String docSel_get(@RequestParam(required = false, defaultValue = "0") int formNo, 
			@RequestParam(required = false, defaultValue = "0") int regNo, 
			HttpSession session, Model model) {
		int userNo = (Integer)session.getAttribute("memNo");
		logger.info("문서양식 및 종류 선택 화면 보여주기 userNo = {}",userNo);
		
		//1 문서 종류, 문서 양식 종류
		List<Map<String, Object>> docTypeList = docTypeService.selectDocType();
		List<Map<String, Object>> docFormList = docFormService.selectDocForm();
		
		
		if(formNo != 0) {
			logger.info("문서 양식 번호 formNo = {}", formNo);
			Map<String, Object> formInfo = docFormService.selectDocFormByNo(formNo);
			model.addAttribute("formInfo",formInfo);
		}
		
		
		logger.info("docTypeList 사이즈 = {}, docFormList 사이즈 = {}", docTypeList.size(), docFormList.size());

		//2 그사람이 등록한 결재라인 목록
		List<LineVO> lineList = lineService.selectAll(userNo);
		
		if(regNo != 0) {
			logger.info("결재라인 번호 regNo = {}", regNo);
			List<Map<String, Object>> clList = confirmlineService.selectAll(regNo);
			model.addAttribute("clList", clList);
		}
		
		model.addAttribute("docTypeList", docTypeList);
		model.addAttribute("docFormList", docFormList);
		model.addAttribute("lineList", lineList);
		
		return "document/docsel";
	}
	
	@RequestMapping(value="/docSel.do", method = RequestMethod.POST)
	public String docSel_post(@ModelAttribute ConfirmVO vo, 
			HttpSession session, Model model) {
		// confirmVO
		// form_no, mem_no, dept_no, reg_no, cf_title, cf_content, cf_state
		// cf_file, cf_tmpstorage, cf_del, cf_order, cf_regdate, cf_okdate
		
		//form_no, mem_no, reg_no, 
		int memNo = (Integer)session.getAttribute("memNo");
		vo.setMemNo(memNo);
		logger.info("문서 작성화면으로 넘기기 매개변수 vo = {}",vo);
		
		Map<String, Object> member = memberService.selectByNo(memNo);
		List<Map<String, Object>> clList = confirmlineService.selectAll(vo.getRegNo());
		Map<String, Object> formInfo = docFormService.selectDocFormByNo(vo.getFormNo());
		
		model.addAttribute("member", member);
		model.addAttribute("clList",clList);
		model.addAttribute("formInfo",formInfo);
		model.addAttribute("today", new Date());
		
		return "document/docreg";
	}
	
	
	@RequestMapping("/docTmp.do")
	public String docTmp(HttpServletRequest request, @ModelAttribute ConfirmVO confirmVo, 
			@RequestParam("fileName") MultipartFile[] files,Model model) {
		logger.info("임시등록처리 confirmVo = {}", confirmVo);
		logger.info("첨부된 파일 크기= {}",files.length);
		confirmVo.setCfTmpstorage("Y");
		
		List<Map<String, Object>> fileList = null;
		if(files.length > 0) { 
			confirmVo.setCfFile("Y"); 
			fileList = fileUtil.multipleUpload(request); 
		}else { 
			confirmVo.setCfFile("N"); 
		}
		
		int cnt = confirmService.insertDoc(confirmVo, fileList);
		logger.info("문서 임시 등록 결과 cnt = {}",cnt);
		
		String url = "/document/docSel.do", msg = "";
		if(cnt > 0) {
			msg = "문서 임시 등록 성공!";
			url = "/document/docList.do";
		}else {
			msg = "문서 임시 등록 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url",url);
		
		return "common/message";
	}
	
	@RequestMapping("/docReg.do")
	public String docReg(HttpServletRequest request, @ModelAttribute ConfirmVO confirmVo, 
			@RequestParam("fileName") MultipartFile[] files, Model model) {
		logger.info("등록처리 confirmVo = {}", confirmVo);
		logger.info("첨부된 파일 크기= {}",files.length);
		
		List<Map<String, Object>> fileList = null;
		if(files[0].getOriginalFilename() != null && !files[0].getOriginalFilename().isEmpty()) { 
			confirmVo.setCfFile("Y"); 
			fileList = fileUtil.multipleUpload(request); 
		}else { 
			confirmVo.setCfFile("N"); 
		}
		
		confirmVo.setCfState(1);
		
		int cnt = confirmService.insertDoc(confirmVo, fileList);
		logger.info("문서 등록 결과 cnt = {}",cnt);
		
		String url = "/document/docSel.do", msg = "";
		if(cnt > 0) {
			msg = "문서 등록 성공!";
			url = "/document/docList.do";
		}else {
			msg = "문서 등록 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url",url);
		
		return "common/message";
	}
	
	@RequestMapping("/docList.do")
	public String docList(@RequestParam(required = false, defaultValue = "1") int cfState, 
			HttpSession session ,Model model) {
		int userNo = (Integer)session.getAttribute("memNo");
		int ranksNo = (Integer)session.getAttribute("ranksNo");
		logger.info("문서 리스트 보여주기 userNo = {}, 매개변수 cfState = {}",userNo, cfState);
		
		String title = "";
		
		List<Map<String, Object>> list = null;
		if(cfState == ConfirmService.DOC_WAIT) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("memNo",userNo);
			map.put("state",1);
			list = confirmService.selectWaitOrBackList(map);
			title = "대기 문서 함";
		}else if(cfState == ConfirmService.DOC_OK) {
			list = confirmService.selectOkList(ranksNo);
			title = "결재 완료 문서 함";
		}else if(cfState == ConfirmService.DOC_BACK) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("memNo",userNo);
			map.put("state",3);
			list = confirmService.selectWaitOrBackList(map);
			title = "결재 반려 문서 함";
		}else if(cfState == ConfirmService.DOC_TMP) {
			list = confirmService.selectTmpList(userNo);
			title = "임시 저장 문서 함";
		}
		
		model.addAttribute("list",list);
		model.addAttribute("title", title);
		return "document/doclist";
	}
	
	@RequestMapping(value="/docEdit.do", method = RequestMethod.GET)
	public String docEdit_get(@RequestParam int cfNo, Model model) {
		logger.info("문서 수정 화면 보여주기 cfNo={}",cfNo);
		
		ConfirmVO cfVo = confirmService.confirmDetail(cfNo);
		
		Map<String, Object> member = memberService.selectByNo(cfVo.getMemNo());
		List<Map<String, Object>> clList = confirmlineService.selectAll(cfVo.getRegNo());
		Map<String, Object> formInfo = docFormService.selectDocFormByNo(cfVo.getFormNo());
		List<ConfirmFileVO> files = confirmService.selectDocFiles(cfVo.getCfNo());
		
		model.addAttribute("member", member);
		model.addAttribute("clList",clList);
		model.addAttribute("formInfo",formInfo);
		model.addAttribute("cfVo",cfVo);
		model.addAttribute("files",files);
		
		return "document/docedit";
	}
	
	@RequestMapping(value="/docEdit.do", method = RequestMethod.POST)
	public String docEdit_post(HttpServletRequest request, @ModelAttribute ConfirmVO confirmVo, 
			@RequestParam("fileName") MultipartFile[] files, Model model ) {
		confirmVo.setCfState(1);
		logger.info("수정처리 confirmVo = {}", confirmVo);
		logger.info("첨부된 파일 크기= {}",files.length);
		
		List<Map<String, Object>> fileList = null;
		if(files[0].getOriginalFilename() != null && !files[0].getOriginalFilename().isEmpty()) {
			confirmVo.setCfFile("Y");
			fileList = fileUtil.multipleUpload(request);
		}
		
		int cnt = confirmService.updateConfirm(confirmVo, fileList);
		logger.info("문서 수정 결과 cnt = {}",cnt);
		
		String url = "/document/docDetail.do?cfNo="+confirmVo.getCfNo(), msg = "";
		if(cnt > 0) {
			msg = "문서 수정 성공!";
			url = "/document/docList.do";
		}else {
			msg = "문서 수정 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url",url);
		
		return "common/message";
	}
	
	@RequestMapping("/docDetail.do")
	public String docDetail(@RequestParam int cfNo,
			Model model) {
		logger.info("문서 자세히 보여주기 문서번호 cfNo={}",cfNo);
		//결재 사인(현재 결재 순서 2)
		//결재 순서 < 2 인 멤버의 사인을 보여준다.
		
		ConfirmVO cfVo = confirmService.confirmDetail(cfNo);
		
		Map<String, Object> member = memberService.selectByNo(cfVo.getMemNo());
		List<Map<String, Object>> clList = confirmlineService.selectAll(cfVo.getRegNo());
		Map<String, Object> formInfo = docFormService.selectDocFormByNo(cfVo.getFormNo());
		List<ConfirmFileVO> files = confirmService.selectDocFiles(cfNo);
		
		model.addAttribute("member", member);
		model.addAttribute("clList",clList);
		model.addAttribute("formInfo",formInfo);
		model.addAttribute("files",files );
		model.addAttribute("cfVo",cfVo);
		
		return "document/docdetail";
	}
	
	@RequestMapping("/docFileSel.do")
	@ResponseBody
	public List<ConfirmFileVO> docFileSel(@RequestParam int cfNo){
		logger.info("파일 목록 보여주기 매개변수 fileNo = {}",cfNo);
		List<ConfirmFileVO> files = confirmService.selectDocFiles(cfNo);
		logger.info("file.size()={}",files.size());
		return files;
	}
	
	@RequestMapping("/docFileDel.do")
	@ResponseBody
	public int docFileDel(@RequestParam String fileName, 
			@RequestParam int cfNo, HttpServletRequest request) {
		logger.info("파일 삭제 처리하기 fileName={}",fileName);
		logger.info("파일 삭제 처리하기 cfNo={}",cfNo);
		
		int cnt = confirmService.deleteDocFile(fileName);
		logger.info("DB에서 파일 삭제 결과 cnt = {}",cnt);
		//저장된 폴더에서 파일 지우기
		String uppath = fileUtil.getUploadPath(request, FileUploadUtil.DOC_FILE_UPLOAD);
		File delFile = new File(uppath,fileName);
		if(cnt > 0) {
			if(delFile.exists()) {
				boolean isDel = delFile.delete();
				logger.info("경로에서 파일 삭제 결과 isDel = {}",isDel);
			}
			
			//모든 파일을 지웠을때 파일 첨부 여부 'N'으로 바꾸기
			int count = confirmService.checkFile(cfNo);
			logger.info("파일여부 count={}",count);
		}
		
		return cnt;
	}
	
	@RequestMapping("/download.do")
	public ModelAndView download(@ModelAttribute ConfirmFileVO vo, HttpServletRequest request ) {
		logger.info("첨부파일 다운로드 하기 vo = {}",vo);
		
		String path = fileUtil.getUploadPath(request, FileUploadUtil.DOC_FILE_UPLOAD);
		File file = new File(path,vo.getFileName());
		File file1 = new File(vo.getFileOriginalName());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("downFile",file);
		map.put("downFileName",file1);
		
		logger.info("첨부파일 다운로드 하기 map.size = {}",map.size());
		
		ModelAndView mav = new ModelAndView("downloadView",map);
		return mav;
	}
	
	@RequestMapping("/docDelete.do")
	public String docDelete(@ModelAttribute ConfirmVO cfVo, Model model, HttpServletRequest request) {
		logger.info("파일 지우기 매개변수 cfVo = {}",cfVo);
		
		int cnt = 0;
		if(cfVo.getCfFile().equals("Y")) { 
			cnt = confirmService.deleteDocFileAll(cfVo.getCfNo());
			List<ConfirmFileVO> files = confirmService.selectDocFiles(cfVo.getCfNo());
			for(ConfirmFileVO vo : files) {
				String uppath = fileUtil.getUploadPath(request, FileUploadUtil.DOC_FILE_UPLOAD);
				File file = new File(uppath, vo.getFileName());
				if(file.exists()) {
					boolean bool = file.delete();
					logger.info("문서 파일 결과 bool = {}",bool);
				}
			}
		}
		
		cnt = confirmService.deleteConfirm(cfVo.getCfNo());
		
		logger.info("문서 삭제 결과 cnt = {}",cnt);
		
		String url = "/document/docDetail.do?cfNo="+cfVo.getCfNo(), msg = "";
		if(cnt > 0) {
			msg = "문서 삭제 성공!";
			url = "/document/docList.do";
		}else {
			msg = "문서 삭제 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url",url);
		
		return "common/message";
	}
	
	@RequestMapping("docBack.do")
	public String docBack(@RequestParam int cfNo, Model model) {
		logger.info("문서 반려 됨 문서 번호 = {}", cfNo);
		int cnt = confirmService.docBack(cfNo);
		
		logger.info("문서 반려 결과 cnt = {}",cnt);
		
		String url = "/document/docDetail.do?cfNo="+cfNo, msg = "";
		if(cnt > 0) {
			msg = "문서 반려 성공!";
			url = "/document/docList.do";
		}else {
			msg = "문서 반려 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url",url);
		
		return "common/message";
		
	}
}

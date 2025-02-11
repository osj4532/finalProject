package com.cwb.finalproject.confirm.controller;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
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
import com.cwb.finalproject.common.PaginationInfo;
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
import com.cwb.finalproject.sign.model.SignService;
import com.cwb.finalproject.sign.model.SignVO;

@Controller
@RequestMapping("/document")
public class ConfirmController {
	
	private Logger logger = LoggerFactory.getLogger(ConfirmController.class);
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
	private SignService signService;
	@Autowired
	private FileUploadUtil fileUtil;
	
	@RequestMapping("/docSelForm.do")
	@ResponseBody
	public Map<String, Object> docSelForm(@RequestParam int formNo){
		Map<String, Object> formInfo = docFormService.selectDocFormByNo(formNo);
		return formInfo;
	}
	
	
	@RequestMapping("/docSelLine.do")
	@ResponseBody 
	public List<Map<String, Object>> docSelLine(@RequestParam int regNo){
		logger.info("결재라인 번호 regNo = {}", regNo);
		List<Map<String, Object>> clList = confirmlineService.selectAll(regNo);
		return clList;
	}
	
	
	@RequestMapping(value="/docSel.do", method = RequestMethod.GET)
	public String docSel_get(@RequestParam(required = false, defaultValue = "0") int formNo, 
			@RequestParam(required = false, defaultValue = "0") int regNo, 
			HttpSession session, Model model) {
		int userNo = (Integer)session.getAttribute("memNo");
		logger.info("문서양식 및 종류 선택 화면 보여주기 userNo = {}",userNo);
		
		//1 문서 종류, 문서 양식 종류
		List<Map<String, Object>> docTypeList = docTypeService.selectDocType();
		List<Map<String, Object>> docFormList = docFormService.selectDocForm();
		
		logger.info("docTypeList 사이즈 = {}, docFormList 사이즈 = {}", docTypeList.size(), docFormList.size());

		//2 그사람이 등록한 결재라인 목록
		List<LineVO> lineList = lineService.selectAll(userNo);
		
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
		if(files[0].getOriginalFilename() != null && !files[0].getOriginalFilename().isEmpty()) { 
			confirmVo.setCfFile("Y"); 
			fileList = fileUtil.multipleUpload(request, FileUploadUtil.DOC_FILE_UPLOAD); 
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
			fileList = fileUtil.multipleUpload(request, FileUploadUtil.DOC_FILE_UPLOAD); 
		}else { 
			confirmVo.setCfFile("N"); 
		}
		
		confirmVo.setCfTmpstorage("N");
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
	
	@RequestMapping("/docListShow.do")
	@ResponseBody
	public List<Map<String, Object>> showList(@RequestParam int cfState, 
			@RequestParam(required = false, defaultValue = "1") int currentPage, 
			HttpServletRequest request){
		List<Map<String, Object>> list = null;
		
		HttpSession session = request.getSession();
		
		int userNo = (Integer)session.getAttribute("memNo");
		int ranksNo = (Integer)session.getAttribute("ranksNo");
		
		logger.info("문서 리스트 보여주기 userNo = {}, 매개변수 cfState = {}",userNo, cfState);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setBlockSize(10);
		pageInfo.setRecordCountPerPage(5);
		pageInfo.setCurrentPage(currentPage);
		
		map.put("firstRecordIndex",pageInfo.getFirstRecordIndex());
		map.put("recordCountPerPage",5);
		
		int totalRec = 0;
		if(cfState == ConfirmService.DOC_WAIT) {
			map.put("memNo",userNo);
			map.put("state",1);
			list = confirmService.selectWaitOrBackList(map);
			totalRec = confirmService.countWBList(map);
		}else if(cfState == ConfirmService.DOC_OK) {
			map.put("ranksNo",ranksNo);
			list = confirmService.selectOkList(map);
			totalRec = confirmService.countOkList(ranksNo);
		}else if(cfState == ConfirmService.DOC_BACK) {
			map.put("memNo",userNo);
			map.put("state",3);
			list = confirmService.selectWaitOrBackList(map);
			totalRec = confirmService.countWBList(map);
		}else if(cfState == ConfirmService.DOC_TMP) {
			map.put("userNo",userNo);
			list = confirmService.selectTmpList(map);
			totalRec = confirmService.countTmpList(userNo);
		}
		
		pageInfo.setTotalRecord(totalRec);
		Map<String, Object> page = new HashMap<String, Object>();
		page.put("page",pageInfo);
		list.add(0, page);
		
		return list;
	}
	
	@RequestMapping("/docList.do")
	public String docList() {
		logger.info("문서 리스트 보여주기 ");
		
		return "document/doclist";
	}
	
	@RequestMapping(value="/docEdit.do", method = RequestMethod.GET)
	public String docEdit_get(@RequestParam int cfNo, Model model) {
		logger.info("문서 수정 화면 보여주기 cfNo={}",cfNo);
		
		ConfirmVO cfVo = confirmService.confirmDetail(cfNo);
		
		Map<String, Object> member = memberService.selectByNo(cfVo.getMemNo());
		List<Map<String, Object>> clList = confirmlineService.selectAll(cfVo.getRegNo());
		logger.info("clList[0]", clList.get(0));
		
		
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
			fileList = fileUtil.multipleUpload(request, FileUploadUtil.DOC_FILE_UPLOAD);
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
		logger.info("clList[0] = {}", clList.get(0));
		Map<String, Object> formInfo = docFormService.selectDocFormByNo(cfVo.getFormNo());
		List<ConfirmFileVO> files = confirmService.selectDocFiles(cfNo);
		List<SignVO> signs = signService.getSignList(cfVo);
		logger.info("사인 개수 = {}",signs.size());
		
		model.addAttribute("member", member);
		model.addAttribute("clList",clList);
		model.addAttribute("formInfo",formInfo);
		model.addAttribute("files",files );
		model.addAttribute("cfVo",cfVo);
		model.addAttribute("signs", signs);
		
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
	public ModelAndView download(@ModelAttribute ConfirmFileVO vo, 
			@RequestParam int type,HttpServletRequest request ) {
		logger.info("첨부파일 다운로드 하기 vo = {}, type={}",vo, type);
		
		String path = "";
		if(type == FileUploadUtil.DOC_FILE_UPLOAD) {
			path = fileUtil.getUploadPath(request, FileUploadUtil.DOC_FILE_UPLOAD);
		}else if(type == FileUploadUtil.MAIL_UPLOAD) {
			path = fileUtil.getUploadPath(request, FileUploadUtil.MAIL_UPLOAD);
		}
		logger.info("path = {}",path);
		File file = new File(path,vo.getFileName());
		File file1 = new File(vo.getFileOriginalName());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("downFile",file);
		map.put("downFileName",file1);
		
		logger.info("첨부파일 다운로드 하기 map.size = {}",map.size());
		
		ModelAndView mav = new ModelAndView("downloadView",map);
		return mav;
	}
	
	@RequestMapping("/docExcelDown.do")
	public ModelAndView docExcel(@RequestParam int cfNo){
		
		ConfirmVO cfVo = confirmService.confirmDetail(cfNo);
		
		Map<String, Object> member = memberService.selectByNo(cfVo.getMemNo());
		List<Map<String, Object>> clList = confirmlineService.selectAll(cfVo.getRegNo());
		Map<String, Object> formInfo = docFormService.selectDocFormByNo(cfVo.getFormNo());
		List<ConfirmFileVO> files = confirmService.selectDocFiles(cfNo);
		List<SignVO> signs = signService.getSignList(cfVo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cfVo",cfVo);
		map.put("member", member);
		map.put("clList", clList);
		map.put("formInfo", formInfo);
		map.put("files", files);
		map.put("signs", signs);
		
		ModelAndView mav = new ModelAndView("downExcelView",map);
		
		return mav;
	}
	
	@RequestMapping("/docDelete.do")
	public String docDelete(@ModelAttribute ConfirmVO cfVo, Model model, HttpServletRequest request) {
		logger.info("파일 지우기 매개변수 cfVo = {}",cfVo);
		
		int cnt = 0;
		if(cfVo.getCfFile().equals("Y")) { 
			List<ConfirmFileVO> files = confirmService.selectDocFiles(cfVo.getCfNo());
			logger.info("confirmFileVoList.size = {}",files.size());
			cnt = confirmService.deleteDocFileAll(cfVo.getCfNo());
			for(ConfirmFileVO vo : files) {
				String uppath = fileUtil.getUploadPath(request, FileUploadUtil.DOC_FILE_UPLOAD);
				logger.info("uppath = {}",uppath);
				File file = new File(uppath, vo.getFileName());
				logger.info("filename = {}", file.getName());
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
	
	@RequestMapping("/docBack.do")
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
	
	@RequestMapping("/docOk.do")
	public String docOk(HttpSession session, @ModelAttribute ConfirmVO cfVo, Model model) {
		// 매개변수 memberNo, 문서 번호
		// 1. member sign 확인
		int memNo = (Integer)session.getAttribute("memNo");
		int cnt = signService.checkSign(memNo);
		logger.info("사인 등록 체크 cnt = {}",cnt);
		
		String msg = "", url = "/sign/signReg.do";
		
		if(cnt > 0) {
			// 2. cfOrder + 1
			int maxOrder = confirmlineService.getMaxOrder(cfVo.getRegNo());
			logger.info("마지막 사인 순서 체크 maxOrder={}",maxOrder);
			//다음 사람으로 결재 넘어가기
			cnt = confirmService.docOk(cfVo.getCfNo());
			logger.info("다음 사람으로 결재 넘어가기 결과 cnt={}",cnt);
			logger.info("cfOrder={}",cfVo.getCfOrder());
			if(cfVo.getCfOrder()+1 > maxOrder && cnt > 0) {
				// 3. confirmline max(line_order) < cfOrder => cf_state = 2, cf_okdate = sysdate
				//모두 결재 완료
				cnt = confirmService.docOkComplete(cfVo.getCfNo());
				logger.info("결재 완료 만들기 cfOrder = {}, 결과 cnt = {}", cfVo.getCfOrder(),cnt);
			}
			msg="결재 완료";
			url="/document/docList.do";
		}else {
			msg="결재 사인을 등록해 주세요.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
}

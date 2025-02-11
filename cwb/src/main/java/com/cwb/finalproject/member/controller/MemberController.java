package com.cwb.finalproject.member.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cwb.finalproject.common.AES256Util;
import com.cwb.finalproject.common.FileUploadUtil;
import com.cwb.finalproject.common.PaginationInfo;
import com.cwb.finalproject.common.WebUtility;
import com.cwb.finalproject.dept.model.DeptService;
import com.cwb.finalproject.dept.model.DeptVO;
import com.cwb.finalproject.member.model.MemberService;
import com.cwb.finalproject.member.model.MemberVO;
import com.cwb.finalproject.position.model.PositionService;
import com.cwb.finalproject.position.model.PositionVO;
import com.cwb.finalproject.ranks.model.RanksService;
import com.cwb.finalproject.ranks.model.RanksVO;

@Controller
public class MemberController {

	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	private AES256Util aes256Util;
	
	@Autowired
	private FileUploadUtil fileUtil;
	@Autowired
	private MemberService memberService;
	@Autowired
	private DeptService deptService;
	@Autowired
	private RanksService ranksService;
	@Autowired
	private PositionService positionService;
	@Autowired
	private WebUtility webUtil;
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value="/member/memberRegister.do", method=RequestMethod.GET)
	public void registerShow(Model model) {
		logger.info("사원 등록 화면");
		List<DeptVO> deptList = deptService.selectAll();
		List<RanksVO> ranksList = ranksService.selectAll();
		List<PositionVO> positionList = positionService.selectAll();
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("ranksList", ranksList);
		model.addAttribute("positionList", positionList);
	}
	
	@RequestMapping(value="/member/memberRegister.do", method = RequestMethod.POST)
	public String register(@ModelAttribute MemberVO vo, @RequestParam(required = false) MultipartFile fileName, @RequestParam(required = false) String memEmail3, Model model, HttpServletRequest request) {
		
		logger.info("사원등록 처리, 파라미터 vo={}", vo);
		
		if(vo.getMemHp2() == null || vo.getMemHp2().isEmpty() || vo.getMemHp3() == null || vo.getMemHp3().isEmpty()) {
			vo.setMemHp1("");
			vo.setMemHp2("");
			vo.setMemHp3("");
		}
		
		//email
		if(vo.getMemEmail1() == null || vo.getMemEmail1().isEmpty()) {
			vo.setMemEmail1("");
			vo.setMemEmail2("");
		}else {
			if(vo.getMemEmail2().equals("etc")) {
				if(memEmail3 == null || memEmail3.isEmpty()) {
					vo.setMemEmail1("");
					vo.setMemEmail2("");
				}else {
					vo.setMemEmail2(memEmail3); 
				}
			}
		}
		
		
		String memPwd = null;
		try {
			aes256Util = new AES256Util(AES256Util.KEY);
			memPwd = aes256Util.aesEncode(vo.getMemPwd());
		} catch (InvalidKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidAlgorithmParameterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (BadPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		vo.setMemPwd(memPwd);
		
		if(fileName != null && !fileName.isEmpty()) {
			Map<String, Object> map = fileUtil.singleUpload(request, FileUploadUtil.MEMBER_UPLOAD);
			vo.setMemFileName((String)map.get("fileName"));
			vo.setMemOriginalFileName((String)map.get("originalFileName"));
			logger.info("파일 넣은 후 vo = {}", vo);
		}
		
		
		int cnt = memberService.insertMember(vo);
		logger.info("사원등록 처리 결과 cnt = {}", cnt);
		
		String msg = "", url = "/member/memberRegister.do";
		if(cnt>0) {
			msg = "사원등록 성공하였습니다.";
			url = "/member/memberList.do";
		}else {
			msg="사원등록 실패하였습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
		
	}
	
	@RequestMapping("/member/ajaxDupUserid.do")
	@ResponseBody
	public boolean ajaxDupUserid(@RequestParam String memId) {
		logger.info("ajax방식 - 아이디 중복확인 파라미터 memId={}", memId);
		
		int result = memberService.dupUserid(memId);
		logger.info("ajax 아이디 중복확인 결과 result = {}", result);
		
		boolean bool = false;
		if(result == MemberService.USEFUL_USERID) {
			bool=true;
		}else if(result == MemberService.NON_USEFUL_USERID) {
			bool=false;
		}
		return bool;
	}
	
	@RequestMapping("/member/memberList.do")
	public void list(Model model) {
		logger.info("멤버 조회 화면");
		
		List<Map<String, Object>> list = memberService.selectOrSearch(null);
		model.addAttribute("list", list);
	}
	
	@RequestMapping(value="/member/memberEdit.do", method = RequestMethod.GET)
	public String editShow(@RequestParam(defaultValue = "0") int memNo, Model model) {
		logger.info("(관리자)멤버 수정 화면, 파라미터 memNo = {}", memNo);
		
		List<DeptVO> deptList = deptService.selectAll();
		List<RanksVO> ranksList = ranksService.selectAll();
		List<PositionVO> positionList = positionService.selectAll();
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("ranksList", ranksList);
		model.addAttribute("positionList", positionList);
		
		Map<String, Object> map = memberService.selectByNo(memNo);
		logger.info("(관리자)수정화면 조회 결과, map={}", map);
		
		model.addAttribute("map", map);
		
		return "member/memberEdit";
	}
	
	@RequestMapping(value="/member/memberEdit.do", method = RequestMethod.POST)
	public String edit(@ModelAttribute MemberVO vo, Model model) {
		logger.info("(관리자)사원수정 처리, 파라미터 vo = {}", vo);
		
		int cnt = memberService.updateMember(vo);
		
		logger.info("(관리자)사원수정 처리 결과 cnt = {}", cnt);
		
		String msg = "", url = "/member/memberEdit.do";
		if(cnt>0) {
			msg = "사원수정 성공하였습니다.";
			url = "/member/memberList.do";
		}else {
			msg="사원수정 실패하였습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
		
	}
	
	@RequestMapping("/member/memberResign.do")
	public String resign(@RequestParam int memNo, Model model) {
		logger.info("사원 퇴사 처리 파라미터, memNo = {}", memNo);
		
		int cnt = memberService.updateResign(memNo);
		logger.info("사원 퇴사 처리 결과 cnt = {}", cnt);
		
		String msg="", url = "/member/memberList.do";
		if(cnt > 0) {
			msg = "사원퇴사 처리되었습니다.";
		}else {
			msg = "사원퇴사 처리 실패하였습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/member/changePwd.do")
	public String changePwd(@RequestParam String memId, Model model) {
		MemberVO vo = memberService.selectByUserid(memId);
		logger.info("임시 비밀번호 보내기 = {}",vo);
		
		String url="/login/login.do", msg="";
		
		if(vo != null) {
			final String pwd = webUtil.createRandomString();
			final String email = vo.getMemEmail1()+"@"+vo.getMemEmail2();
			
			String encodingPwd="";
			
			try {
				aes256Util = new AES256Util(AES256Util.KEY);
				encodingPwd = aes256Util.aesEncode(pwd);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (InvalidKeyException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (NoSuchPaddingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (InvalidAlgorithmParameterException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalBlockSizeException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (BadPaddingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			vo.setMemPwd(encodingPwd);
			int cnt = memberService.changePwd(vo);
			logger.info("비밀번호 변경 결과 cnt = {}", cnt);
			if(cnt > 0) {
				MimeMessagePreparator preparator = null;
				preparator = new MimeMessagePreparator() {
					@Override
					public void prepare(MimeMessage mimeMessage) throws Exception {
						MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
						helper.setTo(email);
						helper.setFrom("zasqw456@gmail.com");
						helper.setSubject("임시비밀번호입니다.");
						helper.setText("임시 비밀번호 입니다.<br> 임시 비밀번호는 꼭 변경해 주세요!!<br>"
								+ "<h1>"+pwd+"</h1>",true);
					}
				};
				mailSender.send(preparator);
				msg="임시 비밀번호가 등록된 이메일로 전송 되었습니다.";
			}else {
				msg="비밀번호 초기화 실패!";
			}
		}else {
			msg="등록된 회원이 없습니다.";
		}
		
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		
		return "common/message";
	}
	
	@RequestMapping("/member/memberShow.do")
	@ResponseBody
	public List<Map<String, Object>> memberShow(@RequestParam (required = false)String keyword, @RequestParam(defaultValue = "1") int currentPage, @RequestParam String resignChk, HttpSession session){
		logger.info("사원 목록 보여주기 매개변수 keyword = {}, currentPage = {}", keyword, currentPage);
		String memId = (String) session.getAttribute("memId");
		
		List<Map<String, Object>> list = null;
		
		PaginationInfo page = new PaginationInfo();
		page.setBlockSize(WebUtility.BLOCK_SIZE);
		page.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		page.setCurrentPage(currentPage);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("memId", memId);
		map.put("firstRecordIndex", page.getFirstRecordIndex());
		map.put("recordCountPerPage", WebUtility.RECORD_COUNT_PER_PAGE);
		
		int totalRecord = 0;
		logger.info("resignchk = {}", resignChk);
		
		if(resignChk.equals("N")) {
			list = memberService.selectOrSearchPaging(map);
			totalRecord = memberService.countMember(map);
			page.setTotalRecord(totalRecord);
		}else if(resignChk.equals("Y")){
			list = memberService.selectOrSearchPagingResign(map);
			totalRecord = memberService.countResign(map);
			page.setTotalRecord(totalRecord);
		}
		
		Map<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put("page", page);
		logger.info("list.size = {}", list.size());
		list.add(0, pageMap);
		
		return list;
		
	}
	
	@RequestMapping("/member/memberMypage.do")
	public String mypage(Model model, HttpServletRequest request) {
		logger.info("마이페이지 화면");
		
		int memNo = (Integer) request.getSession().getAttribute("memNo");
		logger.info("mypage조회 파라미터 memNo = {}", memNo);
		
		int month = memberService.selectMonth(memNo);
		logger.info("month = {}", month);
		
		int year = memberService.selectYear(memNo);
		logger.info("year = {}", year);
		
		Map<String, Object> map = memberService.selectByNo(memNo);
		logger.info("마이페이지 조회 결과 map = {}", map);
		
		model.addAttribute("month", month);
		model.addAttribute("year", year);
		model.addAttribute("map", map);
		
		return "member/memberMypage";
	}
	
	@RequestMapping("/member/memberDetail.do")
	public String detail(@RequestParam(defaultValue = "0") int memNo, Model model) {
		logger.info("사원 정보 화면");
		
		List<DeptVO> deptList = deptService.selectAll();
		List<RanksVO> ranksList = ranksService.selectAll();
		List<PositionVO> positionList = positionService.selectAll();
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("ranksList", ranksList);
		model.addAttribute("positionList", positionList);
		
		Map<String, Object> map = memberService.selectByNo(memNo);
		logger.info("수정화면 조회 결과, map={}", map);
		
		model.addAttribute("map", map);
		
		return "member/memberDetail";
	}
	
	@RequestMapping(value="/member/memberUpdate.do", method = RequestMethod.GET)
	public String updateShow(@RequestParam(defaultValue = "0") int memNo, Model model) {
		logger.info("멤버 수정 화면, 파라미터 memNo = {}", memNo);
		
		List<DeptVO> deptList = deptService.selectAll();
		List<RanksVO> ranksList = ranksService.selectAll();
		List<PositionVO> positionList = positionService.selectAll();
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("ranksList", ranksList);
		model.addAttribute("positionList", positionList);
		
		Map<String, Object> map = memberService.selectByNo(memNo);
		logger.info("수정화면 조회 결과, map={}", map);
		
		model.addAttribute("map", map);
		
		return "member/memberUpdate";
	}
	
	@RequestMapping(value="/member/memberUpdate.do", method = RequestMethod.POST)
	public String update(@ModelAttribute MemberVO vo, @RequestParam(required = false) MultipartFile fileName, @RequestParam(required = false) String memEmail3, Model model, HttpServletRequest request) {
		logger.info("사원수정 처리, 파라미터 vo = {}", vo);
		
		int memNo = (Integer) request.getSession().getAttribute("memNo");
		vo.setMemNo(memNo);
		
		if(vo.getMemHp2() == null || vo.getMemHp2().isEmpty() || vo.getMemHp3() == null || vo.getMemHp3().isEmpty()) {
			vo.setMemHp1("");
			vo.setMemHp2("");
			vo.setMemHp3("");
		}
		
		//email
		if(vo.getMemEmail1() == null || vo.getMemEmail1().isEmpty()) {
			vo.setMemEmail1("");
			vo.setMemEmail2("");
		}else {
			if(vo.getMemEmail2().equals("etc")) {
				if(memEmail3 == null || memEmail3.isEmpty()) {
					vo.setMemEmail1("");
					vo.setMemEmail2("");
				}else {
					vo.setMemEmail2(memEmail3); 
				}
			}
		}
		
		String memPwd = null;
		try {
			aes256Util = new AES256Util(AES256Util.KEY);
			memPwd = aes256Util.aesEncode(vo.getMemPwd());
		} catch (InvalidKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidAlgorithmParameterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (BadPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		vo.setMemPwd(memPwd);
		
		
		
		if(fileName != null && !fileName.isEmpty()) {
			Map<String, Object> map = fileUtil.singleUpload(request, FileUploadUtil.MEMBER_UPLOAD);
			vo.setMemFileName((String)map.get("fileName"));
			vo.setMemOriginalFileName((String)map.get("originalFileName"));
			logger.info("파일 넣은 후 vo = {}", vo);
			
			String oldFile = (String)request.getSession().getAttribute("fileName");
			request.getSession().setAttribute("fileName", vo.getMemFileName());
			if(oldFile !=null &&!oldFile.isEmpty()) {
				String path = fileUtil.getUploadPath(request, FileUploadUtil.MEMBER_UPLOAD);
				File of = new File(path, oldFile);
				if(of.exists()) {
					of.delete();
				}
			}
		}
		int cnt = memberService.updateUser(vo);
		
		logger.info("사원수정 처리 결과 cnt = {}", cnt);
		
		String msg = "", url = "/member/memberUpdate.do";
		if(cnt>0) {
			msg = "사원수정 성공하였습니다.";
			url = "/member/memberMypage.do";
		}else {
			msg="사원수정 실패하였습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/member/memberResignList.do")
	public void memberResign(Model model) {
		logger.info("member 퇴사한 사원 조회");
		
		List<Map<String, Object>> list = memberService.selectResign();
		
		model.addAttribute("list", list);
	}
	
	@RequestMapping("/member/memberReInstate.do")
	public String memberReIn(@RequestParam int memNo, Model model) {
		logger.info("사원 복직 처리 파라미터 memNo = {}", memNo);
		
		int cnt = memberService.updateReIn(memNo);
		logger.info("사원 복직 처리 결과 cnt = {}", cnt);
		
		String msg = "", url = "/member/memberResignList.do";
		if(cnt>0) {
			msg = "사원 복직 처리 되었습니다.";
		}else {
			msg = "사원 복직 처리 실패하였습니다.";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
}

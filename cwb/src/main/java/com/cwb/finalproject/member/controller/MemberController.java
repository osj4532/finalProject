package com.cwb.finalproject.member.controller;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
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
import org.springframework.web.multipart.MultipartFile;

import com.cwb.finalproject.common.AES256Util;
import com.cwb.finalproject.common.FileUploadUtil;
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
	public String register(@ModelAttribute MemberVO vo, @RequestParam MultipartFile fileName,@RequestParam String memEmail3, Model model, HttpServletRequest request) {
		
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
		
		return "member/memberEdit";
	}
	
	@RequestMapping(value="/member/memberEdit.do", method = RequestMethod.POST)
	public String edit(@ModelAttribute MemberVO vo, Model model) {
		logger.info("사원수정 처리, 파라미터 vo = {}", vo);
		
		int cnt = memberService.updateMember(vo);
		
		logger.info("사원수정 처리 결과 cnt = {}", cnt);
		
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
		logger.info("회원 탈퇴 처리 파라미터, memNo = {}", memNo);
		
		int cnt = memberService.updateResign(memNo);
		logger.info("회원 탈퇴 처리 결과 cnt = {}", cnt);
		
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
	
	
}

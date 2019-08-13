package com.cwb.finalproject.address.controller;

import java.io.File;
import java.math.BigDecimal;
import java.nio.file.FileSystem;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailSender;
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

import com.cwb.finalproject.address.model.AddressBookService;
import com.cwb.finalproject.address.model.AddressBookVO;
import com.cwb.finalproject.address.model.EmailService;
import com.cwb.finalproject.address.model.EmailVO;
import com.cwb.finalproject.common.FileUploadUtil;
import com.cwb.finalproject.common.PaginationInfo;
import com.cwb.finalproject.common.WebUtility;
import com.cwb.finalproject.dept.model.DeptService;
import com.cwb.finalproject.dept.model.DeptVO;
import com.cwb.finalproject.member.model.MemberService;
import com.cwb.finalproject.message.model.MessageService;
import com.cwb.finalproject.message.model.MessageVO;

@Controller
@RequestMapping("/address")
public class AddressController {

	private Logger logger = LoggerFactory.getLogger(AddressController.class);
	@Autowired
	private DeptService deptService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private FileUploadUtil fileUtil;
	@Autowired
	private EmailService emailService;
	@Autowired
	private AddressBookService addressBookService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private JavaMailSender mailSender;
	
	
	@RequestMapping("/privateAddr.do")
	public String showPrivAddr() {
		logger.info("개인 주소록 보여주기");
		return "address/privateAddr";
	}
	
	@RequestMapping("/companyAddr.do")
	public String showCompAddr(Model model) {
		logger.info("회사 주소록 보여주기");
		
		List<DeptVO> depts = deptService.selectAll();
		List<Map<String, Object>> members = memberService.selectOrSearch(null);
		logger.info("부서 사이즈={}, member사이즈={}",depts.size(),members.size());
		
		model.addAttribute("depts", depts);
		model.addAttribute("members", members);
		
		return "address/companyAddr";
	}
	
	@RequestMapping("/companySearch.do")
	@ResponseBody
	public List<Map<String, Object>> searchMem(@RequestParam String keyword){
		logger.info("검색어 = {}", keyword);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyword",keyword);
		
		List<Map<String,Object>> members = memberService.selectOrSearch(map);
		for(Map<String, Object> mem : members) {
			//Timestamp는 json으로 바꾸지 못함
			mem.put("MEM_JOINDATE", null);
		}
		logger.info("검색 결과 리스트 사이즈 = {}",members.size());
		return members;
	}
	
	@RequestMapping("/memInfo.do")
	@ResponseBody
	public Map<String, Object> memInfo(@RequestParam int memNo){
		logger.info("멤버 정보 보여주기 memNo = {}", memNo);
		Map<String, Object> member = memberService.selectByNo(memNo);
		String memberPic = (String)member.get("MEM_FILENAME"); 
		if(memberPic == null || memberPic.isEmpty()) {
			member.put("MEM_FILENAME","user.png");
		}
		member.put("MEM_JOINDATE",null);
		return member;
	}
	
	@RequestMapping(value="/sendEmail.do", method = RequestMethod.GET)
	public String sendEmail_get(@RequestParam(required = false) String email, 
			HttpSession session, Model model) {
		logger.info("이메일 보내기 화면 보여주기 매개변수 = {}", email);
		int memNo = (Integer)session.getAttribute("memNo");
		Map<String, Object> member = memberService.selectByNo(memNo);
		
		if((String)member.get("MEM_EMAIL1") != null) {
			String senderMail = member.get("MEM_EMAIL1")+"@"+member.get("MEM_EMAIL2");
			model.addAttribute("sender", senderMail);
		}
		
		model.addAttribute("memNo", memNo);
		model.addAttribute("receiver", email);
		
		return "address/sendEmail";
	}
	
	@RequestMapping(value="/sendEmailProc.do")
	public String sendEmail_post(@ModelAttribute final EmailVO vo,
			@RequestParam MultipartFile fileName,final HttpServletRequest request) {
		
		logger.info("보낸 메일 저장하기 vo = {}, file = {}",vo, fileName);
		
		if(fileName != null && !fileName.isEmpty()) {
			Map<String, Object> map = fileUtil.singleUpload(request, FileUploadUtil.MAIL_UPLOAD);
			vo.setMailFileName((String)map.get("fileName"));
			vo.setMailFileSize((Long)map.get("fileSize"));
			vo.setMailOriginalFileName((String)map.get("originalFileName"));
			logger.info("파일 넣은 후 vo = {}",vo);
		}
		final String[] mails = vo.getMailSenAddr().split(",| ");
		if(mails.length > 1) {
			vo.setMailSenAddr(mails[0]+"외 "+(mails.length-1)+"명");
		}

		int cnt = emailService.insertEmail(vo);
		logger.info("DB에 저장 결과 cnt = {}",cnt);
		
		int i = 0;
		final MimeMessagePreparator[] preparators = new MimeMessagePreparator[mails.length];
		for(final String mail : mails) {
			preparators[i++] = new MimeMessagePreparator() {
				@Override
				public void prepare(MimeMessage mimeMessage) throws Exception {
					MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
					helper.setTo(mail);
					helper.setFrom(vo.getMailRevAddr());
					helper.setSubject(vo.getMailTitle());
					helper.setText(vo.getMailContent(),true);
					
					if(vo.getMailFileName() != null) {
						String path = fileUtil.getUploadPath(request, FileUploadUtil.MAIL_UPLOAD);
						File file = new File(path, vo.getMailFileName());
						FileSystemResource fileAdd = new FileSystemResource(file);
						helper.addAttachment(vo.getMailOriginalFileName(), fileAdd);
					}
				}
			};
		}
		
		
		mailSender.send(preparators);
		
		return "message/mailComplete";
	}
	
	@RequestMapping("/emailList.do")
	public String emailList(@ModelAttribute EmailVO emailVo, HttpSession session, Model model) {
		int memNo = (Integer)session.getAttribute("memNo");
		logger.info("보낸 메일 리스트 보기 memNo={}",memNo);
		logger.info("현재 페이지 ={}",emailVo.getCurrentPage());
		
		emailVo.setMailRev(memNo);
		
		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setBlockSize(10);
		pageInfo.setRecordCountPerPage(5);
		pageInfo.setCurrentPage(emailVo.getCurrentPage());
		
		emailVo.setRecordCountPerPage(5);
		emailVo.setFirstRecordIndex(pageInfo.getFirstRecordIndex());
		logger.info("셋팅후 ={}",emailVo);
		
		
		List<EmailVO> list = emailService.sendMailList(emailVo);
		logger.info("리스트 크기 ={}",list.size());
		
		int totalRec = 0;
		totalRec = emailService.totalCount(memNo);
		logger.info("총 레코드 개수 ={}",totalRec);
		
		pageInfo.setTotalRecord(totalRec);
		
		model.addAttribute("list", list);
		model.addAttribute("pageInfo", pageInfo);
		
		return "address/emailList";
	}
	
	@RequestMapping("/emailDetail.do")
	public String emailDetail(@RequestParam int mailNo, Model model) {
		logger.info("보낸 메일 상세 보기 매개변수 mailNo={}",mailNo);
		EmailVO vo = emailService.selectDetail(mailNo);
		
		int count = emailService.countNext(mailNo);
		if(count > 0) {
			int next = emailService.selectNext(mailNo);
			model.addAttribute("next",next);
		}

		count = emailService.countPre(mailNo);
		if(count > 0) {
			int pre = emailService.selectPre(mailNo);
			model.addAttribute("pre",pre);
		}
		
		model.addAttribute("vo",vo);
		
		return "address/emailDetail";
	}
	
	@RequestMapping("/emailDelete.do")
	@ResponseBody
	public int emailDelete(@RequestParam(value = "sel[]") List<Integer> sel, HttpServletRequest request) {
		logger.info("메일 삭제 처리하기 삭제 할 개수 = {}", sel.size());
		int cnt = -1;
		if(sel.size() != 0) {
			for(int i : sel) {
				EmailVO vo = emailService.selectDetail(i);
				if(vo.getMailFileName() !=null) {
					String path = fileUtil.getUploadPath(request, FileUploadUtil.MAIL_UPLOAD);
					File file = new File(path, vo.getMailFileName());
					if(file.exists()) {
						file.delete();
					}
				}
				cnt = emailService.deleteMail(i);
			}
		}
		return cnt;
	}

	@RequestMapping("/selAddr.do")
	public String selAddr() {
		logger.info("연락처 선택창 보여주기");
		return "address/addrSel";
	}
	
	@RequestMapping("/showEmailList.do")
	@ResponseBody
	public List<Map<String, Object>> showEmailList(@RequestParam int kind,
			@RequestParam String keyword,
			@RequestParam int currentPage, HttpSession session){
		logger.info("이메일 주소록 보여주기 매개변수 = {}",kind);
		logger.info("keyword = {} currentPage = {}",keyword, currentPage);
		
		List<Map<String, Object>> list = null;
		
		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setBlockSize(WebUtility.BLOCK_SIZE);
		pageInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		pageInfo.setCurrentPage(currentPage);
		
		//검색 조건
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword",keyword);
		map.put("firstRecordIndex",pageInfo.getFirstRecordIndex());
		map.put("recordCountPerPage",WebUtility.RECORD_COUNT_PER_PAGE);
		
		int totalRec = 0;
		
		if(kind == 1) {
			//페이징, 검색 추가하기
			list = memberService.selectOrSearchEmail(map);
			totalRec = memberService.countEmail(map);
			
			pageInfo.setTotalRecord(totalRec);
			
			for(Map<String, Object> m : list) {
				m.put("MEM_JOINDATE",null);
			}
		}else if(kind == 2) {
			int memNo = (Integer)session.getAttribute("memNo");
			
			map.put("memNo",memNo);
			
			list = addressBookService.selectPrivateAddr(map);
			totalRec = addressBookService.privateTotalCount(map);
			logger.info("개인 주소록 = {}",totalRec);
			pageInfo.setTotalRecord(totalRec);
		}
		
		Map<String, Object> page = new HashMap<String, Object>();
		page.put("pageInfo",pageInfo);
		logger.info("list = {}",list);
		list.add(0,page);
		
		return list;
		
	}
	
	@RequestMapping("/privateAddrList.do")
	public String showPrivateAddrList(Model model ,HttpSession session) {
		int memNo = (Integer)session.getAttribute("memNo");
		logger.info("개인 주소록 보여주기 memNo = {}",memNo);
		
		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setBlockSize(WebUtility.BLOCK_SIZE);
		pageInfo.setRecordCountPerPage(WebUtility.RECORD_COUNT_PER_PAGE);
		pageInfo.setCurrentPage(1);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memNo",memNo);
		map.put("keyword","");
		map.put("firstRecordIndex",pageInfo.getFirstRecordIndex());
		map.put("recordCountPerPage",WebUtility.RECORD_COUNT_PER_PAGE);
		
		List<Map<String, Object>> list = addressBookService.selectPrivateAddr(map);
		
		model.addAttribute("list", list);
		
		return "address/privateAddrList";
		
	}
	
	@RequestMapping("/addrbookDel.do")
	@ResponseBody
	public int addrbookDel(@RequestParam(value = "sel[]") List<Integer> sel) {
		int cnt = -1;
		for(int bookNo : sel) {
			cnt = addressBookService.addrbookDel(bookNo);
		}
		
		return cnt;
	}
	
	@RequestMapping(value="/addAddr.do",method = RequestMethod.GET)
	public String addAddr_get() {
		logger.info("개인 연락처 등록 창 보여주기");
		return "/address/addAddrForm";
	}
	
	@RequestMapping(value="/addAddr.do",method = RequestMethod.POST)
	public String addAddr_post(@ModelAttribute AddressBookVO vo, HttpSession session,
			Model model) {
		int memNo = (Integer)session.getAttribute("memNo");
		logger.info("개인 연락처 등록 처리 vo = {}, memNo = {}",vo, memNo);
		
		int deptNo = ((BigDecimal)memberService.selectByNo(memNo).get("DEPT_NO")).intValue();
		logger.info("deptNo = {}",deptNo);
		
		vo.setMemNo(memNo);
		vo.setDeptNo(deptNo);
		
		int cnt = addressBookService.addrbookAdd(vo);
		String msg = "", url = "/address/addAddr.do";
		if(cnt > 0) {
			msg = "연락처 등록 성공";
			url = "/address/privateAddrList.do";
		}else {
			msg = "연락처 등록 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value="/addEdit.do", method = RequestMethod.GET)
	public String addEdit_get(@RequestParam int addrbookNo, Model model) {
		logger.info("개인 연락처 수정 창 보여주기 addrbookNo = {}",addrbookNo);
		
		AddressBookVO vo = addressBookService.selectByNo(addrbookNo);
		logger.info("번호로 연락처 조회 vo = {}",vo);
		
		model.addAttribute("vo", vo);
		
		return "address/editAddrForm";
	}
	
	@RequestMapping(value="/addEdit.do", method = RequestMethod.POST)
	public String addEdit_post(@ModelAttribute AddressBookVO vo, Model model) {
		logger.info("개인 연락처 수정 처리 vo = {}",vo);

		String msg = "", url = "/address/addEdit.do?addrbookNo="+vo.getAddrbookNo();
		
		int cnt = addressBookService.addrbookEdit(vo);
		
		if(cnt > 0) {
			msg = "연락처 수정 성공";
			url = "/address/privateAddrList.do";
		}else {
			msg = "연착처 수정 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/sendMessage.do")
	public String sendMessage(@RequestParam(required = false, defaultValue = "0") int memNo, Model model) {
		logger.info("쪽지 보내기 화면 보여주기 매개변수 = {}", memNo);
		
		if(memNo != 0) {
			String userId = (String)memberService.selectByNo(memNo).get("MEM_ID");
			model.addAttribute("userId", userId);
		}
		
		return "address/sendMessage";
	}
	
	@RequestMapping("/selCoworker.do")
	public String selCoworker() {
		logger.info("쪽지 주소록 보여주기");
		
		return "address/selCoworker";
	}
	
	@RequestMapping("/sendMsgProc.do")
	public String sendMsgProc(@ModelAttribute MessageVO msgVo, @RequestParam String msgrevId,
			HttpSession session, Model model) {
		int memNo = (Integer)session.getAttribute("memNo");
		msgVo.setMemNo(memNo);
		logger.info("쪽지 보내기 처리 vo = {}", msgVo);
		logger.info("쪽지 보낼 아이디 msgrevId = {}", msgrevId);
		
		String[] ids = msgrevId.split(",| ");
		
		String msg = "", url = "/message/sendMessage.do";
		
		int[] memNos = new int[ids.length];
		for(int i = 0; i < ids.length; i++) {
			memNos[i] = memberService.selectByUserid(ids[i]).getMemNo();
			logger.info("번호 = {}",memNos[i]);
			if(memNos[i] == 0) {
				msg = ids[i]+"는 존재하지 않는 아이디 입니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "common/message";
			}
		}
		
		int cnt = messageService.insertMsg(msgVo, memNos);
		logger.info("결과 cnt = {}",cnt);
		
		if(cnt > 0) {
			msg = "쪽지 보내기 성공";
			url = "/message/close.do";
		}else {
			msg = "쪽지 보내기 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	
	
}


package com.cwb.finalproject.member.model;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cwb.finalproject.common.AES256Util;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO memberDAO;
	AES256Util aes256Util;
	
	public List<Map<String, Object>> selectByDeptNo(int deptNo){
		return memberDAO.selectByDeptNo(deptNo);
	}
	public Map<String, Object> selectByNo(int memNo){
		return memberDAO.selectByNo(memNo);
	}
	
	@Override
	public int loginCheck(String memId, String memPwd) {
		String dbPwd = memberDAO.selectForLogin(memId);
		int result = 0;
		if(dbPwd != null && !dbPwd.isEmpty()) {
			
			try {
				aes256Util = new AES256Util(AES256Util.KEY);
				dbPwd = aes256Util.aesDecode(dbPwd);
				//dbPwd = aes256Util.aesEncode(dbPwd);
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
			
			if(dbPwd==null || dbPwd.isEmpty()) {
				result=ID_NONE;
			}else {
				if(dbPwd.equals(memPwd)) {
					result=LOGIN_OK;
				}else {
					result=PWD_DISAGREE;
				}
			}
		}
		return result;
	}
	@Override
	public MemberVO selectByUserid(String memId) {
		return memberDAO.selectByUserid(memId);
	}
	@Override
	public List<Map<String, Object>> selectOrSearch(Map<String, Object> map){
		return memberDAO.selectOrSearch(map);
	}
	
	public List<Map<String, Object>> selectOrSearchEmail(Map<String, Object> map){
		return memberDAO.selectOrSearchEmail(map);
	}
	
	public int countEmail(Map<String, Object> map) {
		return memberDAO.countEmail(map);
	}
	@Override
	public int insertMember(MemberVO vo) {
		return memberDAO.insertMember(vo);
	}
	@Override
	public int dupUserid(String memId) {
		int count = memberDAO.dupUserid(memId);
		int result = 0;
		if(count>0) {	//이미 해당 아이디가 존재함 => 사용불가
			result = NON_USEFUL_USERID;
		}else {
			result = MemberService.USEFUL_USERID;	//사용가능
		}
		return result;
	}
	@Override
	public MemberVO selectByMemNotoVo(int memNO) {
		return memberDAO.selectByMemNotoVo(memNO);
	}
	@Override
	public int updateMember(MemberVO vo) {
		return memberDAO.updateMember(vo);
	}
	@Override
	public int updateResign(int memNo) {
		return memberDAO.updateResign(memNo);
	}
	public int changePwd(MemberVO vo) {
		return memberDAO.changePwd(vo);
	}
	@Override
	public int countMember(Map<String, Object> map) {
		return memberDAO.countMember(map);
	}
	@Override
	public List<Map<String, Object>> selectOrSearchPaging(Map<String, Object> map) {
		return memberDAO.selectOrSearchPaging(map);
	}
	@Override
	public int updateUser(MemberVO vo) {
		return memberDAO.updateUser(vo);
	}
	@Override
	public int selectMonth(int memNo) {
		return memberDAO.selectMonth(memNo);
	}
	@Override
	public List<Map<String, Object>> selectYearAll(int memNo) {
		return memberDAO.selectYearAll(memNo);
	}
	@Override
	public int selectYear(int memNo) {
		return memberDAO.selectYear(memNo);
	}
}

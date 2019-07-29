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
		
		int result = 0;
		if(dbPwd==null || dbPwd.isEmpty()) {
			result=ID_NONE;
		}else {
			if(dbPwd.equals(memPwd)) {
				result=LOGIN_OK;
			}else {
				result=PWD_DISAGREE;
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
}

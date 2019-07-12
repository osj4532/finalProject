package com.cwb.finalproject.sign.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cwb.finalproject.confirm.model.ConfirmVO;

public interface SignService {
	public int insertSign(SignVO vo);
	public SignVO selectSign(int memberNo);
	public int updateSign(SignVO vo, HttpServletRequest request);
	public List<SignVO> getSignList(ConfirmVO vo);
}

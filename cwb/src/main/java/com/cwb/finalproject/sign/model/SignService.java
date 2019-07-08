package com.cwb.finalproject.sign.model;

import javax.servlet.http.HttpServletRequest;

public interface SignService {
	public int insertSign(SignVO vo);
	public SignVO selectSign(int memberNo);
	public int updateSign(SignVO vo, HttpServletRequest request);
}

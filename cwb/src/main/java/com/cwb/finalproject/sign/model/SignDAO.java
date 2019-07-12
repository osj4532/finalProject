package com.cwb.finalproject.sign.model;

import java.util.List;

import com.cwb.finalproject.confirm.model.ConfirmVO;

public interface SignDAO {
	public int insertSign(SignVO vo);
	public SignVO selectSign(int memberNo);
	public int updateSign(SignVO vo);
	public List<SignVO> getSignList(ConfirmVO vo);
	public int checkSign(int memNo);
}

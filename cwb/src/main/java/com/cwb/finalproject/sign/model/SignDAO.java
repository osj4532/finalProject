package com.cwb.finalproject.sign.model;

public interface SignDAO {
	public int insertSign(SignVO vo);
	public SignVO selectSign(int memberNo);
	public int updateSign(SignVO vo);
}

package com.cwb.finalproject.webhard.model;

import java.util.List;
import java.util.Map;

public interface WebhardDAO {

	public List<WebhardListVO> selectWBList();
	
	public List<Map<String, Object>> selectFileByWebNo(WebhardVO vo);
	public int insertWBFile(WebhardVO vo);
	public WebhardVO selectByFileNo(int fileNo);
	public int upDowncount(int fileNo);
	public int deleteWBFile(Map<String, Object> map);
	
	public int insertWBCate(String webCategory);
	public int updateWBCate(WebhardListVO vo);
	public int deleteWBFileAll(int webNo);
	public int deleteWBCate(int webNo);
	public double selectUseing(int memNo);
}

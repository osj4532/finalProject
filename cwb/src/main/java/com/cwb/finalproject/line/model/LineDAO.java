package com.cwb.finalproject.line.model;

import java.util.List;

public interface LineDAO {
	public int insertLine(LineVO vo);
	public List<LineVO> selectAll(int userNo);
}

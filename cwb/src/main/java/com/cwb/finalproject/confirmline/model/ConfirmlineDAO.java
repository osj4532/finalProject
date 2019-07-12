package com.cwb.finalproject.confirmline.model;

import java.util.List;
import java.util.Map;

public interface ConfirmlineDAO {
	public int insertConfirmLine(ConfirmlineVO vo);
	public List<Map<String, Object>> selectAll(int regNo);
	public int getMaxOrder(int regNo);
}

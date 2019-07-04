package com.cwb.finalproject.commute.model;

import java.util.List;
import java.util.Map;

public interface CommuteDAO {
	public List<Map<String, Object>> selectAll();
}

package com.cwb.finalproject.line.model;

import java.util.List;

import com.cwb.finalproject.confirmline.model.ConfirmlineVO;

public interface LineService {
	
	public int regLine(LineVO vo, List<ConfirmlineVO> confirmList);
}

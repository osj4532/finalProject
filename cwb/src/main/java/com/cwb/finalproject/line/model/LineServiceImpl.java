package com.cwb.finalproject.line.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cwb.finalproject.confirmline.model.ConfirmlineDAO;
import com.cwb.finalproject.confirmline.model.ConfirmlineVO;

@Service
public class LineServiceImpl implements LineService{
	@Autowired
	private ConfirmlineDAO confirmlineDAO;
	@Autowired
	private LineDAO lineDAO;
	
	@Transactional
	public int regLine(LineVO vo, List<ConfirmlineVO> confirmList) {
		
		int cnt = 0;
		try {
			cnt = lineDAO.insertLine(vo);
			for(int i = 0; i < confirmList.size(); i++) {
				ConfirmlineVO confirmVo = confirmList.get(i);
				confirmVo.setRegNo(vo.getRegNo());
				cnt = confirmlineDAO.insertConfirmLine(confirmVo);
			}
			
		}catch(RuntimeException e) {
			cnt = -1;
		}
		
		return cnt;
	}
	
}

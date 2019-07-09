package com.cwb.finalproject.confirm.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ConfirmServiceImpl implements ConfirmService{
	@Autowired
	private ConfirmDAO confirmDAO;

	@Transactional
	public int insertDoc(ConfirmVO vo, List<Map<String, Object>> fileList) {
		int cnt = 0;
		try {
		
			cnt = confirmDAO.insertDoc(vo);
			
			if(vo.getCfFile() == "Y") {
				for(Map<String, Object> map : fileList) {
					String fileName = (String)map.get("fileName");
					String originalFileName = (String)map.get("originalFileName");
					long fileSize = (Long)map.get("fileSize");
					
					ConfirmFileVO cfFileVo = new ConfirmFileVO();
					cfFileVo.setFileName(fileName);
					cfFileVo.setFileOriginalName(originalFileName);
					cfFileVo.setFileSize(fileSize);
					cfFileVo.setCfNo(vo.getCfNo());
					
					cnt = confirmDAO.insertDocFile(cfFileVo);
				}
			}
		
		}catch (RuntimeException e) {
			cnt = -1;
		}
		
		return cnt;
	}
}

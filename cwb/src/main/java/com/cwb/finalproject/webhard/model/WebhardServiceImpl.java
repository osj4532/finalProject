package com.cwb.finalproject.webhard.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class WebhardServiceImpl implements WebhardService{

	@Autowired
	private WebhardDAO webhardDao;
	
	public List<WebhardListVO> selectWBList(){
		return webhardDao.selectWBList();
	}
	
	public List<Map<String, Object>> selectFileByWebNo(WebhardVO vo){
		return webhardDao.selectFileByWebNo(vo);
	}
	
	@Transactional
	public int insertWBFile(WebhardVO vo, List<Map<String, Object>> fileList) {
		int cnt = 0;
		try {
			for(Map<String, Object> map : fileList) {
				String fileName = (String)map.get("fileName");
				String originalFileName = (String)map.get("originalFileName");
				long fileSize = (Long)map.get("fileSize");
	
				vo.setFileName(fileName);
				vo.setFileOriginalfilename(originalFileName);
				vo.setFileFilesize(fileSize);
				cnt = webhardDao.insertWBFile(vo);
			}
		}catch (RuntimeException e) {
			e.printStackTrace();
			cnt = -1;
		}
		return cnt;
	}
	
}

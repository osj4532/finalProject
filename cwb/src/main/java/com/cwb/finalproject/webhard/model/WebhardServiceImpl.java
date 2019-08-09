package com.cwb.finalproject.webhard.model;

import java.util.HashMap;
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
	
	public WebhardVO selectByFileNo(int fileNo) {
		return webhardDao.selectByFileNo(fileNo);
	}
	
	@Transactional
	public int upDowncount(int[] fileNo) {
		int cnt = 0;
		try {
			for(int i = 0; i < fileNo.length; i++) {
				cnt = webhardDao.upDowncount(fileNo[i]);
			}
		}catch(RuntimeException e) {
			cnt = -1;
			e.printStackTrace();
		}
		return cnt;
	}
	
	@Transactional
	public int deleteWBFile(int[] selFile, int ranksNo, int memNo) {
		int cnt = 0;
		try {
			for(int i = 0; i < selFile.length; i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("fileNo",selFile[i]);
				map.put("ranksNo",ranksNo);
				map.put("memNo",memNo);
				cnt = webhardDao.deleteWBFile(map);
				if(cnt == 0) {
					break;
				}
			}
		}catch(RuntimeException e) {
			cnt = -1;
			e.printStackTrace();
		}
		return cnt;
	}
	
	public int insertWBCate(String webCategory) {
		return webhardDao.insertWBCate(webCategory);
	}
	public int updateWBCate(WebhardListVO vo) {
		return webhardDao.updateWBCate(vo);
	}
	@Transactional
	public int deleteWBCate(int webNo) {
		int cnt = 0;
		try {
			cnt = webhardDao.deleteWBFileAll(webNo);
			if(cnt >= 0) {
				cnt = webhardDao.deleteWBCate(webNo);
			}
		}catch (RuntimeException e) {
			cnt = -1;
			e.printStackTrace();
		}
		return cnt;
	}
	
	public double selectUseing(int memNo) {
		return webhardDao.selectUseing(memNo);
	}
}

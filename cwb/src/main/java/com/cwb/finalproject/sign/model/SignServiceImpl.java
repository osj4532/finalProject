package com.cwb.finalproject.sign.model;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cwb.finalproject.common.FileUploadUtil;
import com.cwb.finalproject.confirm.model.ConfirmVO;

@Service
public class SignServiceImpl implements SignService{

	@Autowired
	private SignDAO signDao;
	@Autowired
	private FileUploadUtil fileUtil;
	private Logger logger =LoggerFactory.getLogger(SignServiceImpl.class);
	
	public int insertSign(SignVO vo) {
		return signDao.insertSign(vo);
	}
	
	public SignVO selectSign(int memberNo) {
		return signDao.selectSign(memberNo);
	}
	
	public int updateSign(SignVO vo, HttpServletRequest request) {
		SignVO prev = selectSign(vo.getMemNo());
		if(prev.getSignFileName() != null && !prev.getSignFileName().isEmpty()) {
			String path = fileUtil.getUploadPath(request, FileUploadUtil.SIGN_UPLOAD);
			File file = new File(path, prev.getSignFileName());
			if(file.exists()) {
				boolean result = file.delete();
				logger.info("기존 파일 삭제 여부 = {}",result);
			}
		}
		
		return signDao.updateSign(vo);
	}
	
	public List<SignVO> getSignList(ConfirmVO vo){
		return signDao.getSignList(vo);
	}
}

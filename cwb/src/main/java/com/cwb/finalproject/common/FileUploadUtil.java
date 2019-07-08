package com.cwb.finalproject.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class FileUploadUtil {
	
	public static final int MEMBER_UPLOAD = 1;
	public static final int BOARD_UPLOAD = 2;
	public static final int SIGN_UPLOAD = 3;
	
	@Resource(name="fileProperties")
	private Properties props;
	
	private Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);
	
	public Map<String, Object> singleUpload(HttpServletRequest request){
		
		String fileName="", originalFileName = "";
		long fileSize = 0;
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
		
		Map<String, MultipartFile> fileMap = mr.getFileMap();
		MultipartFile multiFile = fileMap.get("signName");
		
		originalFileName = multiFile.getOriginalFilename();
		fileName = getUniqueFileName(originalFileName);
		fileSize = multiFile.getSize();
		
		String uppath = getUploadPath(request, FileUploadUtil.SIGN_UPLOAD);
		logger.info("파일 저장 경로 = {}",uppath);
		File file = new File(uppath, fileName);
		
		
		try {
			multiFile.transferTo(file);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fileName",fileName);
		map.put("fileSize",fileSize);
		map.put("originalFileName",originalFileName);
		
		return map;
	}
	
	
	public String getUploadPath(HttpServletRequest request, int uploadPathKey) {
		String type= props.getProperty("file.upload.type");
		String result = "";
		if(type.equals("test")) {
			
			if(uploadPathKey == MEMBER_UPLOAD) {
				result = props.getProperty("file.member.path.test");
			}else if(uploadPathKey == BOARD_UPLOAD) {
				result = props.getProperty("file.board.path.test");
			}else if(uploadPathKey == SIGN_UPLOAD) {
				result = props.getProperty("file.sign.path.test");
			}
			
		}else {
			String path = "";
			if(uploadPathKey == MEMBER_UPLOAD) {
				path = props.getProperty("file.member.path");
			}else if(uploadPathKey == BOARD_UPLOAD) {
				path = props.getProperty("file.board.path");
			}else if(uploadPathKey == SIGN_UPLOAD) {
				path = props.getProperty("file.sign.path");
			}
			
			result = request.getServletContext().getRealPath(path);
		}
		
		logger.info("업로드 경로 = {}",result);
		return result;
	}
	
	public String getUniqueFileName(String originalFileName) {
		String first, last;
		first = originalFileName.substring(0, originalFileName.lastIndexOf("."));
		last = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date now = new Date();
		first = first + sdf.format(now) + last;
		return first;
	}
}

package com.cwb.finalproject.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
	public static final int DOC_FILE_UPLOAD = 4;
	public static final int MAIL_UPLOAD = 5;
	
	@Resource(name="fileProperties")
	private Properties props;
	
	private Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);
	
	public List<Map<String, Object>> multipleUpload(HttpServletRequest request, int type){
		String fileName="", originalFileName = "";
		long fileSize = 0;
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
		List<MultipartFile> fileList = mr.getFiles("fileName");
		
		List<Map<String, Object>> fileMapList = new ArrayList<Map<String,Object>>();
		
		String uppath = getUploadPath(request, type);
		logger.info("파일 저장 경로 = {}",uppath);
		
		for(MultipartFile mf : fileList) {
			originalFileName = mf.getOriginalFilename();
			fileSize = mf.getSize();
			fileName = getUniqueFileName(originalFileName);
			
			Map<String, Object> fileMap = new HashMap<String, Object>();
			fileMap.put("fileName",fileName);
			fileMap.put("fileSize",fileSize);
			fileMap.put("originalFileName",originalFileName);
			fileMapList.add(fileMap);
			
			File file = new File(uppath,fileName);
			try {
				mf.transferTo(file);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return fileMapList;
		
		
	}
	
	public Map<String, Object> singleUpload(HttpServletRequest request, int type){
		
		String fileName="", originalFileName = "";
		long fileSize = 0;
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
		
		Map<String, MultipartFile> fileMap = mr.getFileMap();
		MultipartFile multiFile = fileMap.get("file");
		
		originalFileName = multiFile.getOriginalFilename();
		fileName = getUniqueFileName(originalFileName);
		fileSize = multiFile.getSize();
		
		String uppath = getUploadPath(request, type);
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
			}else if(uploadPathKey == DOC_FILE_UPLOAD) {
				result = props.getProperty("file.doc.path.test");
			}else if(uploadPathKey == MAIL_UPLOAD) {
				result = props.getProperty("file.mail.path.test");
			}
			
		}else {
			String path = "";
			if(uploadPathKey == MEMBER_UPLOAD) {
				path = props.getProperty("file.member.path");
			}else if(uploadPathKey == BOARD_UPLOAD) {
				path = props.getProperty("file.board.path");
			}else if(uploadPathKey == SIGN_UPLOAD) {
				path = props.getProperty("file.sign.path");
			}else if(uploadPathKey == DOC_FILE_UPLOAD) {
				result = props.getProperty("file.doc.path");
			}else if(uploadPathKey == MAIL_UPLOAD) {
				result = props.getProperty("file.mail.path");
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

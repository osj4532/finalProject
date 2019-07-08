package com.cwb.finalproject.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
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

import com.cwb.finalproject.resources.model.ResourcesVO;

@Component
public class ResImgUploadUtility {
	private Logger logger = LoggerFactory.getLogger(ResImgUploadUtility.class);
	
	//이미지 업로드인지, 자료실 파일 업로드인지 구분하는 상수
	public static final int IMAGE_UPLOAD=1; //이미지 업로드
	public static final int PDS_FILE_UPLOAD=2; //자료실 파일 업로드
	
	@Resource(name = "fileProperties")
	Properties props;
	
	public List<Map<String, Object>> fileUpload(HttpServletRequest request,
			int uploadPathGb) {
		//파일 업로드 처리
		MultipartHttpServletRequest multiRequest
			=(MultipartHttpServletRequest)request;
	
		//파일명, 파일크기를 저장할 Map
		//파일정보가 들어가 Map을 여러개 저장할 List
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		Map<String, MultipartFile> fileMap=multiRequest.getFileMap();

		Iterator<String> iter = fileMap.keySet().iterator();
		while(iter.hasNext()) {
			String key = iter.next(); //input type이 file인 요소 name
			
			MultipartFile tempFile= fileMap.get(key); //업로드 파일을 임시파일 형태로 제공
			if(!tempFile.isEmpty()) {
				//업로드 된 경우
				
				//업로드된 파일의 파일명
				String originalFileName=tempFile.getOriginalFilename();
				logger.info("업로드 파일명 ={}",originalFileName);
				
				//파일이름 변경하기
				String fileName=getUniqueFileName(originalFileName);
				
				//파일 크기
				long fileSize= tempFile.getSize();
				
				//업로드 처리
				//업로드 폴더 구하기
				String upPath=getUploadPath(request, uploadPathGb);
				
				File file = new File(upPath,fileName);
				try {
					tempFile.transferTo(file);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				Map<String, Object> map= new HashMap<String, Object>();
				map.put("fileName", fileName);
				map.put("fileSize", fileSize);
				map.put("originalFileName", originalFileName);
						
				//map을 list에 저장
				list.add(map);
			}//if
			
		}//while
		logger.info("파일업로드 결과 list.size={}",list.size());
		return list;
	}
	
	public String getUniqueFileName(String fileName) {
		//파일 이름 변경하기
		//ab.txt=> ab + 밀리초 + .txt
		int idx =fileName.lastIndexOf(".");
		String firstName =fileName,lastName="";
		if(idx!=-1) {
			firstName=fileName.substring(0, idx);
			lastName=fileName.substring(idx);
		}
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String Unique = sdf.format(d);
		
		String result =firstName+Unique+lastName;
		logger.info("변경된 파일명 ={}",result);
		return result;
		
	}
	
	public String getUploadPath(HttpServletRequest request, int uploadPathGb) {
		//업로드 경로 구하기
		String result="";
		String type =props.getProperty("file.upload.type");
		if(type.equals("test")) {
			//테스트 경로
			result = props.getProperty("file.resimg.path.test");
		}else {
			//배포경로
			String path=props.getProperty("file.resimg.path");
			
			//실제 물리적 경로 구하기
			result = request.getServletContext().getRealPath(path);
		}
		logger.info("upload path={}",result);
		
		return result;
	}
	
	public String getFileInfo(ResourcesVO resourcesVo,
			HttpServletRequest request) {
		
		String OrName= resourcesVo.getResOriginalfilename();
		String fileName= resourcesVo.getResFilename();
		double fileSize = Math.round((resourcesVo.getResFilesize()/1000.0)*10)/10.0;
		
		String result="<img src='"+request.getContextPath()+"/resources/images/file.gif'	alt='file이미지'/>";
		result+=OrName;
		result+="("+fileSize+"KB)";
		
		return result; 
	}
}

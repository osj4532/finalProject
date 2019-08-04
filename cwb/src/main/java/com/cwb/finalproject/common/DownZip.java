package com.cwb.finalproject.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.cwb.finalproject.webhard.model.WebhardService;
import com.cwb.finalproject.webhard.model.WebhardVO;

@Component
public class DownZip {
	
	@Autowired
	WebhardService webhardService;
	@Autowired
	FileUploadUtil fileUtil;
	
	public String downloadZip(int[] selFile, HttpServletResponse response, String path) {
		ZipOutputStream zout = null;
		WebhardVO vo = webhardService.selectByFileNo(selFile[0]);
		String zipName = path+"/"+vo.getFileOriginalfilename()+".zip";
		
		try {
			zout = new ZipOutputStream(new FileOutputStream(zipName));
			byte[] buf = new byte[1024];
			
			for(int i = 0; i < selFile.length; i++) {
				WebhardVO vo1 = webhardService.selectByFileNo(selFile[i]);
				FileInputStream in = new FileInputStream(path+"/"+vo1.getFileName());
				zout.putNextEntry(new ZipEntry(vo1.getFileOriginalfilename()));
				
				int len;
				while((len = in.read(buf)) > 0) {
					zout.write(buf,0,len);
				}
				
				zout.closeEntry();
				in.close();
			}
			
			zout.close();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return zipName;
	}
	
}

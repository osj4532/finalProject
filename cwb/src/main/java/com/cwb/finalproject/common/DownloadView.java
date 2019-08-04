package com.cwb.finalproject.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component
public class DownloadView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		File file = (File)model.get("downFile");
		File file1 = (File)model.get("downFileName");
		
		if(file == null || !file.exists() || !file.canRead()) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('파일이 존재하기 않거나 손상되었습니다.')");
			out.println("history.back()");
			out.println("</script>");
			
			return;
		}
		
		response.setHeader("Content-Disposition", "attachment; filename="+file1.getName());
		
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			OutputStream os = response.getOutputStream();
			FileCopyUtils.copy(fis, os);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(fis != null) {
				fis.close();
			}
		}
		
		if((Boolean)model.get("isZip") != null) {
			if(file.exists()) {
				file.delete();
			}
		}
		
	}

}

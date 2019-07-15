package com.cwb.finalproject.common;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import com.cwb.finalproject.confirm.model.ConfirmFileVO;
import com.cwb.finalproject.confirm.model.ConfirmVO;
import com.cwb.finalproject.sign.model.SignVO;

@Component
public class DownExcelView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ConfirmVO cfVo = (ConfirmVO)model.get("cfVo");
		Map<String, Object> member = (Map<String, Object>)model.get("member"); 
		List<Map<String, Object>> clList = (List<Map<String, Object>>)model.get("clList");
		Map<String, Object> formInfo = (Map<String, Object>)model.get("formInfo");
		List<ConfirmFileVO> files = (List<ConfirmFileVO>)model.get("files");
		List<SignVO> signs = (List<SignVO>)model.get("signs");

		//워크북 생성
		Workbook wb = new HSSFWorkbook();
		Sheet sheet = wb.createSheet(cfVo.getCfNo()+"_"+(String)formInfo.get("FORM_NAME"));
		sheet.setColumnWidth(1, 5000);
		sheet.setColumnWidth(3, 5000);
		sheet.setColumnWidth(4, 5000);
		sheet.setColumnWidth(5, 5000);
		Row row = null;
		Cell cell = null;
		
		//테이블 헤더용 스타일
		CellStyle headStyle = wb.createCellStyle();
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);

		//데이터 가운데 정렬
		headStyle.setAlignment(HorizontalAlignment.CENTER);

		//데이터용 경계 스타일 테두리만 지정
		CellStyle bodyStyle = wb.createCellStyle();
		bodyStyle.setVerticalAlignment(VerticalAlignment.TOP);
		bodyStyle.setWrapText(true);

		CellStyle titleStyle = wb.createCellStyle();
		titleStyle.setAlignment(HorizontalAlignment.CENTER);
		Font font = wb.createFont();
		font.setFontHeightInPoints((short)20);
		titleStyle.setFont(font);
		
		row=sheet.createRow(0);
		sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 3, 4));
		cell = row.createCell(3);
		cell.setCellStyle(titleStyle);
		cell.setCellValue((String)formInfo.get("FORM_NAME"));
		
		//기안자 정보
		createInfo(row, sheet, cell, headStyle, member, cfVo, clList, signs);
		
		createFormInfo(row, sheet, headStyle, cell, formInfo);
		
		row = sheet.createRow(8);
		cell = row.createCell(0);
		sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 1, 7));
		cell.setCellStyle(headStyle);
		cell.setCellValue("제목");
		for(int i = 1; i <= 7; i++ ) {
			cell = row.createCell(i);
			if(i == 1) {
				cell.setCellValue(cfVo.getCfTitle());
			}
			headStyle.setBorderBottom(BorderStyle.THIN);
			headStyle.setBorderTop(BorderStyle.THIN);
			headStyle.setBorderRight(BorderStyle.THIN);
			headStyle.setBorderLeft(BorderStyle.THIN);
			cell.setCellStyle(headStyle);
		}
		
		row = sheet.createRow(9);
		sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), 29, 0, 7));
		for(int i = row.getRowNum(); i <=29; i++ ) {
			row = sheet.createRow(i);
			for(int j = 0; j <= 7; j++) {
				cell = row.createCell(j);
				
				if(i == row.getRowNum()) {
					bodyStyle.setBorderTop(BorderStyle.THIN);
					if(j == 0) {
						cell.setCellValue(convert(cfVo.getCfContent()));
					}
				}
				if(i == 29) {
					bodyStyle.setBorderBottom(BorderStyle.THIN);
				}
				
				if(j == 0) {
					bodyStyle.setBorderLeft(BorderStyle.THIN);
				}
				
				if(j == 7) {
					bodyStyle.setBorderRight(BorderStyle.THIN);
				}
				cell.setCellStyle(bodyStyle);
			}
		}
		
		
		
		String formName = URLEncoder.encode((String)formInfo.get("FORM_NAME"),"UTF-8");
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename="+cfVo.getCfNo()+"_"+formName+".xls");

		wb.write(response.getOutputStream());
		wb.close();
	}
	
	private String convert(String content) {
		content = content.replace("</p>", "\r\n");
		content = content.replace("<br>", "\r\n");
		content = content.replace("<h", "\r\n<");
		content = content.replace("</tr>", "\r\n");
		content = content.replace("</td>", " ");
		content = content.replace("&nbsp;", " ");
		content = content.replaceAll("<[^>]*>", "");
		return content;
	}
	
	private void createFormInfo(Row row, Sheet sheet, CellStyle style,Cell cell, Map<String, Object> formInfo) {
		row=sheet.createRow(6);
		cell = row.createCell(1);
		cell.setCellStyle(style);
		cell.setCellValue("문서 종류");
		cell = row.createCell(2);
		cell.setCellStyle(style);
		cell.setCellValue((String)formInfo.get("TYPE_NAME"));
		cell = row.createCell(3);
		cell.setCellStyle(style);
		cell.setCellValue("문서 양식 종류");
		cell = row.createCell(4);
		cell.setCellStyle(style);
		cell.setCellValue((String)formInfo.get("FORM_NAME"));
		cell = row.createCell(5);
		cell.setCellStyle(style);
		cell.setCellValue("양식 보안 등급");
		cell = row.createCell(6);
		cell.setCellStyle(style);
		cell.setCellValue((String)formInfo.get("RANKS_NAME"));
		
	}

	private void createInfo(Row row, Sheet sheet, Cell cell, CellStyle style, Map<String, Object> member, ConfirmVO cfVo,List<Map<String, Object>> clList, List<SignVO> signs) {
		int rowNo = 1;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String[] head = {"기안자","부서","직책","기안일"};
		String[] value = {(String)member.get("MEM_NAME"),(String)member.get("DEPT_NAME"), (String)member.get("POS_NAME"), sdf.format(cfVo.getCfRegdate())};
		int signsize = signs.size(); 
		
		
		for(int i = 0; i < head.length; i++) {
			int cellNo = 6;
			
			row=sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellStyle(style);
			cell.setCellValue(head[i]);
			
			cell = row.createCell(1);
			cell.setCellStyle(style);
			cell.setCellValue(value[i]);
			
			if(i == 0) {
				for(int j = 0; j < clList.size(); j++) {
					Map<String, Object> map = clList.get(j);
					cell = row.createCell(cellNo++);
					cell.setCellStyle(style);
					cell.setCellValue((String)map.get("MEM_NAME"));
				}
			}else if(i == 1) {
				for(int j = 0; j < clList.size(); j++) {
					SignVO sign = null;
					if(j < signsize) {
						sign = signs.get(j);
						cell = row.createCell(cellNo++);
						cell.setCellStyle(style);
						cell.setCellValue("결재됨");
					}else {
						cell = row.createCell(cellNo++);
						cell.setCellStyle(style);
						cell.setCellValue("");
					}
					
				}
			}else if(i == 2) {
				for(int j = 0; j < clList.size(); j++) {
					cell = row.createCell(cellNo++);
					cell.setCellStyle(style);
					cell.setCellValue("-");
				}
			}
		}
	}
	
}

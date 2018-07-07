package com.civildefense.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.civildefense.dto.TraineeDTO;

public class ExcelView extends AbstractExcelPOIView {
	 
    @SuppressWarnings("unchecked")
    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, 
		HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        String fileName = model.get("fileName").toString();
 
        //target에 따라서 엑셀 문서 작성을 분기한다.
        //Object로 넘어온 값을 각 Model에 맞게 형변환 해준다.
        List<Map<String, Object>> traineeList 
        	= (ArrayList<Map<String, Object>>) model.get("traineeList");
 
        //Sheet 생성
        Sheet sheet = workbook.createSheet(fileName);
        Row row = null;
        int rowCount = 0;
        int cellCount = 0;
 
        // 제목 Cell 생성
        row = sheet.createRow(rowCount++);
 
        row.createCell(cellCount++).setCellValue("이수 번호");
        row.createCell(cellCount++).setCellValue("이름");
        row.createCell(cellCount++).setCellValue("생년월일");
        row.createCell(cellCount++).setCellValue("등록 일자");
        row.createCell(cellCount++).setCellValue("주소");
        row.createCell(cellCount++).setCellValue("핸드폰번호");
        row.createCell(cellCount++).setCellValue("이수");
        row.createCell(cellCount++).setCellValue("개인정보 취급 동의");
 
        // 데이터 Cell 생성
        for (Map<String, Object> trainee : traineeList) {
            row = sheet.createRow(rowCount++);
            cellCount = 0;
            row.createCell(cellCount++).setCellValue(String.valueOf(trainee.get("NO")));
            row.createCell(cellCount++).setCellValue(String.valueOf(trainee.get("NAME"))); 
            row.createCell(cellCount++).setCellValue(String.valueOf(trainee.get("BIRTH")));
            row.createCell(cellCount++).setCellValue(String.valueOf(trainee.get("REGISTER_DATE")));
            row.createCell(cellCount++).setCellValue(String.valueOf(trainee.get("ADDRESS")));
            row.createCell(cellCount++).setCellValue(String.valueOf(trainee.get("PHONE")));
            row.createCell(cellCount++).setCellValue("완료");
            row.createCell(cellCount++).setCellValue("동의");
        }
    }
 
    @Override
    protected Workbook createWorkbook() {
        return new XSSFWorkbook();
    }
 
}
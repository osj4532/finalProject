package com.cwb.finalproject.document.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DocFormServiceImpl implements DocFormService{
	
	@Autowired
	private DocFormDAO docFormDAO;
	
	public List<Map<String, Object>> selectDocForm(){
		return docFormDAO.selectDocForm();
	}
	
	public Map<String, Object> selectDocFormByNo(int formNo){
		return docFormDAO.selectDocFormByNo(formNo);
	}
}

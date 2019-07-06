package com.cwb.finalproject.document.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DocTypeServiceImpl implements DocTypeService{

	@Autowired
	private DocTypeDAO docTypeDAO;
	
	public List<Map<String, Object>> selectDocType(){
		return docTypeDAO.selectDocType();
	}
}

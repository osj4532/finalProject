package com.cwb.finalproject.document.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	public int docFormInsert(DocFormVO vo) {
		return docFormDAO.docFormInsert(vo);
	}
	@Transactional
	public int docFormDel(List<Integer> selForm) {
		int cnt = 0;
		try {
			for(int formNo : selForm) {
				cnt = docFormDAO.docFormDel(formNo);
			}
		}catch (RuntimeException e) {
			cnt = -1;
		}
		return cnt;
	}
}

package com.cwb.finalproject.document.model;

import java.util.List;
import java.util.Map;

public interface DocTypeDAO {

	List<Map<String, Object>> selectDocType();
	public int docTypeInsert(DocTypeVO vo);
	public int docTypeDel(String typeName);
}

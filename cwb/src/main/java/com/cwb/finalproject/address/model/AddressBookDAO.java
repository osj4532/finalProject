package com.cwb.finalproject.address.model;

import java.util.List;
import java.util.Map;



public interface AddressBookDAO {
	public int privateTotalCount(Map<String, Object> map);
	public List<Map<String, Object>> selectPrivateAddr(Map<String, Object> map);
}

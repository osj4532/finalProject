package com.cwb.finalproject.address.model;

import java.util.List;
import java.util.Map;

public interface AddressBookService {
	public int privateTotalCount(Map<String, Object> map) ;
	public List<Map<String, Object>> selectPrivateAddr(Map<String, Object> map);
	public int addrbookDel(int addrbookNo);
	public int addrbookAdd(AddressBookVO vo);
	public AddressBookVO selectByNo(int addrbookNo);
	public int addrbookEdit(AddressBookVO vo);
}

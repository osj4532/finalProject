package com.cwb.finalproject.address.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AddressBookServiceImpl implements AddressBookService{

	@Autowired
	private AddressBookDAO addressBookDAO;
	
	public int privateTotalCount(Map<String, Object> map) {
		return addressBookDAO.privateTotalCount(map);
	}
	public List<Map<String, Object>> selectPrivateAddr(Map<String, Object> map){
		return addressBookDAO.selectPrivateAddr(map);
	}
	public int addrbookDel(int addrbookNo) {
		return addressBookDAO.addrbookDel(addrbookNo);
	}
	public int addrbookAdd(AddressBookVO vo) {
		return addressBookDAO.addrbookAdd(vo);
	}
	public AddressBookVO selectByNo(int addrbookNo) {
		return addressBookDAO.selectByNo(addrbookNo);
	}
	public int addrbookEdit(AddressBookVO vo) {
		return addressBookDAO.addrbookEdit(vo);
	}
}

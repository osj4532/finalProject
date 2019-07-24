package com.cwb.finalproject.message.model;

import java.util.List;
import java.util.Map;

public interface MessageDAO {
	public int insertMsg(MessageVO vo);
	public int insertMsgRev(MsgRevVO vo);
	public List<Map<String, Object>> selectRevMsg(Map<String, Object> map);
	public int countRevMsg(Map<String, Object> map);
	public List<Map<String, Object>> selectSenMsg(Map<String, Object> map);
	public int countSenMsg(Map<String, Object> map);
}

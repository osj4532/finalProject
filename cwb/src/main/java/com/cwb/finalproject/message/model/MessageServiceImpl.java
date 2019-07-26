package com.cwb.finalproject.message.model;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MessageServiceImpl implements MessageService{
	
	@Autowired
	public MessageDAO messageDAO;
	
	private Logger logger = LoggerFactory.getLogger(MessageServiceImpl.class);
	
	@Transactional
	public int insertMsg(MessageVO vo, int[] memNos) {
		int cnt = 0;
		try {
			cnt = messageDAO.insertMsg(vo);
			logger.info("message insert 결과 cnt = {}", cnt);
			
			for(int i = 0; i < memNos.length; i++) {
				MsgRevVO revVo = new MsgRevVO();
				revVo.setMemNo(memNos[i]);
				revVo.setMsgNo(vo.getMsgNo());
				
				cnt = messageDAO.insertMsgRev(revVo);
				logger.info("msgRev insert 결과 cnt = {}", cnt);
			}
			
		}catch (RuntimeException e) {
			cnt = -1;
		}
		
		return cnt;
	}
	
	public List<Map<String, Object>> selectRevMsg(Map<String, Object> map){
		return messageDAO.selectRevMsg(map);
	}
	public int countRevMsg(Map<String, Object> map) {
		return messageDAO.countRevMsg(map);
	}
	public List<Map<String, Object>> selectSenMsg(Map<String, Object> map){
		return messageDAO.selectSenMsg(map);
	}
	public int countSenMsg(Map<String, Object> map) {
		return messageDAO.countSenMsg(map);
	}
	public int readCheck(int msgrevNo) {
		return messageDAO.readCheck(msgrevNo);
	}
	public Map<String, Object> selectByNo(Map<String, Object> map){
		return messageDAO.selectByNo(map);
	}
	public Map<String, Object> selectByNoSen(Map<String, Object> map){
		return messageDAO.selectByNoSen(map);
	}
	public int msgRevDel(int revNo) {
		return messageDAO.msgRevDel(revNo);
	}
	public int msgPre(Map<String, Object> map) {
		return messageDAO.msgPre(map);
	}
	public int countMsgPre(Map<String, Object> map) {
		return messageDAO.countMsgPre(map);
	}
	public int msgNext(Map<String, Object> map) {
		return messageDAO.msgNext(map);
	}
	public int countMsgNext(Map<String, Object> map) {
		return messageDAO.countMsgNext(map);
	}
	public int senMsgPre(Map<String, Object> map) {
		return messageDAO.senMsgPre(map);
	}
	public int countSenMsgPre(Map<String, Object> map) {
		return messageDAO.countSenMsgPre(map);
	}
	public int senMsgNext(Map<String, Object> map) {
		return messageDAO.senMsgNext(map);
	}
	public int countSenMsgNext(Map<String, Object> map) {
		return messageDAO.countSenMsgNext(map);
	}
}

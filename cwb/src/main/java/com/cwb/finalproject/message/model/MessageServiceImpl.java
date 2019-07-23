package com.cwb.finalproject.message.model;

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
}

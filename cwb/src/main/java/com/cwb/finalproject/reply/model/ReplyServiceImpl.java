package com.cwb.finalproject.reply.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceImpl implements ReplyService{

	
	@Autowired ReplyDAO replyDao;

	@Override
	public int insertOriginReply(ReplyVO replyVo) {
		return replyDao.insertOriginReply(replyVo);
	}

	@Override
	public List<ReplyVO> selectReplyByNo(int boardNo) {
		return replyDao.selectReplyByNo(boardNo);
	}
	
	
	
}

package com.cwb.finalproject.reply.model;

import java.util.List;

public interface ReplyDAO {
	
	int insertOriginReply(ReplyVO replyVo);
	List<ReplyVO> selectReplyByNo(int boardNo);
	
}

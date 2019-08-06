package com.cwb.finalproject.reply.model;

import java.util.List;

public interface ReplyService {

	int insertOriginReply(ReplyVO replyVo);
	List<ReplyVO> selectReplyByNo(int boardNo);
	int updateReplyByNo(ReplyVO replyVo);
	
	//대댓글
	ReplyVO selectOriginReply(int repNo);
	int insertReply(ReplyVO replyVo);
	int updateSortNo(ReplyVO replyVo);
	List<ReplyVO> selectReplyGroup(int repNo);
	
}

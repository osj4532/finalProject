package com.cwb.finalproject.reply.model;

import java.util.List;

public interface ReplyDAO {
	
	int insertOriginReply(ReplyVO replyVo);
	List<ReplyVO> selectReplyByNo(int boardNo);
	int updateReplyByNo(ReplyVO replyVo);
	
	int deletereplyByBoardno(int boardNo);
	int deleteAllReplyByBdList(int boardNo);
	
	//대댓글
	ReplyVO selectOriginReply(int repNo);
	int insertReply(ReplyVO replyVo);
	int updateSortNo(ReplyVO replyVo);
	List<ReplyVO> selectReplyGroup(int repNo);
	int deleteReply(int repNo);
	
	int selectReplyMine(int repNo);
	int deleteAllReply(int repNo);
	
}

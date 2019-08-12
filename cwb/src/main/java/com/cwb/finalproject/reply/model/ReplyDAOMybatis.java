package com.cwb.finalproject.reply.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOMybatis implements ReplyDAO{
	private String namespace="config.mybatis.mapper.oracle.reply.";

	@Autowired SqlSessionTemplate sqlSession;

	@Override
	public int insertOriginReply(ReplyVO replyVo) {
		return sqlSession.insert(namespace+"insertOriginReply", replyVo);
	}

	@Override
	public List<ReplyVO> selectReplyByNo(int boardNo) {
		return sqlSession.selectList(namespace+"selectReplyByNo", boardNo);
	}

	@Override
	public int updateReplyByNo(ReplyVO replyVo) {
		return sqlSession.update(namespace+"updateReplyByNo", replyVo);
	}

	@Override
	public ReplyVO selectOriginReply(int repNo) {
		return sqlSession.selectOne(namespace+"selectOriginReply", repNo);
	}

	@Override
	public int insertReply(ReplyVO replyVo) {
		return sqlSession.insert(namespace+"insertReply", replyVo);
	}

	@Override
	public int updateSortNo(ReplyVO replyVo) {
		return sqlSession.update(namespace+"updateSortNo", replyVo); 
	}

	@Override
	public List<ReplyVO> selectReplyGroup(int repNo) {
		return sqlSession.selectList(namespace+"selectReplyGroup",repNo);
	}

	@Override
	public int deleteReply(int repNo) {
		return sqlSession.delete(namespace+"deleteReply", repNo);
	}

	@Override
	public int selectReplyMine(int repNo) {
		return sqlSession.selectOne(namespace+"selectReplyMine", repNo);
	}

	@Override
	public int deleteAllReply(int repNo) {
		return sqlSession.delete(namespace+"deleteAllReply", repNo);
	}

	@Override
	public int deletereplyByBoardno(int boardNo) {
		return sqlSession.delete(namespace+"deletereplyByBoardno", boardNo);
	}

	@Override
	public int deleteAllReplyByBdList(int boardNo) {
		return sqlSession.delete(namespace+"deleteAllReplyByBdList", boardNo);
	} 
	 
}

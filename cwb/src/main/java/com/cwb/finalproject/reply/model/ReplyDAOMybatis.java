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
	
}

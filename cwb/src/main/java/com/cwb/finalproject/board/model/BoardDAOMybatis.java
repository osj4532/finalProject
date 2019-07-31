package com.cwb.finalproject.board.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOMybatis implements BoardDAO{
	private String namespace = "config.mybatis.mapper.oracle.board.";
	
	@Autowired SqlSessionTemplate sqlSession;
	
	@Override
	public int boardListInsert(BoardListVO boardListVo) {
		return sqlSession.insert(namespace+"boardListInsert", boardListVo);
	}

	@Override
	public List<BoardListVO> selectBoardList() {
		return sqlSession.selectList(namespace+"selectBoardList");
	}

	@Override
	public int delectBoardList(int bdlistNo) {
		return sqlSession.delete(namespace+"delectBoardList", bdlistNo);
	}

	@Override
	public BoardListVO selectBoardListByNo(int bdlistNo) {
		return sqlSession.selectOne(namespace+"selectBoardListByNo", bdlistNo);
	}

	@Override
	public int updateBoardList(BoardListVO boardlistVo) {
		return sqlSession.update(namespace+"updateBoardList", boardlistVo);
	}

	@Override
	public List<BoardVO> selectBoardByListNo(int bdlistNo) {
		return sqlSession.selectList(namespace+"selectBoardByListNo", bdlistNo);
	}  
   
}

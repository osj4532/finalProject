package com.cwb.finalproject.board.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired BoardDAO boardDao;
	
	@Override
	public int boardListInsert(BoardListVO boardListVo) {
		return boardDao.boardListInsert(boardListVo);
	}

	@Override
	public List<BoardListVO> selectBoardList() {
		return boardDao.selectBoardList();
	}

	@Override
	public int delectBoardList(int bdlistNo) {
		return boardDao.delectBoardList(bdlistNo);
	}

	@Override
	public BoardListVO selectBoardListByNo(int bdlistNo) {
		return boardDao.selectBoardListByNo(bdlistNo);
	}

	@Override
	public int updateBoardList(BoardListVO boardlistVo) {
		return boardDao.updateBoardList(boardlistVo);
	}

	@Override
	public List<BoardVO> selectBoardByListNo(int bdlistNo) {
		return boardDao.selectBoardByListNo(bdlistNo);
	}

}

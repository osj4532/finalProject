package com.cwb.finalproject.board.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	public int delectBoardList(int bdlistNo) {
		int cnt = boardDao.deleteboardByListNo(bdlistNo);
		cnt +=boardDao.delectBoardList(bdlistNo);
		return cnt;
		
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

	@Override
	public int insertBoard(BoardVO boardVo) {
		return boardDao.insertBoard(boardVo);
	}

	@Override
	public BoardVO selectboard(int boardNo) {
		return boardDao.selectboard(boardNo);
	}

	@Override
	public int updateboard(BoardVO boardVo) {
		return boardDao.updateboard(boardVo);
	}

	@Override
	public int deleteboard(int boardNo) {
		return boardDao.deleteboard(boardNo);
	}


}

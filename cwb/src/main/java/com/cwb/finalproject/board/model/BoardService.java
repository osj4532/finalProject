package com.cwb.finalproject.board.model;

import java.util.List;

public interface BoardService {
	int boardListInsert(BoardListVO boardListVo);
	List<BoardListVO> selectBoardList();
	int delectBoardList(int bdlistNo);
	BoardListVO selectBoardListByNo(int bdlistNo);
	int updateBoardList(BoardListVO boardlistVo);
	List<BoardVO> selectBoardByListNo(BoardVO boradVo); 
	int insertBoard(BoardVO boardVo);
	BoardVO selectboard(int boardNo);
	int updateboard(BoardVO boardVo);
	int deleteboard(int boardNo);
	int updateReadCount(int boardNo);
	int updateCommend(int boardNo);
	
	int boardTotalrecord(BoardVO boardVo);

}

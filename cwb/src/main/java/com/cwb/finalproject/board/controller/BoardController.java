package com.cwb.finalproject.board.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cwb.finalproject.board.model.BoardListVO;
import com.cwb.finalproject.board.model.BoardService;
import com.cwb.finalproject.ranks.model.RanksService;
import com.cwb.finalproject.ranks.model.RanksVO;

@Controller
@RequestMapping("/Board")
public class BoardController {
	Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired BoardService boardService;
	@Autowired RanksService ranksService;
	
	
	@RequestMapping("/BoardAllList.do")
	public String boardAllListshow(Model model) {
		logger.info("전체 게시판 관리 화면 ");
		List<RanksVO> rankList = ranksService.selectAll();
		List<BoardListVO> bdLlist = boardService.selectBoardList();
		logger.info("전체 게시판 관리 게시판 리스트 bdLlist={}",bdLlist);
		 
		
		model.addAttribute("bdLlist", bdLlist);
		model.addAttribute("rankList", rankList);
		return "Board/BoardAllList"; 
	}
	
	@RequestMapping("/BoardListInsert.do")
	public String boardListinsert(@ModelAttribute BoardListVO boardlistVo
			,Model model) {
		logger.info("게시판 리스트 추가 boardlistVo={}",boardlistVo);
		
		int cnt =boardService.boardListInsert(boardlistVo);
		
		String msg="",url="/Board/BoardAllList.do";
		if(cnt>0) {
			msg="게시판 리스트 추가 완료";
		}else {
			msg="게시판 리스트 추가 실패"; 
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url); 
		return "common/message";
	}
	
	@RequestMapping("/BoardListDel.do")
	public String boardListDel(@RequestParam int bdlistNo
			,Model model) {
		logger.info("게시판 리스트 삭제 bdlistNo={}",bdlistNo);
		
		int cnt =boardService.delectBoardList(bdlistNo);
		
		String msg="",url="/Board/BoardAllList.do";
		if(cnt>0) {
			msg="게시판 리스트 삭제 성공";
		}else {
			msg="게시판 리스트 삭제 실패"; 
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url); 
		return "common/message";
	}
	
	@RequestMapping("/BoardListByNo.do")
	@ResponseBody
	public BoardListVO boardListByno(int bdlistNo) {
		logger.info("ajax 게시판 수정 보여주기 bdlistNo={}",bdlistNo);
		
		BoardListVO boardlistVo = boardService.selectBoardListByNo(bdlistNo);
		
		return boardlistVo;
	}
	
	@RequestMapping("/BoardListEdit.do")
	public String boardListEdit(@ModelAttribute BoardListVO boardListVo,
			Model model){
		logger.info("게시판 리스트 수정 boardListVo={}",boardListVo);
		
		int cnt =boardService.updateBoardList(boardListVo);
		
		String msg="",url="/Board/BoardAllList.do";
		if(cnt>0) {
			msg="게시판 리스트 삭제 성공";
		}else {
			msg="게시판 리스트 삭제 실패"; 
		}
		 
		model.addAttribute("msg", msg);
		model.addAttribute("url", url); 
		return "common/message";

	} 
}


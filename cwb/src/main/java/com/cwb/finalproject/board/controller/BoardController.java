package com.cwb.finalproject.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cwb.finalproject.board.model.BoardService;

@Controller
@RequestMapping("/Board")
public class BoardController {
	Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired BoardService boardService;
	
	@RequestMapping("/BoardAllList.do")
	public String boardAllListshow() {
		logger.info("전체 게시판 관리 화면 ");
		
		
		
		
		return "Board/BoardAllList";
	}
	
	
	
}

package com.cwb.finalproject.board.model;

import com.cwb.finalproject.common.SearchVO;

public class BoardVO extends SearchVO{
	private int boardNo; /* 게시글번호 */
	private int memNo;  /* 사원번호 */
	private int bdlistNo; /* 게시판번호 */
	private String boardTitle;   /* 게시글제목 */
	private String boardContent; /* 게시글본문 */
	private int boardReadcount; /* 조회수 */
	private String boardRegdate; /* 등록일 */
	private String boardChangedate; /* 수정일 */
	private String boardFilename; /* 업로드파일명 */
	private Long boardFilesize;  /* 파일사이즈 */
	private String boardOriginalfilename;   /* 원본파일명 */
	private int boardDowncount;  /* 다운로드수 */
	private String boardDelflag; /* 삭제구분 */ 
	private int boardRecommend;/* 추천수 */
	
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public int getBdlistNo() {
		return bdlistNo;
	}
	public void setBdlistNo(int bdlistNo) {
		this.bdlistNo = bdlistNo;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public int getBoardReadcount() {
		return boardReadcount;
	}
	public void setBoardReadcount(int boardReadcount) {
		this.boardReadcount = boardReadcount;
	}
	public String getBoardRegdate() {
		return boardRegdate;
	}
	public void setBoardRegdate(String boardRegdate) {
		this.boardRegdate = boardRegdate;
	}
	public String getBoardChangedate() {
		return boardChangedate;
	}
	public void setBoardChangedate(String boardChangedate) {
		this.boardChangedate = boardChangedate;
	}
	public String getBoardFilename() {
		return boardFilename;
	}
	public void setBoardFilename(String boardFilename) {
		this.boardFilename = boardFilename;
	}
	public Long getBoardFilesize() {
		return boardFilesize;
	}
	public void setBoardFilesize(Long boardFilesize) {
		this.boardFilesize = boardFilesize;
	}
	public String getBoardOriginalfilename() {
		return boardOriginalfilename;
	}
	public void setBoardOriginalfilename(String boardOriginalfilename) {
		this.boardOriginalfilename = boardOriginalfilename;
	}
	public int getBoardDowncount() {
		return boardDowncount;
	}
	public void setBoardDowncount(int boardDowncount) {
		this.boardDowncount = boardDowncount;
	}
	public String getBoardDelflag() {
		return boardDelflag;
	}
	public void setBoardDelflag(String boardDelflag) {
		this.boardDelflag = boardDelflag;
	}
	public int getBoardRecommend() {
		return boardRecommend;
	}
	public void setBoardRecommend(int boardRecommend) {
		this.boardRecommend = boardRecommend;
	}
	@Override
	public String toString() {
		return "BoardVO [boardNo=" + boardNo + ", memNo=" + memNo + ", bdlistNo=" + bdlistNo + ", boardTitle="
				+ boardTitle + ", boardContent=" + boardContent + ", boardReadcount=" + boardReadcount
				+ ", boardRegdate=" + boardRegdate + ", boardChangedate=" + boardChangedate + ", boardFilename="
				+ boardFilename + ", boardFilesize=" + boardFilesize + ", boardOriginalfilename="
				+ boardOriginalfilename + ", boardDowncount=" + boardDowncount + ", boardDelflag=" + boardDelflag
				+ ", boardRecommend=" + boardRecommend + ", toString()=" + super.toString() + "]";
	}
	
	
}

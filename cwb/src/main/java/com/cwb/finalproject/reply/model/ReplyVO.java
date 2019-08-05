package com.cwb.finalproject.reply.model;

public class ReplyVO {
	private int repNo; /* 댓글번호 */
	private String repContent; /* 댓글본문 */
	private String repRegdate; /* 댓글등록일 */
	private int repGroup; /* 댓글 그룹 */
	private int repSortno; /* 댓글 순서 */
	private int repDepth; /* 댓글 계층 */
	private String repSecret; /* 공개여부 */
	private int memNo; /* 사원번호 */
	private int boardNo; /* 게시글번호 */
	public int getRepNo() {
		return repNo;
	}
	public void setRepNo(int repNo) {
		this.repNo = repNo;
	}
	public String getRepContent() {
		return repContent;
	}
	public void setRepContent(String repContent) {
		this.repContent = repContent;
	}
	public String getRepRegdate() {
		return repRegdate;
	}
	public void setRepRegdate(String repRegdate) {
		this.repRegdate = repRegdate;
	}
	public int getRepGroup() {
		return repGroup;
	}
	public void setRepGroup(int repGroup) {
		this.repGroup = repGroup;
	}
	public int getRepSortno() {
		return repSortno;
	}
	public void setRepSortno(int repSortno) {
		this.repSortno = repSortno;
	}
	public int getRepDepth() {
		return repDepth;
	}
	public void setRepDepth(int repDepth) {
		this.repDepth = repDepth;
	}
	public String getRepSecret() {
		return repSecret;
	}
	public void setRepSecret(String repSecret) {
		this.repSecret = repSecret;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	@Override
	public String toString() {
		return "ReplyVO [repNo=" + repNo + ", repContent=" + repContent + ", repRegdate=" + repRegdate + ", repGroup="
				+ repGroup + ", repSortno=" + repSortno + ", repDepth=" + repDepth + ", repSecret=" + repSecret
				+ ", memNo=" + memNo + ", boardNo=" + boardNo + "]";
	}
	
	
	
}

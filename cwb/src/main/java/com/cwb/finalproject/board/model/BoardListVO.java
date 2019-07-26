package com.cwb.finalproject.board.model;

public class BoardListVO {
	private int bdlistNo; /* 게시판번호 */
	private String bdlistName; /* 게시판이름 */
	private String bdlistRe;   /* 댓글허용 */
	private String  bdlistUp;   /* 업로드허용 */
	private int ranksNo; /* 등급번호 */
	private String bdlistRc;  /* 추천허용 */
	private String  bdlistRegdate; /* 등록일 */
	public int getBdlistNo() {
		return bdlistNo;
	}
	public void setBdlistNo(int bdlistNo) {
		this.bdlistNo = bdlistNo;
	}
	public String getBdlistName() {
		return bdlistName;
	}
	public void setBdlistName(String bdlistName) {
		this.bdlistName = bdlistName;
	}
	public String getBdlistRe() {
		return bdlistRe;
	}
	public void setBdlistRe(String bdlistRe) {
		this.bdlistRe = bdlistRe;
	}
	public String getBdlistUp() {
		return bdlistUp;
	}
	public void setBdlistUp(String bdlistUp) {
		this.bdlistUp = bdlistUp;
	}
	public int getRanksNo() {
		return ranksNo;
	}
	public void setRanksNo(int ranksNo) {
		this.ranksNo = ranksNo;
	}
	public String getBdlistRc() {
		return bdlistRc;
	}
	public void setBdlistRc(String bdlistRc) {
		this.bdlistRc = bdlistRc;
	}
	public String getBdlistRegdate() {
		return bdlistRegdate;
	}
	public void setBdlistRegdate(String bdlistRegdate) {
		this.bdlistRegdate = bdlistRegdate;
	}
	@Override
	public String toString() {
		return "BoardListVO [bdlistNo=" + bdlistNo + ", bdlistName=" + bdlistName + ", bdlistRe=" + bdlistRe
				+ ", bdlistUp=" + bdlistUp + ", ranksNo=" + ranksNo + ", bdlistRc=" + bdlistRc + ", bdlistRegdate="
				+ bdlistRegdate + "]";
	}
	
	
	
}

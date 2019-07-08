package com.cwb.finalproject.ranks.model;

public class RanksVO {
	private int ranksNo;
	private String ranksName;
	public int getRanksNo() {
		return ranksNo;
	}
	public void setRanksNo(int ranksNo) {
		this.ranksNo = ranksNo;
	}
	public String getRanksName() {
		return ranksName;
	}
	public void setRanksName(String ranksName) {
		this.ranksName = ranksName;
	}
	@Override
	public String toString() {
		return "RanksVO [ranksNo=" + ranksNo + ", ranksName=" + ranksName + "]";
	}
	
	
}

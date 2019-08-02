package com.cwb.finalproject.position.model;

public class PositionVO {
	private int posNo;
	private String posName;
	public int getPosNo() {
		return posNo;
	}
	public void setPosNo(int posNo) {
		this.posNo = posNo;
	}
	public String getPosName() {
		return posName;
	}
	public void setPosName(String posName) {
		this.posName = posName;
	}
	@Override
	public String toString() {
		return "PositionVO [posNo=" + posNo + ", posName=" + posName + "]";
	}

	

}

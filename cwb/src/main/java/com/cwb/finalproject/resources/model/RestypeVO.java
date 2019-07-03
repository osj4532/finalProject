package com.cwb.finalproject.resources.model;

public class RestypeVO {
	private int typeNo; /* 종류번호 */
	private String typeName; /* 종류이름 */
	public int getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(int typeNo) {
		this.typeNo = typeNo;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	@Override
	public String toString() {
		return "RestypeVO [typeNo=" + typeNo + ", typeName=" + typeName + "]";
	}
	
}

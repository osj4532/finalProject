package com.cwb.finalproject.document.model;

public class DocTypeVO {
	private int typeNo;
	private String typeName;
	private String typeDel;
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
	public String getTypeDel() {
		return typeDel;
	}
	public void setTypeDel(String typeDel) {
		this.typeDel = typeDel;
	}
	@Override
	public String toString() {
		return "DocTypeVO [typeNo=" + typeNo + ", typeName=" + typeName + ", typeDel=" + typeDel + "]";
	}
	
	
}

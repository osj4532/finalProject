package com.cwb.finalproject.webhard.model;

public class WebhardListVO {
	private int webNo;
	private String webCategory;
	public int getWebNo() {
		return webNo;
	}
	public void setWebNo(int webNo) {
		this.webNo = webNo;
	}
	public String getWebCategory() {
		return webCategory;
	}
	public void setWebCategory(String webCategory) {
		this.webCategory = webCategory;
	}
	@Override
	public String toString() {
		return "WebhardListVO [webNo=" + webNo + ", webCategory=" + webCategory + "]";
	}
}

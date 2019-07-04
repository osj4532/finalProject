package com.cwb.finalproject.confirm.model;

import java.sql.Timestamp;

public class ConfirmVO {
	private int cfNo;
	private int formNo;
	private int memNo;
	private int deptNo;
	private int regNo;
	private String cfTitle;
	private String cfContent;
	private int cfState;
	private String cfFile;
	private String cfTmpstorage;
	private String cfDel;
	private int cfOrder;
	private Timestamp cfRegdate;
	private Timestamp cfOkdate;
	public int getCfNo() {
		return cfNo;
	}
	public void setCfNo(int cfNo) {
		this.cfNo = cfNo;
	}
	public int getFormNo() {
		return formNo;
	}
	public void setFormNo(int formNo) {
		this.formNo = formNo;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public int getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}
	public int getRegNo() {
		return regNo;
	}
	public void setRegNo(int regNo) {
		this.regNo = regNo;
	}
	public String getCfTitle() {
		return cfTitle;
	}
	public void setCfTitle(String cfTitle) {
		this.cfTitle = cfTitle;
	}
	public String getCfContent() {
		return cfContent;
	}
	public void setCfContent(String cfContent) {
		this.cfContent = cfContent;
	}
	public int getCfState() {
		return cfState;
	}
	public void setCfState(int cfState) {
		this.cfState = cfState;
	}
	public String getCfFile() {
		return cfFile;
	}
	public void setCfFile(String cfFile) {
		this.cfFile = cfFile;
	}
	public String getCfTmpstorage() {
		return cfTmpstorage;
	}
	public void setCfTmpstorage(String cfTmpstorage) {
		this.cfTmpstorage = cfTmpstorage;
	}
	public String getCfDel() {
		return cfDel;
	}
	public void setCfDel(String cfDel) {
		this.cfDel = cfDel;
	}
	public int getCfOrder() {
		return cfOrder;
	}
	public void setCfOrder(int cfOrder) {
		this.cfOrder = cfOrder;
	}
	public Timestamp getCfRegdate() {
		return cfRegdate;
	}
	public void setCfRegdate(Timestamp cfRegdate) {
		this.cfRegdate = cfRegdate;
	}
	public Timestamp getCfOkdate() {
		return cfOkdate;
	}
	public void setCfOkdate(Timestamp cfOkdate) {
		this.cfOkdate = cfOkdate;
	}
	@Override
	public String toString() {
		return "ConfirmVO [cfNo=" + cfNo + ", formNo=" + formNo + ", memNo=" + memNo + ", deptNo=" + deptNo + ", regNo="
				+ regNo + ", cfTitle=" + cfTitle + ", cfContent=" + cfContent + ", cfState=" + cfState + ", cfFile="
				+ cfFile + ", cfTmpstorage=" + cfTmpstorage + ", cfDel=" + cfDel + ", cfOrder=" + cfOrder
				+ ", cfRegdate=" + cfRegdate + ", cfOkdate=" + cfOkdate + "]";
	}
}

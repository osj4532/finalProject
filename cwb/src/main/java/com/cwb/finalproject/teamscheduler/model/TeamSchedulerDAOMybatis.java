package com.cwb.finalproject.teamscheduler.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TeamSchedulerDAOMybatis implements TeamSchedulerDAO{
	private String namespace="config.mybatis.mapper.oracle.teamscheduler.";
	
	@Autowired SqlSessionTemplate sqlsession;
	
	@Override
	public int insertTeamScd(TeamSchedulerVO teamSchedulerVo) {
		return sqlsession.insert(namespace+"insertTeamScd", teamSchedulerVo);
	}

	@Override
	public int insertTeamDayScd(TeamSchedulerVO teamSchedulerVo) {
		return sqlsession.insert(namespace+"insertTeamDayScd", teamSchedulerVo);
	}

	@Override
	public List<TeamSchedulerVO> selectByTeam(int deptNo) {
		return sqlsession.selectList(namespace+"selectByTeam", deptNo); 
	}

	@Override
	public int deleteByscdNo(int tschNo) {
		return sqlsession.delete(namespace+"deleteByscdNo", tschNo);
	}

	@Override
	public int updateTeamDayScd(TeamSchedulerVO teamSchedulerVo) {
		return sqlsession.update(namespace+"updateTeamDayScd", teamSchedulerVo);
	}

	@Override
	public int updateTeamScd(TeamSchedulerVO teamSchedulerVo) {
		return sqlsession.update(namespace+"updateTeamScd", teamSchedulerVo);			
	}

	@Override
	public int updateTeamScdContent(TeamSchedulerVO teamSchedulerVo) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	
}

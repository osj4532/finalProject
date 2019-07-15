package com.cwb.finalproject.teamscheduler.model;

import java.util.List;

public interface TeamSchedulerDAO {
	int insertTeamScd(TeamSchedulerVO teamSchedulerVo);
	int insertTeamDayScd(TeamSchedulerVO teamSchedulerVo);
	List<TeamSchedulerVO> selectByTeam(int deptNo);
	int deleteByscdNo(int tschNo);
	int updateTeamDayScd(TeamSchedulerVO teamSchedulerVo);
	int updateTeamScd(TeamSchedulerVO teamSchedulerVo);
	int updateTeamScdContent(TeamSchedulerVO teamSchedulerVo);
}

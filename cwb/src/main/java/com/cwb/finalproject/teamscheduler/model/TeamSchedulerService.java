package com.cwb.finalproject.teamscheduler.model;

import java.util.List;

public interface TeamSchedulerService {
	int insertTeamScd(TeamSchedulerVO teamSchedulerVo, boolean isday);
	List<TeamSchedulerVO> selectByTeam(int deptNo);
	int deleteByscdNo(int tschNo);
	int updateTeamScd(TeamSchedulerVO teamSchedulerVo,boolean isday);
	int updateTeamScdContent(TeamSchedulerVO teamSchedulerVo);
}

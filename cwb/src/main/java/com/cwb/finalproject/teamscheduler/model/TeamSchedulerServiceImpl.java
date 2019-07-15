package com.cwb.finalproject.teamscheduler.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeamSchedulerServiceImpl implements TeamSchedulerService{

	@Autowired TeamSchedulerDAO teamSchedulerDao;
	
	@Override
	public int insertTeamScd(TeamSchedulerVO teamSchedulerVo, boolean isday) {
		int cnt = 0;
		if(isday) {
			cnt=teamSchedulerDao.insertTeamDayScd(teamSchedulerVo);
		}else {
			cnt=teamSchedulerDao.insertTeamScd(teamSchedulerVo);
		}
		return cnt;
	}

	@Override
	public List<TeamSchedulerVO> selectByTeam(int deptNo) {
		return teamSchedulerDao.selectByTeam(deptNo);
	}

	@Override
	public int deleteByscdNo(int tschNo) {
		return teamSchedulerDao.deleteByscdNo(tschNo);
	}

	@Override
	public int updateTeamScd(TeamSchedulerVO teamSchedulerVo, boolean isday) {
		int cnt = 0;
		if(isday) {
			teamSchedulerDao.updateTeamDayScd(teamSchedulerVo);
		}else {
			teamSchedulerDao.updateTeamScd(teamSchedulerVo);
		}
		return cnt;
	}

	@Override
	public int updateTeamScdContent(TeamSchedulerVO teamSchedulerVo) {
		return teamSchedulerDao.updateTeamScdContent(teamSchedulerVo);
	}

}

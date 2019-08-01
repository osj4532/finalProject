package com.cwb.finalproject.position.model;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface PositionDAO {

	public List<PositionVO> selectAll();
}

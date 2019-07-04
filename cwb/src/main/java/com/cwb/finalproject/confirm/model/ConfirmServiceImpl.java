package com.cwb.finalproject.confirm.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConfirmServiceImpl implements ConfirmService{
	@Autowired
	private ConfirmDAO confirmDAO;
}

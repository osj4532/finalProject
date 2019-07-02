package com.cwb.finalproject.scheduler.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/scheduler")
public class SchedulerController {

	@RequestMapping("/scheduler.do")
	public String scheduler_view() {
		
		return "scheduler/scheduler";
	}
}

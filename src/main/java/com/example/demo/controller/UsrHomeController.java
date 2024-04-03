package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.util.Crawlling;
import com.example.demo.util.MovieScheduleScraperWithJsoup;

@Controller
public class UsrHomeController {

	@RequestMapping("/usr/home/main")
	public String showMain() {

		return "/usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {

		return "redirect:/usr/home/main";
	}

	@RequestMapping("/usr/crawl")
	public String doCrawl() {

		Crawlling.sample(); 
		
//		TheaterCrawler.main();

		return "redirect:/usr/home/main";
	}
	@RequestMapping("/usr/crawll")
	public String doCrawll() {
		MovieScheduleScraperWithJsoup.main(new String[]{});
	    return "redirect:/usr/home/main";
	}

}
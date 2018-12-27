package com.xg.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PageController {
    /**
     * 展示首页
     *
     * @return
     */
    @RequestMapping("/")
    public String showIndex() {
        return "index";
    }

    /**
     * 页面跳转统一处理
     *
     * @param page
     * @return
     */
    @RequestMapping("/{page}")
    public String showPage(@PathVariable String page) {
        return page;
    }
}

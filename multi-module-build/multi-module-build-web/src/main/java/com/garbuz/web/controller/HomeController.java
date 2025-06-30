package com.garbuz.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("message", "Welcome to multi module project!");
        model.addAttribute("title", "Main Page");
        return "index";
    }

    @GetMapping("/hello")
    public String hello(@RequestParam(value = "name", defaultValue = "World") String name, 
                       Model model) {
        model.addAttribute("message", "Hello, " + name + "!");
        model.addAttribute("title", "Hi there");
        return "hello";
    }
}
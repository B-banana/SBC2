package kr.co.soft.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	/*
	 * @Resource(name = "loginUserBean") private UserBean loginUserBean;
	 */
	
	// "/" : 주소를 입력하면 무조건 HomeController를 찾아오게 하는 코드
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		/* System.err.println("home"); */
		/* System.err.println(loginUserBean); */
		
		return "redirect:/main";
	}
}

package kr.co.soft.controller;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soft.beans.UserBean;
import kr.co.soft.service.UserService;
import kr.co.soft.validator.UserValidator;

@RequestMapping("/user")
@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;

	// -------------------------------------------------

	@PostMapping("/login_pro")
	public String login_pro(@Valid @ModelAttribute("tempLoginUserBean") UserBean tempLoginUserBean,
			BindingResult result) {

		if (result.hasErrors()) { // 유효성 검사를 통하가지 못하게 된다면
			return "user/login";
		}

		userService.getLoginUserInfo(tempLoginUserBean);

		if (loginUserBean.isUserLogin() == true) {
			return "user/login_success";
		} else {
			return "user/login_fail";
		}
	}

	@GetMapping("/login")
	public String login(@ModelAttribute("tempLoginUserBean") UserBean tempLoginUserBean,
			@RequestParam(value = "fail", defaultValue = "false") Boolean fail, Model model) {

		model.addAttribute("fail", fail);

		return "user/login";
	}
	
	@GetMapping("/not_login")
	public String not_login() {

		return "user/not_login";
	}

	// --------------------------------------

	@PostMapping("/join_pro")
	public String join_pro(@Valid @ModelAttribute("joinUserBean") UserBean joinUserBean, BindingResult result) {

		if (result.hasErrors()) { // 유효성 검사를 통하가지 못하게 된다면
			return "user/join";
		}

		userService.addUserInfo(joinUserBean);

		return "user/join_success";
	}

	@GetMapping("/join")
	public String join(@ModelAttribute("joinUserBean") UserBean joinUserBean) {

		return "user/join";
	}

	// ----------------------------------------

	@GetMapping("/modify")
	public String modify(@ModelAttribute("modifyUserBean") UserBean modifyUserBean) {

		//로그인한 유저 기본정보 가져가기
		userService.getModifyUserInfo(modifyUserBean);

		return "user/modify";
	}

	@PostMapping("/modify_pro")
	public String modify_pro(@Valid @ModelAttribute("modifyUserBean") UserBean modifyUserBean, BindingResult result) {

		if(result.hasErrors()) {
			return "user/modify";
		}
		
		//업데이트
		userService.ModifyUserInfo(modifyUserBean);

		return "user/modify_success";
	}

	@GetMapping("/logout")
	public String logout() {

		loginUserBean.setUserLogin(false);

		return "user/logout";
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {

		UserValidator validator1 = new UserValidator();
		binder.addValidators(validator1);
	}

}

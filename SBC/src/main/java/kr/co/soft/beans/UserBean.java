package kr.co.soft.beans;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserBean {
	
	private int user_idx;
	
	@Size(min = 2, max = 8)
	@Pattern(regexp = "[가-힣]*")
	private String user_name;
	
	@Size(min = 4, max = 20)
	@Pattern(regexp = "[a-zA-Z0-9]*")
	private String user_id;
	
	@Size(min = 4, max = 8)
	@Pattern(regexp = "[a-zA-Z0-9]*")
	private String user_pw;
	
	@Size(min = 4, max = 8)
	@Pattern(regexp = "[a-zA-Z0-9]*")
	private String user_pw2;
	
	private boolean userIdExist;
	
	private boolean userLogin;
	
	
	//최초에 회원 가입시 중복검사를 하지 않을것이므로 false
	public UserBean() {
		this.userIdExist = false;
		this.userLogin = false;	//초기값 : 로그인이 안된 상태
	}
	
	
	
}

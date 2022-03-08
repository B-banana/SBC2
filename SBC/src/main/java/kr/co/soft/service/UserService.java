package kr.co.soft.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soft.beans.UserBean;
import kr.co.soft.dao.UserDao;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;
	
	public boolean checkUserIdExist(String user_id) {
		
		String user_name = userDao.checkUserIdExist(user_id);
		
		if (user_name == null) {
			return true;
		} else {
			return false;
		}
		
	}
	
	//-------------------------------------
	
	public void addUserInfo(UserBean joinUserBean) {
		
		userDao.addUserInfo(joinUserBean);
	}
	
	
	//--------------------------------------
	
	public void getLoginUserInfo(UserBean tempLoginUserBean) {
		
		UserBean tempLoginUserBean2 = userDao.getLoginUserInfo(tempLoginUserBean);
		
		if(tempLoginUserBean2 != null) {
			
			loginUserBean.setUser_idx(tempLoginUserBean2.getUser_idx());
			loginUserBean.setUser_name(tempLoginUserBean2.getUser_name());
			loginUserBean.setUserLogin(true); //로그인이 된 상태
		}

	}
	
	public void getModifyUserInfo(UserBean modifyUserInfo) {
		
		UserBean tempModifyUserBean = userDao.getModifyUserInfo(loginUserBean.getUser_idx());
		
		modifyUserInfo.setUser_id(tempModifyUserBean.getUser_id());
		modifyUserInfo.setUser_name(tempModifyUserBean.getUser_name());
		modifyUserInfo.setUser_idx(loginUserBean.getUser_idx());
		
	}
	
	public void ModifyUserInfo(UserBean modifyUserBean) {
		
		//로그인한 유저번호 호출하여 저장
		modifyUserBean.setUser_id(loginUserBean.getUser_id());
		userDao.ModifyUserInfo(modifyUserBean);
	}
		

	
	

}

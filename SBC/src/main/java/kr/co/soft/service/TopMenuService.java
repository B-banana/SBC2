package kr.co.soft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soft.beans.BoardInfoBean;
import kr.co.soft.dao.TopMenuDao;

@Service
public class TopMenuService {
	
	@Autowired
	private TopMenuDao toapMenuDao;
	
	public List<BoardInfoBean> getTopMenuList(){
		
		List<BoardInfoBean> topMenuList = toapMenuDao.getTopMenuList();
		
		return topMenuList;
	}

}

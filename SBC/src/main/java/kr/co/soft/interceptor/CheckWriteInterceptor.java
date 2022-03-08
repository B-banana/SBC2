package kr.co.soft.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.soft.beans.ContentBean;
import kr.co.soft.beans.UserBean;
import kr.co.soft.service.BoardService;

public class CheckWriteInterceptor implements HandlerInterceptor {
	
	private UserBean loginUserBean;
	private BoardService boardService;
	
	public CheckWriteInterceptor(UserBean loginUserBean, BoardService boardService) {
		this.loginUserBean = loginUserBean;
		this.boardService = boardService;
			
	}
	

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String str1 = request.getParameter("content_idx");
		int content_idx = Integer.parseInt(str1);
		
		ContentBean currentBean = boardService.getContentInfo(content_idx);
		
		if (currentBean.getContent_writer_idx() != loginUserBean.getUser_idx()) {
			//경로 읽어오기
			String contextPath = request.getContextPath();
			
			response.sendRedirect(contextPath + "/board/not_writer");
			return false;
		}
		
		return true;
	}
	
	

}

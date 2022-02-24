package kr.co.soft.config;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

public class SpringConfigClass implements WebApplicationInitializer{

	//본래는 서버에 있는 web.xml의 초기분석 경로를 수행해야 하지만 개발자가 변경하여 초기 분석경로는 변경하기 위해
	//ServletContext에 ServletAppContext.java클래스를 설정
	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		AnnotationConfigWebApplicationContext  servletAppContext=new AnnotationConfigWebApplicationContext();
		servletAppContext.register(ServletAppContext.class);
		
		//요청 발생 시 요청을 처리하는 서블릿을 DispatcherServlet으로 설정해줌
		DispatcherServlet dispatcherServlet=new DispatcherServlet(servletAppContext);
		//매개변수 servletContext이용하여 로드 온(load-on)
		ServletRegistration.Dynamic servlet=servletContext.addServlet("dispatcher", dispatcherServlet);
		//부가설정
		servlet.setLoadOnStartup(1);
		servlet.addMapping("/");
		
		//======================================================================================
		
		//일반 Bean을 정의하는 클래스 지정
		AnnotationConfigWebApplicationContext rootAppContext=new AnnotationConfigWebApplicationContext();
		rootAppContext.register(RootAppContext.class);
		
		//listener 구현부 지정
		ContextLoaderListener listener=new ContextLoaderListener(rootAppContext);
		servletContext.addListener(listener);
		
		//Filter 구현부 지정
		FilterRegistration.Dynamic filter=servletContext.addFilter("encodingFilter", CharacterEncodingFilter.class);
		filter.setInitParameter("encoding", "UTF-8");
		filter.addMappingForServletNames(null, false, "dispatcher");
	
	}

}

/*
public class SpringConfigClass extends AbstractAnnotationConfigDispatcherServletInitializer {

	//DispatcherServlet
	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] {"/"};
	}
	//프로젝트 기본 프레임 경로
	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] { ServletAppContext.class };
	}
	//일반 bean 정의하는 경로
	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] { RootAppContext.class };
	}

	//필터
	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter encodingFilter=new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		return new Filter[] { encodingFilter };
	}

}*/

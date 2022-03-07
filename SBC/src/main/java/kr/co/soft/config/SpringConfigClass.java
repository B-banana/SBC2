package kr.co.soft.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

//public class SpringConfigClass implements WebApplicationInitializer {
//
//	@Override
//	public void onStartup(ServletContext servletContext) throws ServletException {
//		AnnotationConfigWebApplicationContext servletAppContext = new AnnotationConfigWebApplicationContext();
//		servletAppContext.register(ServletAppContext.class);
//
//		// 요청 발생 시 요청을 처리하는 서블릿을 DispatcherServlet 으로 설정.
//		DispatcherServlet ds = new DispatcherServlet(servletAppContext);
//
//		// 매개변수 servletAppContext 이용하여 로드 온 (load-on)
//		ServletRegistration.Dynamic servlet = servletContext.addServlet("dispatcher", ds);
//
//		// 부가설정
//		servlet.setLoadOnStartup(1);
//		servlet.addMapping("/");
//
//		// ========================================================================================================
//
//		// 일반 Bean을 정의하는 클래스 지정
//		AnnotationConfigWebApplicationContext rootAppContext = new AnnotationConfigWebApplicationContext();
//		rootAppContext.register(RootAppContext.class);
//
//		// listener 구현부 지정
//		ContextLoaderListener listener = new ContextLoaderListener(rootAppContext);
//		servletContext.addListener(listener);
//
//		// Filter 구현부 지정
//		FilterRegistration.Dynamic filter = servletContext.addFilter("encodingFilter", CharacterEncodingFilter.class);
//		filter.setInitParameter("encoding", "UTF-8");
//		filter.addMappingForServletNames(null, false, "dispatcher");
//	}
//
//}

public class SpringConfigClass extends AbstractAnnotationConfigDispatcherServletInitializer {
	// DispathcerServlet
	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}

	// 프로젝트 기본 프레임 경로
	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] { ServletAppContext.class };
	}

	// 일반 Bean 정의하는 경로
	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] { RootAppContext.class };
	}

	// 필터
	@Override
	protected Filter[] getServletFilters() {

		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		return new Filter[] { encodingFilter };
	}

	//Multipart 정보 구현 코드
	@Override
	protected void customizeRegistration(Dynamic registration) {
		super.customizeRegistration(registration);
		
		// null: 톰캣에서 제공하는 임시 기억 장소 사용.
		// 52428800 : 업로드 데이터의 용량(1024*50) 50MB
		// 524288000 : 파일 데이터를 포함한 전체 용량 500M 설정
		// 0 파일의 임계값(데이터가 들어오면 자동으로 용량 저장)

		MultipartConfigElement config = new MultipartConfigElement(null, 52428800, 524288000, 0);
		registration.setMultipartConfig(config);
	}

}

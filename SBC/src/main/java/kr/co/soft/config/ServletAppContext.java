package kr.co.soft.config;

import javax.annotation.Resource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import kr.co.soft.beans.UserBean;
import kr.co.soft.interceptor.CheckWriteInterceptor;
import kr.co.soft.interceptor.CheckloginInterceptor;
import kr.co.soft.interceptor.TopMenuInterceptor;
import kr.co.soft.mapper.BoardMapper;
import kr.co.soft.mapper.TopMenuMapper;
import kr.co.soft.mapper.UserMapper;
import kr.co.soft.service.BoardService;
import kr.co.soft.service.TopMenuService;

@Configuration // <annotation-driven>과 같은
@ComponentScan("kr.co.soft.controller")
@ComponentScan("kr.co.soft.dao")
@ComponentScan("kr.co.soft.service")
@PropertySource("/WEB-INF/properties/db.properties")
@EnableWebMvc // controller어노테이션이 셋팅되어 있는 클래스 로드
public class ServletAppContext implements WebMvcConfigurer {

	@Value("${db.classname}")
	private String db_classname;

	@Value("${db.url}")
	private String db_url;

	@Value("${db.username}")
	private String db_username;

	@Value("${db.password}")
	private String db_password;

	@Autowired
	private TopMenuService topMenuService;

	@Autowired
	private BoardService boardService;

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;

	// jsp의 파일이름 앞 뒤 생략
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.configureViewResolvers(registry);
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

	// 정적 파일의 경로를 맵핑
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.addResourceHandlers(registry);
		registry.addResourceHandler("/**").addResourceLocations("/resource/");
	}

	// 메시지 등록
	@Bean
	public ReloadableResourceBundleMessageSource messageSource() {
		ReloadableResourceBundleMessageSource res = new ReloadableResourceBundleMessageSource();

		// res.setBasename("/WEB-INF/properties/error_message"); // 단일. 확장자 쓰지말것

		res.setBasenames("/WEB-INF/properties/error_message");
		// 복수의 것. 쉼표로 처리

		return res;

	}

	/* @PropertySource와 메시지 충돌 -> 분리하는 코드 */
	@Bean
	public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {

		return new PropertySourcesPlaceholderConfigurer();
	}

	// 데이터베이스 정속 데이터 정보 등록
	@Bean
	public BasicDataSource dataSource() {

		BasicDataSource source = new BasicDataSource();

		source.setDriverClassName(db_classname);
		source.setUrl(db_url);
		source.setUsername(db_username);
		source.setPassword(db_password);

		return source;
	}

	// 등록된 접속 정보와 쿼리문 관리
	@Bean
	public SqlSessionFactory factory(BasicDataSource source) throws Exception {

		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();

		factoryBean.setDataSource(source); // 등록

		SqlSessionFactory factory = factoryBean.getObject();

		return factory;
	}

	// 쿼리문 실행을 위한 객체(Mapper)
	@Bean
	public MapperFactoryBean<TopMenuMapper> test_mapper(SqlSessionFactory factory) throws Exception {

		MapperFactoryBean<TopMenuMapper> factoryBean = new MapperFactoryBean<TopMenuMapper>(TopMenuMapper.class);

		factoryBean.setSqlSessionFactory(factory);

		return factoryBean;
	}

	@Bean
	public MapperFactoryBean<UserMapper> getUsermapper(SqlSessionFactory factory) throws Exception {

		MapperFactoryBean<UserMapper> factoryBean = new MapperFactoryBean<UserMapper>(UserMapper.class);

		factoryBean.setSqlSessionFactory(factory);

		return factoryBean;
	}

	@Bean
	public MapperFactoryBean<BoardMapper> getBoardMapper(SqlSessionFactory factory) throws Exception {

		MapperFactoryBean<BoardMapper> factoryBean = new MapperFactoryBean<BoardMapper>(BoardMapper.class);

		factoryBean.setSqlSessionFactory(factory);

		return factoryBean;
	}

	// ==================================================

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.addInterceptors(registry);

		TopMenuInterceptor topMenuInterceptor = new TopMenuInterceptor(topMenuService, loginUserBean);

		InterceptorRegistration reg1 = registry.addInterceptor(topMenuInterceptor);

		reg1.addPathPatterns("/**"); // 모든 요청 주소에 AOP 등록

		// --------------------------------------------
		
		CheckloginInterceptor checkLoginInterceptor = new CheckloginInterceptor(loginUserBean);

		InterceptorRegistration reg2 = registry.addInterceptor(checkLoginInterceptor);

		reg2.addPathPatterns("/user/modify", "/user/logout", "/board/*");
		reg2.excludePathPatterns("/board/main");

		// -----------------------------------------------

		CheckWriteInterceptor checkWriteInterceptor = new CheckWriteInterceptor(loginUserBean, boardService);

		InterceptorRegistration reg3 = registry.addInterceptor(checkWriteInterceptor);

		reg3.addPathPatterns("/board/modify", "/board/delete");
	}

	// 첨부파일의 내용이 등록되도록 StandardServletMultipartResolver를 등록
	@Bean
	public StandardServletMultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver(); // 객체 생성하여 변환
	}

}

package kr.co.soft.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soft.mapper.ProductMapper;
import kr.co.soft.mapperVO.ProductVO;

@Repository
public class ProductDao {
	
	@Autowired
	ProductMapper mapper;

	List<ProductVO> getAllProductList(){
		return mapper.getAllProductList();
	}
}

package kr.co.soft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soft.mapper.ProductMapper;
import kr.co.soft.mapperVO.ProductVO;

@Service
public class ProductService {

	@Autowired
	ProductMapper mapper;

	public List<ProductVO> getAllProductList(){
		return mapper.getAllProductList();
	}
	
}

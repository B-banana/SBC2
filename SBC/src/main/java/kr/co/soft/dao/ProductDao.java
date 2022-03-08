package kr.co.soft.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soft.bean.ProductBean;
import kr.co.soft.mapper.ProductMapper;

@Repository
public class ProductDao {
	
	@Autowired
	ProductMapper mapper;

	List<ProductBean> getAllProductList(){
		return mapper.getAllProductList();
	}
}

package kr.co.soft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.soft.mapper.ProductMapper;

@SuppressWarnings({"unchecked", "rawtypes"})
@RestController	//@Controller + @ResponseBody
public class ShopController {

	@Autowired
	ProductMapper productMapper;
	
	@GetMapping("/products")
	public List getAllProductList(){
		System.out.println("Request Method : GET");
		
		return productMapper.getAllProductList();
	}
	
}

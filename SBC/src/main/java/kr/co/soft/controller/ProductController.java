package kr.co.soft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.soft.bean.ProductBean;
import kr.co.soft.service.ProductService;


@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	ProductService service;
	
	@GetMapping("/main")
	public String product(Model model){
		
		List<ProductBean> productList = service.getAllProductList();
		model.addAttribute("productList", productList);
		
		return "product/main";
	}

	
}

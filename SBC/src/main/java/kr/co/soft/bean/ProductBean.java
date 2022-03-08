package kr.co.soft.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductBean {

	private String product_id;
	private String product_name;
	private int price;
	private int stock;
	private String product_category;
	
	public ProductBean() {
		
	}
	
	public ProductBean(String product_id, String product_name, int price, int stock, String product_category) {
		this.product_id = product_id;
		this.product_name = product_name;
		this.price = price;
		this.stock = stock;
		this.product_category = product_category;
	}

	@Override
	public String toString() {
		
		return "ProductVO[product_id="+product_id+" product_name="+product_name+" price="+price+"]";
	}

}

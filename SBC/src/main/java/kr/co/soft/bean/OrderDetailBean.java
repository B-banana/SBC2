package kr.co.soft.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDetailBean {

	private String merchant_uid;
	private String product_id;
	private int quantity;
	
	public OrderDetailBean() {
		
	}
	
	public OrderDetailBean(String merchant_uid, String product_id, int quantity) {
		this.merchant_uid = merchant_uid;
		this.product_id = product_id;
		this.quantity = quantity;
	}
}

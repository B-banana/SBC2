package kr.co.soft.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderlistBean {
	
	private String merchant_uid;
	private String user_id;
	private String phone;
	private String email;
	private String order_date;
	private int postcode;
	private String address1;
	private String address2;
	private int total_price;
	private int shipping;
	private int total_amount;
	
	public OrderlistBean() {
		
	}
	
	public OrderlistBean(String merchant_uid, String user_id, String phone, String email, 
			String order_date, int postcode, String address1, String address2,
			int total_price, int shipping, int total_amount) {
		this.merchant_uid = merchant_uid;
		this.user_id = user_id;
		this.phone = phone;
		this.email = email;
		this.order_date = order_date;
		this.postcode = postcode;
		this.address1 = address1;
		this.address2 = address2;
		this.total_price = total_price;
		this.shipping = shipping;
		this.total_amount = total_amount;
	}
}

package kr.co.soft.mapperVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentVO {

	private String imp_id;
	private String merchant_id;
	private String pay_date;
	private int amount;
	
	public PaymentVO() {
		
	}
	
	public PaymentVO(String imp_id, String merchant_id, String pay_date, int amount) {
		this.imp_id = imp_id;
		this.merchant_id = merchant_id;
		this.pay_date = pay_date;
		this.amount = amount;
	}
}

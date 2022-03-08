package kr.co.soft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soft.mapperVO.ProductVO;

public interface ProductMapper {

	@Select("select product_id,product_name,price from sbc.product")
	List<ProductVO> getAllProductList();

}
